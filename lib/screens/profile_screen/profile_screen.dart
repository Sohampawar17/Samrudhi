
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/screens/profile_screen/profile_model.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';
import '../../../widgets/full_screen_loader.dart';
import '../../constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Choose the color scheme based on the current theme
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onViewModelReady: (model) => model.initialise(context),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'My Profile',
            style: TextStyle(fontSize: 18, color: colorScheme.onPrimary),
          ),
          leading: IconButton.outlined(
            onPressed: () => Navigator.popAndPushNamed(context, Routes.homePage),
            icon:  Icon(Icons.arrow_back, color: colorScheme.onPrimary),
          ),
          backgroundColor: colorScheme.primary,
        ),
        body: fullScreenLoader(
          loader: model.isBusy,
          context: context,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(

                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: colorScheme.shadow,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(
                            model.employeedetail.employeeImage ?? "",
                          ), // Replace with your image asset
                        ),
                        title: Text(
                          (model.employeedetail.employeeName ?? "N/A").toUpperCase(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          model.employeedetail.designation ?? "N/A",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: colorScheme.shadow,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       const AutoSizeText('Employee ID',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),minFontSize: 14,),
                        const SizedBox(height: 8),
                        AutoSizeText(model.employeedetail.name ?? "N/A",style: const TextStyle(fontWeight: FontWeight.bold),minFontSize: 16),
                        const Divider(thickness: 1,),
                        const AutoSizeText('Date of joining',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),minFontSize: 14),
                        const SizedBox(height: 8),
                        AutoSizeText(model.employeedetail.dateOfJoining ?? "N/A",style: const TextStyle(fontWeight: FontWeight.bold),minFontSize: 16),
                        const Divider(thickness: 1,),
                        const AutoSizeText('Date of Birth',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),minFontSize: 14),
                        const SizedBox(height: 8),
                        AutoSizeText(model.employeedetail.dateOfBirth ?? "N/A",style: const TextStyle(fontWeight: FontWeight.bold),minFontSize: 16),
                        const Divider(thickness: 1,),
                        const AutoSizeText('Gender',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),minFontSize: 14),
                        const SizedBox(height: 8),
                        AutoSizeText(model.employeedetail.gender ?? "N/A",style: const TextStyle(fontWeight: FontWeight.bold),minFontSize: 16),
                        const Divider(thickness: 1,),
                        const AutoSizeText('Official email address',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),minFontSize: 14),
                        const SizedBox(height: 8),
                        AutoSizeText(model.employeedetail.companyEmail ?? "N/A",style: const TextStyle(fontWeight: FontWeight.bold),minFontSize: 16),
                        const Divider(thickness: 1,),
                        const AutoSizeText('Personal email address',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),minFontSize: 14),
                        const SizedBox(height: 8),
                        AutoSizeText(model.employeedetail.personalEmail ?? "N/A",style: const TextStyle(fontWeight: FontWeight.bold),minFontSize: 16),
                        const Divider(thickness: 1,),
                        const AutoSizeText('Contact number',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),minFontSize: 14),
                        const SizedBox(height: 8),
                        AutoSizeText(model.employeedetail.cellNumber ?? "N/A",style: const TextStyle(fontWeight: FontWeight.bold),minFontSize: 16),
                        const Divider(thickness: 1,),
                        const AutoSizeText('Emergency conatct number',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),minFontSize: 14),
                        const SizedBox(height: 8),
                        AutoSizeText(model.employeedetail.emergencyPhoneNumber ?? "N/A",style: const TextStyle(fontWeight: FontWeight.bold),minFontSize: 16),



                        // Add more ListTile widgets for other profile details
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: colorScheme.shadow,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),child: ListTile(
              onTap: () => Navigator.popAndPushNamed(context, Routes.changePasswordScreen),
              leading: Icon(Icons.lock_outlined),
              title: Text('Change the Password',style: TextStyle(fontWeight: FontWeight.bold),),trailing: Icon(Icons.arrow_forward_ios_outlined),
            )),
                  const SizedBox(height: 20,),
                  Container(
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: colorScheme.shadow,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),child: ListTile(textColor: Colors.redAccent,iconColor: Colors.redAccent,
                    onTap:() {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Logout'),
                            content: Text('Are you sure you want to log out?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  // Close the dialog
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  logout(context); // Close the dialog
                                },
                                child: Text('Logout'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    leading: Icon(Icons.login_outlined),
                    title: Text('Logout',style: TextStyle(fontWeight: FontWeight.bold),),trailing: Icon(Icons.arrow_forward_ios_outlined),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
