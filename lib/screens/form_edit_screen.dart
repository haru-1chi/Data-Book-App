// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_db/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_db/models/transactions.dart';

class FormEditScreen extends StatefulWidget {
  final Transactions data;

  //Controller

  const FormEditScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<FormEditScreen> createState() => _FormEditScreenState();
}

class _FormEditScreenState extends State<FormEditScreen> {
  final formKey = GlobalKey<FormState>();

  final idController = TextEditingController();
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final yearController = TextEditingController();
  final publisherController = TextEditingController();
  final amountController = TextEditingController();

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  void initState() {
    super.initState();
    idController.text = widget.data.id.toString();
    titleController.text = widget.data.title.toString();
    authorController.text = widget.data.author.toString();
    yearController.text = widget.data.year.toString();
    publisherController.text = widget.data.publisher.toString();
    amountController.text = widget.data.amount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('แบบฟอร์มแก้ไขข้อมูล'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      enabled: false,
                      style: const TextStyle(color: Colors.black54),
                      decoration: const InputDecoration(labelText: "Item ID"),
                      autofocus: false,
                      controller: idController,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "ชื่อหนังสือ"),
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
                      decoration: const InputDecoration(labelText: "ชื่อผู้เขียน"),
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
                        if (double.parse(str) <= 0) {
                          return "กรุณาป้อนปีที่ตีพิมพ์มากกว่า 0";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "ชื่อสำนักพิมพ์"),
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
                          return "กรุณาป้อนราคา";
                        }
                        if (double.parse(str) <= 0) {
                          return "กรุณาป้อนราคามากกว่า 0";
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                        style: style,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            var id = int.parse(idController.text);
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
                                id: id,
                                title: title,
                                author: author,
                                year: year,
                                publisher: publisher,
                                amount: amount,
                                date: widget.data.date);
                            provider.updateTransaction(item);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("บันทึกข้อมูล"))
                  ]),
            )));
  }
}
