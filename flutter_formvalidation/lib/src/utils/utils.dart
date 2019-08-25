//file: utils.dart


  bool is_numeric(String strvalue){
    if(strvalue.isEmpty) return false;
    final n = num.tryParse(strvalue);
    return (n==null) ? false : true;
  }
