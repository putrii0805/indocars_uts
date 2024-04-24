class Car {
  int? id;
  int price, gearbox, seat, topSpeed;
  String model, brand, color, rentPeriod, fuel;
  List? images;

  Car({
    this.id,
    required this.model,
    required this.brand,
    required this.color,
    required this.seat,
    required this.gearbox,
    required this.fuel,
    required this.topSpeed,
    required this.rentPeriod,
    required this.price,
    this.images,
  });

  Car.fromJson(Map json)
      : id = json['id'],
        brand = json['brand'],
        model = json['model'],
        color = json['color'],
        seat = json['seat'],
        gearbox = json['gearbox'],
        fuel = json['fuel'],
        topSpeed = json['top_speed'],
        rentPeriod = json['rent_period'],
        price = json['price'],
        images = json['images'];

  Map toJson(){
    return{
      'id' : id,
      'brand' : brand,
      'model' : model,
      'color' : color,
      'seat' : seat,
      'gearbox' : gearbox,
      'fuel' : fuel,
      'top_speed' : topSpeed,
      'rent_period' : rentPeriod,
      'price' : price,
      'images' : images
    };
  }
}
