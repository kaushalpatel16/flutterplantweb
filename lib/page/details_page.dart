import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:plantweb/core/color.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class DetailsPage extends StatelessWidget {
  const DetailsPage(jsonDecode, {Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return
      Scaffold(
        body: SafeArea(
          child: FutureBuilder(builder: (context,snapshot) {
            if(snapshot.hasData){
              return PageView.builder(
                itemBuilder:(context,index){
                  return Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: height / 2,
                            decoration: BoxDecoration(
                              color: lightGreen,
                              boxShadow: [
                                BoxShadow(
                                  color: black.withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(60),
                                bottomRight: Radius.circular(60),
                              ),
                            ),
                            child:ClipRRect(

                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(60),
                                  bottomRight: Radius.circular(60),
                                ),

                                child: Image.network((jsonDecode(snapshot.data!.body.toString())[index]['ImagePath']).toString(),height:double.infinity,width:double.infinity,fit: BoxFit.fill,)),


                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: (jsonDecode(snapshot.data!.body.toString())[index]['name']).toString(),
                                            style: TextStyle(
                                              color: black.withOpacity(0.8),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '  (${(jsonDecode(snapshot.data!.body.toString())[index]['Category']).toString()} Plant)',
                                            style: TextStyle(
                                              color: black.withOpacity(0.5),
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 30.0,
                                      width: 30.0,
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: green,
                                        boxShadow: [
                                          BoxShadow(
                                            color: green.withOpacity(0.2),
                                            blurRadius: 15,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Image.asset(
                                        'assets/icons/heart.png',
                                        color: white,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20.0),
                                RichText(
                                  text: TextSpan(
                                    text: (jsonDecode(snapshot.data!.body.toString())[index]['Description']).toString(),
                                    style: TextStyle(
                                      color: black.withOpacity(0.5),
                                      fontSize: 15.0,
                                      height: 1.4,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Text(
                                  'Treatment',
                                  style: TextStyle(
                                    color: black.withOpacity(0.9),
                                    fontSize: 18.0,
                                    height: 1.4,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),

                                const SizedBox(height: 20.0),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Image.asset('assets/icons/sun.png',
                                              color: black, height: 24.0),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Image.asset('assets/icons/drop.png',
                                              color: black, height: 24.0),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Image.asset('assets/icons/temperature.png',
                                              color: black, height: 24.0),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Image.asset('assets/icons/up_arrow.png',
                                              color: black, height: 24.0),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                        ),flex: 2,
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back),
                          ),
                          Image.asset('assets/icons/cart.png',
                              color: black, height: 40.0),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 15.0),
                          decoration: BoxDecoration(
                            color: green,
                            boxShadow: [
                              BoxShadow(
                                color: green.withOpacity(0.3),
                                blurRadius: 15,
                                offset: const Offset(0, -5),
                              ),
                            ],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(60),
                            ),
                          ),
                          child: Text(
                            'Buy \$${(jsonDecode(snapshot.data!.body.toString())[index]['Price']).toString()}',
                            style: TextStyle(
                              color: white.withOpacity(0.9),
                              fontSize: 18.0,
                              height: 1.4,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },);
            }
            else{
              return const Center(child: CircularProgressIndicator(),);
            }
          },
            future: getDataFromwebserver(),
          ),
        ),
      );
  }

  Future<http.Response> getDataFromwebserver() async {
    var response = await http.get(
        Uri.parse('https://631189bb19eb631f9d742399.mockapi.io/Book'));
    print(response.body.toString());
    return response;
  }
}