import 'package:flutter/material.dart';
import 'package:ibenta_technical_test_flutter/data/users_repository.dart';
import 'package:ibenta_technical_test_flutter/models/user.dart';
import 'package:ibenta_technical_test_flutter/views/base_page.dart';

class UserPage extends StatefulWidget {
  final UsersRepository? repository;
  final User? user;

  UserPage({
    Key? key,
    required this.repository,
    this.user,
  }) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextEditingController = TextEditingController();
  final _userNameTextEditingController = TextEditingController();
  final _firstNameTextEditingController = TextEditingController();
  final _lastNameTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();

  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _emailTextEditingController.text = widget.user?.email ?? '';
    _userNameTextEditingController.text = widget.user?.userName ?? '';
    _firstNameTextEditingController.text = widget.user?.firstName ?? '';
    _lastNameTextEditingController.text = widget.user?.lastName ?? '';
    _passwordTextEditingController.text = widget.user?.password ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextEditingController.dispose();
    _userNameTextEditingController.dispose();
    _firstNameTextEditingController.dispose();
    _lastNameTextEditingController.dispose();
    _passwordTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: widget.user?.id == null ? 'Create new user' : 'Update user',
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            TextFormField(
              controller: _userNameTextEditingController,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Username',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Username is required';
                }
                return null;
              },
              onEditingComplete: () {},
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailTextEditingController,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  return 'Email is not valid';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _firstNameTextEditingController,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'First name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'First name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _lastNameTextEditingController,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Last name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Last name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordTextEditingController,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
              obscureText: true,
              validator: (value) {
                if (widget.user == null) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Password needs to be at least 6 characters long';
                  }
                }

                return null;
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottom: Container(
        padding: const EdgeInsets.all(20),
        height: 75,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                child: Text(widget.user == null ? "Submit" : 'Update'),
                style: ButtonStyle(
                  backgroundColor: _isProcessing
                      ? MaterialStateProperty.all<Color>(Colors.grey)
                      : MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: _isProcessing
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isProcessing = true;
                          });

                          final user = User(
                            id: widget.user?.id,
                            email: _emailTextEditingController.text,
                            userName: _userNameTextEditingController.text,
                            firstName: _firstNameTextEditingController.text,
                            lastName: _lastNameTextEditingController.text,
                            password: _passwordTextEditingController.text,
                          );
                          try {
                            widget.user == null
                                ? await widget.repository?.createUser(user)
                                : await widget.repository?.updateUser(user);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  widget.user == null
                                      ? 'User was created'
                                      : 'User was updated',
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.of(context).pop(true);
                          } on Exception catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(error.toString()),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }

                          setState(() {
                            _isProcessing = false;
                          });
                        }
                      },
              ),
            ),
            SizedBox(width: widget.user != null ? 10 : 0),
            widget.user != null
                ? Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      child: Text('Delete'),
                      onPressed: _isProcessing
                          ? null
                          : () async {
                              setState(() {
                                _isProcessing = true;
                              });

                              try {
                                await widget.repository
                                    ?.deleteUser(widget.user!.id!);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('User was deleted'),
                                    backgroundColor: Colors.green,
                                  ),
                                );

                                Navigator.of(context).pop(true);
                              } on Exception catch (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(error.toString()),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }

                              setState(() {
                                _isProcessing = false;
                              });
                            },
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
