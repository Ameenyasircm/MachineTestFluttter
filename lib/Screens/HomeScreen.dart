import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Constants/text_vdieo.dart';
import 'package:project/providers/mainProvider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider =
    Provider.of<MainProvider>(context, listen: false);
    MediaQueryData queryData;
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    queryData=MediaQuery.of(context);
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: height*0.05,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<MainProvider>(
              builder: (context,value,child) {
                return Container(
                  width: width,
                  height: height*0.15,
                  decoration: BoxDecoration(color: Colors.greenAccent,borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 34,
                        backgroundImage:
                        NetworkImage(value.image),
                      ),
                    SizedBox(width: width*0.03,),
                    Container(width: width*0.6,
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(value.name,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600),),
                          Text(value.phone),
                        ],
                      ),
                    )
                  ],),
                ),
                );
              }
            ),
          ),
          SizedBox(height: height*0.01,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            Container(
              height: 242,//height * .270
              width: width,
              decoration:BoxDecoration(
                  color:Colors.grey,
                  border:Border(
                    top: BorderSide(
                      color: Colors.greenAccent,
                      width: 5,
                    ),
                    bottom: BorderSide(
                      color: Colors.greenAccent,
                      width: 5,
                    ),

                  )),
              child: ClipRRect(
                // borderRadius: BorderRadius.all(
                //     Radius.circular(20)
                // ),
                child: YoutubeAppDemo(
                  link: 'F2xtrS3xSLo'
                      .toString(),
                ),
              ),
            )
          )

        ],
      ),
    );
  }
}
