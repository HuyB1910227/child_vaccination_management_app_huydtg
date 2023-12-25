import 'package:flutter/material.dart';

class About extends StatelessWidget {
  static const routeName = '/profile/about';
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Về chúng tôi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const <Widget>[
            SizedBox(height: 8.0,),
            Text("TẦM NHÌN",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.redAccent,
                  letterSpacing: 2
              ),
            ),
            SizedBox(height: 8.0,),
            Text("Được thành lập từ 20/12/1995, đến nay HuKoTravel là Công ty Lữ hành hàng đầu Việt Nam với nhiều giải thưởng danh giá, uy tín trong và ngoài nước. Trong định hướng phát triển kinh doanh đến năm 2025, HuKoTravel tập trung xây dựng hệ sinh thái đa dạng với 3 lĩnh vực lớn: Lữ hành; Vận tải - Hàng Không; Thương mại - Dịch vụ.",
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 8.0,),
            Text("SỨ MỆNH",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.redAccent,
                  letterSpacing: 2
              ),
            ),
            SizedBox(height: 8.0,),
            Text("Mang lại cảm xúc thăng hoa cho du khách trong mỗi hành trình - Đây là mục tiêu và là sứ mệnh HuKoTravel cam kết và nỗ lực mang lại cho du khách. HuKoTravel trở thành người bạn đồng hành cùng du khách trong mọi hành trình du lịch và tạo ra những giá trị tốt đẹp. Tại Huko travel, du lịch không những là hành trình khám phá mà còn là hành trình sẻ chia, thể hiện dấu ấn khác biệt của Thương hiệu HuKo Travel từ 3 thuộc tính thương hiệu: Sự chuyên nghiệp, mang cảm xúc thăng hoa cho khách hàng và những giá trị gia tăng hấp dẫn cho du khách sau mỗi chuyến đi.",
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}