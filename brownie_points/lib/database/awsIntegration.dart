

import 'dart:io';
import 'package:aws_s3_client/aws_s3_client.dart';
import 'package:brownie_points/config/Config.dart';

class AwsIntegration {


  static Future<String> uploadImage(File image) async
  {
    final String bucketURI = "https://browniepointsbucket.s3.us-east-2.amazonaws.com/";
    print("Trying to connect to the sapce");
    Spaces spaces= Spaces(
        region: "us-east-2",
        accessKey: MOBILE_AWS_ACCESS_KEY,
        secretKey: MOBILE_AWS_SECRET_KEY);
    if(image == null)
      return "https://banner.uclipart.com/20200112/lqt/mexican-food-cartoon-line.png";
    Bucket bucket = spaces.bucket(AWS_BUCKET);
    String type = image.path.substring(image.path.lastIndexOf('.'), image.path.length);
    String imageName = "${DateTime.now().year}-${DateTime.now().day}-${DateTime.now().month}_${DateTime.now().microsecond}$type";
    String tag = await bucket.uploadFile(imageName, image.readAsBytesSync(), 'image', Permissions.public);
    print("$bucketURI"+imageName);
    if(tag != null)
      return bucketURI + imageName;
  }
}