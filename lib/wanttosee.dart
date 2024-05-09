
import 'package:flutter/material.dart';
class InstagramTagPageDemo extends StatefulWidget {
  @override
  _InstagramTagPageDemoState createState() => _InstagramTagPageDemoState();
}

class _InstagramTagPageDemoState extends State<InstagramTagPageDemo> {

  late List<int> likes;

  @override
  void initState() {
    super.initState();
    likes = List.generate(100, (index) => 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  'https://statusneo.com/wp-content/uploads/2023/02/MicrosoftTeams-image551ad57e01403f080a9df51975ac40b6efba82553c323a742b42b1c71c1e45f1.jpg'
                  ,fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8.0,
                right: 8.0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      likes[index]++;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 20.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        '${likes[index]}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
