import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noterec/styles/app_style.dart';

Widget noteCard(
    Function()? onTap,
    Function(DocumentSnapshot? documentSnapshot) update,
    Function(String d_id) delete,
    QueryDocumentSnapshot doc) {
  int color_id = doc['color_id'];

  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppStyle.cardColor[color_id],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doc['note_title'],
                style: AppStyle.mainTitle,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                doc['creation_date'],
                style: AppStyle.dateTitle,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                doc['note_content'],
                style: AppStyle.mainCounter,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          SizedBox(
            height: 25.0,
          ),
          Row(
            children: [
              SizedBox(
                width: 60,
              ),
              IconButton(
                  onPressed: () {
                    update(doc);
                  },
                  icon: Icon(Icons.edit)),
              IconButton(
                  onPressed: () => delete(doc.id),
                  icon: Icon(
                    Icons.delete,
                  )),
            ],
          ),
        ],
      ),
    ),
  );
}
