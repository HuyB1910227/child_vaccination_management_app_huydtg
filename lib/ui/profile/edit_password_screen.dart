import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user/user.dart';
import '../shared/dialog_utils.dart';
import './user_manager.dart';

class EditPasswordScreen extends StatefulWidget {
  static const routeName = '/user/edit-password';
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _isSubmitting = ValueNotifier<bool>(false);
  final Map<String, String> _submitData = {
    'oldPassword': '',
    'newPassword': '',
    'newPasswordConfirm': '',

  };



  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    _isSubmitting.value = true;

    try {

      User? result = await context.read<UserManager>().updatePassword(_submitData["oldPassword"]!, _submitData["newPasswordConfirm"]!);
      if (result != null) {
        showLogoutDialog(context, "Mật khẩu đã được cập nhât! Quý khách vui lòng đăng lại với mật khẩu mới để tiếp tục sử dụng dịch vụ của chúng tôi.");
      } else {
        showErrorDialog(
            context,
            "Đã xảy ra lỗi trong quá trình cập nhật. Quý khách vui lòng kiểm tra mật khẩu cũ!");
      }

    } catch (error) {
      // print(error);
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
        title: Text('Đổi mật khẩu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildOldPasswordField(),
              _buildNewPasswordField(),
              _buildNewPasswordConfirmField(),
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

  Widget _buildOldPasswordField() {
    return TextFormField(
      initialValue: "",
      decoration: const InputDecoration(labelText: 'Mật khẩu cũ'),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Chưa nhập mật khẩu';
        } else if (value!.length < 8) {
          return 'Mật khẩu phải có ít nhất 8 giá trị';
        }
        return null;
      },
      // validator: _validateUsername,
      onSaved: (value) {
        _submitData["oldPassword"] = value!;
      },
    );
  }
  String? _newPass = "";
  Widget _buildNewPasswordField() {
    return TextFormField(
      initialValue: "",
      decoration: const InputDecoration(labelText: 'Mật khẩu mới'),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      validator: (value) {
        setState(() {
          _newPass = value;
        });
        if (value!.isEmpty) {
          return 'Chưa nhập mật khẩu mới';
        } else if (value!.length < 8) {
          return 'Mật khẩu mới phải có ít nhất 8 giá trị';
        }
        return null;
      },

      onSaved: (value) {
        _submitData["newPassword"] = value!;
      },
    );
  }
  Widget _buildNewPasswordConfirmField() {
    return TextFormField(
      initialValue: "",
      decoration: const InputDecoration(labelText: 'Nhập lại mật khẩu mới'),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Chưa nhập lại mật khẩu mới';
        } else if (value != _newPass) {
          return 'Mật khẩu mới không khớp';
        }
        return null;
      },
      onSaved: (value) {
        _submitData["newPasswordConfirm"] = value!;
      },
    );
  }
}
