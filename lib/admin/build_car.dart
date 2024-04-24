import 'package:flutter/material.dart';
import 'package:indocars/admin/edit_car.dart';
import 'package:indocars/data.dart';
import 'package:indocars/models/car.dart';
import 'package:indocars/constants.dart';
import 'package:indocars/services/car_service.dart';

Widget buildCar(BuildContext context, Car car, int index, Function onDeleteHandler) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    padding: const EdgeInsets.all(16),
    margin: EdgeInsets.only(
        right: index != null ? 16 : 0, left: index == 0 ? 16 : 0),
    width: 220,
    child: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    car.rentPeriod,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 120,
              child: Center(
                child: Hero(
                  tag: car.model,
                  child: Image.network(
                    car.images?[0],
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              car.model,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              car.brand,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditCar(car: car)));
                },
                child: const Icon(Icons.edit, color: Colors.green),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Delete Car'),
                        content: const Text("Are you sure to delete this car?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("No"),
                          ),
                          TextButton(
                            onPressed: ()async{
                               await onDeleteHandler(car);
                              Navigator.pop(context);
                            },
                            child: const Text("Yes", style: TextStyle(
                              color: Colors.red
                            ),),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red.shade400,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
