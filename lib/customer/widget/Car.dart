import 'package:flutter/material.dart';

class Car extends StatelessWidget {
  final String imgUrl;
  final String vehicleName;

  const Car({
    super.key,
    required this.imgUrl,
    required this.vehicleName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 450,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        color: Colors.black54,
      ),
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(15)),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 50,
              ),
              SizedBox(
                width: 25,
                height: 25,
                child: Image.asset('assets/images/rr.jpg'),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                vehicleName,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const SizedBox(
                width: 60,
              ),
              const Text(
                '4.5',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const Icon(
                Icons.star,
                color: Colors.orange,
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Image.network(imgUrl),
              )
            ],
          )
        ],
      ),
    );
  }
}
