import 'package:flutter/material.dart';
import '../profile/user_manager.dart';
import '../shared/dialog_utils.dart';
import 'package:provider/provider.dart';

import '../../models/user/user.dart';


class EditUsernameScreen extends StatefulWidget {
  static const routeName = '/user/edit-username';
  final String username;

  const EditUsernameScreen(this.username, {super.key});

  @override
  State<EditUsernameScreen> createState() => _EditUsernameScreenState();
}

class _EditUsernameScreenState extends State<EditUsernameScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _isSubmitting = ValueNotifier<bool>(false);
  final Map<String, String> _submitData = {
    'username': '',
  };


  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    _isSubmitting.value = true;

    try {
      if (_submitData["username"] != widget.username) {
        bool isInvalidUsername = await context.read<UserManager>().isInvalidUsername(_submitData["username"]!);
        if(isInvalidUsername) {
          showErrorDialog(
              context,
              "Tên đăng nhập đã được sử dụng! Quý khách vui lòng chọn tên đăng nhập khác");
        }

        User? result = await context.read<UserManager>().updateUsername(_submitData["username"]!);
        print(result);
        if (result != null) {
          showLogoutLocalDialog(context, "Tên đăng nhập đã được cập nhật! Quý khách vui lòng đăng  lại với tên đăng nhập mới: ${_submitData["username"]}.");

        } else {
          showErrorDialog(
              context,
              "Đã xảy ra lỗi trong quá trình cập nhật. Quý khách vui lòng thử lại sau");
        }

      } else {
        Navigator.of(context).pop();
      }

    } catch (error) {
      print(error);
      showErrorDialog(
          context,
          'Vui lòng kiểm tra kết nối mạng');
    }

    _isSubmitting.value = false;
  }

  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thay đổi tên đăng nhập'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildUsernameField(),
              ValueListenableBuilder<bool>(
                valueListenable: _isSubmitting,
                builder: (context, isSubmitting, child) {

                  return _buildSubmitButton();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submit,
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
            child: const Text("Lưu thay đổi", style: TextStyle(color: Colors.purpleAccent)),
          )),
    );


  }




  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Chưa nhập tên đăng nhập';
    }
    else if (value.length < 8) {
      return 'Tên đăng nhập phải có ít nhất 8 ký tự';
    }
    return null;
  }

  Widget _buildUsernameField() {
    return TextFormField(
      initialValue: widget.username,
      decoration: const InputDecoration(labelText: 'Tên đăng nhập'),
      keyboardType: TextInputType.text,

      validator: _validateUsername,
      onSaved: (value) {
        _submitData["username"] = value!;
      },
    );
  }
}
