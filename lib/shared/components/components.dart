import 'package:flutter/material.dart';
import 'package:news_app/news_app/web_view/web_view.dart';

Widget defaultButton({
  double width = double.infinity,
  Color color = Colors.teal,
  bool isUpperCase = true,
  double radius = 0.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          function();
        },
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );

Widget defaultTextField({
  required String label,
  required TextInputType type,
  required TextEditingController controller,
  required IconData prefix,
  required FormFieldValidator validate,
  IconData? suffix,
  double radius = 0.0,
  bool obscureText = false,
  Function? suffixPressed,
  Function? onSubmitted,
}) =>
    TextFormField(
      controller: controller,
      onFieldSubmitted: (s) {
        onSubmitted!(s);
      },
      keyboardType: type,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  {
                    suffixPressed!();
                  }
                },
                icon: Icon(suffix),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      validator: validate,
    );
//a//aa//a

Widget buildArticalItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/image/circel.png',
                image: '${article['urlToImage']}',
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) => Icon(Icons.error),

              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                width: 120.0,
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${article['title']}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}


