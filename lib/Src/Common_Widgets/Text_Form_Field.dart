import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getifyjobs/Models/CollegePrfileModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:searchfield/searchfield.dart';
import 'package:super_tag_editor/tag_editor.dart';
import 'package:super_tag_editor/widgets/rich_text_widget.dart';

import '../utilits/Common_Colors.dart';
import '../utilits/Text_Style.dart';
import 'Build_Imge.dart';
import 'Common_Button.dart';

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}

//TEXTFORM FIELD
//Common fields
Widget textFormField(
    {TextEditingController? Controller,
    String? Function(String?)? validating,
    bool? isEnabled,
    void Function(String)? onChanged,
    required String hintText,
    List<TextInputFormatter>? inputFormatters,
    required TextInputType keyboardtype,
    FocusNode? focusNode}) {
  return Container(
    // height: 50,
    child: TextFormField(
      enabled: isEnabled,
      focusNode: focusNode,
      controller: Controller,
      textCapitalization: TextCapitalization.none,
      inputFormatters: inputFormatters,
      validator: validating,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        hintText: hintText,
        hintStyle: phoneHT,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: white2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: white2),
        ),
        fillColor: white2,
        filled: true,
      ),
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      style: Textfield_Style,
      keyboardType: keyboardtype,
    ),
  );
}

//TEXTFIELD DATE PICKER
Widget TextFieldDatePicker(
    {TextEditingController? Controller,
    String? Function(String?)? validating,
    void Function(String)? onChanged,
    required String hintText,
    required bool isDownArrow,
    FocusNode? focusNode,
    void Function()? onTap}) {
  return TextFormField(
    controller: Controller,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    onTap: onTap,
    readOnly: true,
    focusNode: focusNode,
    keyboardType: TextInputType.number,
    maxLength: 15,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: white2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: white2),
      ),
      counterText: "",
      hintText: hintText,
      helperStyle: phoneHT,
      suffixIcon: isDownArrow == true
          ? Icon(
              Icons.keyboard_arrow_down_sharp,
              color: Colors.black,
              size: 35,
            )
          : null,
      prefixIcon: Icon(
        Icons.calendar_today_outlined,
        color: grey4,
        size: 18,
      ),
      hintStyle: phoneHT,
      errorMaxLines: 3,
      contentPadding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 2.0, right: 2.0),
      fillColor: white2,
      filled: true,
    ),
    validator: validating,
    onChanged: onChanged,
    textInputAction: TextInputAction.next,
    style: const TextStyle(
      fontFamily: "Inter",
      fontWeight: FontWeight.w400,
      fontSize: 12.0,
      color: Colors.black,
    ),
  );
}

// TEXT FIELD PASSWORD
Widget textFieldPassword(
    {TextEditingController? Controller,
    String? Function(String?)? validating,
    void Function(String)? onChanged,
    required bool obscure,
    required void Function()? onPressed,
    required String hintText,
    FocusNode? focusNode,
    required TextInputType keyboardtype}) {
  return Container(
    // height: 50,
    child: TextFormField(
      controller: Controller,
      obscureText: obscure,
      validator: validating,
      focusNode: focusNode,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        hintText: hintText,
        hintStyle: phoneHT,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: white2),
            borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.lock : Icons.lock_open,
            color: grey2,
          ),
          onPressed: onPressed,
        ),
        fillColor: white2,
        filled: true,
      ),
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardtype,
      style: Textfield_Style,
    ),
  );
}

// TEXT FIELD PASSWORD
Widget textFieldPassword2(
    {TextEditingController? Controller,
    String? Function(String?)? validating,
    void Function(String)? onChanged,
    required bool obscure,
    required void Function()? onPressed,
    required String hintText,
    required TextInputType keyboardtype}) {
  return Container(
    // height: 50,
    child: TextFormField(
      controller: Controller,
      obscureText: obscure,
      validator: validating,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        hintText: hintText,
        hintStyle: phoneHT1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: white1),
            borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.lock : Icons.lock_open,
            color: grey2,
          ),
          onPressed: onPressed,
        ),
        fillColor: white1,
        filled: true,
      ),
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardtype,
      style: Textfield_Style,
    ),
  );
}

