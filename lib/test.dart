import 'package:background_sms/background_sms.dart';
import 'package:permission_handler/permission_handler.dart';

class testSMS {
  Future<void> _getPermission() async {
    await [
      Permission.sms,
      Permission.location, // Add location permission
    ].request();
  }

  Future<bool> _isPermissionGranted() async {
    final smsPermissionStatus = await Permission.sms.status.isGranted;
    //  final locationPermissionStatus = await Permission.location.status.isGranted;
    return smsPermissionStatus;
  }

  Future<void> sendMessageWithLocation(
    String phoneNumber,
    String message, {
    int? simSlot,
  }) async {
    try {
      if (await _isPermissionGranted()) {
        // final currentLocation = await _getCurrentPosition();
        // final latitude = currentLocation.latitude;
        // final longitude = currentLocation.longitude;

        // Get location name from coordinates
        // String locationName = await _getLocationName(latitude, longitude);

        // final messageWithLocation =
        // "Help! Location: $locationName, Latitude: $latitude, Longitude: $longitude\n$message";

        var result = await BackgroundSms.sendMessage(
          phoneNumber: phoneNumber,
          message: message,
          simSlot: simSlot,
        );
        if (result == SmsStatus.sent) {
          print("Sent");
        } else {
          print("Failed");
        }
      } else {
        await _getPermission();
      }
    } catch (e) {
      print("Error sending SMS: $e");
    }
  }
}

void main() {
  testSMS().sendMessageWithLocation("6264777794", "Hello");
}
