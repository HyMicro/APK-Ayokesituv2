import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 355,
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset('assets/img/svg/Search.svg'),
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: "",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
              onChanged: (value) {
                // Handle search
              },
            ),
          ),
        ],
      ),
    );
  }
}