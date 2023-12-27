import 'package:flutter/material.dart';
import '../profile/edit_password_screen.dart';
import '../profile/edit_username_screen.dart';
import '../profile/user_manager.dart';
import 'package:provider/provider.dart';
import '../../models/user/user.dart';
import '../shared/circle_image.dart';
import '../auth/auth_manager.dart';
import '../notification/notification_navigate_button.dart';

class ProfileOverviewScreen extends StatelessWidget {
  const ProfileOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tài khoản"),
        actions: const [NotificationNavigateButton()],
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                width: double.infinity,
                color: const Color.fromARGB(255, 237, 128, 161),
                child: Column(children: <Widget>[
                  const CircleImage(
                    imageProvider: AssetImage('assets/needle_logo.png'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Hệ thống tiêm chủng trẻ em - Angelo",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  const Text("Xin kính chào quý khách! ",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<AuthManager>().logout();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      child: const Text(
                        'Đăng xuất',
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          FutureBuilder(
              future: context.read<UserManager>().fetchUserDetail(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null) {
                    final user = snapshot.data as User;
                    return Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            const Divider(),
                            ListTile(
                              leading: const Icon(Icons.phone),
                              title: Text(user.phone),
                              subtitle: const Text("SĐT đã được đăng ký tài khoản"),
                              trailing: IconButton(onPressed: () {print("redd");}, icon: Icon(Icons.check_box),),
                            ),
                            const Divider(),
                            ListTile(
                              leading: Icon(Icons.account_circle_outlined),
                              title: Text(user.username),
                              subtitle: Text("Tên tài khoản"),
                              trailing: IconButton(onPressed: () {
                                Navigator.of(context).pushNamed(
                                  EditUsernameScreen.routeName,
                                  arguments: user.username,
                                );
                              }, icon: Icon(Icons.edit, color: Colors.blue,),),
                            ),
                            const Divider(),
                            ListTile(
                              leading: Icon(Icons.password),
                              title: Text("********"),
                              subtitle: Text("Mật khẩu tài khoản"),
                              trailing: IconButton(onPressed: () {
                                Navigator.of(context).pushNamed(
                                  EditPasswordScreen.routeName
                                );
                              }, icon: Icon(Icons.edit, color: Colors.blue,),),
                            ),
                          ],
                        ));
                  }
                }
                return const Center(child: CircularProgressIndicator());
              }),

          // const
        ],
      ),
    );


  }
}