//DESCRIPTION
Widget textfieldDescription(
    {TextEditingController? Controller,
    String? Function(String?)? validating,
    required String? hintText,
    List<TextInputFormatter>? inputFormatters,
    FocusNode? focusNode}) {
  return Container(
    // height: 50,
    child: TextFormField(
      controller: Controller,
      textCapitalization: TextCapitalization.none,
      maxLines: 5,
      minLines: 3,
      keyboardType: TextInputType.multiline,
      validator: validating,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        hintText: hintText,
        hintStyle: phoneHT,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: white2),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: white2,
        filled: true,
      ),
      textInputAction: TextInputAction.next,
      style: Textfield_Style,
    ),
  );
}

Widget textfieldDescription1(
    {TextEditingController? Controller,
    String? Function(String?)? validating}) {
  return Container(
    // height: 50,
    child: TextFormField(
      controller: Controller,
      textCapitalization: TextCapitalization.none,
      maxLines: 5,
      minLines: 3,
      keyboardType: TextInputType.multiline,
      validator: validating,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        hintText: "Enter the Interview Address",
        hintStyle: phoneHT1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: white2),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: white2,
        filled: true,
      ),
      textInputAction: TextInputAction.next,
      style: Textfield_Style,
    ),
  );
}

Widget textfieldDescription3(
    {TextEditingController? Controller,
    String? Function(String?)? validating}) {
  return Container(
    // height: 50,
    child: TextFormField(
      controller: Controller,
      textCapitalization: TextCapitalization.none,
      maxLines: 5,
      minLines: 3,
      keyboardType: TextInputType.multiline,
      validator: validating,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        hintText: "Enter Feedback about company",
        hintStyle: phoneHT1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: white1),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: white1,
        filled: true,
      ),
      textInputAction: TextInputAction.next,
      style: Textfield_Style,
    ),
  );
}

//SEARCH BAR
Widget textFormFieldSearchBar(
    {TextEditingController? Controller,
    String? Function(String?)? validating,
    bool? isEnabled,
    bool? isMultifilterNeeded,
    void Function()? MultifilteronTap,
    void Function(String)? onChanged,
    required String hintText,
    List<TextInputFormatter>? inputFormatters,
    required TextInputType keyboardtype,
    required FocusNode? focusNode}) {
  return Container(
    // height: 50,
    child: TextFormField(
      enabled: isEnabled,
      controller: Controller,
      focusNode: focusNode,
      textCapitalization: TextCapitalization.none,
      inputFormatters: inputFormatters,
      validator: validating,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        hintText: hintText,
        hintStyle: phoneHT,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: blue1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: blue1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: blue1),
        ),
        fillColor: white1,
        filled: true,
        prefixIcon: Icon(
          Icons.search,
          size: 24,
          color: grey4,
        ),
        suffixIcon: isMultifilterNeeded == true
            ? InkWell(
                onTap: MultifilteronTap,
                child: Icon(
                  Icons.filter_list,
                  size: 24,
                  color: Colors.black,
                ),
              )
            : null,
      ),
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      style: Textfield_Style,
      keyboardType: keyboardtype,
    ),
  );
}

