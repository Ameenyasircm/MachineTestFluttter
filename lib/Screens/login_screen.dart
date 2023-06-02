import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:project/Screens/registrationScreen.dart';
import 'package:sms_autofill/sms_autofill.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
enum MobileVarificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}
class _LoginScreenState extends State<LoginScreen> {
  MobileVarificationState currentSate =
      MobileVarificationState.SHOW_MOBILE_FORM_STATE;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  late BuildContext context;
  String Code = "";
  bool showLoading = false;

  late String verificationId;
  FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference mRootReference = FirebaseDatabase.instance.ref();
  final FocusNode _pinPutFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Container(
        child: currentSate == MobileVarificationState.SHOW_MOBILE_FORM_STATE
            ? getMobileFormWidget(context)
            : getOtpFormWidget(context),
        // padding: const EdgeInsets.all(16),
      ),
    );
  }
  getOtpFormWidget(context) {
    EasyLoading.dismiss();
    setState(() => this.context = context);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
              color: Colors.greenAccent
              )),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*.5,
            color: Colors.green,
            child: Center(
              child: Container(height: 80,width: 80,
                decoration: const BoxDecoration(

                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*.35),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 3 / 10,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              child: const Text(
                                "OTP Verification",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.greenAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "OTP send to your Number",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ),
                            Container(
                              child: PinFieldAutoFill(
                                codeLength:   6,
                                focusNode: _pinPutFocusNode,
                                keyboardType: TextInputType.number,
                                autoFocus: true,
                                controller: otpController,
                                currentCode: "",
                                decoration:  BoxLooseDecoration(
                                    textStyle: TextStyle(color: Colors.black),
                                    radius: Radius.circular(5),
                                    strokeColorBuilder: FixedColorBuilder(Colors.greenAccent)),
                                onCodeChanged: (pin) {
                                  if (pin!.length == 6) {
                                    PhoneAuthCredential phoneAuthCredential =
                                    PhoneAuthProvider.credential(
                                        verificationId: verificationId,
                                        smsCode: pin);
                                    signInWithPhoneAuthCredential(
                                        phoneAuthCredential);
                                    otpController.text = pin;
                                    setState(() {
                                      Code = pin;
                                    });
                                  }
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: const [
                                  Text("Dont'receive OTP?"),
                                  Text("RESEND OTP"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  getMobileFormWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: SingleChildScrollView(
        child: Column(
          children: [
        SizedBox(
        height: MediaQuery.of(context).size.height*0.25,),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.3,
              child: Icon(Icons.login,size: 100,color: Colors.white,),
            ),


            // SizedBox(height: MediaQuery.of(context).size.height*.01,
            //   width: MediaQuery.of(context).size.width*.1,

            Container(
              margin: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * .3,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.green, Colors.greenAccent],
                  ),
                  color: const Color(0xFFEFF3DF).withOpacity(0.3),
                  border: Border.all(
                    width: 1,
                    color: Colors.white10,
                  ),
                  borderRadius:
                  const BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 1.0,
                        blurStyle: BlurStyle.outer),
                  ]),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      textAlign: TextAlign.center,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      controller: phoneController,
                      style: const TextStyle(
                          color: Colors.green,
                          fontFamily: 'MontserratSemiBold'),
                      decoration: InputDecoration(
                        hintText: "Mobile Number",
                        hintStyle:
                        const TextStyle(color: Color(0xff000000)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .07,
                      decoration: BoxDecoration(
                        gradient:  LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 1.0],
                          colors: [Colors.green, Colors.greenAccent],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            if (phoneController.text.length == 10) {
                              showLoading = true;
                            }
                          });
                          await auth.verifyPhoneNumber(
                              phoneNumber: "+91${phoneController.text}",
                              verificationCompleted:
                                  (phoneAuthCredential) async {
                                setState(() {
                                  print('jnrvnikfnv');
                                  showLoading = false;
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Verification Completed"),
                                  duration: Duration(milliseconds: 3000),
                                ));
                                if (kDebugMode) {}
                              },
                              verificationFailed: (verificationFailed) async {
                                setState(() {
                                  showLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content:
                                  Text("Sorry, Verification Failed"),
                                  duration: Duration(milliseconds: 3000),
                                ));
                                if (kDebugMode) {
                                  print(verificationFailed.message.toString());
                                }
                              },
                              codeSent:
                                  (verificationId, resendingToken) async {
                                setState(() {
                                  showLoading = false;
                                  currentSate = MobileVarificationState
                                      .SHOW_OTP_FORM_STATE;
                                  this.verificationId = verificationId;

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        "OTP sent to phone successfully"),
                                    duration:
                                    Duration(milliseconds: 3000),
                                  ));

                                  if (kDebugMode) {
                                    print("");
                                  }
                                });
                              },
                              codeAutoRetrievalTimeout:
                                  (verificationId) async {});
                        },

                        child: const Text(
                          "LOGIN",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                          textStyle: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'MontserratRegular',
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          minimumSize: const Size(120, 45),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    print('done 1  $phoneAuthCredential');
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
      await auth.signInWithCredential(phoneAuthCredential);
      if (kDebugMode) {
        print(' 1  $phoneAuthCredential');
      }
      setState(() {
        showLoading = false;
      });
      try {
        var LoginUser = authCredential.user;
        if (LoginUser != null) {

         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>RegistrationScreen()));


          if (kDebugMode) {
            print("Login SUccess");
          }
        }
      } catch (e) {
        const snackBar = SnackBar(
          content: Text('Otp failed'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print(e.toString());
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          e.message ?? "",
        ),
      ));
    }
  }
}
