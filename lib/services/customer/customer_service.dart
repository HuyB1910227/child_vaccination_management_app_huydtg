import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/customer/customer.dart';
import '../../models/auth_token.dart';
import '../api_service.dart';

class CustomerService extends ApiService {
  CustomerService([AuthToken? authToken]) : super (authToken);

  Future<Customer?> fetchCustomerByToken() async {
    try {
      final url = Uri.parse('$defaultUrl/api/customers/token/profile');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
      );
      if (response.statusCode != 200) {
        print("Not found customer");
        return null;
      }
      final resultString =
      utf8.decode(response.bodyBytes);
      final resultMap =
      json.decode(resultString);
      if (resultMap.isEmpty) {
        return null;
      }
      try{

        final customer = Customer.fromJson(resultMap);
        print("founded customer");
        print(customer);
        return customer;
      } catch(e) {
        print(e);
      }
      return null;
    } catch (error) {
      return null;
    }
  }

  Future<Customer?> partialUpdate(Customer customer) async {
    try {
      final url = Uri.parse('$defaultUrl/api/customers/${customer.id}');
      print(url);
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
        body: json.encode(customer.toJson()),
      );
      print(json.encode(customer.toJson()));
      print(response.headers);
      if (response.statusCode != 200) {
        print("can not update patient");
        return null;
      }
      final responseDataString =
      utf8.decode(response.bodyBytes);
      final responseDataMap =
      json.decode(responseDataString);
      if (responseDataMap.isEmpty) {
        return null;
      }
      final customerUpdated = Customer.fromJson(responseDataMap);
      print("updated customer");
      return customerUpdated;
    } catch (error) {
      return null;
    }
  }

  Future<bool> isInvalidValue(String? phone, String? identityCard,String? email) async {
    final request = {
      phone: phone,
      identityCard: identityCard,
      email: email,
    };
    try {
      final url = Uri.parse('$defaultUrl/customers/is-invalid-unique-value');
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
        body: json.encode(request),
      );
      final responseDataString =
      utf8.decode(response.bodyBytes);
      final responseDataMap =
      json.decode(responseDataString);
      return responseDataMap;
    } catch (error) {
      return false;
    }
  }
}