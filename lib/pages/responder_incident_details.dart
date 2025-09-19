import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class IncidentDetail extends StatelessWidget {
  final String title;
  final String location;
  final String distance;
  final String urgency;
  final IconData icon;

  const IncidentDetail({
    super.key,
    required this.title,
    required this.location,
    required this.distance,
    required this.urgency,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color urgencyColor;
    switch (urgency) {
      case 'High':
        urgencyColor = Colors.red;
        break;
      case 'Medium':
        urgencyColor = Colors.orange;
        break;
      default:
        urgencyColor = Colors.green;
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Incident Details',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Incident Header
            Row(
              children: [
                CircleAvatar(
                  radius: 8.w,
                  backgroundColor: urgencyColor.withOpacity(0.2),
                  child: Icon(icon, color: urgencyColor, size: 8.w),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 0.5.h),
                      Text(location,
                          style: TextStyle(
                              fontSize: 10.sp, color: Colors.grey[600])),
                      SizedBox(height: 0.5.h),
                      Text(distance,
                          style: TextStyle(
                              fontSize: 10.sp, color: Colors.grey[600])),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: urgencyColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Text(
                    urgency,
                    style: TextStyle(
                        color: urgencyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),

            // Media / Images Placeholder
            Text('Attached Media',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 1.h),
            Container(
              height: 25.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(3.w),
              ),
              child: const Center(
                child: Icon(Icons.image, color: Colors.grey, size: 50),
              ),
            ),
            SizedBox(height: 3.h),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.w)),
                    ),
                    child: Text('Accept',
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.w)),
                    ),
                    child: Text('Decline',
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),

            // Navigate Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.navigation, color: Colors.white),
                label: Text('Navigate',
                    style: TextStyle(
                        fontSize: 12.sp, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.w)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
