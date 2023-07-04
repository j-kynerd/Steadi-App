import SwiftUI

struct CreateAccountView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @Binding var user: User
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: createAccount) {
                    Text("Create Account")
                }
                .buttonStyle(PlainButtonStyle())
                .padding()
                
                Spacer()
            }
            .navigationBarTitle("Create Account")
        }
    }
    
    func createAccount() {
        if password == confirmPassword {
            let newUser = User(username: username, email: email, password: password)
            presentationMode.wrappedValue.dismiss()
            
            // TODO: create user in DB
            user = newUser

            
            // if successful...
                isLoggedIn = true
            
        } else {
            // Show an alert to the user indicating that the passwords don't match
            print("Passwords don't match!")
        }
    }
}
