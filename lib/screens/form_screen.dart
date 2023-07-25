// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_db/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_db/models/transactions.dart';
import 'package:intl/intl.dart';

class FormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  //Controller
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final yearController = TextEditingController();
  final publisherController = TextEditingController();
  final amountController = TextEditingController();

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('แบบฟอร์มบันทึกข้อมูล'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "ชื่อหนังสือ"),
                      autofocus: false,
                      controller: titleController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "กรุณาป้อนชื่อหนังสือ";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "ชื่อผู้เขียน"),
                      autofocus: false,
                      controller: authorController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "กรุณาป้อนชื่อผู้เขียน";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "ปีที่ตีพิมพ์"),
                      keyboardType: TextInputType.number,
                      controller: yearController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "กรุณาป้อนปีที่ตีพิมพ์";
                        }
                        if (int.parse(str) <= 0) {
                          return "กรุณาป้อนปีที่ตีพิมพ์มากกว่า 0";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "ชื่อสำนักพิมพ์"),
                      autofocus: false,
                      controller: publisherController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "กรุณาป้อนชื่อสำนักพิมพ์";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "ราคา"),
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "กรุณาป้อนราคาหนังสือ";
                        }
                        if (double.parse(str) <= 0) {
                          return "กรุณาป้อนราคาหนังสือมากกว่า 0";
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                        style: style,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            var title = titleController.text;
                            var author = authorController.text;
                            var year = int.parse(yearController.text);
                            var publisher = publisherController.text;
                            var amount = double.parse(amountController.text);

                            // call provider
                            var provider = Provider.of<TransactionProvider>(
                                context,
                                listen: false);
                            Transactions item = Transactions(
                                title: title,
                                author: author,
                                year: year,
                                publisher: publisher,
                                amount: amount,
                                date: DateFormat('yyyy-MM-dd - kk:mm:ss')
                                    .format(DateTime.now()));
                            provider.addTransaction(item);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("เพิ่มข้อมูล"))
                  ]),
            )));
  }
}
