import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class InviteFriends extends StatelessWidget {
  const InviteFriends({super.key});

  @override
  Widget build(BuildContext context) {
    const imageUrl =
        "https://images.unsplash.com/photo-1495837174058-628aafc7d610?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Invite Friends'),
      ),
      body: Column(
        children: [
          FutureBuilder<void>(
            future: precacheImage(const NetworkImage(imageUrl), context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer.fromColors(
                  baseColor: const Color.fromARGB(57, 32, 32, 32),
                  highlightColor: const Color.fromARGB(82, 63, 63, 63),
                  child: Container(
                    height: 250.h,
                    color: Colors.black,
                  ),
                );
              } else {
                return Image.network(imageUrl);
              }
            },
          ),
          SizedBox(height: 40.h),
          Text(
            'Get your 5 coins!',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.h),
          Text(
            "Apny Dost ko Tamasha pr invite karen or dost k\nSign up krtu hi 5 coins ap ky. Ek din men ziada sy\nziada 5 dosto ko invite kr skty hen.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 20.h),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
            child: Text(
              "XYZCODE",
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding:
                    EdgeInsets.symmetric(horizontal: 150.w, vertical: 10.h),
              ),
              onPressed: () {},
              child: Text(
                "Invite",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
