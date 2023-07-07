import 'package:cuaca/provider/cuaca_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CuacaProvider cuacaProvider = CuacaProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer<CuacaProvider>(
            builder: (context, provider, child) {
              // Mendapatkan tanggal saat ini
              DateTime currentDate = DateTime.now();
              // Mendapatkan nama hari dalam bahasa Inggris
              String formattedDay = DateFormat.EEEE().format(currentDate);
              // Mendapatkan nama bulan dalam bahasa Inggris
              String formattedMonth = DateFormat.MMMM().format(currentDate);
              // Mendapatkan tanggal
              String formattedDate = DateFormat.d().format(currentDate);

              // Gambar latar belakang berdasarkan jenis cuaca
              DecorationImage backgroundImage;
              if (provider.cuacaModel.weather?.first.main == "Clouds") {
                backgroundImage = const DecorationImage(
                  image: AssetImage('assets/images/cloud.jpg'),
                  fit: BoxFit.cover,
                );
              } else if (provider.cuacaModel.weather?.first.main == "Clear") {
                backgroundImage = const DecorationImage(
                  image: AssetImage('assets/images/clear2.jpg'),
                  fit: BoxFit.cover,
                );
              } else if (provider.cuacaModel.weather?.first.main == "Haze") {
                backgroundImage = const DecorationImage(
                  image: AssetImage('assets/images/cleary.jpg'),
                  fit: BoxFit.cover,
                );
              } else if (provider.cuacaModel.weather?.first.main == "Rain") {
                backgroundImage = const DecorationImage(
                  image: AssetImage('assets/images/rainy.jpg'),
                  fit: BoxFit.cover,
                );
              } else if (provider.cuacaModel.weather?.first.main == "Snow") {
                backgroundImage = const DecorationImage(
                  image: AssetImage('assets/images/snowy.jpg'),
                  fit: BoxFit.cover,
                );
              } else {
                backgroundImage = const DecorationImage(
                  image: AssetImage('assets/images/default.jpg'),
                  fit: BoxFit.cover,
                );
              }

              return SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    image: backgroundImage,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: TextFormField(
                                    controller: provider.cityNameText,
                                    decoration: const InputDecoration(
                                      hintText: "Masukkan Nama Kota",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            FloatingActionButton(
                              onPressed: () {
                                provider.showWeatherData();
                              },
                              child: const Icon(Icons.search),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${provider.cuacaModel.name?? ''} ",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "$formattedDay, $formattedMonth $formattedDate",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 40),
                              Text(
                                "${provider.cuacaModel.main?.temp ?? ''} °C",
                                style: TextStyle(
                                  fontSize: 60,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 40),
                              Text(
                                "${provider.cuacaModel.weather?.first.main?? ''} ",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "${provider.cuacaModel.main?.tempMin?? '' }/${provider.cuacaModel.main?.tempMax?? ''} ",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