Widget tagSearchField(
    {required String hintText,
    required bool focusTagEnabled,
    required List<String> values,
    // required TextEditingController textEditingController,
    required List<DropDownData> listValue,
    required FocusNode? focus,
    required String? error,
    required Function(List<String>) onPressed}) {
  _onDelete(index) {
    values.removeAt(index);
    onPressed(values);
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color:
                error != null ? Colors.red : Colors.grey, // Red border if error
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TagEditor<String>(
          padding: EdgeInsets.only(left: 8, right: 8),
          backgroundColor: white2,
          borderRadius: 10,
          length: values.length,

          // controller: textEditingController,
          focusNode: focus,
          delimiters: [
            ',',
          ],
          hasAddButton: false,
          resetTextOnSubmitted: true,
          // This is set to grey just to illustrate the `textStyle` prop
          textStyle: const TextStyle(color: Colors.grey),
          onSubmitted: (outstandingValue) {
            if (outstandingValue.isNotEmpty) {
              values.add(outstandingValue);
              onPressed(values);
            } else {
              focus!.unfocus();
            }
          },
          inputDecoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: phoneHT,
          ),
          onTagChanged: (newValue) {
            values.add(newValue);
            onPressed(values);
          },
          tagBuilder: (context, index) => Container(
            color: focusTagEnabled && index == values.length - 1
                ? Colors.redAccent
                : Colors.transparent,
            child: _Chip(
              index: index,
              label: values[index],
              onDeleted: _onDelete,
            ),
          ),
          // InputFormatters example, this disallow \ and /
          inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[/\\]'))],
          useDefaultHighlight: false,
          suggestionBuilder: (context, state, data, index, length, highlight,
              suggestionValid) {
            var borderRadius = const BorderRadius.all(Radius.circular(10));
            if (index == 0) {
              borderRadius = const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              );
            } else if (index == length - 1) {
              borderRadius = const BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              );
            }
            return InkWell(
              onTap: () {
                values.add(data);
                print("object");
                onPressed(values);

                state.resetTextField();
                state.closeSuggestionBox();
              },
              child: Container(
                  decoration: highlight
                      ? BoxDecoration(
                          color: Theme.of(context).focusColor,
                          borderRadius: borderRadius)
                      : null,
                  padding: const EdgeInsets.all(16),
                  child: RichTextWidget(
                    wordSearched: suggestionValid ?? '',
                    textOrigin: data,
                  )),
            );
          },
          onFocusTagAction: (focused) {
            focusTagEnabled = focused;
          },
          onDeleteTagAction: () {
            if (values.isNotEmpty) {
              values.removeLast();
            }
          },
          onSelectOptionAction: (item) {
            values.add(item);
            onPressed(values);
          },
          suggestionsBoxElevation: 10,
          suggestionsBoxMaxHeight: 150,

          findSuggestions: (String query) {
            if (query.isNotEmpty) {
              var lowercaseQuery = query.toLowerCase();

              final mockResults =
                  listValue.map((e) => e.qualification ?? "").toList();

              return mockResults.where((profile) {
                return profile.toLowerCase().contains(query.toLowerCase()) ||
                    profile.toLowerCase().contains(query.toLowerCase());
              }).toList(growable: false)
                ..sort((a, b) => a
                    .toLowerCase()
                    .indexOf(lowercaseQuery)
                    .compareTo(b.toLowerCase().indexOf(lowercaseQuery)));
            }
            return [];
          },
        ),
      ),
      if (error != null) // Show error message
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            error,
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
        ),
    ],
  );
}

Widget tagSearchFieldPreferredLoc(
    {required String hintText,
    required bool focusTagEnabled,
    required List<String> values,
    // required TextEditingController textEditingController,
    required List<DropDownData> listValue,
    required String? error,
    required Function(List<String>) onPressed}) {
  _onDelete(index) {
    values.removeAt(index);
    onPressed(values);
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color:
                error != null ? Colors.red : Colors.grey, // Red border if error
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TagEditor<String>(
          enabled: false,
          enableFocusAfterEnter: false,
          focusNode: FocusNode(),
          padding: EdgeInsets.only(left: 8, right: 8),
          backgroundColor: white2,
          borderRadius: 10,
          length: values.length,
          // controller: textEditingController,
          delimiters: [','],
          hasAddButton: false,
          resetTextOnSubmitted: true,
          // This is set to grey just to illustrate the `textStyle` prop
          textStyle: const TextStyle(color: Colors.grey),
          onSubmitted: (outstandingValue) {
            if (outstandingValue.isNotEmpty) {
              values.add(outstandingValue);
              onPressed(values);
            } else {
              // focus!.unfocus();
            }
          },
          inputDecoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
          onTagChanged: (newValue) {
            values.add(newValue);
            onPressed(values);
          },
          tagBuilder: (context, index) => Container(
            color: focusTagEnabled && index == values.length - 1
                ? Colors.redAccent
                : Colors.transparent,
            child: _Chip(
              index: index,
              label: values[index],
              onDeleted: _onDelete,
            ),
          ),
          // InputFormatters example, this disallow \ and /
          inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[/\\]'))],
          useDefaultHighlight: false,
          suggestionBuilder: (context, state, data, index, length, highlight,
              suggestionValid) {
            var borderRadius = const BorderRadius.all(Radius.circular(20));
            if (index == 0) {
              borderRadius = const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              );
            } else if (index == length - 1) {
              borderRadius = const BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              );
            }
            return InkWell(
              onTap: () {
                values.add(data);
                print("object");
                onPressed(values);

                state.resetTextField();
                state.closeSuggestionBox();
              },
              child: Container(
                  decoration: highlight
                      ? BoxDecoration(
                          color: Theme.of(context).focusColor,
                          borderRadius: borderRadius)
                      : null,
                  padding: const EdgeInsets.all(10),
                  child: RichTextWidget(
                    wordSearched: suggestionValid ?? '',
                    textOrigin: data,
                  )),
            );
          },
          onFocusTagAction: (focused) {
            focusTagEnabled = focused;
          },
          onDeleteTagAction: () {
            if (values.isNotEmpty) {
              values.removeLast();
            }
          },
          onSelectOptionAction: (item) {
            values.add(item);
            onPressed(values);
          },
          suggestionsBoxElevation: 10,
          suggestionsBoxMaxHeight: 150,
          findSuggestions: (String query) {
            if (query.isNotEmpty) {
              var lowercaseQuery = query.toLowerCase();

              final mockResults =
                  listValue.map((e) => e.qualification ?? "").toList();

              return mockResults.where((profile) {
                return profile.toLowerCase().contains(query.toLowerCase()) ||
                    profile.toLowerCase().contains(query.toLowerCase());
              }).toList(growable: false)
                ..sort((a, b) => a
                    .toLowerCase()
                    .indexOf(lowercaseQuery)
                    .compareTo(b.toLowerCase().indexOf(lowercaseQuery)));
            }
            return [];
          },
        ),
      ),
      if (error != null) // Show error message
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            error,
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
        ),
    ],
  );
}

