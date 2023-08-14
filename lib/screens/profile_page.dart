import 'package:electric_park/screens/screens.dart';
import 'package:electric_park/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../constants/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder(builder: (context, Store<AppState> store) {
      return Scaffold(
          backgroundColor: KColors.quatro,
          body: ListView(
            children: [
              SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: KColors.quint,
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width - 10,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  color: KColors.quatro,
                                  child: store.state.user_profile_pic == ""
                                      ? const Icon(
                                          Icons.account_circle,
                                          size: 120,
                                          color: Color.fromARGB(
                                              173, 245, 245, 245),
                                        )
                                      : Image(
                                          image: NetworkImage(
                                              store.state.user_profile_pic!),
                                          height: 120,
                                          width: 120),
                                ),
                              ),
                              Container(
                                width: 120,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(199, 37, 39, 77),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(60),
                                        bottomRight: Radius.circular(60))),
                                child: IconButton(
                                    onPressed: () {
                                      pickImage(store);
                                    },
                                    icon: const Icon(
                                      Icons.border_color,
                                      color: Color.fromARGB(199, 245, 245, 245),
                                    )),
                              )
                            ]),
                        const Text("Welcome ",
                            style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: KColors.background)),
                        Text(store.state.user_name ?? "user",
                            style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: KColors.quatro))
                      ]),
                ),
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: store.state.chargerId == ""
                          ? KColors.tertiary
                          : KColors.charge,
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width - 10,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: store.state.chargerId == ""
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.spaceAround,
                        crossAxisAlignment: store.state.chargerId == ""
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        children: store.state.chargerId == ""
                            ? [
                                const Center(
                                  child: Text("Not charging at the moment",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: KColors.secondary)),
                                )
                              ]
                            : [
                                const Text("Charging at:",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: KColors.primary)),
                                Text(
                                    store
                                        .state
                                        .chargers![store.state.chargers!
                                            .indexWhere((element) =>
                                                element.ID.toString() ==
                                                store.state.chargerId)]
                                        .addressInfo
                                        .Title,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: KColors.background))
                              ]),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfileModifyPage(
                                  type: Profile.Name,
                                  userId: store.state.user_id,
                                  icon: "assets/lottie/user_name.json")));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: KColors.quint,
                          ),
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.5 - 20,
                          child: const Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit,
                                size: 30,
                                color: KColors.background,
                              ),
                              Text("Edit name",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: KColors.background))
                            ],
                          )),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfileModifyPage(
                                  type: Profile.Email,
                                  userId: store.state.user_id,
                                  icon: "assets/lottie/mail.json")));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: KColors.quint,
                              borderRadius: BorderRadius.circular(10)),
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.5 - 20,
                          child: const Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.mail,
                                size: 30,
                                color: KColors.background,
                              ),
                              Text("Change email",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: KColors.background))
                            ],
                          )),
                        )),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfileModifyPage(
                                  type: Profile.Password,
                                  userId: store.state.user_id,
                                  icon: "assets/lottie/password.json")));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: KColors.quint,
                          ),
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.5 - 20,
                          child: const Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.password,
                                size: 30,
                                color: KColors.background,
                              ),
                              Text("Change password",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: KColors.background))
                            ],
                          )),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: KColors.tertiary,
                            borderRadius: BorderRadius.circular(10)),
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.5 - 20,
                        child: const Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              size: 30,
                              color: KColors.background,
                            ),
                            Text("Logout",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: KColors.background))
                          ],
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ));
    });
  }
}
