import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tamasha_bp/Tamasha/Homepage/Movies_data/carousal.dart';
import 'package:tamasha_bp/Tamasha/Homepage/Movies_data/program_row.dart';
import 'package:tamasha_bp/Tamasha/Homepage/Movies_data/programs_data_model.dart';
import 'package:tamasha_bp/Tamasha/Homepage/SearchBarHome/search_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<ProgramsDataModel> _programsData;

  @override
  void initState() {
    super.initState();
    _programsData = fetchProgramsData();
  }

  Future<ProgramsDataModel> fetchProgramsData() async {
    final String response = await rootBundle.loadString('data.json');
    return ProgramsDataModel.fromJson(json.decode(response));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.text_fields_rounded,
              size: 30,
            ),
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieSearchBar(),
                ),
              ),
              icon: const Icon(Icons.search, size: 30),
            )
          ],
        ),
      ),
      body: FutureBuilder<ProgramsDataModel>(
        future: _programsData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.programs!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            return ListView(
              children: [
                CarouselExample(), // Add your carousel here
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data?.programs?.length,
                  itemBuilder: (context, index) {
                    final program = snapshot.data?.programs?[index];
                    return ProgramRow(program: program ?? Program());
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