Widget buildCompanyInfoRow(String pathPNG, String companyName,
    TextStyle textStyle, double imageWidth, double imageHeight,
    {required bool? isMapLogo}) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, top: 5),
    child: Container(
      child: Row(
        children: [
          isMapLogo == true
              ? Container(
                  height: imageHeight,
                  width: imageWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                          image: AssetImage("lib/assets/$pathPNG"),
                          fit: BoxFit.cover)),
                )
              : Container(
                  height: imageHeight,
                  width: imageWidth,
                  child: buildImage(pathPNG,
                      border: const Radius.circular(25), fit: BoxFit.cover),
                ),
          SizedBox(
            width: 25,
          ),
          Expanded(
            child: Container(
              child: Text(
                companyName,
                style: textStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildCompanyInfoRow1(String pathPNG, String companyName,
    TextStyle textStyle, double imageWidth, double imageHeight,
    {required bool? isMapLogo}) {
  return Container(
    child: Row(
      children: [
        isMapLogo == true
            ? Container(
                height: imageHeight,
                width: imageWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                        image: NetworkImage(pathPNG), fit: BoxFit.cover)),
              )
            : Container(
                height: imageHeight,
                width: imageWidth,
                child: buildImage(pathPNG,
                    border: const Radius.circular(25), fit: BoxFit.cover),
              ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            child: Text(
              companyName,
              style: textStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget collegeRowTitle(String pathPNG, String companyName, TextStyle textStyle,
    double imageWidth, double imageHeight) {
  return Container(
    child: Row(
      children: [
        Container(
          height: imageHeight,
          width: imageWidth,
          child: ImgPathSvg(pathPNG),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Container(
            child: Text(
              companyName,
              style: textStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget collegeRowTitle1(String pathPNG, String companyName, TextStyle textStyle,
    double imageWidth, double imageHeight) {
  return Container(
    child: Row(
      children: [
        Container(
          height: imageHeight,
          width: imageWidth,
          child: Image(
            image: NetworkImage(pathPNG),
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            child: Text(
              companyName,
              style: textStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget textWithheader({required String headertxt, required String subtxt}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headertxt,
          style: htxt,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          subtxt,
          style: stxt,
        ),
      ],
    ),
  );
}

Widget buildListView(List<String> yourList) {
  return ListView.builder(
    itemCount: yourList.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: Text(yourList[index]),
      );
    },
  );
}

//DropDownExperience
Widget dropDownField(context,
    {required String? value,
    required String? hintText,
    required List<String>? listValue,
    required void Function(String?)? onChanged,
    FocusNode? focusNode,
    required String? error,
    String? Function(String?)? validator}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(
              color: error != null
                  ? Colors.red
                  : Colors.grey, // Red border if error
            ),
            borderRadius: BorderRadius.circular(10),
            color: white2),
        child: DropdownButtonFormField<String>(
          focusNode: focusNode,
          validator: validator,
          // validator: (value) {
          //   if (value!.isEmpty) {
          //     return 'Please Select Career Status';
          //   }
          //   return null;
          // },
          hint: Text(
            hintText!,
            style: phoneHT,
          ),
          value: value,
          isExpanded: true,
          decoration: InputDecoration(border: InputBorder.none),
          icon: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.keyboard_arrow_down_sharp,
              color: Colors.black,
              size: 35,
            ),
          ),
          items: listValue?.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Text(option),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
      if (error != null) // Show error message
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            error,
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
        ),
    ],
  );
}

Widget dropDownSearchField(
  context, {
  required FocusNode? focus,
  required List<DropDownData> listValue,
  required String? Function(String?)? validator,
  required void Function(String?)? searchText,
  required void Function(SearchFieldListItem<DropDownData> x)? onChanged,
  required String hintT,
  TextEditingController? controller,
}) {
  List<DropDownData> lists = listValue.map((e) => e).toList();
  lists.sort((a, b) => a.qualification!.compareTo(b.qualification!));
  return SearchField(
    controller: controller,
    focusNode: focus,
    suggestionDirection: SuggestionDirection.down,
    suggestions: lists
        .map((e) => SearchFieldListItem<DropDownData>(e.qualification ?? ""))
        .toList(),
    suggestionState: Suggestion.expand,
    suggestionsDecoration: SuggestionDecoration(padding: EdgeInsets.all(10)),
    textInputAction: TextInputAction.next,
    suggestionStyle: TextStyle(
      fontSize: 18,
      color: Colors.black.withOpacity(0.8),
    ),
    validator: validator,
    searchInputDecoration: SearchInputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      hintText: hintT,
      hintStyle: phoneHT,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: white2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: white2),
      ),
      fillColor: white2,
      filled: true,
    ),
    maxSuggestionsInViewPort: 5,
    itemHeight: 40,
    onSuggestionTap: onChanged,
    onSubmit: searchText,
  );
}

Widget dropDownSearchFieldSpecialization(context,
    {required FocusNode? focus,
    required List<DropDownData> listValue,
    required String? Function(String?)? validator,
    required void Function(String?)? searchText,
    required void Function(SearchFieldListItem<DropDownData> x)? onChanged,
    required String hintT}) {
  List<DropDownData> lists = listValue.map((e) => e).toList();
  lists.sort((a, b) => a.specialization!.compareTo(b.specialization!));

  return SearchField(
    focusNode: focus,
    suggestionDirection: SuggestionDirection.down,
    suggestions: lists
        .map((e) => SearchFieldListItem<DropDownData>(e.specialization ?? ""))
        .toList(),
    suggestionState: Suggestion.expand,
    suggestionsDecoration: SuggestionDecoration(padding: EdgeInsets.all(10)),
    textInputAction: TextInputAction.next,
    suggestionStyle: TextStyle(
      fontSize: 18,
      color: Colors.black.withOpacity(0.8),
    ),
    validator: validator,
    searchInputDecoration: SearchInputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      hintText: hintT,
      hintStyle: phoneHT,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: white2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: white2),
      ),
      fillColor: white2,
      filled: true,
    ),
    maxSuggestionsInViewPort: 5,
    itemHeight: 40,
    onSuggestionTap: onChanged,
    onSubmit: searchText,
  );
}

Widget dropDownSearchFieldCollege(context,
    {required FocusNode? focus,
    required List<DropDownData> listValue,
    required String? Function(String?)? validator,
    required void Function(String?)? searchText,
    required void Function(SearchFieldListItem<DropDownData> x)? onChanged,
    required TextEditingController? controller,
    required String hintT}) {
  List<DropDownData> lists = listValue.map((e) => e).toList();
  lists.sort((a, b) => a.collegeName!.compareTo(b.collegeName!));

  return SearchField(
    controller: controller,
    focusNode: focus,
    suggestionDirection: SuggestionDirection.down,
    suggestions: lists
        .map((e) => SearchFieldListItem<DropDownData>(e.collegeName ?? ""))
        .toList(),
    suggestionState: Suggestion.expand,
    suggestionsDecoration: SuggestionDecoration(padding: EdgeInsets.all(10)),
    textInputAction: TextInputAction.next,
    suggestionStyle: TextStyle(
      fontSize: 18,
      color: Colors.black.withOpacity(0.8),
    ),
    validator: validator,
    searchInputDecoration: SearchInputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      hintText: hintT,
      hintStyle: phoneHT,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: white2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: white2),
      ),
      fillColor: white2,
      filled: true,
    ),
    maxSuggestionsInViewPort: 5,
    itemHeight: 40,
    onSuggestionTap: onChanged,
    onSubmit: searchText,
  );
}

//DROPDOWN WHITE1
Widget dropDownField2(context,
    {required String? value,
    required List<String>? listValue,
    required void Function(String?)? onChanged}) {
  return Container(
    height: 50,
    width: MediaQuery.of(context).size.width,
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(10), color: white1),
    child: DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: white1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: white1),
          ),
          fillColor: white1,
          filled: true),
      icon: Icon(
        Icons.keyboard_arrow_down_sharp,
        color: Colors.black,
        size: 35,
      ),
      items: listValue?.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Text(option),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    ),
  );
}

