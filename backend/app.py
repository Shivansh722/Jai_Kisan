import pickle
from io import BytesIO

import numpy as np
import requests
import tensorflow as tf
from commodity_mapping import commodity_map
from district_mapping import district_mapping
from flask import Flask, jsonify, request
from flask_cors import CORS
from market_mapping import market_mapping
from PIL import Image
from state_mapping import state_mapping

app = Flask(__name__)
CORS(app, supports_credentials=True, origins="*")

with open('model3.pkl', 'rb') as model_file:
    model = pickle.load(model_file)
    
MODEL = tf.keras.models.load_model("./saved_models/2")

CLASS_NAMES = ["Early Blight", "Late Blight", "Healthy"]

def read_file_as_image(data) -> np.ndarray:
    image = np.array(Image.open(BytesIO(data)))
    return image
    

@app.route('/')
def home():
    return jsonify({'message': 'Hello World'})

@app.route('/current_price', methods=['POST'])
def current_price():
    try:
        reqBody = request.get_json(force=True)
        commodity = reqBody['commodity']
        state = reqBody['state']
        market = reqBody['market']  # Make sure 'market' matches the key in the request JSON
        
        url = "https://enam.gov.in/web/Ajax_ctrl/trade_data_list"
        headers = {
            "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
            "Cookie": "SERVERID=node1; ci_session=hkhrqtfs9a2rgubir1gmj512n4l601m5; uniqueCode=20240719088",
        }
        payload = "language=en&commodityName={}&stateName={}&apmcName={}&fromDate=2024-03-07&toDate=2024-03-10".format(commodity, state, market)  

        resp = requests.post(url, headers=headers, data=payload)
        resObj = resp.json()
        print(resObj)
        
        if 'data' in resObj:
            data = resObj['data']
            
            # filter data
            data = list(filter(lambda x: x['commodity'] == commodity, data))
            data = list(filter(lambda x: x['state'] == state, data))
            data = list(filter(lambda x: x['apmc'] == market, data))

            print(data)
            if data:
                return jsonify({
                    'success': True,
                    'prices': {
                        'max_price': data[0]['max_price'],
                        'min_price': data[0]['min_price'],
                        'modal_price': data[0]['modal_price']
                    }
                })
            else:
                return jsonify({'error': 'No data found for the given criteria.'})
        else:
            return jsonify({'error': 'No data returned from the server.'})
        
    except Exception as e:
        print(e)
        return jsonify({'error': 'An error occurred: ' + str(e)})

@app.route('/predict',methods=['post'])
def get():
    try:
        data = request.get_json(force=True)
        
        commodity_value = commodity_map.get(data['commodity'], -1)
        if commodity_value == -1:
            return jsonify({'error': 'Commodity not found in mapping dictionary'})
        
        district_value = district_mapping.get(data['district'], -1)
        if district_value == -1:
            return jsonify({'error': 'District not found in mapping dictionary'})
        
        market_value = market_mapping.get(data['market'], -1)
        if market_value == -1:
            return jsonify({'error': 'Market not found in mapping dictionary'})
        
        state_value = state_mapping.get(data['state'], -1)
        if state_value == -1:
            return jsonify({'error': 'State not found in mapping dictionary'})
        
        user_input = [
            commodity_value,
            state_value,
            district_value,
            market_value,
            data['day']
        ]
        print(user_input)
        result = model.predict([[user_input[0],user_input[1],user_input[2],user_input[3],0,0,user_input[4]]])
        # return jsonify({'message': result.tolist()})
        return jsonify({
            "success": True,
            "price": result.tolist()[0]
        })
    except Exception as e:
        return jsonify({'error': str(e)})
    
    
@app.route('/predictleaf', methods=['POST'])
def predict():
    try:
        file = request.files['file']
        image = read_file_as_image(file.read())
        img_batch = np.expand_dims(image, 0)
        
        predictions = MODEL.predict(img_batch)

        predicted_class = CLASS_NAMES[np.argmax(predictions[0])]
        confidence = float(np.max(predictions[0]))
        return jsonify({
            'class': predicted_class,
            'confidence': confidence
        })
    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(host="0.0.0.0", debug=True)
