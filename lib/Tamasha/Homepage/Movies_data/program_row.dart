import 'package:flutter/material.dart';
import 'package:tamasha_bp/Tamasha/Homepage/Movies_data/program_thumbnail.dart';
import 'package:tamasha_bp/Tamasha/Homepage/Movies_data/programs_data_model.dart';
import 'package:tamasha_bp/utils/colors.dart';

class ProgramRow extends StatelessWidget {
  final Program program;

  const ProgramRow({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                program.channelName!,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View more',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Color(kwhitecolor),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: program.programData!.length,
            itemBuilder: (context, index) {
              final programDatum = program.programData?[index];
              return ProgramThumbnail(
                  programDatum: programDatum ?? ProgramDatum());
            },
          ),
        ),
      ],
    );
  }
}
