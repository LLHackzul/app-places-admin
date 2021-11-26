import 'package:flutter/material.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';
import './my_profile_screen.dart';
import './auth_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Consumer<Auth>(
      builder: (ctx, authData,_)=>  authData.isAuth
              ? MyProfileScreen()
              : FutureBuilder(
                  future: authData.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? Center(child: CircularProgressIndicator(),)
                          : AuthScreen()),
    );
  }
}
