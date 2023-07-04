import SwiftUI

struct LoginView: View {
    @Binding var user: User
    @Binding var isLoggedIn: Bool
    
    @State private var username = ""
    @State private var email    = ""
    @State private var password = ""
    @State private var isShowingCreateAccount = false

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10.0)
                .padding(.horizontal)
                .autocapitalization(.none)

            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10.0)
                .padding(.horizontal)

            Button(action: {
                Task {
                    isLoggedIn = await signIn(username: username, password: password)
                }}) {
                Text("Log in")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10.0)
                    .padding(.horizontal)
            }


            Button(action: {
                isShowingCreateAccount = true
            }) {
                Text("Create Account")
                    .foregroundColor(.blue)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(10.0)
                    .padding(.horizontal)
            }
        }
        .sheet(isPresented: $isShowingCreateAccount) {
            CreateAccountView(user: $user, isLoggedIn: $isLoggedIn)
        }
    }
}
