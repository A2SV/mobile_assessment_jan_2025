import 'package:flutter/material.dart';

class Dialogs {
  Future<dynamic> showConfirmDialog(
    BuildContext context,
  ) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor == Colors.white
                    ? Colors.black
                    : Colors.white,
            title: Text(
              "Confirmation",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            content: Text(
              "Place an order?",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).scaffoldBackgroundColor),
            ),
            actions: <Widget>[
              TextButton(
                  child: Text(
                    "no",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  }),
              SizedBox(
                  width: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(true);
                    },
                    child: Text("yes",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white)),
                  )),
            ],
          );
        });
  }
}
