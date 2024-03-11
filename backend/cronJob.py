import csv
import datetime
import os
import pickle
import time

import numpy as np
import pandas as pd
import requests
import schedule
from commodity_mapping import commodity_map
from district_mapping import district_mapping
from market_mapping import market_mapping
from month_mapping import month_mapping
from season_mapping import season_mapping
from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import train_test_split
from state_mapping import state_mapping


def fetch_data():
  url = "https://enam.gov.in/web/Liveprice_ctrl/trade_data_list_1"
  headers = {
      "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      "cookie": "SERVERID=node1; ci_session=rva8ajmdp0uv6sa65gtv80ctp3godkqa",
  }
  payload = "language=en&commodity=WHEAT&fromDate=2024-02-01&toDate=2024-02-01"

  resp = requests.post(url, headers=headers, data=payload)
  resObj = resp.json()
  data = resObj['data']

  csv_array = []

  for data_item in data:
    date = datetime.datetime.now().strftime("%m/%d/%Y")
    csv_array.append([data_item['state'], "Faridabad", data_item['apmc'], data_item['commodity'], "Others", date, data_item['min_price'], data_item['max_price'], data_item['modal_price']])

  return csv_array

def cronJob():
    newData = fetch_data()

    with open('your_updated_file.csv', 'a') as csvFile:
      writer = csv.writer(csvFile)
      writer.writerows(newData)

    df = pd.read_csv('your_updated_file.csv')
    df.drop(['variety'], axis=1, inplace=True)
    df.isnull().sum()
    data2 = df.copy()
    data2 = data2.dropna()
    data2.isnull().sum()
    Dict = {1:"january", 2:"february", 3:"march", 4:"april", 5:"may", 6:"june", 7:"july", 8:"august", 9:"september", 10:"october", 11:"november", 12:"december"}
    month_Column = []
    for rr in data2["arrival_date"]:
      str = rr
      str2 = str.split('/')
      month_Column.append(Dict[int(str2[0])])
    data2["month_Column"] = month_Column
    season_names = []

    for tt in data2["month_Column"]:
      if tt in ["december", "january", "february"]:
        season_names.append("winter")
      elif tt in ["march", "april", "may"]:
        season_names.append("spring")
      elif tt in ["june", "july", "august"]:
        season_names.append("summer")
      elif tt in ["september", "october", "november"]:
        season_names.append("autumn")
    data2["season_names"] = season_names
    day_of_week = []
    for rr in data2["arrival_date"]:
      str = rr
      df = pd.Timestamp(rr)
      day = df.dayofweek
      day_of_week.append(day)
    data2["day"] = day_of_week
    data2 = data2.drop(["arrival_date"], axis=1)
    Q1 = np.percentile(data2['modal_price'],25,interpolation='midpoint')

    Q3 = np.percentile(data2['modal_price'],75,interpolation='midpoint')
    IQR = Q3-Q1
    upper = np.where(data2['modal_price'] >= (Q3+1.5*IQR))

    lower = np.where(data2['modal_price'] <= (Q1-1.5*IQR))
    data2.drop(upper[0],inplace=True)
    data2.drop(lower[0],inplace=True)
    df = data2.copy()
    data2["commodity"] = data2["commodity"].map(commodity_map)
    data2["market"] = data2["market"].map(market_mapping)
    data2["state"] = data2["state"].map(state_mapping)
    data2["district"] = data2["district"].map(district_mapping)
    data2["season_names"] = data2["season_names"].map(season_mapping)
    data2["month_Column"] = data2["month_Column"].map(month_mapping)

    features = data2[['commodity', 'state', 'district', 'market', 'month_Column', 'season_names', 'day']]

    labels = data2['modal_price']
    Xtrain,Xtest,Ytrain,Ytest = train_test_split(features,labels,test_size=0.2,random_state=2)
    regr = RandomForestRegressor(max_depth=1000, random_state=2)
    regr.fit(Xtrain, Ytrain)

    if os.path.exists('model3.pkl'):
      os.remove('model3.pkl')

    pickle.dump(regr, open('model3.pkl', 'wb'))


schedule.every(24).hours.do(cronJob)

# while True:
#     schedule.run_pending()
#     time.sleep(3600)
fetch_data()