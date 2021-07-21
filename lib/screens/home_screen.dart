import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_template/config/client.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeScreen extends StatelessWidget {
  static String id = 'home_screen';
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app_rounded),
              onPressed: () {
                _auth.signOut();
                Navigator.of(context).popUntil((route) => route.isFirst);
              }),
        ],
        title: Text('⚡YOUR IN!!'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text("Im Home")],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 500.0,
                child: GraphQLProvider(
                  client: Config.initializeClient(),
                  child: Query(
                    options: QueryOptions(
                      document: gql(r"""
                      query MyQuery {
                        comments(order_by: {id: asc}) {
                          comment
                          id
                          user {
                            email
                            name
                            id
                          }
                          
                        }
                      }
                      """),
                    ),
                    builder: (
                      QueryResult result, {
                      Future<QueryResult> Function() refetch,
                      FetchMore fetchMore,
                    }) {
                      if (result.hasException) {
                        return Text(result.exception.toString());
                      }

                      if (result.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final allComments = result.data['comments'];

                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.card_travel),
                            title: Text(allComments[index]['user']['name']),
                            subtitle: Text(allComments[index]['comment']),
                          );
                        },
                        itemCount: allComments.length,
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
