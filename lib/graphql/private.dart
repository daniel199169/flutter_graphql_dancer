import 'package:graphql/client.dart';

import 'package:dancer/graphql/models/user.dart';
import 'package:dancer/globals.dart' as globals;


class Private {
  static String token;

  static final _httpLink = HttpLink(uri: globals.API_URI + "/api/secured");
  static final _authLink = AuthLink(
    getToken: () async => 'Bearer $token',
  );

  static final Link _link = _authLink.concat(_httpLink);
  static final _client = GraphQLClient(
    cache: InMemoryCache(),
    link: _link,
  );

  static void resetCache() {
    _client.cache.reset();
  }

  static Future<QueryResult> teachers() async {
    const String query = r"""
      query Teachers {
        teachers {
          id
          phone
          firstName
          lastName
          roles
          ranking
          myRank
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
          events {
            id
            name
            startsAt
            endsAt
            type
            recurring
            description
            location {
              id
              name
              address
              geoLat
              geoLng
            }
            teacher {
              id
              firstName
              lastName
              phone
              roles
              profileImage
            }
          }
          age
          country
          about
          currentSchool
          linkInstagram
          linkTiktok
          linkFacebook
        }
      }
    """;

    final options = QueryOptions(
      documentNode: gql(query),
      variables: <String, dynamic>{
      },
    );

    return _client.query(options);
  }

  static Future<QueryResult> events() async {
    const String query = r"""
      query Events() {
        events {
          total
          data {
            id
            name
            startsAt
            endsAt
            type
            recurring
            location {
              id
              name
              address
              geoLat
              geoLng
            }
            teacher {
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
    """;

    final options = QueryOptions(
      documentNode: gql(query),
      variables: <String, dynamic>{
      },
    );

    return _client.query(options);
  }

  static Future<QueryResult> locations() async {
    const String query = r"""
      query Locations {
        locations {
          total
          data {
            id
            name
            address
            geoLat
            geoLng
            type
            openingHours
            category
          }
        }
      }
    """;

    final options = QueryOptions(
      documentNode: gql(query),
      variables: <String, dynamic>{
      },
    );

    return _client.query(options);
  }

  static Future<QueryResult> attendees() async {
    const String query = r"""
      query Attendees {
        users {
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
    """;

    final options = QueryOptions(
      documentNode: gql(query),
      variables: <String, dynamic>{
      },
    );

    return _client.query(options);
  }

  static Future<QueryResult> checkIn(int eventId) async {
    const String query = r"""
      mutation Confirm($eventId: Int!) {
        eventCheckIn(
          eventId: $eventId,
        )
      }
    """;

    final options = MutationOptions(
      documentNode: gql(query),
      variables: <String, dynamic>{
        'eventId': eventId,
      },
    );

    return _client.mutate(options);
  }

  static Future<QueryResult> rankTeacher(int teacherId, int rank) async {
    const String query = r"""
      mutation RankTeacher($teacherId: Int!, $rank: Int!) {
        rankTeacher(
          teacherId: $teacherId,
          rank: $rank,
        )
      }
    """;

    final options = MutationOptions(
      documentNode: gql(query),
      variables: <String, dynamic>{
        'teacherId': teacherId,
        'rank': rank,
      },
    );

    return _client.mutate(options);
  }

  static Future<QueryResult> updateUser(User user, {int imageId = null}) async {
    const String query = r"""
      mutation UpdateUser($age: Int, $country: String, $about: String, $currentSchool: String, $linkInstagram: String, $linkTiktok: String, $linkFacebook: String, $imageId: Int) {
        userUpdate(
          age: $age,
          country: $country,
          about: $about,
          currentSchool: $currentSchool,
          linkInstagram: $linkInstagram,
          linkTiktok: $linkTiktok,
          linkFacebook: $linkFacebook,
          imageId: $imageId,
        ) {
          id
          phone
          firstName
          lastName
          roles
          email
          username
          contact1
          contact2
          age
          country
          about
          groups {
            id
            name
            admin {
              id
              phone
              firstName
              lastName
              roles
            }
          }
          currentSchool
          linkInstagram
          linkTiktok
          linkFacebook
          profileImage
        }
      }
    """;

    final options = MutationOptions(
      documentNode: gql(query),
      variables: <String, dynamic>{
        'age': user.age,
        'country': user.country,
        'about': user.about,
        'currentSchool': user.currentSchool,
        'linkInstagram': user.linkInstagram,
        'linkTiktok': user.linkTiktok,
        'linkFacebook': user.linkFacebook,
        'imageId': imageId,
      },
    );

    return _client.mutate(options);
  }

  static Future<QueryResult> gallery() async {
    const String query = r"""
    query Gallery {
      galleries {
        id
        name
        images {
          id
          url
        }
      }
    }
    """;

    final options = QueryOptions(
      documentNode: gql(query),
      variables: <String, dynamic>{
      },
    );

    return _client.query(options);
  }
}

