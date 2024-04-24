import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indocars/admin/car_list.dart';
import 'package:indocars/available_cars.dart';
import 'package:indocars/constants.dart';
import 'package:indocars/components/build_input_component.dart';
import 'package:indocars/services/car_service.dart';
import 'package:indocars/models/car.dart';
import 'package:indocars/showroom.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  TextEditingController modelController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController seatController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController topSpeedController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController gearboxController = TextEditingController();

  String selectedRentPeriodValue = "Daily";
  String selectedFuelValue = "Diesel";

  List<Uint8List> files = [];
  bool _isSaving = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Add Car',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  _pickImageFromGallery();
                },
                child: Container(
                  padding:
                      files.isEmpty ? EdgeInsets.all(20) : EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(
                      style: BorderStyle.solid,
                      color: Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      files.isNotEmpty
                          ? Container(
                              height: 100,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  for (var file in files)
                                    Stack(
                                      children: [
                                        Image(image: MemoryImage(file)),
                                        Positioned(
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                files.remove(file);
                                              });
                                            },
                                            child: const Icon(
                                              Icons.cancel,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                ],
                              ))
                          : Column(
                              children: [
                                Center(
                                  child: Text(
                                    'Select image for your car',
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Icon(
                                  Icons.add_photo_alternate_rounded,
                                  size: 42,
                                  color: kPrimaryColor,
                                )
                              ],
                            ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              BuildInputText(controller: modelController, label: "Model"),
              const SizedBox(
                height: 20,
              ),
              BuildInputText(controller: brandController, label: "Brand"),
              const SizedBox(
                height: 20,
              ),
              BuildInputText(
                controller: seatController,
                label: "Seat",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 30,
              ),
              BuildInputText(controller: colorController, label: "Color"),
              const SizedBox(
                height: 30,
              ),
              BuildInputText(controller: topSpeedController, label: "Top Speed", keyboardType: TextInputType.number),
              const SizedBox(
                height: 30,
              ),
              BuildInputText(
                  controller: gearboxController,
                  label: "Gearbox",
                  keyboardType: TextInputType.number),
              const SizedBox(
                height: 30,
              ),
              const Text("Fuel"),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: [
                        Radio(
                          value: "Diesel",
                          groupValue: selectedFuelValue,
                          onChanged: (value) => setState(
                            () => selectedFuelValue = "Diesel",
                          ),
                          activeColor: kPrimaryColor,
                        ),
                        const Text("Diesel")
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Radio(
                          value: "Gasoline",
                          groupValue: selectedFuelValue,
                          onChanged: (value) => setState(
                            () => selectedFuelValue = "Gasoline",
                          ),
                          activeColor: kPrimaryColor,
                        ),
                        const Text("Gasoline")
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Radio(
                          value: "Petrol",
                          groupValue: selectedFuelValue,
                          onChanged: (value) => setState(
                            () => selectedFuelValue = "Petrol",
                          ),
                          activeColor: kPrimaryColor,
                        ),
                        const Text("Petrol")
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Rent Period"),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Radio<String>(
                          activeColor: kPrimaryColor,
                          value: 'Daily',
                          groupValue: selectedRentPeriodValue,
                          onChanged: (value) => setState(
                            () => selectedRentPeriodValue = "Daily",
                          ),
                        ),
                        const Text("Daily")
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Radio<String>(
                          activeColor: kPrimaryColor,
                          value: 'Weekly',
                          groupValue: selectedRentPeriodValue,
                          onChanged: (value) => setState(
                            () => selectedRentPeriodValue = "Weekly",
                          ),
                        ),
                        const Text("Weekly")
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Radio<String>(
                          activeColor: kPrimaryColor,
                          value: 'Monthly',
                          groupValue: selectedRentPeriodValue,
                          onChanged: (value) => setState(
                            () => selectedRentPeriodValue = "Monthly",
                          ),
                        ),
                        const Text("Monthly")
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              BuildInputText(
                controller: priceController,
                label: "Price(Rp)",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              GestureDetector(
                onTap: _isSaving ? null : handleSaveCar,
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFF6A00), Color(0xFFFFA96B)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: _isSaving? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColorShadow),
                    ) : Text(
                      "Simpan",
                      style: TextStyle(
                        fontSize: 20,
                        color: kPrimaryColorShadow,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void handleSaveCar() async{

    setState(() {
      _isSaving = true;
    });

    Car car = Car(
      brand: brandController.text,
      model: modelController.text,
      color: colorController.text,
      seat: int.parse(seatController.text),
      fuel: selectedFuelValue,
      rentPeriod: selectedRentPeriodValue,
      gearbox: int.parse(gearboxController.text),
      price: int.parse(priceController.text),
      topSpeed: int.parse(topSpeedController.text),
    );
    try{
     bool success = await CarService.insertCar(car, files);
     if(success){
       Navigator.pop(context,true);

       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: Text('Car added successfully'),
           backgroundColor: Colors.green.shade400,
         ),
       );
     }else{
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: Text('Failed to add car'),
           backgroundColor: Colors.red,
         ),
       );
     }

    }catch(e){
      print(e);
    }

    setState(() {
      _isSaving = false;
    });
  }
  Future _pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;
    setState(() {
      files.add(File(image.path).readAsBytesSync());
    });
  }
}
