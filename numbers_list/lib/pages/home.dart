import 'dart:developer';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> numbersList = ['123456789', '55555555', '88888888'];
  final _numberMask = MaskTextInputFormatter(
      mask: '(##) # ####-####', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de números'),
        actions: [
          TextButton.icon(
              onPressed: () {
                final _numbersControler = TextEditingController();
                final _qtdControler = TextEditingController();
                showCupertinoDialog(
                    context: context,
                    builder: (context) =>
                        showDialog(_numbersControler, _qtdControler));
              },
              icon: Icon(
                Icons.add_call,
                color: Colors.white,
              ),
              label: Text('Adicionar novos números',
                  style: TextStyle(color: Colors.white)))
        ],
      ),
      body: ListView.builder(
          itemCount: numbersList.length,
          itemBuilder: (context, index) {
            String number = numbersList[index];
            return ListTile(
              leading: Text(number),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.call_rounded,
                        color: Theme.of(context).primaryColor,
                      )),
                  SizedBox(width: 10),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.phone_android,
                        color: Theme.of(context).primaryColor,
                      ))
                ],
              ),
            );
          }),
    );
  }

  Material showDialog(TextEditingController _numbersControler,
      TextEditingController _qtdControler) {
    return Material(
        child: Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Primeiro número da lista'),
            TextField(
              controller: _numbersControler,
              inputFormatters: [_numberMask],
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(hintText: '(##) # ####-####'),
            ),
            SizedBox(height: 30),
            Text('Quantidade'),
            TextField(
              keyboardType: TextInputType.number,
              controller: _qtdControler,
              decoration: InputDecoration(hintText: '20'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  final _qtd = _qtdControler.value.text;
                  String _phone = _numbersControler.value.text;

                  var _phoneNum = double.parse(_phone.substring(12));

                  if (_qtd.isNotEmpty || _qtd == '') {
                    if (_phone.length == 16) {
                      List<String> _list = [];

                      for (var i = 0; i < int.parse(_qtd); i++) {
                        _list.add(
                            _phone.substring(0, 12) + _phoneNum.toString());
                        _phoneNum++;
                      }

                      setState(() {
                        numbersList = _list;
                      });

                      Navigator.of(context).pop();
                    }
                  }
                },
                child: Text('Gerar lista'))
          ],
        ),
      ),
    ));
  }
}
