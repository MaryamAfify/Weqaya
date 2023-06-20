import 'dart:async';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:doctor/home_screen/screens/search_for_lab_doctor_screen/search_lab_doctor.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../doctor/doctorlist/spec.dart';
import '../../lab/lab_search/test.dart';
import '../../ocr/api_ocr/api_ocr.dart';
import '../../ocr/result/choose_lab.dart';
import '../../recommendation_screen/checkups_by_recommendation/checkups.dart';
import '../../recommendation_screen/recommendation_api/get_recommendation.dart';
import '../../styles/colors.dart';
import '../app_setting/screens/appSetting.dart';
import 'package:http/http.dart' as http;

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> with TickerProviderStateMixin {
  List information = [
    {"name": "Vitamin A"},
    {"name": "Vitamin C"},
    {"name": "Vitamin D"},
    {"name": "Vitamin E "},
    {"name": "Vitamin K"},
    {"name": "B vitamins"},
    {"name": "Vitamin deficiencies"},
    {"name": "vitamin C deficiency"},
    {"name": "A balanced diet"},
  ];
  List subinformation = [
    {"name": " is important for vision, immune function, and cell growth."},
    {
      "name":
          " is necessary for collagen production, wound healing, and immune function."
    },
    {
      "name":
          "plays a crucial role in calcium absorption, bone health, and immune system regulation."
    },
    {"name": "is an antioxidant that helps protect cells from damage."},
    {"name": " is essential for blood clotting and bone health."},
    {
      "name":
          "are involved in energy production, red blood cell formation, and nerve function."
    },
    {
      "name":
          "can lead to various health problems, depending on the specific vitamin lacking."
    },
    {
      "name":
          "can cause scurvy, while vitamin D deficiency can lead to weakened bones (rickets in children and osteomalacia in adults)."
    },
    {
      "name":
          " that includes a variety of fruits, vegetables, whole grains, lean proteins, and healthy fats is usually sufficient to meet the body's vitamin requirements."
    },
  ];
  ScrollController _scrollController = ScrollController();
  AnimationController? _animationController;
  List<double> _positionXList = [];
  List<double> _positionYList = [];
  final int numberOfIcons = 20;
  @override
  void initState() {
    super.initState();
    _initializePositions();
    _startAutoScroll();
    _startAnimation();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    Timer.periodic(Duration(seconds: 50), (timer) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(seconds: 20),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _initializePositions() {
    final random = Random();
    _positionXList =
        List.generate(numberOfIcons, (_) => random.nextDouble() * 300);
    _positionYList =
        List.generate(numberOfIcons, (_) => random.nextDouble() * 300);
  }

  void _startAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1),
    )..repeat();

    _animationController?.addListener(() {
      setState(() {
        final random = Random();
        for (int i = 0; i < _positionXList.length; i++) {
          _positionXList[i] += random.nextDouble() * 5 - 2.5;
          _positionYList[i] += random.nextDouble() * 5 - 2.5;
        }
      });
    });
  }

  File? _image;
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImageOCR(BuildContext context,
    File? image,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    if (image == null) return;

    // Replace with your API endpoint and token
    String apiUrl = 'http://hadyahmed-001-site1.ctempurl.com/api/Patient/OCR';

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.headers['Authorization'] = 'Bearer $token';
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    var response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response);
      print('Image uploaded successfully');
      
     Fluttertoast.showToast(
        msg: "Image uploaded successfully",
        toastLength: Toast.LENGTH_SHORT, // Duration of the toast
        gravity: ToastGravity.BOTTOM, // Position of the toast message
        backgroundColor: Colors.grey, // Background color of the toast
        textColor: Colors.white, // Text color of the toast
        fontSize: 16.0, // Font size of the toast message
      );

    } else {
      print('Image upload failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 667));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("Find your desire health solution"),
        backgroundColor: defaultColor,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
                alignment: Alignment.topLeft,
                width: 357,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    color: Colors.grey[200]),
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Search_lab_doctor();
                    }));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Search For A Doctor Or Lab"),
                    ],
                  ),
                )),
            Column(children: [
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 170,
                    height: 170,
                    child: MaterialButton(
                        elevation: 2,
                        color: Colors.white,
                        child: Column(children: [
                          Image.asset("images/l.jpg"),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Lab Visit", style: TextStyle(fontSize: 13))
                        ]),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Tests();
                          }));
                        }),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 170,
                    height: 170,
                    child: MaterialButton(
                        elevation: 2,
                        color: Colors.white,
                        child: Column(children: [
                          Image.asset(
                            "images/d.jpg",
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Clincal Vist", style: TextStyle(fontSize: 13))
                        ]),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return spec();
                          }));
                        }),
                  ),
                ],
              )),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 170,
                      height: 170,
                      child: MaterialButton(
                          elevation: 2,
                          color: Colors.white,
                          child: Column(children: [
                            Image.asset("images/r.jpg"),
                            Text("Recommended Tests",
                                style: TextStyle(fontSize: 13))
                          ]),
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          onPressed: () {
                            Api.getrecommtestsbutton(context);
                          }),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 170,
                          height: 170,
                          child: MaterialButton(
                            elevation: 2,
                            color: Colors.white,
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "images/logo.png",
                                        width: 200,
                                        height: 200,
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Upload your Prescription"),
                                          SizedBox(width: 15),
                                          GestureDetector(
                                            onTap: pickImage,
                                            child: const Icon(
                                                Icons.camera_alt_outlined),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              profilesColor, // Change the color to your desired color
                                        ),
                                        onPressed: () {
                                          uploadImageOCR(context,_image);
                                        },
                                        child: Text("Upload"),
                                      ),
                                      SizedBox(height: 20),
                                      MaterialButton(
                                        onPressed: () async {
                                          await Apiocr.getocr();
                                          await Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return ocrtests();
                                            }),
                                          );
                                        },
                                        padding: EdgeInsets.all(10.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        color: defaultColor,
                                        child: Text(
                                          'Get Results',
                                          style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 1.5,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            child: Column(
                              children: [
                                Image.asset("images/p.png"),
                                Text("Upload Prescription",
                                    style: TextStyle(fontSize: 13)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "  Health Information ",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Text(
                  "      ",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 400,
              height: 150,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: information.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: (() {}),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(14, 10, 14, 10),
                          width: 356,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 2,
                                  offset: Offset(3, 3),
                                  spreadRadius: 1.5,
                                ),
                              ]),
                          child: ListTile(
                            leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage(
                                  "images/dailyinfo.png",
                                )),
                            title: Text(
                              "${information[i]['name']}",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(16),
                              ),
                            ),
                            subtitle: Text(
                              "${subinformation[i]['name']}",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
