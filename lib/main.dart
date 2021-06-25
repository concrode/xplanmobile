/// Flutter code sample for Form

// This example shows a [Form] with one [TextFormField] to enter an email
// address and an [ElevatedButton] to submit the form. A [GlobalKey] is used here
// to identify the [Form] and validate input.
//
// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/form.png)

import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml_parser/xml_parser.dart';



void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body:
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const MyStatefulWidget(),
            )
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Future<String> postOTP(String _uri, String _message) {
  //   HttpClient client = new HttpClient();
  //   HttpClientRequest request =  client.postUrl(Uri.parse(_uri));
  //   request.write(_message);
  //   HttpClientResponse response =  request.close();
  //   StringBuffer _buffer = new StringBuffer();
  //   await for (String a in  response.transform(utf8.decoder)) {
  //     _buffer.write(a);
  //   }
  //   print("_buffer.toString: ${_buffer.toString()}");
  //   return _buffer.toString();
  // }


  @override
  Widget build(BuildContext context) {
    String instruction = '';
    String asset = '';
    String exchange = '';
    String quantity = '';
    String limitPrice = '';


    


    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Instruction'
            ),
            onChanged: (text) {
              instruction = text;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Asset'
            ),
            onChanged: (text) {
              asset = text;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Exchange'
            ),
            onChanged: (text) {
              exchange = text;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Quantity'
            ),
            onChanged: (text) {
              quantity = text;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Limit Price'
            ),
            onChanged: (text) {
              limitPrice = text;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // // Validate will return true if the form is valid, or false if
                // // the form is invalid.
                // if (_formKey.currentState!.validate()) {
                //   // Process data.
                // }

                  var builder = new xml.XmlBuilder();
                  builder.processing('xml', 'version="1.0" encoding="iso-8859-9"');
                  builder.element('orders', nest: () {
                    builder.element('order', nest: () {
                      builder.element('order-date', nest: '2021-06-24');
                      builder.element('expiry', nest: '2021-06-24');
                      builder.element('instruction', nest: instruction);
                      builder.element('asset-code', nest: asset);
                      builder.element('exchange', nest: exchange);
                      builder.element('quantity', nest: quantity);
                      builder.element('limit', nest: limitPrice);
                      builder.element('cash', nest: double.parse(quantity) *  double.parse(limitPrice));
                      builder.element('source-user-id', nest: 'yuntian.he@iress');
                      builder.element('account-code', nest: '11440');
                      builder.element('source', nest: 'xplan-mobile');
                      builder.element('settlement-currency', nest: 'AUD');
                    });
                  });
                  var bookshelfXml = builder.build();
                  String _uriMsj = bookshelfXml.toString();
                  print("_uriMsj: $_uriMsj");

                  String _uri = 'http://172.30.2.221:8080/uma.ws/res/orders/xplan?sid=4E20F191-914E-4738-9300-A97DF8319214';

                  final response =  http.post(
                      Uri.parse(_uri),
                      headers: <String, String>{
                        'Content-Type': 'application/xml; charset=UTF-8',
                      },
                      body: _uriMsj
                    ).then((value) =>  print('value' + value.body));
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
