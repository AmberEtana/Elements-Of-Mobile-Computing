import SwiftUI
import Firebase
import PromiseKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import Kingfisher

struct ContentView: View {
    @EnvironmentObject var userEvents: EventStore
    @EnvironmentObject var viewModel: AuthViewModel
    @State var user: User? = nil
    @State var showSheet = false
    @State var loading: Bool = false
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    @State var showQRScanner: Bool = false
    @State var qRImageGenerator = QRImageGenerator(message: "Not Set")
    
    let fakeData = ["email": "fake@email.com",
                    "username": "error",
                    "fullname": "error",
                    "profileImageUrl": "error",
                    "uid": "error"]
    
   
    
    
    func signOut() {
        try? Auth.auth().signOut()
    }

    var body: some View {
        Group {
            if (viewModel.userSession != nil) {
                ZStack {
                    
                    NavigationView {
                        
                        TabView {
                            ProfileView(user: viewModel.user ?? User(dictionary: fakeData))
                                .background(Color("Custom Background"))
                            
                            .tabItem {
                                Image(systemName: "person.circle")
                                Text("Profile")
                                    
                            }
                            
                            
                                    
                            // Third tab TODO: Calendar
                            EventsCalendarView()
                                .background(Color("Custom Background"))
                                .tabItem {
                                    Image(systemName: "calendar.circle.fill")
                                    Text("Calendar")
                                }

                            
                            // Second tab
                            SocialView()
                                .background(Color("Custom Background"))
                                .tabItem {
                                    Image(systemName: "message")
                                    Text("Social")
                                }
                            
                            
                            
                            
                            
                            EventsListView()
                                .background(Color("Custom Background"))
                                .tabItem {
                                    Image(systemName: "list.triangle")
                                    Text("Events")
                                }
                            
                            SettingsView()
                                .background(Color("Custom Background"))
                                .tabItem {
                                    Image(systemName: "gear")
                                    Text("Settings")
                                }
                        }
                        .navigationBarItems(leading: NavigationLink(destination: ScannerView()) {
                            Image(systemName: "qrcode")
                        })
                        .accentColor(Color("Custom Accent"))
                            
                    }
                }
                
            } else {
                LoginView()
            }
        }
    }
    
    func presentAlert(title: String, message: String) {
        self.alertTitle = title
        self.alertMessage = message
        self.showAlert = true
    }
}

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .environmentObject(EventStore(preview: true))
                .environmentObject(AuthViewModel())
        }
    }


