import 'package:graphql/client.dart';

import 'package:dancer/globals.dart' as globals;


class Public {
  static final _httpLink = HttpLink(uri: globals.API_URI + "/api");
  static final Link _link = _httpLink;
  static final _client = GraphQLClient(
    cache: InMemoryCache(),
    link: _link,
  );

  static void resetCache() {
    _client.cache.reset();
  }

  static Future<QueryResult> login(String phone, String password) async {
    const String query = r"""
      query Login($phone: String!, $password: String!) {
        login(phone: $phone, password: $password) {
          token
          tokenType
          user {
            id
            phone
            firstName
            lastName
            email
            username
            contact1
            contact2
            roles
            profileImage
            groups {
              id
              name
              admin {
                id
                phone
                firstName
                lastName
                roles
                profileImage
              }
            }

          }
        }
      }
    """;

    final options = QueryOptions(
      documentNode: gql(query),
      variables: <String, dynamic>{
        'phone': phone.trim(),
        'password': password.trim(),
      },
    );

    return _client.query(options);
  }
}
