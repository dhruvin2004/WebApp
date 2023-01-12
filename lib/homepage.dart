import 'package:crome/webpage.dart';
import 'package:flutter/material.dart';

import 'app_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return  Stack(
      children: [
        SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: h,
            width: w,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/image/bg_image.jpg"),
                    fit: BoxFit.fill)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Favourites",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: w,
                child: GridView.count(
                  childAspectRatio: 1/1.4,
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 35,
                  children: [
                    ...AppString.favourite
                        .map(
                          (e) => GestureDetector(
                        onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> WebPage(path: e['path'])));

                        },
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              height : 70,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.asset(
                                "${e['img']}",
                              ),
                            ),
                            Text("${e['name']}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    )
                        .toList(),
                    // Column(
                    //   children: [
                    //     Container(
                    //       margin: EdgeInsets.only(bottom: 5),
                    //       height : 70,
                    //       width: w,
                    //       decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           borderRadius: BorderRadius.circular(5)),
                    //       child: Icon(Icons.add,size: 40,)
                    //     ),
                    //     Text("Add",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
