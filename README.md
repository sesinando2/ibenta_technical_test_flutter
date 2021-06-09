# Ibenta Technical Test (Flutter)

Welcome to the Ibenta Technical Test for Flutter Developers. Please make sure you have access to this repo.

#### Requirements:
```
flutter --version
Flutter 2.2.0 • channel beta • https://github.com/flutter/flutter.git
Framework • revision b22742018b (4 weeks ago) • 2021-05-14 19:12:57 -0700
Engine • revision a9d88a4d18
Tools • Dart 2.13.0
```

#### To do this test:
1. Fork this repo to your github account.
1. Create a branch: `feature/<Your Name in Kebab Case>-<Todays Date>` e.g. `feature/john-smith-25-09-2020`
1. Push all your changes in that branch.
1. When you're done with the test, create a pull request.
1. Send me the link of your pull request. Make sure I have access to your repo and PR.

---

#### Level 1:
1. Create a screen with the following fields:
    1. `Username` - This is a required text field.
    1. `Email` - This is a required email field. This should only contain a valid email value.
    1. `First Name` - This is a required text field.
    1. `Last Name` - This is a required text field
    1. `Password` - This is a required password field.
1. Add a validation for the fields. Please refer to the field definition above.
1. Add a submit button. Clicking this button will display an alert/notification that the user has been added.

---

#### Level 2:
1. Create another screen all existing users.
1. Implement a delete functionality that will remove previously added user.
1. When the list is empty, display a message indicating the user that they need to add a user first.
1. Implement an edit functionality that will allow user to edit existing users from the table.

Bonus: Implement some form of automated testing.

---

#### Level 3:
1. Do all steps in Level 1 & Level 2
1. Implement an API client with the following details:
    * Base URL is `https://authentication-service-pr45.gitops.ibenta.com/api`
    * Will use `OAuth2` for security. OAuth2 details are as follows:
        * Grant Type: `Client Credentials`
        * Access Token URL: `https://authentication-service-pr45.gitops.ibenta.com/oauth/token`
        * Client ID: `AITWD1zyBVuPWgn4ZBHSREtXJDZXL9Lt`
        * Client Secret: `ELEGpyarKD0OWDrzfiqWqmpkOb4FSKnb`
        * Scope: `read write`
1. Use this client to:
    1. Create new users:
        * Request: `POST https://authentication-service-pr45.gitops.ibenta.com/api/users`
        * Request Body:
            ```
                {
                    "name": "jon.jones@ibenta.com.au",
                    "firstName": "Jon",
                    "lastName": "Jones",
                    "email": "jon.jones@ibenta.com.au",
                    "password": "Password1"
                }
            ```
        * Response: `HTTP 201`
        * Response Body: Note ignore permission, roles, groups and organisation
            ```
                {
                    "name": "jon.jones@ibenta.com.au",
                    "permissions": [],
                    "firstName": "Jon",
                    "lastName": "Jones",
                    "email": "jon.jones@ibenta.com.au",
                    "password": null,
                    "roles": [],
                    "groups": [],
                    "id": 79,
                    "organisation": null
                }
            ```
    1. Update existing users:
        * Request: `PUT https://authentication-service-pr45.gitops.ibenta.com/api/users/{id}`
        * Request Body:
            ```
                {
                    "name": "jon.jones@ibenta.com.au",
                    "firstName": "Jon",
                    "lastName": "Jones",
                    "email": "jon.jones@ibenta.com.au",
                    "password": "Password1"
                }
            ```
        * Response: `HTTP 200`
        * Response Body: Note ignore permission, roles, groups and organisation
            ```
                {
                    "name": "james.jones@ibenta.com.au",
                    "permissions": [],
                    "firstName": "Jon",
                    "lastName": "Jones",
                    "email": "jon.jones@ibenta.com.au",
                    "password": null,
                    "roles": [],
                    "groups": [],
                    "id": 79,
                    "organisation": null
                }
            ```
    1. Delete existing user:
        * Request: `DELETE https://authentication-service-pr45.gitops.ibenta.com/api/users/{id}`
        * Response: `HTTP 204`
    1. List all users:
        * Request: `GET https://authentication-service-pr45.gitops.ibenta.com/api/users`
        * Response: `HTTP 200`
        * Response Body: Note ignore permission, roles, groups and organisation
            ```
                {
                    "content": [
                        {
                            "name": "jon.jones@ibenta.com.au",
                            "permissions": [],
                            "firstName": "Jon",
                            "lastName": "Jones",
                            "email": "jon.jones@ibenta.com.au",
                            "password": null,
                            "roles": [],
                            "groups": [],
                            "id": 79,
                            "organisation": null
                        }
                    ],
                    "pageable": {
                        "sort": {
                            "sorted": false,
                            "unsorted": true,
                            "empty": true
                        },
                        "pageSize": 20,
                        "pageNumber": 0,
                        "offset": 0,
                        "paged": true,
                        "unpaged": false
                    },
                    "totalPages": 1,
                    "totalElements": 1,
                    "last": true,
                    "first": true,
                    "sort": {
                        "sorted": false,
                        "unsorted": true,
                        "empty": true
                    },
                    "numberOfElements": 1,
                    "size": 20,
                    "number": 0,
                    "empty": false
                }
            ```

Bonus: Implement pagination.

# ibenta_technical_test_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
