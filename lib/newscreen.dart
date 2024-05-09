import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_ui/wanttosee.dart';
import 'buildGridView.dart';
import 'myChatBot.dart';


class TikTokUI extends StatefulWidget {
  @override
  _TikTokUIState createState() => _TikTokUIState();
}

class _TikTokUIState extends State<TikTokUI>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFollowing = false;
  late List<bool> likedStatus; // Declare as late so it's initialized later

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  File? _imageFile;
  void _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
// for the dialog box for the gallery and camera
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
// iamges from internet
  final List<String> _imageUrls = [
    'https://st4.depositphotos.com/6903990/31458/i/450/depositphotos_314585930-stock-photo-beauty-girl-long-shiny-wavy.jpg',
    'https://www.angelopedia.com/newspic/9X1NXJM081Model-main.jpg',
    'https://static.toiimg.com/thumb/msid-67023037,width-400,resizemode-4/67023037.jpg',
    'https://www.awesomeindia.in/wp-content/uploads/2023/11/Zendaya.jpg',
    'https://w0.peakpx.com/wallpaper/738/294/HD-wallpaper-alexandra-daddario-actress-american-beautiful-eyes-thumbnail.jpg',
    'https://i.pinimg.com/236x/62/2a/18/622a185b7acb03126363e26c961e8264.jpg',
    'https://source.boomplaymusic.com/buzzgroup2/M00/38/5F/rBEe_GKzAjGAEX22AAGLKnKmBEs220.jpg',
    'https://i.pinimg.com/736x/80/3a/48/803a484290528f56bcfe2cc11d077a29.jpg',
    'https://images.filmibeat.com/img/popcorn/list_items/-20231120163631-617.jpg',
    'https://wallpapers.com/images/hd/actress-pictures-ppejzqzemk6ac2no.jpg',
  ];
//controller for the
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    likedStatus = List.generate(_imageUrls.length, (index) => false);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jenny wilson',
          style: TextStyle(fontSize: 20),
        ),
        // leding button and actio buttons are used
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Add your onPressed logic here
            },
          ),
          IconButton(
            icon: Icon(Icons.horizontal_distribute),
            onPressed: () {
              // Add your onPressed logic here
            },
          ),
        ],
      ),
      //nestedscrollview is used for scrolling in nested we can only use silver widgets
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            //silvertoboxadater is like a conatiner
            SliverToBoxAdapter(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(children: [
                      _imageFile != null
                          ? CircleAvatar(
                        radius: 50,
                        backgroundImage: (FileImage(_imageFile!)),
                      )
                          : const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-photo/woman-with-beauty-long-brown-hair-fashion-model-with-long-straight-hair-fashion-model-posing_186202-8460.jpg'),
                      ),
                      Positioned(
                        child: IconButton(
                          onPressed: _showImagePickerOptions,
                          icon: const Icon(Icons.add_a_photo),
                        ),
                        bottom: -10,
                        left: 80,
                      )
                    ]),
                    SizedBox(height: 8),
                    Text(
                      'JENNY WILSON',
                      style:
                      TextStyle(fontSize: 18,),
                    ),
                    SizedBox(
                        height:
                        4), // Add space between the username and additional text
                    Text(
                      'Modal & actor',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              '679',
                              style: TextStyle(
                                  fontSize: 25),
                            ),
                            Text(
                              'posts',
                              style:
                              TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text('2.9 M',
                                style: TextStyle(
                                    fontSize: 25)),
                            Text(
                              'Followers',
                              style:
                              TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '648',
                              style: TextStyle(
                                  fontSize: 25),
                            ),
                            Text(
                              'following',
                              style:
                              TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '27M',
                              style: TextStyle(
                                  fontSize: 25),
                            ),
                            Text(
                              'Likes',
                              style:
                              TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: toggleFollow,
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                              ),
                              icon: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              label: Text(
                                isFollowing ? 'Following' : 'Follow',
                                style: TextStyle(
                                    fontSize: 15,

                                    color: Colors.white),
                              ),
                            ),
                            // created gemini chat bot
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(context,MaterialPageRoute(builder: (context) =>MyChatBot()));
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                              ),
                              icon: Icon(
                                Icons.message,
                                color: Colors.redAccent,
                              ),
                              label: Text(
                                'Message',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.redAccent),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade200),
                              child: Icon(
                                FontAwesomeIcons.instagram,
                                size: 25,
                                color: Colors.red,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade100),
                              child: Icon(
                                Icons.favorite,
                                size: 25,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // here is the tab created
            SliverAppBar(
              pinned: true,
              title: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    icon: Icon(Icons.category, size: 40, color: Colors.red),
                  ),
                  Tab(
                    icon: Icon(Icons.bookmark, size: 40, color: Colors.black),
                  ),
                  Tab(
                    icon: Icon(Icons.favorite, size: 40, color: Colors.red),
                  )
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildGridView(),
            BuildGridView(),
            InstagramTagPageDemo(),
          ],
        ),
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: EdgeInsets.all(5),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        mainAxisExtent: 200,
      ),
      itemCount: _imageUrls.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              print('Tapped on post $index');
            });
          },
          //clipRRect is used gove border rdius to the images
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  height: 200,
                  width: 200,
                  _imageUrls[index],
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                child: IconButton(
                  icon: Icon(
                    likedStatus[index] ? Icons.favorite : Icons.favorite_border,
                    color: likedStatus[index] ? Colors.red : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      likedStatus[index] = !likedStatus[index];
                    });
                    print('Liked post $index');
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<File?>('_imageFile', _imageFile));
  }
}
