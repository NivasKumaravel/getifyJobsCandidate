import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utilits/Common_Colors.dart';
import '../utilits/Text_Style.dart';

class PdfPickerExample extends StatefulWidget {
  String? optionalTXT;
  String? pdfUrl;
  final bool? isProfile;
  bool? isCancelNeed;

  PdfPickerExample({Key? key, required this.optionalTXT, this.pdfUrl, required this.isProfile,required this.isCancelNeed});

  @override
  _PdfPickerExampleState createState() => _PdfPickerExampleState();
}

class _PdfPickerExampleState extends State<PdfPickerExample> {
  File? _selectedFile;
  String? _fileName;

  String pathPDF = "";

  @override
  void initState() {
    super.initState();

    if (isValidUrl(widget.pdfUrl ?? "")) {
      _fileName = basename(widget.pdfUrl!);

      // downloadPDF(widget.pdfUrl ?? "");
    } else {
      _fileName = "+ Upload Resume";
      print('Invalid URL');
    }
  }

  bool isValidUrl(String url) {
    Uri uri = Uri.parse(url);
    return uri.isAbsolute;
  }

  Future<void> _pickFile() async {
    if (isValidUrl(widget.pdfUrl ?? "")) {
      launch(widget.pdfUrl ?? "");
    } else {
      print('Invalid URL');

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'], // Limit to PDF files
      );

      if (result != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
          _fileName = result.files.single.name;
          SingleTon singleton = SingleTon();
          singleton.setPdf = _selectedFile;
        });
      }
    }
  }

  Future<void> downloadPDF(String pdfUrl) async {
    var request = await http.get(Uri.parse(pdfUrl));
    var bytes = request.bodyBytes;
    var pathPDFFile =
        (await getApplicationDocumentsDirectory()).path + '/$_fileName';
    File file = File(pathPDFFile);
    await file.writeAsBytes(bytes, flush: true);
    setState(() {
      pathPDF = pathPDFFile;
    });
  }

  void _cancelSelection() {
    setState(() {
      _selectedFile = null;
      _fileName = null;
    });
  }

  void _viewPdfExternally() {
    if (_selectedFile != null) {
      OpenFile.open(_selectedFile!.path); // Open the PDF externally
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isProfile == true?white2:white1,
      body:
     widget.isProfile == true? Center(
        child: InkWell(
          onTap: _pickFile,
          child: Center(
            child: _selectedFile == null
                ? Attachment1(context,
                optionalText: widget.optionalTXT ?? "+ Upload Resume")
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _viewPdfExternally,
                  child:
                  Container(
                    height: 75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: white1),
                    child:
                    Row(
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 10, right: 15),
                          child: ImgPathSvg("pdf.svg"),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "${_fileName}",
                              style: pdfT,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            )),
                        Spacer(),
                        InkWell(
                          onTap: _cancelSelection,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.cancel_outlined,
                              color: grey1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ):
      Center(
        child: InkWell(
          onTap: _pickFile,
          child: Center(
            child: _selectedFile == null
                ? Attachment(
                    optionalText: widget.optionalTXT ?? "+ Upload Resume")
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: _viewPdfExternally,
                        child:
                        Container(
                          height: 75,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: white1),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 15),
                                child: ImgPathSvg("pdf.svg"),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "${_fileName}",
                                    style: pdfT,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  )),
                              Spacer(),
                              InkWell(
                                onTap: _cancelSelection,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Icon(
                                    Icons.cancel_outlined,
                                    color: grey1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget Attachment({required String optionalText}) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 30),
      child: DottedBorder(
          color: grey5,
          borderType: BorderType.RRect,
          radius: Radius.circular(10),
          child: Container(
            height: 55,
            child: Center(child: AttachPdf(optional: optionalText)),
          )),
    );
  }

  Widget Attachment1(context,{required String optionalText}) {
    return
      optionalText !=""? Container(
      height: 75,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: white1),
      child: Row(
        children: [
          Padding(
            padding:
            const EdgeInsets.only(left: 10, right: 15),
            child: ImgPathSvg("pdf.svg"),
          ),
          Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                "${optionalText}",
                style: pdfT,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              )),
          widget.isCancelNeed == true  ? Spacer():Container(),
          widget.isCancelNeed == true?InkWell(
            onTap: (){
              setState(() {
                widget.optionalTXT = '';
                widget.pdfUrl = '';
                SingleTon singleton = SingleTon();
                singleton.setPdf = null;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                Icons.cancel_outlined,
                color: grey1,
              ),
            ),
          ):Container(),
        ],

      ),
    ):Attachment(optionalText: '+ Upload Resume');
  }
}


