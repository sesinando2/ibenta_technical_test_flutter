import 'package:flutter/material.dart';
import 'package:ibenta_technical_test_flutter/data/api_client.dart';
import 'package:ibenta_technical_test_flutter/data/api_constants.dart';
import 'package:ibenta_technical_test_flutter/data/users_repository.dart';
import 'package:ibenta_technical_test_flutter/models/user.dart';
import 'package:ibenta_technical_test_flutter/views/base_page.dart';
import 'package:ibenta_technical_test_flutter/views/users/user_page.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

class UsersPage extends StatefulWidget {
  UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  UsersRepository? _repository;

  @override
  void initState() {
    super.initState();
    _setupRepository();
  }

  Future<void> _setupRepository() async {
    final client = await oauth2.clientCredentialsGrant(
      Uri.parse(ApiConstants.ACCESS_TOKEN_URL),
      ApiConstants.CLIENT_ID,
      ApiConstants.CLIENT_SECRET,
      scopes: ['read', 'write'],
    );
    _repository = UsersRepository(ApiClient(client));
  }

  Future<List<User>> _getUsers() async {
    final users = await _repository?.getUsers();
    return users!;
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'All users',
      child: FutureBuilder<List<User>>(
        future: _getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text("No users found"),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) {
                return Divider(color: Colors.grey);
              },
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return ListTile(
                  title: Text(user.userName),
                  subtitle: Text(user.email),
                  onTap: () async {
                    final didUpdate = await Navigator.of(context).push<bool>(
                      MaterialPageRoute(
                        builder: (context) => UserPage(
                          repository: _repository,
                          user: user,
                        ),
                      ),
                    );

                    if (didUpdate != null && didUpdate) {
                      //Refresh list of users
                      setState(() {});
                    }
                  },
                );
              },
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final didCreate = await Navigator.of(context).push<bool>(
            MaterialPageRoute(
              builder: (context) => UserPage(
                repository: _repository,
              ),
            ),
          );

          if (didCreate != null && didCreate) {
            //Refresh list of users
            setState(() {});
          }
        },
      ),
    );
  }
}
