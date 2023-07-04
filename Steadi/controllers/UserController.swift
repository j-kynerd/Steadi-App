import Amplify
import Foundation

func signUp(user: User, email: String) async {
    let userAttributes = [AuthUserAttribute(.email, value: user.email)]
    let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
    do {
        let signUpResult = try await Amplify.Auth.signUp(
            username: user.username,
            password: user.password,
            options: options
        )
        if case let .confirmUser(deliveryDetails, _, userId) = signUpResult.nextStep {
            print("Delivery details \(String(describing: deliveryDetails)) for userId: \(String(describing: userId))")
        } else {
            print("SignUp Complete")
        }
    } catch let error as AuthError {
        print("An error occurred while registering a user \(error)")
    } catch {
        print("Unexpected error: \(error)")
    }
}


func signIn(username: String, password: String) async -> Bool {
    do {
        let signInResult = try await Amplify.Auth.signIn(
            username: username,
            password: password
            )
        if signInResult.isSignedIn {
            print("Sign in succeeded")
            
            UserDefaults.standard.set(username, forKey: "username")
            UserDefaults.standard.set(password, forKey: "password")
            
            return true
        }
    } catch let error as AuthError {
        print("Sign in failed \(error)")
        return false
    } catch {
        print("Unexpected error: \(error)")
        return false
    }
    return false
}

func updateAttribute(user: User) async {
    do {
        let updateResult = try await Amplify.Auth.update(
            userAttribute: AuthUserAttribute(.phoneNumber, value: "+2223334444")
        )

        switch updateResult.nextStep {
        case .confirmAttributeWithCode(let deliveryDetails, let info):
            print("Confirm the attribute with details send to - \(deliveryDetails) \(String(describing: info))")
        case .done:
            print("Update completed")
        }
    } catch let error as AuthError {
        print("Update attribute failed with error \(error)")
    } catch {
        print("Unexpected error: \(error)")
    }
}
