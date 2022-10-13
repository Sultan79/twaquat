import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twaquat/services/droupDown_user.dart';

class UsersDropDown extends StatefulWidget {
  const UsersDropDown({
    super.key,
    required this.hint,
    required this.title,
    required this.users,
    this.width = 350,
  });

  final String hint;
  final String title;
  final double width;
  final List users;
  @override
  State<UsersDropDown> createState() => _UsersDropDownState();
}

class _UsersDropDownState extends State<UsersDropDown> {
  var dropdownValue;
  List<String> usersName = [];

  void getUsersName() {
    for (var element in widget.users) {
      usersName.add(element['userName']);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsersName();
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.title;
    String hint = widget.hint;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        SizedBox(
          height: 13,
        ),
        SizedBox(
          height: 60,
          width: widget.width,
          child: DecoratedBox(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.0,
                    style: BorderStyle.solid,
                    color: Colors.grey.shade300),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              child: DropdownButton<dynamic>(
                value: dropdownValue,
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down),
                elevation: 16,
                onChanged: (newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    context.read<DropDownUsers>().userPicked = newValue;
                    print(context.read<DropDownUsers>().userPicked);
                  });
                },
                hint: Text(
                  hint,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                underline: SizedBox(),
                items: widget.users.map<DropdownMenuItem>((var value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Text(value['userName'])),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
