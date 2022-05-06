import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget defaultFormField({
  required String? Function(String?) validate,
  String? Function(String?)? onChange,
  required TextEditingController controller,
  void Function()? suffixPressed,
  required TextInputType type,
  required IconData prefix,
  required String label,
  bool readOnly = false,
  Function()? onTab,
  bool isPassword = false,
  IconData? suffix,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validate,
      onChanged: onChange,
      obscureText: isPassword,
      onTap: onTab,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: suffixPressed,
        ),
        border: const OutlineInputBorder(),
      ),
    );

Widget buildArticleItem(article,BuildContext context) => Padding(
  padding: const EdgeInsetsDirectional.all(20.0),
  child: Row(
    children: [
      Container(
        width: 120.0,
        height: 120.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
              image: NetworkImage(
                  '${article['urlToImage'] ?? 'https://www.zambianguardian.com/wp-content/uploads/2021/09/Difference-between-public-administration-and-business-administration.jpg'}'),
              fit: BoxFit.cover),
        ),
      ),
      const SizedBox(
        width: 20.0,
      ),
      Expanded(
        child: SizedBox(
          height: 120.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${article['title']}',
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${article['publishedAt']}',
                style: const TextStyle(color: Colors.grey),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    ],
  ),
);

Widget articleBuilder(list)=> ConditionalBuilder(
  condition: list.isNotEmpty,
  builder: (context)=> ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context,index)=> buildArticleItem(list[index], context),
      separatorBuilder: (context,index)=> myDivider(),
      itemCount: 10
  ),
  fallback: (context)=> const Center(
    child: CircularProgressIndicator(),),
);

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=> widget)
);

