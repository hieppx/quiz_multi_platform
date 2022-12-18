import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_multi_platform/common/url.dart';

class Avatar extends StatelessWidget {
  final String imageUrl;
  final double size;

  const Avatar({
    super.key,
    required this.imageUrl,
    required this.size
  });

  Future<http.Response> getUrlResponse() {
    return http.post(Uri.parse('${Url.avatar}$imageUrl'));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUrlResponse(),
      builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: size,
            width: size,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: MemoryImage(
                snapshot.data!.bodyBytes,
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