Widget NotificationStack() {
  return Stack(
    children: [
      Padding(
        padding: EdgeInsets.only(right: 20, top: 10),
        child: ImgPathSvg("bell.svg"),
      ),
      // Positioned(
      //   top: 10,
      //   right: 20,
      //   child: Container(
      //     width: 10,
      //     height: 10,
      //     decoration: BoxDecoration(
      //       color: Colors.red, // Set the color of the dot here
      //       shape: BoxShape.circle,
      //     ),
      //   ),
      // ),
    ],
  );
}

//WHITE COLOR FIELD
Widget textFormField2(
    {TextEditingController? Controller,
    String? Function(String?)? validating,
    bool? isEnabled,
    void Function(String)? onChanged,
    required String hintText,
    List<TextInputFormatter>? inputFormatters,
    required TextInputType keyboardtype}) {
  return Container(
    // height: 50,
    child: TextFormField(
      enabled: isEnabled,
      controller: Controller,
      textCapitalization: TextCapitalization.none,
      inputFormatters: inputFormatters,
      validator: validating,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
        hintText: hintText,
        hintStyle: phoneHT1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: white1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: white1),
        ),
        fillColor: white1,
        filled: true,
      ),
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      style: Textfield_Style,
      keyboardType: keyboardtype,
    ),
  );
}

