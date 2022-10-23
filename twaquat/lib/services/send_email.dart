import 'package:url_launcher/url_launcher_string.dart';

Future<void> SendEmailToSupport() async {
  final toEmail = 'Support@sandaqa.sa';
  // TextEditingController emailSubject = TextEditingController();
  // TextEditingController emailBody = TextEditingController();
  // showDialog(context: context, builder: builder)
  final url =
      'mailto:$toEmail?subject=${Uri.encodeFull("")}&body=${Uri.encodeFull("")}';
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  }
}

Future<void> SendEmailToJoinCompany() async {
  final toEmail = 'Support@sandaqa.sa';
  final url =
      'mailto:$toEmail?subject=${Uri.encodeFull("Request to Join Company")}&body=${Uri.encodeFull("Write here your Company and department name. (note: make sure to send this email by useing your Signup Email)")}';
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  }
}
