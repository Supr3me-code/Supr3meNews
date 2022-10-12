import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/views/article.dart';

class ArticleTile extends StatelessWidget {
  final String? imageUrl, title, desc, url;

  ArticleTile({
    required this.imageUrl,
    required this.title,
    required this.desc,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(
              articleUrl: url,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
        child: Card(
          color: Colors.grey.shade900,
          elevation: 10,
          shadowColor: Colors.grey.shade300,
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 10),
                  child: Flex(
                    direction: Axis.horizontal,
                    children:[ Expanded(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(imageUrl!, fit: BoxFit.cover)),
                    ),]
                  ),
                ),              
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Text(
                      title!,
                      style: GoogleFonts.lora(
                        color: Colors.white,
                        fontSize: 16,
                        letterSpacing: 0.3,
                        fontWeight: FontWeight.w600,
                      )
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: Divider(
                  color: Colors.grey.shade300,
                ), ),             
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Text(
                          desc!,
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.inter(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                            fontSize: 15,
                          ),
                        ),
                      //),
                    ),
                    ]
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
