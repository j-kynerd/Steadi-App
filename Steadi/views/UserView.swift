import SwiftUI

struct UserView: View {
    @Binding var user: User
    @State var isEditing = false
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            Text("User Info")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 20)
            if isEditing {
                VStack(spacing: 20) {
                    TextField("Username", text: $user.username)
                        .padding()
                    
                    SecureField("Password", text: $user.password)
                        .padding()
                    
                    TextField("Email", text: Binding(
                        get: { user.email ?? "" },
                        set: { user.email = $0 }
                    ))
                    .padding()
                    
                    TextField("First Name", text: Binding(
                        get: { user.firstName ?? "" },
                        set: { user.firstName = $0 }
                    ))
                    .padding()
                    
                    TextField("Last Name", text: Binding(
                        get: { user.lastName ?? "" },
                        set: { user.lastName = $0 }
                    ))
                    .padding()
                    
                    Button(action: {
                        // TODO: Implement save logic
                        isEditing = false
                    }) {
                        Text("Save")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            } else {
                VStack(spacing: 20) {
                    Text("Username: \(user.username)")
                        .font(.headline)
                    Text("Email: \(user.email ?? "N/A")")
                        .font(.headline)
                    Text("First Name: \(user.firstName ?? "N/A")")
                        .font(.headline)
                    Text("Last Name: \(user.lastName ?? "N/A")")
                        .font(.headline)
                    
                    Button(action: {
                        isEditing = true
                    }) {
                        Text("Edit")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
}
