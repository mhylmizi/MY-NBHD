// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../components/button_v2.dart';
// import '../components/textfield_v1.dart';
// import 'login_page.dart';

// class SignupPage extends StatefulWidget {
//   final Function()? onTap;
//   const SignupPage({super.key, required this.onTap, required String username});

//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   // textfield controller
//   final fullnameController = TextEditingController();

//   final passwordController = TextEditingController();

//   final emailController = TextEditingController();

//   final addressController = TextEditingController();

//   final phonenumController = TextEditingController();

//   // SIGN USER UP
//   void siginUserUp() async {
//     // show loading circle
//     showDialog(
//       context: context,
//       builder: (context) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );

// // try sign up
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );
//       // pop loading circle
//       Navigator.pop(context);
//     } on FirebaseAuthException catch (e) {
//       // pop loading circle
//       Navigator.pop(context);
//       // show error message
//       wrongCredentialsMessage(e.code);
//     }
//   }

//   // wrong email popup
//   void wrongCredentialsMessage(String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Colors.green,
//           title: Center(
//             child: Text(
//               message,
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//           child: Center(
//         child: SingleChildScrollView(
//           child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//             const SizedBox(
//               height: 50,
//             ),

//             // Register
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 30),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Register',
//                     style: TextStyle(
//                         fontSize: 45,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(
//               height: 10,
//             ),

//             //Please create an account to continue
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Please create an account to continue',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey.shade600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             //username textfield
//             TextfieldV1(
//               controller: fullnameController,
//               hintText: 'Full Name',
//               obscureText: false,
//             ),

//             const SizedBox(height: 15),

//             TextfieldV1(
//               controller: emailController,
//               hintText: 'Email',
//               obscureText: false,
//             ),

//             const SizedBox(height: 15),

//             //password textfield
//             TextfieldV1(
//               controller: passwordController,
//               hintText: 'Password',
//               obscureText: true,
//             ),

//             const SizedBox(height: 15),

//             TextfieldV1(
//               controller: passwordController,
//               hintText: 'Confirm Password',
//               obscureText: true,
//             ),

//             const SizedBox(height: 15),

//             TextfieldV1(
//               controller: addressController,
//               hintText: 'Address',
//               obscureText: true,
//             ),

//             const SizedBox(height: 15),

//             TextfieldV1(
//               controller: phonenumController,
//               hintText: 'Telephone Number',
//               obscureText: true,
//             ),

//             const SizedBox(height: 15),

//             ButtonV2(
//               onTap: siginUserUp,
//               buttonText: 'Register',
//               textStyle: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//                 fontSize: 18,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('Already have an account?'),
//                 const SizedBox(
//                   width: 4,
//                 ),
//                 GestureDetector(
//                   onTap: widget.onTap,
//                   child: const Text(
//                     'Sign in',
//                     style: TextStyle(
//                       color: Colors.blue,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ]),
//         ),
//       )),
//     );
//   }
// }
