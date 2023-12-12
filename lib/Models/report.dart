class CheckboxData {
  bool checkboxValue1;
  bool checkboxValue2;
  bool checkboxValue3;
  bool checkboxValue4;
  bool checkboxValue5;
  bool checkboxValue6;
  bool checkboxValue7;
  bool checkboxValue8;
  bool checkboxValue9;
  bool checkboxValue10;
  bool checkboxValue11;
  bool checkboxValue12;
  bool checkboxValue13;
  bool checkboxValue14;
  bool checkboxValue15;
  String others;
  String imgUrl;
  

  CheckboxData({
    required this.checkboxValue1,
    required this.checkboxValue2,
    required this.checkboxValue3,
    required this.checkboxValue4,
    required this.checkboxValue5,
    required this.checkboxValue6,
    required this.checkboxValue7,
    required this.checkboxValue8,
    required this.checkboxValue9,
    required this.checkboxValue10,
    required this.checkboxValue11,
    required this.checkboxValue12,
    required this.checkboxValue13,
    required this.checkboxValue14,
    required this.checkboxValue15,
    required this.others,
    required this.imgUrl,

    
  });

  Map<String, dynamic> toJson() {
    return {
      'checkboxValue1': checkboxValue1,
      'checkboxValue2': checkboxValue2,
      'checkboxValue3': checkboxValue3,
      'checkboxValue4': checkboxValue4,
      'checkboxValue5': checkboxValue5,
      'checkboxValue6': checkboxValue6,
      'checkboxValue7': checkboxValue7,
      'checkboxValue8': checkboxValue8,
      'checkboxValue9': checkboxValue9,
      'checkboxValue11': checkboxValue10,
      'checkboxValue12': checkboxValue12,
      'checkboxValue13': checkboxValue13,
      'checkboxValue14': checkboxValue14,
      'checkboxValue15': checkboxValue15,
      'Others': others,
      'Image': imgUrl
    };
  }
}
