import 'package:flutter/material.dart';

class BuildGridView extends StatefulWidget {
  const BuildGridView({super.key});

  @override
  State<BuildGridView> createState() => _BuildGridViewState();
}

class _BuildGridViewState extends State<BuildGridView> with SingleTickerProviderStateMixin {

  late List<bool> likedStatus; // Declare as late so it's initialized later

  @override
  void initState() {
    super.initState();
    likedStatus = List.generate(_imageUrls.length, (index) => false);
  }


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

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.all(5),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          // childAspectRatio: double.maxFinite,
          //mainAxisExtent: 200,
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
              child: Stack(children: [
                ClipRRect(
                  //borderRadius: BorderRadius.circular(20.0),
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
                      }),
                ),
              ]));
        });
  }
}
