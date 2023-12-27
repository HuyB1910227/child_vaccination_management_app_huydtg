import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'patient_detail_screen.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/avatar_image.dart';
import 'package:provider/provider.dart';
import '../../../models/patient/patient.dart';
import '../../nutrition/nutrition_detail_screen.dart';
import '../../assignment/disease_group/disease_group_general_screen.dart';
import '../patient_detail/patient_edit_screen.dart';
import '../../avatar/avatar_manager.dart';
import 'package:intl/intl.dart';

class PatientDetailInfo extends StatefulWidget {
  final Patient patient;

  const PatientDetailInfo({required this.patient, super.key});

  @override
  State<PatientDetailInfo> createState() => _PatientDetailInfoState();
}

class _PatientDetailInfoState extends State<PatientDetailInfo> {
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
    String? message = await context.read<AvatarManager>().updatePatientAvatar(_image, widget.patient.id);
    if (message != null) {
      if (message == "image uploaded") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Cập nhật ảnh đại diện thành công."),
          ),
        );
        Navigator.of(contextReference).pushReplacementNamed(
          PatientDetailScreen.routeName,
          arguments: widget.patient.id,
        );
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
      if (widget.patient.avatar != null && _image == null)
        FutureBuilder(
          future: context
              .read<AvatarManager>()
              .loadImageWithAvatarName(widget.patient.avatar!),
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
      if (widget.patient.avatar == null && _image == null)
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


      const SizedBox(
        height: 10,
      ),
      Row(
        children: <Widget>[
          const Expanded(
            child: Text('Mã số trẻ:',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.purpleAccent)),
          ),
          Expanded(
            child: Text('${widget.patient.id}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: <Widget>[
          const Expanded(
            child: Text('Họ và tên:',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.purpleAccent)),
          ),
          Expanded(
            child: Text(widget.patient.fullName,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: <Widget>[
          const Expanded(
            child: Text('Ngày sinh:',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.purpleAccent)),
          ),
          Expanded(
            child: Text(
                DateFormat("dd/MM/yyyy").format(widget.patient.dateOfBirth),
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: <Widget>[
          const Expanded(
            child: Text('Giới tính:',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.purpleAccent)),
          ),
          Expanded(
            child: Text(widget.patient.gender == 1 ? "Nữ" : "Nam",
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: <Widget>[
          const Expanded(
            child: Text('Địa chỉ:',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.purpleAccent)),
          ),
          Expanded(
            child: Text(widget.patient.address,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(
            PatientEditScreen.routeName,
            arguments: widget.patient,
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
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
              child: const Text("Chỉnh sửa thông tin",
                  style: TextStyle(color: Colors.purpleAccent)),
            )),
      ),
      const SizedBox(
        height: 20,
      ),
      const Text("Khác"),
      const SizedBox(
        height: 20,
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            DiseaseGroupGeneralScreen.routeName,
            arguments: widget.patient.id,
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
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
              alignment: Alignment.centerLeft,
              child: const Text("Nhật ký tiêm chủng",
                  style: TextStyle(color: Colors.purpleAccent)),
            )),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            NutritionDetailScreen.routeName,
            arguments: widget.patient.id,
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          primary: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(color: Colors.purple),
          ),
        ),
        child: Ink(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              alignment: Alignment.centerLeft,
              child: const Text("Chỉ số cơ thể",
                  style: TextStyle(color: Colors.purpleAccent)),
            )),
      ),

    ]);
  }
}
