import 'package:boilerplate_ui/utils/SizeConfig.dart';
import 'package:boilerplate_ui/views/select_theme_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_theme.dart';
import '../app_theme_notifier.dart';
import 'about_app_dialog.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  //ThemeData
  ThemeData themeData;
  CustomAppTheme customAppTheme;

  //Global Keys
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //Other Variables
  bool isInProgress = false;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget child) {
        int themeType = value.themeMode();
        themeData = AppTheme.getThemeFromThemeMode(themeType);
        customAppTheme = AppTheme.getCustomAppTheme(themeType);

        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeData,
            home: Scaffold(
                key: _scaffoldKey,
                backgroundColor: customAppTheme.bgLayer1,
                appBar: AppBar(
                  backgroundColor: themeData.colorScheme.primary,
                  elevation: 0,
                  centerTitle: true,
                  title: Text("Setting",
                      style: AppTheme.getTextStyle(
                          themeData.appBarTheme.titleTextStyle,
                          fontWeight: 600,
                          color: themeData.colorScheme.onPrimary)),
                ),
                body: Column(
                  children: [
                    Container(
                      height: MySize.size3,
                      child: isInProgress
                          ? LinearProgressIndicator(
                              minHeight: MySize.size3,
                            )
                          : Container(
                              height: MySize.size3,
                            ),
                    ),
                    Expanded(
                      child: _buildBody(),
                    ),
                  ],
                )));
      },
    );
  }

  _buildBody() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: Spacing.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            children: [
              ClipOval(
                child: Container(
                  decoration: BoxDecoration(
                      color: themeData.colorScheme.primary.withAlpha(20),
                      border: Border.all(width: 1),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "./assets/images/profil.png",
                        ),
                      )),
                  height: MySize.size68,
                  width: MySize.size68,
                ),
              ),
              SizedBox(width: MySize.size18),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Ahmad Ryan N. Y.",
                      style: AppTheme.getTextStyle(
                        themeData.textTheme.titleLarge,
                      )),
                  Text("Kelompok 4",
                      style: AppTheme.getTextStyle(
                        themeData.textTheme.bodySmall,
                        fontWeight: 500,
                      )),
                ],
              ),
            ],
          ),
        ),
        Divider(),
        _menuItem(
            title: "Pengaturan Profil",
            icon: Icons.person,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => SelectThemeDialog());
            }),
        _menuItem(title: "Tema", icon: Icons.star_rate_rounded, onTap: () {}),
        _menuItem(
            title: "Pusat Bantuan", icon: Icons.call_rounded, onTap: () {}),
        _menuItem(
            title: "Kebijakan Privasi",
            icon: Icons.shield_outlined,
            onTap: () {}),
        _menuItem(
            title: "Tentang Kami",
            icon: Icons.accessibility_new_rounded,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AboutAppDialog());
            }),
      ],
    );
  }

  _menuItem({String title, IconData icon, Function onTap}) {
    return InkWell(
        onTap: onTap,
        child: Container(
            padding: Spacing.fromLTRB(30, 20, 20, 20),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: themeData.colorScheme.secondary,
                  size: MySize.size28,
                ),
                SizedBox(width: MySize.size24),
                Text(title,
                    style: AppTheme.getTextStyle(
                      themeData.textTheme.titleMedium,
                      fontWeight: 600,
                    ))
              ],
            )));
  }
}
