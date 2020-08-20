import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onTextChanged;

  SearchBar({
    Key key,
    this.onTextChanged,
    this.controller,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
          suffixIcon: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() {
                widget.controller.text = "";
              });
            },
          )),
    );
  }

  _onTextChanged() {
    widget.onTextChanged(widget.controller.text);
  }
}
