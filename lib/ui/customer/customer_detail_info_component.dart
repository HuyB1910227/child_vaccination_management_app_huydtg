import 'dart:io';
import 'package:flutter/material.dart';
import '../avatar/avatar_manager.dart';
import '../main_screen.dart';
import '../shared/avatar_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../models/customer/customer.dart';
import 'package:intl/intl.dart';
import 'customer_edit_screen.dart';
import 'dart:typed_data';
class CustomerDetailInfo extends StatefulWidget {
  final Customer customer;

  const CustomerDetailInfo({required this.customer, super.key});

  @override
  State<CustomerDetailInfo> createState() => _CustomerDetailInfoState();
}

class _CustomerDetailInfoState extends State<CustomerDetailInfo> {
  File? _image;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final imageTemporary = File(image.path);

    setState(() {
      _image = imageTemporary;
    });
  }

  Future<void> uploadImage() async {
    final contextReference = context;
    String? message = await context.read<AvatarManager>().updateUserAvatar(_image);
    if (message != null) {
      if (message == "image uploaded") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Cập nhật ảnh đại diện thành công."),
          ),
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen(defaultSelectedIndex: 3)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Cập nhật thất bại! Vui lòng thử lại sau."),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cập nhật thất bại! Vui lòng thử lại sau."),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {

    return ListView(children: [

      if (widget.customer.avatar != null && _image == null)
        FutureBuilder(
          future: context
              .read<AvatarManager>()
              .loadImageWithAvatarName(widget.customer.avatar!),
          initialData: const AvatarImage(
            imageProvider: AssetImage('assets/default_avatar.jpg'),
            imageRadius: 100,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const AvatarImage(
                  imageProvider: AssetImage('assets/default_avatar.jpg'),
                  imageRadius: 100,
                );
              } else {
                return AvatarImage(
                  imageProvider: MemoryImage(
                    snapshot.data as Uint8List,
                  ),
                  imageRadius: 100,
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),

      if (widget.customer.avatar == null && _image == null)
        const AvatarImage(
          imageProvider: AssetImage('assets/default_avatar.jpg'),
          imageRadius: 100,
        ),
      const SizedBox(
        height: 10,
      ),
      if (_image != null)
        AvatarImage(
          imageProvider: FileImage(_image!),
          imageRadius: 100,
        ),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                getImage();
              },
              child: const Row(
                children: [
                  Icon(Icons.image),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Chọn ảnh đại diện")
                ],
              )),
          if (_image != null)
            const SizedBox(
              width: 10,
            ),
          if (_image != null)
            ElevatedButton(
              onPressed: () {
                uploadImage();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.blue),
              ),
              child: const Row(
                children: [
                  Icon(Icons.file_upload_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Lưu thay đổi")
                ],
              ),
            ),
        ],
      ),
      const SizedBox(height: 20,),
      Row(
        children: <Widget>[
          const Expanded(
            child: Text('Mã khách hàng:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent)),
          ),
          Expanded(
            child: Text('${widget.customer.id}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      const SizedBox(height: 20,),

      Row(
        children: <Widget>[
          const Expanded(
            child: Text('Họ và tên:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent)),
          ),
          Expanded(
            child: Text(widget.customer.fullName,
                style: const TextStyle(
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      const SizedBox(height: 20,),
      Row(
        children: <Widget>[
          const Expanded(
            child: Text('CMND/CCCD:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent)),
          ),
          Expanded(
            child: Text('${widget.customer.identityCard}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      const SizedBox(height: 20,),
      Row(
        children: <Widget>[
          const Expanded(
            child: Text('Ngày sinh:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent)),
          ),
          Expanded(
            child: Text(DateFormat("dd/MM/yyyy").format(widget.customer.dateOfBirth),
                style: const TextStyle(
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      const SizedBox(height: 20,),
      Row(
        children: <Widget>[
          const Expanded(
            child: Text('Giới tính:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent)),
          ),
          Expanded(
            child: Text(widget.customer.gender == 1 ? "Nữ" : "Nam",
                style: const TextStyle(
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      const SizedBox(height: 20,),
      Row(
        children: <Widget>[
          const Expanded(
            child: Text('Địa chỉ:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent)),
          ),
          Expanded(
            child: Text(widget.customer.address,
                style: const TextStyle(
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      const SizedBox(height: 20,),
      Row(
        children: <Widget>[
          const Expanded(
            child: Text('Số điện thoại:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent)),
          ),
          Expanded(
            child: Text(widget.customer.phone,
                style: const TextStyle(
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      const SizedBox(height: 20,),
      Row(
        children: <Widget>[
          const Expanded(
            child: Text('Email:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent)),
          ),
          Expanded(
            child: Text(widget.customer.email ?? '',
                style: const TextStyle(
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      const SizedBox(height: 20,),
      ElevatedButton(
        onPressed: () {

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CustomerEditScreen(widget.customer)));
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(0),
          primary: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.purple),
          ),
        ),
        child: Ink(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              alignment: Alignment.center,
              child: const Text("Chỉnh sửa thông tin", style: TextStyle(color: Colors.purpleAccent)),
            )),
      ),
      const Card(
        color: Colors.orangeAccent,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Text("Lưu ý: Để thay đổi thông tin CCCD/CMND, số điện thoại! Quý khách vui lòng đến cơ sở tiêm chủng gần nhất để chỉnh sửa thông tin.", style: TextStyle(color:Colors.white),),),
        ),
      ),


    ]);
  }
}