//WHITE DESCRIPTION
Widget textfieldDescription2(
    {TextEditingController? Controller,
    String? Function(String?)? validating}) {
  return Container(
    // height: 50,
    child: TextFormField(
      controller: Controller,
      textCapitalization: TextCapitalization.none,
      maxLines: 5,
      minLines: 3,
      keyboardType: TextInputType.multiline,
      validator: validating,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        hintText: "Description",
        hintStyle: phoneHT1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: white1),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: white1,
        filled: true,
      ),
      textInputAction: TextInputAction.next,
      style: Textfield_Style,
    ),
  );
}

class TimePickerFormField extends StatefulWidget {
  final Function(String) onValidate;
  TimePickerFormField({required this.onValidate});
  @override
  _TimePickerFormFieldState createState() => _TimePickerFormFieldState();
}

class _TimePickerFormFieldState extends State<TimePickerFormField> {
  String? _selectedTime;

  // @override
  // void initState() {
  //   super.initState();
  //   _selectedTime = TimeOfDay.now();
  // }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      String formattedTime = _formatTime(picked);
      setState(() {
        SingleTon().setTime = _selectedTime ?? formattedTime;
        _selectedTime = formattedTime;
      });
      widget.onValidate!(_selectedTime!); // Call the validation callback
    }
  }

  String _formatTime(TimeOfDay time) {
    String period = time.period == DayPeriod.am ? 'AM' : 'PM';
    int hour = time.hourOfPeriod;
    int minute = time.minute;
    String formattedHour = hour.toString().padLeft(2, '0');
    String formattedMinute = minute.toString().padLeft(2, '0');
    return '$formattedHour:$formattedMinute $period';
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        readOnly: true,
        decoration: InputDecoration(
          counterText: "",
          hintText: "HH: MM : AM/PM",
          hintStyle: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
            color: Colors.grey,
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: white2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: white2),
          ),
          fillColor: white2,
          filled: true,
          prefixIcon: IconButton(
            icon: Icon(
              Icons.access_time_outlined,
              color: grey4,
              size: 25,
            ),
            onPressed: () {
              _selectTime(context);
            },
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_down_sharp,
              color: Colors.black,
              size: 35,
            ),
            onPressed: () {
              _selectTime(context);
            },
          ),
        ),
        onChanged: null,
        validator: (value) {
          if (value == "(HH:MM)") {
            return 'Please select a time';
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        style: const TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
          color: Colors.black,
        ),
        controller: TextEditingController(
          text: _selectedTime,
        ));
  }
}

