import 'dart:convert';

import 'package:http/http.dart' as http;

class Networking {
  static final Networking _instance = Networking._internal();
  static Networking getInstance() => _instance;

  // named constructor
  Networking._internal();

  // Need to be changed
  var _host = 'http://118.68.218.70';
  var _userName = 'Administrator';
  var _password = '';

  Networking setHost(String host) {
    _host = host;
    return _instance;
  }

  Networking setUserName(String userName) {
    _userName = userName;
    return _instance;
  }

  Networking setPassword(String password) {
    _password = password;
    return _instance;
  }

  Future<dynamic> isCustomer(String user, String password) async {
    // if (_userName == '' || _password == '' || _host == '') {
    //   throw Exception('Networking props error!');
    // }

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$_userName:$_password'))}';
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response = await http.get(
        Uri.parse(
            '$_host/PetsPark/hs/DogsPark/V1/Owner?phonenumber=$user&password=$password'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to call API, StatusCode: ${response.statusCode}');
    }
  }

  String getUserName() => _userName;
  // String? getPassword() => _password;

  Future<dynamic> getJSON(var url) async {
    // if (_userName == '' || _password == '' || _host == '') {
    //   throw Exception('Networking props error!');
    // }

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_userName:$_password'));
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response =
        await http.get(Uri.parse('$_host/$url'), headers: requestHeaders);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to call API, StatusCode: ${response.statusCode}');
    }
  }

  Future<dynamic> getReportsMeta() async {
    // TODO
    return {"indicatorQuantity": 5};
  }

  Future<dynamic> postToken(var url) async {
    if (_userName == '' || _password == '' || _host == '') {
      throw Exception('Networking props error!');
    }

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_userName:$_password'));
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response =
        await http.post(Uri.parse('$_host/$url'), headers: requestHeaders);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post API, StatusCode: ${response.statusCode}');
    }
  }

  Future<dynamic> putMaintenance(var url, var spobject) async {
    if (_userName == '' || _password == '' || _host == '') {
      throw Exception('Networking props error!');
    }

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_userName:$_password'));
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response = await http.put(Uri.parse('$_host/$url'),
        headers: requestHeaders, body: spobject);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post API, StatusCode: ${response.statusCode}');
    }
  }

  Future<dynamic> putUser(var url, var spobject) async {
    if (_userName == '' || _password == '' || _host == '') {
      throw Exception('Networking props error!');
    }

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_userName:$_password'));
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response = await http.put(Uri.parse('$_host/$url'),
        headers: requestHeaders, body: spobject);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to post API, StatusCode: ${response.statusCode}');
    }
  }

  Future<dynamic> isUser(String user, String password) async {
    if (_userName == '' || _password == '' || _host == '') {
      throw Exception('Networking props error!');
    }

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_userName:$_password'));
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response = await http.get(
        Uri.parse('$_host/hiaki_cms2/hs/hiaki_client/V1/users?username=' +
            user +
            '&password=' +
            password),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to call API, StatusCode: ${response.statusCode}');
    }
  }

  Future<dynamic> putUserData(var url, var spobject) async {
    if (_userName == '' || _password == '' || _host == '') {
      throw Exception('Networking props error!');
    }

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_userName:$_password'));
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response = await http.put(Uri.parse('$_host/$url'),
        headers: requestHeaders, body: spobject);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to post API, StatusCode: ${response.statusCode}');
    }
  }

  Future<dynamic> putSupport(var url, var spobject) async {
    if (_userName == '' || _password == '' || _host == '') {
      throw Exception('Networking props error!');
    }

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_userName:$_password'));
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response = await http.put(Uri.parse('$_host/$url'),
        headers: requestHeaders, body: spobject);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post API, StatusCode: ${response.statusCode}');
    }
  }

  Future<dynamic> postJSON(var url, var spobject) async {
    if (_userName == '' || _password == '' || _host == '') {
      throw Exception('Networking props error!');
    }

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_userName:$_password'));
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response = await http.post(Uri.parse('$_host/$url'),
        headers: requestHeaders, body: spobject);

    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      throw Exception('Failed to post API, StatusCode: ${response.statusCode}');
    }
  }

  Future<dynamic> putCustomer(var url, var spobject) async {
    // if (_userName == '' || _password == '' || _host == '') {
    //   throw Exception('Networking props error!');
    // }

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$_userName:$_password'))}';
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response = await http.put(Uri.parse('$_host/$url'),
        headers: requestHeaders, body: spobject);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post API, StatusCode: ${response.statusCode}');
    }
  }

  Future<dynamic> postDaycare(var url, var spobject) async {
    String basicAuth =
        // ignore: prefer_interpolation_to_compose_strings
        'Basic ' + base64Encode(utf8.encode('$_userName:$_password'));
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response = await http.post(Uri.parse('$_host/$url'),
        headers: requestHeaders, body: spobject);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to post API, StatusCode: ${response.statusCode}');
    }
  }

  Future<dynamic> postCustomer(var url, var spobject) async {
    // if (_userName == '' || _password == '' || _host == '') {
    //   throw Exception('Networking props error!');
    // }

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_userName:$_password'));
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response = await http.post(Uri.parse('$_host/$url'),
        headers: requestHeaders, body: spobject);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to post API, StatusCode: ${response.statusCode}');
    }
  }

  Future<bool?> postNewDog(
    String phoneNumber,
    var spobject,
  ) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_userName:$_password'));
    Map<String, String> requestHeaders = {'authorization': basicAuth};
    final response = await http.post(
      Uri.parse(
          'http://118.68.218.70/PetsPark/hs/DogsPark/V2/Dog?CustomerPhoneNumber=$phoneNumber'),
      headers: requestHeaders,
      body: spobject,
    );

    if (response.statusCode == 200) {
      //final data = jsonDecode(response.body);
      return true;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return null;
      // throw Exception('Failed to load info');
    }
  }
}
