import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indocars/admin/car_list.dart';
import 'package:indocars/components/build_input_component.dart';
import 'package:indocars/models/car.dart';
import 'package:indocars/constants.dart';
import 'package:indocars/services/car_service.dart';

class EditCar extends StatefulWidget {
  Car car;

  EditCar({super.key, required this.car});

  @override
  State<EditCar> createState() => _EditCarState();
}

class _EditCarState extends State<EditCar> {
  TextEditingController modelController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController seatController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController topSpeedController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController gearboxController = TextEditingController();

  String selectedRentPeriodValue = '';
  String selectedFuelValue = "";

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    selectedFuelValue = widget.car.fuel;
    selectedRentPeriodValue = widget.car.rentPeriod;
    brandController.text = widget.car.brand;
    modelController.text = widget.car.model;
    colorController.text = widget.car.color;
    gearboxController.text = widget.car.gearbox.toString();
    priceController.text = widget.car.price.toString();
    seatController.text = widget.car.seat.toString();
    topSpeedController.text = widget.car.topSpeed.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Edit Car",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        child: ListView(
          children: [
            SizedBox(height: 20),
            BuildInputText(controller: modelController, label: "Model"),
            SizedBox(height: 20),
            BuildInputText(controller: brandController, label: "Brand"),
            SizedBox(height: 20),
            BuildInputText(
                controller: seatController,
                label: "Seat",
                keyboardType: TextInputType.number),
            SizedBox(height: 20),
            BuildInputText(controller: colorController, label: "Color"),
            SizedBox(height: 20),
            BuildInputText(
                controller: topSpeedController,
                label: "Top Speed",
                keyboardType: TextInputType.number),
            SizedBox(height: 20),
            BuildInputText(
                controller: gearboxController,
                label: "Gearbox",
                keyboardType: TextInputType.number),
            SizedBox(height: 20),
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
            SizedBox(height: 20),
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
            SizedBox(height: 20),
            BuildInputText(
                controller: priceController,
                label: "Price",
                keyboardType: TextInputType.number),
            Divider(),
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
                  child: _isSaving
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              kPrimaryColorShadow),
                        )
                      : Text(
                          "Save",
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
    );
  }

  void handleSaveCar() async {
    setState(() {
      _isSaving = true;
    });

    Car car = Car(
      id: widget.car.id,
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
    print(car);
    try {
      bool success = await CarService.updateCar(car);
      if (success) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CarList()));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Car is updated successfully.'),
            backgroundColor: Colors.green.shade400,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update car'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print(e);
    }

    setState(() {
      _isSaving = false;
    });
  }
}
