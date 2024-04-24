import 'package:flutter/material.dart';
import 'package:indocars/models/car.dart';
import 'package:indocars/services/car_service.dart';

class TestReadCar extends StatefulWidget {
  const TestReadCar({super.key});

  @override
  State<TestReadCar> createState() => _TestReadCarState();
}

class _TestReadCarState extends State<TestReadCar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Car>>(
        future: CarService.getCars(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }else if(snapshot.hasError){
            return Center(child: Text('error: ${snapshot.error}'));
          }else{
            List<Car> cars = snapshot.data ?? [];
            return ListView.builder(
                itemCount: cars.length,
                itemBuilder: (context, index) {
                 return Row(
                   children: [
                     for(var img in cars[index].images!)
                       Container(height: 100, width: 100,
                         decoration: BoxDecoration(
                             image: DecorationImage(
                                 image: NetworkImage(img)
                         ),
                       ),
                       ),
                     Text(cars[index].model),
                   ],
                 );
                },
            );
          }
        },
      ),
    );
  }
}
