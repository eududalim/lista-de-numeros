import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:numbers_list/api/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> numbersList = [];
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
              label: Text('Gerar nova lista',
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
                      onPressed: () {
                        number = number.replaceAll('(', '');
                        number = number.replaceAll(')', '');
                        number = number.replaceAll(' ', '');
                        number = number.replaceAll('-', '');
                        try {
                          WhatsAppApi.abrirWhatsApp(number);
                        } catch (e) {
                          log(e.toString());
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Aplicativo não encontrado')));
                        }
                      },
                      icon: Icon(
                        Icons.perm_phone_msg_rounded,
                        color: Colors.green,
                      )

                      /* Image.asset(
                        '/home/flutter/Documentos/lista-de-numeros/numbers_list/assets/whatsapp-icon.png',
                        width: 50,
                        scale: 5,
                      ) */
                      ),
                ],
              ),
            );
          }),
    );
  }

  showDialog(TextEditingController _numbersControler,
      TextEditingController _qtdControler) {
    return Scaffold(
        body: Dialog(
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

                  if (_qtd.isNotEmpty || _qtd != '') {
                    if (_phone.length == 16) {
                      var _phoneNum = int.parse(_phone.substring(12));

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
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Insira os dados corretamente')));
                },
                child: Text('Gerar lista'))
          ],
        ),
      ),
    ));
  }
}
