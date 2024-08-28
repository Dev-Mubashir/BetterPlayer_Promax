import 'package:flutter/material.dart';
import 'package:tamasha_bp/Tamasha/MorePage/widgets/middle_container.dart';
import 'package:tamasha_bp/Tamasha/MorePage/widgets/more_options.dart';
import 'package:tamasha_bp/Tamasha/MorePage/widgets/top_container.dart';

// ignore: use_key_in_widget_constructors
class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final options = getOptions(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 25,
        ),
      ),
      body: Column(
        children: [
          const TopContainer(),
          const MiddleContainer(),
          // List of Options
          Expanded(
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                return ListTile(
                  visualDensity: VisualDensity.compact,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  leading:
                      Icon(options[index].icon, color: Colors.white, size: 24),
                  title: Row(
                    children: [
                      Text(options[index].text,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14)),
                      options[index].child ?? const SizedBox(),
                    ],
                  ),
                  onTap: options[index].onTap,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
