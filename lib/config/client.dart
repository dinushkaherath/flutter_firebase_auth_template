import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

String uuidFromObject(Object object) {
  if (object is Map<String, Object>) {
    final String typeName = object['__typename'] as String;
    final String id = object['id'].toString();
    if (typeName != null && id != null) {
      return <String>[typeName, id].join('/');
    }
  }
  return null;
}

class Config {
  static final HttpLink httpLink = HttpLink(
      'https://eternal-cat-44.hasura.app/v1/graphql',
      defaultHeaders: {'x-hasura-admin-secret': ''});
  //Todo Add hasura secret

  static final WebSocketLink webSocketLink = WebSocketLink(
    'wss://eternal-cat-44.hasura.app/v1/graphql',
    config: SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: Duration(seconds: 30),
    ),
  );
  static final Link link = httpLink.concat(webSocketLink);
  static ValueNotifier<GraphQLClient> initializeClient() {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(dataIdFromObject: uuidFromObject),
        link: link,
      ),
    );
    return client;
  }
}
