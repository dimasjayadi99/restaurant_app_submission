import 'package:flutter/material.dart';
import 'package:submission_restauirant_app/data/models/restaurant_detail_model.dart';
import 'package:submission_restauirant_app/utils/date_formatter.dart';

class ReviewPage extends StatefulWidget {
  final List<CustomerReview> listReview;

  const ReviewPage({super.key, required this.listReview});

  @override
  ReviewPageState createState() => ReviewPageState();
}

class ReviewPageState extends State<ReviewPage> {
  List<CustomerReview> listReview = [];

  @override
  void initState() {
    super.initState();
    listReview = widget.listReview;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Review"),
      ),
      body: SafeArea(
          child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  horizontalTitleGap: 4,
                  dense: true,
                  leading: Text("${index + 1}"),
                  title: Text(
                    listReview[index].name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(listReview[index].review),
                  trailing: Text(formatDate(listReview[index].date)),
                );
              },
              itemCount: listReview.length)),
    );
  }
}
