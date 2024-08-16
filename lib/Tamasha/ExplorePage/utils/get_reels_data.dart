import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:tamasha_bp/Tamasha/ExplorePage/utils/encryption_data.dart';

Future<List<Map<String, dynamic>>> fetchDataAndDecrypt() async {
  const url = 'https://jazztv.pk/alpha/api_gateway/index.php/reels/feed';
  final String authToken = authorizationBearerToken;

  try {
    // Send HTTP GET request with authorization header
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $authToken',
    });

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the response body to get the encrypted data
      final responseBody = jsonDecode(response.body);
      final encryptedData = responseBody['eData'];

      // Decryption keys
      final String sk = signingKey;
      final String iv = initializationVector;

      // Decrypt the encrypted data
      final decryptedData = decryptAES(encryptedData, sk, iv);

      // Parse the decrypted data as a list of maps
      final List<dynamic> jsonData = jsonDecode(decryptedData);

      // Return the list of video data as maps
      return jsonData.map((data) => data as Map<String, dynamic>).toList();
    } else {
      // Handle non-200 status codes
      debugPrint('Failed to fetch data. Status code: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    // Handle any errors that occur during the request or decryption
    debugPrint('Error fetching data: $e');
    return [];
  }
}

String decryptAES(String encryptedData, String key, String iv) {
  final keyBytes = encrypt.Key.fromUtf8(key);
  final ivBytes = encrypt.IV.fromUtf8(iv);
  final encrypter = encrypt.Encrypter(
      encrypt.AES(keyBytes, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));

  try {
    final decodedEncryptedData = hexDecode(encryptedData);
    final dataToDecrypt = Uint8List.fromList(decodedEncryptedData);
    final decrypted =
        encrypter.decrypt(encrypt.Encrypted(dataToDecrypt), iv: ivBytes);
    return decrypted;
  } catch (e) {
    // print("Decryption failed: $e");
    return '';
  }
}

List<int> hexDecode(String hex) {
  return List.generate(hex.length ~/ 2, (i) {
    final byteString = hex.substring(i * 2, i * 2 + 2);
    return int.parse(byteString, radix: 16);
  });
}
