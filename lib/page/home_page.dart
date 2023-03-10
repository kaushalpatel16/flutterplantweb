import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:plantweb/core/color.dart';
import 'package:plantweb/data/category_model.dart';
import 'package:plantweb/data/plant_data.dart';
import 'package:plantweb/page/add_newplant.dart';
import 'package:plantweb/page/details_page.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'dart:async';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  PageController controller = PageController();

  @override
  void initState() {
    controller = PageController(viewportFraction: 0.6, initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      key: _sideMenuKey,
      menu: buildMenu(),
      type: SideMenuType.slideNRotate,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          automaticallyImplyLeading: false,
          leadingWidth: 40,
          leading: TextButton(
            onPressed: () {
              final _state = _sideMenuKey.currentState;
              if (_state!.isOpened)
                _state.closeSideMenu(); // close side menu
              else
                _state.openSideMenu();
            },
            child: Image.asset(
              'assets/icons/menu.png',
            ),
          ),


          actions: [
            Container(
              height: 40.0,
              width: 40.0,
              margin: const EdgeInsets.only(right: 20, top: 10, bottom: 5),
              decoration: BoxDecoration(
                color: green,
                boxShadow: [
                  BoxShadow(
                    color: green.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ],
                borderRadius: BorderRadius.circular(10.0),
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/avatar11.png',
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 20.0),
                child: Row(
                  children: [
                    Container(
                      height: 45.0,
                      width: 300.0,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: white,
                        border: Border.all(color: green),
                        boxShadow: [
                          BoxShadow(
                            color: green.withOpacity(0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 0),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            height: 45,
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search',
                              ),
                            ),
                          ),
                          Image.asset(
                            'assets/icons/search.png',
                            height: 25,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 45.0,
                      width: 45.0,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: green,
                        boxShadow: [
                          BoxShadow(
                            color: green.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(0, 0),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Image.asset(
                        'assets/icons/adjust.png',
                        color: white,
                        height: 25,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (int i = 0; i < categories.length; i++)
                      GestureDetector(
                        onTap: () {
                          setState(() => selectId = categories[i].id);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              categories[i].name,
                              style: TextStyle(
                                color: selectId == i
                                    ? green
                                    : black.withOpacity(0.7),
                                fontSize: 16.0,
                              ),
                            ),
                            if (selectId == i)
                              const CircleAvatar(
                                radius: 3,
                                backgroundColor: green,
                              )
                          ],
                        ),
                      )
                  ],
                ),
              ),

              SizedBox(
                height: 320.0,
                child: Scaffold(
                  body: FutureBuilder(builder: (context,snapshot) {
                    if(snapshot.hasData){
                      return PageView.builder(
                        itemCount: jsonDecode(snapshot.data!.body.toString()).length,
                        controller: controller,
                        physics: const BouncingScrollPhysics(),
                        padEnds: false,
                        pageSnapping: true,
                        onPageChanged: (value) => setState(() => activePage = value),
                        itemBuilder: (itemBuilder, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => DetailsPage(jsonDecode(
                                      snapshot.data!.body.toString())[index], ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15,left: 15),
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: white,

                                  border: Border.all(color: green, width:2),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Stack(
                                  children: [

                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(25.0),
                                        child:Image.network((jsonDecode(snapshot.data!.body.toString())[index]['ImagePath']).toString(),height:double.infinity,fit: BoxFit.fill,),


                                    ),

                                     Positioned(
                                      right: 8,
                                      top: 8,
                                      child: CircleAvatar(
                                        backgroundColor: green,
                                        radius: 20,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(
                                              MaterialPageRoute(
                                                builder: (context) => AddUser(jsonDecode(
                                                    snapshot.data!.body.toString())[index]),
                                              ),
                                            )
                                                .then(
                                                  (value) {
                                                if (value == true) {
                                                  setState(() {});
                                                }
                                              },
                                            );
                                          },
                                          child: Icon(Icons.edit,size: 25,),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 8,
                                      top: 50,
                                      child: CircleAvatar(
                                        backgroundColor: green,
                                        radius: 20,
                                        child: InkWell(
                                          onTap: () {
                                            deleteUser((jsonDecode(
                                                snapshot.data!.body.toString())[index]['id'])).then(
                                                  (value) {
                                                setState(() {});
                                              },
                                            );
                                          },
                                          child: Icon(Icons.delete,size: 25,),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 5),
                                        child: Row(
                                          children: [
                                            Text(
                                              (jsonDecode(snapshot.data!.body.toString())[index]['name']).toString(),
                                              style: TextStyle(
                                                color: black.withOpacity(0.7),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            Text(" - ",
                                              style: TextStyle(
                                                color: black.withOpacity(0.7),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            Text(
                                              (jsonDecode(snapshot.data!.body.toString())[index]['Price']).toString(),
                                              style: TextStyle(
                                                color: black.withOpacity(0.7),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
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
              ),
              Padding(
                padding:  EdgeInsets.only(top: 20,left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular',
                      style: TextStyle(
                        color: black.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Image.asset(
                        'assets/icons/more.png',
                        color: green,
                        height: 30,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 150.0,
                child: ListView.builder(
                  itemCount: populerPlants.length,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(left: 20.0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (itemBuilder, index) {
                    return Container(
                      width: 220.0,
                      margin:
                          const EdgeInsets.only(right: 20, bottom: 10, top: 30),
                      decoration: BoxDecoration(
                        color: lightGreen,
                        boxShadow: [
                          BoxShadow(
                            color: green.withOpacity(0.20),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                populerPlants[index].imagePath,
                                width: 70,
                                height: 70,
                              ),
                              const SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    populerPlants[index].name,
                                    style: TextStyle(
                                      color: black.withOpacity(0.7),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  Text(
                                    '\$${populerPlants[index].price.toStringAsFixed(0)}',
                                    style: TextStyle(
                                      color: black.withOpacity(0.4),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Positioned(
                            right: 20,
                            bottom: 20,
                            child: CircleAvatar(
                              backgroundColor: green,
                              radius: 15,
                              child: Image.asset(
                                'assets/icons/add.png',
                                color: white,
                                height: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => AddUser(null),
                      ),
                    )
                        .then(
                          (value) {
                        if (value == true) {
                          setState(() {});
                        }
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 100,right: 20),
                        child: Text(
                          'Add New Plant',
                          style: TextStyle(
                            color: black.withOpacity(0.7),
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                      Icon(Icons.add_box_rounded,color: Colors.green,size: 30,)
                    ],
                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildMenu() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 22.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  "Hello, Kaushal Patel",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => const HomePage()));
            },
            leading: const Icon(Icons.home, size: 20.0, color: Colors.white),
            title: const Text("Home"),
            textColor: Colors.white,
            dense: true,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.verified_user,
                size: 20.0, color: Colors.white),
            title: const Text("Profile"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.monetization_on,
                size: 20.0, color: Colors.white),
            title: const Text("Wallet"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.shopping_cart,
                size: 20.0, color: Colors.white),
            title: const Text("Cart"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading:
            const Icon(Icons.star_border, size: 20.0, color: Colors.white),
            title: const Text("Favorites"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading:
            const Icon(Icons.settings, size: 20.0, color: Colors.white),
            title: const Text("Settings"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
  int selectId = 0;
  int activePage = 0;
  Future<http.Response> getDataFromwebserver() async{
    var response=await http.get(Uri.parse('https://631189bb19eb631f9d742399.mockapi.io/Book'));
    print(response.body.toString());
    return response;
  }
  Future<void> deleteUser(id) async {
    var response1 = await http.delete(
        Uri.parse("https://631189bb19eb631f9d742399.mockapi.io/Book/$id"));
  }
}

