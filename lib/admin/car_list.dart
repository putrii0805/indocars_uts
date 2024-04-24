import 'package:indocars/admin/add_car.dart';
import 'package:indocars/admin/car_detail.dart';
import 'package:flutter/material.dart';
import 'package:indocars/constants.dart';
import 'package:indocars/data.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:indocars/services.dart';
import 'package:indocars/models/car.dart';
import 'package:indocars/services/car_service.dart';
import 'package:indocars/admin/build_car.dart';

class CarList extends StatefulWidget {
  // final List<Car> cars;
  // CarList({required this.cars});
  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  List<Car> cars = [];

  List<Filter> filters = getFilterList();
  late Filter selectedFilter;

  void _fetchCars() async {
    try {
      List<Car> fetchedCars =
          await CarService.getCars(); // Wait for getCars() to complete
      setState(() {
        cars = fetchedCars; // Assign fetched cars to the cars list
      });
    } catch (error) {
      print("Error fetching cars: $error");
      // Handle error
    }
  }

  @override
  void initState() {
    _fetchCars();
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Car List'),
        ),
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.black,
                        size: 28,
                      )),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Cars (" + cars.length.toString() + ")",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: GridView.count(
                    physics: const BouncingScrollPhysics(),
                    childAspectRatio: 1 / 1.5,
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 10,
                    children: cars.map((item) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailCar(car: item)),
                            );
                          },
                          child: buildCar(context, item, 0, deleteCar));
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCarScreen(),
                )).then((value) async {
                  _fetchCars();
                  setState(() {

                  });
            });
          },
          backgroundColor: kPrimaryColor,
          child: const Icon(
            Icons.add_circle,
            size: 32,
            color: Colors.white,
          ),
        ));
  }

  bool deleteCar(Car car) {
    CarService.deleteCar(car);
    setState(() {
      _fetchCars();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Car is deleted.'),
        backgroundColor: Colors.green,
      ),
    );
    return true;
  }
}
