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
        title: Text('Lista de numéros'),
        actions: [
          FlatButton.icon(
              onPressed: () {
                final _numbersControler = TextEditingController();
                final _qtdControler = TextEditingController();
                showCupertinoDialog(
                    builder: (context) => Column(
                      mainAxisSize: ,
                          children: [
                            Text('Digite o primeiro número com DDD'),
                            TextField(
                              controller: _numbersControler,
                              inputFormatters: [_numberMask],
                              keyboardType: TextInputType.phone,
                              decoration:
                                  InputDecoration(hintText: '(##) # ####-####'),
                            ),
                            SizedBox(height: 10),
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
                                  final _phone = _numbersControler.value.text;

                                  debugPrint(
                                      '::   Quantidade: $_qtd \n Numero: $_phone');

                                  if (_qtd.isNotEmpty || _qtd == '') {
                                    try {
                                      if (_phone.isNotEmpty ||
                                          _phone.length >= 10) {}
                                    } catch (e) {}
                                  }
                                },
                                child: Text('Gerar lista'))
                          ],
                        ), context: context;
              },
              icon: Icon(Icons.add_call),
              label: Text('Adicionar novos números'))
        ],
      ),
      body: ListView.builder(
          itemCount: numbersList.length,
          itemBuilder: (context, index) {
            String number = numbersList[index];
            return ListTile(
              leading: Text(number),
            );
          }),
    );
  }
}
