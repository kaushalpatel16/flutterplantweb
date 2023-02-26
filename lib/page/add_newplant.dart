import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddUser extends StatefulWidget {
  AddUser(this.map);

  Map? map;

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();
  TextEditingController CategoryController = TextEditingController();
  TextEditingController PriceController = TextEditingController();
  TextEditingController ImagePathController =TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text =
    widget.map == null ? "" : widget.map!['name'];
    DescriptionController.text = widget.map == null ? "" : widget.map!['Description'];
    CategoryController.text = widget.map == null ? "" : widget.map!['Category'];
    PriceController.text =
    widget.map == null ? "" : widget.map!['Price'];
    ImagePathController.text =
    widget.map == null ? "" : widget.map!['ImagePath'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      // border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.trim().length == 0) {
                              return 'Enter Valid Name';
                            }
                            return null;
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Enter  Name",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.trim().length == 0) {
                              return 'Enter Valid description';
                            }
                            return null;
                          },
                          controller: DescriptionController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Enter description",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.trim().length == 0) {
                              return 'Enter Valid category';
                            }
                            return null;
                          },
                          controller: CategoryController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Enter category",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.trim().length == 0 ) {
                              return 'Enter  price';
                            }
                            return null;
                          },
                          controller: PriceController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Enter price ",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.trim().length == 0) {
                              return 'Enter Valid Name';
                            }
                            return null;
                          },
                          controller: ImagePathController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Enter image",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(
                            () async {
                          if (_formKey.currentState!.validate()) {
                            if (widget.map == null) {
                              addUser().then(
                                    (value) => Navigator.of(context).pop(true),
                              );
                            } else {
                              updateUser(widget.map!['id']).then(
                                    (value) => Navigator.of(context).pop(true),
                              );
                            }
                          }
                        },
                      );
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addUser() async {
    Map map = {};
    map['name'] = nameController.text;
    map['Description'] = DescriptionController.text;
    map['Category'] = CategoryController.text;
    map['Price'] = PriceController.text;
    map['Image'] = ImagePathController.text;

    var response1 = await http.post(
        Uri.parse("https://631189bb19eb631f9d742399.mockapi.io/Book"),
        body: map);
    print(response1.body);
  }

  Future<void> updateUser(id) async {
    Map map = {};
    map['name'] = nameController.text;
    map['Description'] = DescriptionController.text;
    map['Category'] = CategoryController.text;
    map['Price'] = PriceController.text;
    map['Price'] = PriceController.text;

    var response1 = await http.put(
        Uri.parse("https://631189bb19eb631f9d742399.mockapi.io/Book/$id"),
        body: map);
    print(response1.body);
  }
}