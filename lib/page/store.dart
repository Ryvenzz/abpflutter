// import 'package:flutter/material.dart';
// import 'package:abp/item/catalog.dart';
// import 'package:abp/API/api_service.dart';

// class StorePage extends StatefulWidget {
//   @override
//   _StorePageState createState() => _StorePageState();
// }

// class _StorePageState extends State<StorePage> {
//   late Future<List<catalog>> futureCatalog;

//   @override
//   void initState() {
//     super.initState();
//     futureCatalog = ApiService.fetchShops(); // Assume 0 fetches all stores or modify accordingly
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Toko-Toko',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: const Color.fromRGBO(134, 28, 30, 1),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'Toko-Toko',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Expanded(
//               child: FutureBuilder<List<catalog>>(
//                 future: futureCatalog,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return Center(child: Text('No stores found'));
//                   }

//                   final catalogs = snapshot.data!;
//                   final storeNames = catalogs.map((item) => item.shopNamaToko).toSet().toList();

//                   return GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 0.75,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                     ),
//                     itemCount: storeNames.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(
//                             context,
//                             '/catalog',
//                             arguments: storeNames[index],
//                           );
//                         },
//                         child: Container(
//                           padding: EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: Colors.grey[200],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Center(
//                             child: Text(storeNames[index]),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
