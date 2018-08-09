# iOS Session Example

This example shows how to build an iOS application with [Saber](https://github.com/apleshkov/saber) to work with user sessions: logging in, logging out and loading a user data. It uses [Alamofire](https://github.com/Alamofire/Alamofire) to work with [GitHub API](https://developer.github.com), [KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess) to store tokens and [PureLayout](https://github.com/PureLayout/PureLayout) for Auto Layout.

All dependencies are managed by [CocoaPods](https://github.com/CocoaPods/CocoaPods).

There're two containers (see `Saber` folder for generated files):
- `AppContainer`: a global container, represents an `App` scope
- `UserContainer`: a user-specific container, represents a `User` scope

One of the most important service is a `UserManager` (`App`-scoped). It's responsible for creating the `UserContainer` and logging a user in/out.

There's a single root view controller - `HomeVC` (`App`-scoped). We don't control its creation, so it's annotated with `@saber.injectOnly` and does a self-injection inside the `viewDidLoad()` method.

When you tap a "Login" button on the `HomeVC` controller, an `AuthorizerVC` controller is presented. A received  `access_token` will be stored in a `Keychain`, so a user won't have to log in again in the future. To _remove_ a stored token just tap a "Logout" button.

After a user is logged in, the app gets his/her name via a `UserAPI` (`User`-scoped).

There's no mechanism of token refreshing to simplify this example.

_Note_: both `github_client_id` and `github_client_secret` environment variables are provided via a `Run` scheme in Xcode, so you have to set your own to launch the app. 
