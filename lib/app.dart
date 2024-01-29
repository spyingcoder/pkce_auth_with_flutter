import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pkce_auth_with_flutter/cubit/login_cubit.dart';
import 'package:pkce_auth_with_flutter/screens/login_screen.dart';

(String, Uint8List) generateCodeVerifier(int bytes) {
  if (bytes < 32 || bytes > 96) {
    throw ArgumentError(
        "Expected bytes to be passed should be greater than 32 and less than 96 to generate a correct length verifier");
  }

  Uint8List codeVerifierBytes =
      Uint8List.fromList(List.generate(bytes, (index) => _secureRandomByte()));

  // Encoding the random bytes using base64 URL encoding & remove the leading equal to's
  String verifier = base64UrlEncode(codeVerifierBytes).split('=')[0];

  return (verifier, codeVerifierBytes);
}

int _secureRandomByte() {
  // Using the secure random method to generate a random byte
  return Random.secure().nextInt(256);
}

(String, Uint8List) generateChallenge(String verifier) {
  List<int> verifierBytes = utf8.encode(verifier);

  // Using the 256 Hashing Algorithm for encryption
  Digest digest = sha256.convert(verifierBytes);

  // Encoding the buffer bytes from digest as base64 URL
  String base64UrlEncoded = base64UrlEncode(digest.bytes);

  return (base64UrlEncoded, digest.bytes as Uint8List);
}

bool verifyChallenge(String base64URLEncodedChallenge, String verifier) {
  Uint8List challengeBytes = base64Url.decode(base64URLEncodedChallenge);
  Uint8List verifierBytes = utf8.encode(verifier) as Uint8List;

  // Using the 256 Hashing Algorithm for encryption
  Digest digest = sha256.convert(verifierBytes);

  developer.log(digest.bytes.toString(), name: "Code Verifier ");
  developer.log(challengeBytes.toString(), name: "Code Challenge ");

  // Compare the verifier's & challenger's bytes
  return _areEqual(challengeBytes, digest.bytes as Uint8List);
}

bool _areEqual(Uint8List list1, Uint8List list2) {
  if (list1.length != list2.length) {
    return false;
  }
  for (int i = 0; i < list1.length; i++) {
    if (list1[i] != list2[i]) {
      return false;
    }
  }
  return true;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // Getting the value of Code Verifier String and Code Verifier Buffer
    // Length of the code verifier's buffer is 128
    var (codeVerifierStringBase64URLEncoded, codeVerifierBytes) =
        generateCodeVerifier(96);
    //
    var (codeChallengeStringBase64URLEncoded, codeChallengeBytes) =
        generateChallenge(codeVerifierStringBase64URLEncoded);
    //
    var challengeVerificationResult = verifyChallenge(
      codeChallengeStringBase64URLEncoded,
      codeVerifierStringBase64URLEncoded,
    );
    //
    developer.log(challengeVerificationResult.toString(),
        name: "Is challenge verified");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => LoginCubit(),
        child: const LoginScreen(),
      ),
    );
  }
}
