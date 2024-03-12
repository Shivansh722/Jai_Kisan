// import 'package:flutter/material.dart';



// class SoilResultPage extends StatelessWidget {
//   final xFile? selectedSoilImage;
//   final String? resultSoilClass;
//   final double? resultSoilConfidence;

//   const SoilResultPage({
//     Key? key,
//     required this.selectedSoilImage,
//     required this.resultSoilClass,
//     required this.resultSoilConfidence,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Soil Detection Result'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (selectedSoilImage != null)
//               Image.file(
//                 File(selectedSoilImage!.path),
//                 height: 200,
//                 width: 200,
//                 fit: BoxFit.cover,
//               ),
//             const SizedBox(height: 20),
//             if (resultSoilClass != null && resultSoilConfidence != null)
//               Column(
//                 children: [
//                   Text('Soil Class: $resultSoilClass'),
//                   Text('Soil Confidence: $resultSoilConfidence'),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
