import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:tamasha_bp/Tamasha/Homepage/SearchBarHome/encryption_data.dart';

Future<List<Map<String, dynamic>>> fetchDataAndDecrypt(String query) async {
  const url =
      'https://dev.jazztv.pk/alpha/api_gateway/index.php/v3/media/search';
  final String authToken = authorizationBearerToken;

  // Define the parameters
  final Map<String, String> params = {
    "word": query,
    "page": "1",
    "type": "all"
  };

  try {
    // Send HTTP POST request with authorization header
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(params),
    );

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

      // debugPrint('Decrypted data: $decryptedData');

      // Parse the decrypted data as a Map with a "data" key containing a list of maps
      final Map<String, dynamic> jsonData = jsonDecode(decryptedData);

      // Return the list of video data from the "data" key
      return List<Map<String, dynamic>>.from(jsonData['data']);
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
    debugPrint("Decryption failed: $e");
    return '';
  }
}

List<int> hexDecode(String hex) {
  return List.generate(hex.length ~/ 2, (i) {
    final byteString = hex.substring(i * 2, i * 2 + 2);
    return int.parse(byteString, radix: 16);
  });
}
