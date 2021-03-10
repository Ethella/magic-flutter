<p style="text-align: center;"><h3> magic_flutter</h3></p>

magic_flutter is a Flutter plugin for [Magic SDK](https://docs.magic.link/)
that you can integrate into your application to enable passwordless authentication using magic links - similar to Slack and Medium.

[Flutter](https://flutter.dev/) is Google’s UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase. Flutter is used by developers and organizations around the world, and is free and open source.

### Prerequisites
- Flutter SDK
  
#### Usage

<b>Intialize Magic SDK</b>

Initializes a new Magic SDK instance using the given publisherKey,and returns a bool. On initializing successfully, it will return true.

```dart
final result = await Magic.initializeMagic(publisherKey: publisherKey)
```

<b>Login with Magic link</b>

Allows users to login with magic link. Upon successful login, returns
`Future<DidToken>`.
```dart
final didToken = await Magic.initialize(email: "email address");
```

<b>Get user meta data</b>

Method to get meta data of already logged in user. Returns `Future<GetMetaDataResponse>` on success.

```dart
final getMetaDataResponse = await Magic.getMetaData();
```

<b>Update email</b>

Method to update email id of already logged in user. The method should be used if user is already logged in. Returns true if successfully udpated.

```dart
final isUpdated = await Magic.updateEmail(email: "emailAddress");
```

<b>Get login status</b>

Returns `Future<bool>`, which denotes if user has already logged in, or not.

```dart
final isLoggedIn = await Magic.isLoggedIn();
```

<b>Logout</b>

Method to logout, if user is logged in. Returns `Future<bool>` to denote, whether user has successfully logged out.

```dart
final isLoggedOut = await Magic.logout();
```