class MyDatePickerForm extends StatefulWidget {
  @override
  _MyDatePickerFormState createState() => _MyDatePickerFormState();
}

class _MyDatePickerFormState extends State<MyDatePickerForm> {
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: true,
      keyboardType: TextInputType.number,
      maxLength: 15,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: white2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: white2),
        ),
        counterText: "",
        hintText: 'DD / MM / YYYY',
        helperStyle: phoneHT,
        suffixIcon: Icon(
          Icons.keyboard_arrow_down_sharp,
          color: Colors.black,
          size: 35,
        ),
        prefixIcon: Icon(
          Icons.calendar_today_outlined,
          color: grey4,
          size: 24,
        ),
        hintStyle: const TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w400,
          fontSize: 12.0,
          color: Colors.grey,
        ),
        errorMaxLines: 1,
        contentPadding: const EdgeInsets.only(
            top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
        fillColor: white2,
        filled: true,
      ),
      textInputAction: TextInputAction.next,
      style: const TextStyle(
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
        color: Colors.black,
      ),
      controller: dateController,
      onTap: () => _selectDate(context),
    );
  }
}

Widget generateCustomContainer({
  required Color containerColor,
  required TextStyle titleStyle,
  required TextStyle subtitleStyle,
  required TextStyle valueStyle,
  required String title,
  required String subtitle,
  required String value,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: containerColor,
    ),
    margin: EdgeInsets.only(left: 20, bottom: 20),
    child: Container(
      margin: EdgeInsets.only(left: 20, right: 40, top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, maxLines: 2, style: titleStyle),
          Text(subtitle, style: subtitleStyle),
          Text(value, style: valueStyle),
        ],
      ),
    ),
  );
}

Widget generateCustomContainer1({
  required Color containerColor,
  required TextStyle titleStyle,
  required TextStyle valueStyle,
  required String title,
  required String value,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: containerColor,
    ),
    margin: EdgeInsets.only(left: 20, bottom: 20),
    child: Container(
      margin: EdgeInsets.only(left: 20, right: 40, top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, maxLines: 2, style: titleStyle),
          SizedBox(
            height: 6,
          ),
          Text(value, style: valueStyle),
        ],
      ),
    ),
  );
}

//ENTER QR CODE
//CHAT FIELD
Widget Chat_Field(context,
    {TextEditingController? Controller,
    String? Function(String?)? validating,
    required void Function()? onTap,
    bool? isEnabled,
    void Function(String)? onChanged,
    required String hintText,
    List<TextInputFormatter>? inputFormatters,
    required TextInputType keyboardtype}) {
  return Container(
    // height: 50,
    child: TextFormField(
      enabled: isEnabled,
      readOnly: false,
      controller: Controller,
      textCapitalization: TextCapitalization.none,
      inputFormatters: inputFormatters,
      validator: validating,
      decoration: InputDecoration(
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 30, top: 5, bottom: 5),
          child: Chat_Button(context, onTap),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        hintText: hintText,
        hintStyle: phoneHT,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: white1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: white1),
        ),
        fillColor: white1,
        filled: true,
      ),
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      style: Textfield_Style,
      keyboardType: keyboardtype,
    ),
  );
}
