import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/Screens/HomeScreen.dart';
import 'package:project/providers/mainProvider.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider =
    Provider.of<MainProvider>(context, listen: false);
    MediaQueryData queryData;
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    queryData=MediaQuery.of(context);
    return
      Scaffold(
        backgroundColor: Colors.greenAccent,
      body: queryData.orientation==Orientation.portrait?
      Padding(
        padding: const EdgeInsets.only(left: 12.0,right: 12),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height*0.1,),
              Consumer<MainProvider>(
                builder: (context,value,child) {
                  return value.fileimage!=null?InkWell(
                    onTap: (){
                      value.chooseImage(context);
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage:
                      FileImage(value.fileimage!),
                    ),
                  ):InkWell(onTap: (){
                    value.chooseImage(context);
                  },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                     AssetImage('assets/Image.png'),
                    ),
                  );
                }
              ),
              SizedBox(height: height*0.04,),
              Consumer<MainProvider>  (
                builder: (context,value,child) {
                  return Container(
                    height: MediaQuery.of(context).size.height * .07,
                    child: TextFormField(
                      controller: value.regNameCT,
                      onChanged: (value) {

                      },
                      style:
                      const TextStyle(color: Colors.black, fontSize: 20),
                      autofocus: false,
                      keyboardType: TextInputType.name,
                      textAlign: TextAlign.center,
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      decoration: InputDecoration(

                        fillColor: Colors.white,
                        counterStyle: TextStyle(color: Colors.black),
                        hintStyle:
                        TextStyle(color:Colors.black, fontSize: 15),
                        // contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        // labelText: 'MOBILE NUMBER',,
                        hintText: 'Enter Your Name',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),

                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
              SizedBox(height: height*0.04,),
              Consumer<MainProvider>(
                  builder: (context,value,child) {
                    return Container(
                      height: MediaQuery.of(context).size.height * .07,
                      child: TextFormField(
                        controller: value.regEmailCT,
                        onChanged: (value) {

                        },
                        style:
                        const TextStyle(color: Colors.black, fontSize: 20),
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        decoration: InputDecoration(

                          fillColor: Colors.white,
                          counterStyle: TextStyle(color: Colors.black),
                          hintStyle:
                          TextStyle(color:Colors.black, fontSize: 15),
                          // contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          // labelText: 'MOBILE NUMBER',,
                          hintText: 'Enter Your Email Id',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),

                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              ),
              SizedBox(height: height*0.04,),
              Consumer<MainProvider>(
                  builder: (context,value,child) {
                    return Container(
                      height: MediaQuery.of(context).size.height * .098,
                      child: TextFormField(
                        maxLength: 10,
                        controller: value.regPhoneCT,
                        onChanged: (value) {

                        },
                        style:
                        const TextStyle(color: Colors.black, fontSize: 20),
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        decoration: InputDecoration(

                          fillColor: Colors.white,
                          counterStyle: TextStyle(color: Colors.black),
                          hintStyle:
                          TextStyle(color:Colors.black, fontSize: 15),
                          // contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          // labelText: 'MOBILE NUMBER',,
                          hintText: 'Enter Your Mobile No',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),

                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              ),
              SizedBox(height: height*0.04,),
              Consumer<MainProvider>(
                  builder: (context,value,child) {
                    return InkWell(onTap: (){
                      print('bhcdcjerfver');
                      value.selectDate(context);

                    },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .07,
                        child: TextFormField(
                          onTap: (){
                          },
                          controller: value.regDobCT,
                          onChanged: (value) {

                          },
                          style:
                          const TextStyle(color: Colors.black, fontSize: 20),
                          autofocus: false,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          enabled: false,
                          inputFormatters: [LengthLimitingTextInputFormatter(10)],
                          decoration: InputDecoration(

                            fillColor: Colors.white,
                            counterStyle: TextStyle(color: Colors.black),
                            hintStyle:
                            TextStyle(color:Colors.black, fontSize: 15),
                            // contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            // labelText: 'MOBILE NUMBER',,
                            hintText: 'Select DOB',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),

                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              ),
              SizedBox(height: height*0.04,),
              SizedBox(width: width*0.6,
                child: MaterialButton(onPressed: (){
                  mainProvider.insertDataFun();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>HomeScreen()));

                },height: 50,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  splashColor: Colors.greenAccent.withOpacity(0.5),
                  elevation: 1.0,
                  minWidth: 50.0,color: Colors.white,
                  child: Center(child: Text('Save')),
                ),
              )
            ],
          ),
        ),
      ):SizedBox(),
    );
  }
}
