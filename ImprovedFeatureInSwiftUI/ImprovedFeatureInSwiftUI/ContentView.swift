//
//  ContentView.swift
//  ImprovedFeatureInSwiftUI
//
//  Created by mac admin on 30/06/20.
//

import SwiftUI
import MapKit
import AVKit

/*If you want to programmatically make SwiftUI’s ScrollView move to a specific location, you should embed a ScrollViewReader inside it. This provides a scrollTo() method that can move to any view inside the parent scrollview, just by providing its anchor.*/


struct ContentView: View {
    var body: some View{
        ScrollViewReaderView()
        
        
//        TextEditorView()
//          VStack{
//              LazyVGridView()
//              LazyHGridView()
//
//          }
//
//
//
//          TextEditor(text: $document.text)
//
//          ColorPickerView()
//          ToolBarItemView()
//
//          NavigationView {
//              Sidebar()
//              TextEditorView()
//          }

    }
}

struct ScrollViewReaderView: View {
    let colors: [Color] = [.red, .green, .blue]

    var body: some View {
        ScrollView {
            ScrollViewReader { value in
                LazyVStack {
                    Button("Jump to #d") {
                        print("kunal")
                        value.scrollTo("d", anchor: .top)
                    }
                    
//                    ForEach(0..<10) { i in
//                        Text("Example ")
//                            .frame(width: 300, height: 300)
//                            .background(colors[i % colors.count])
//                    }

                    
                    Text("hello world1").frame(height: 200).id("a")
                    Text("hello world2").frame(height: 200).id("b")
                    Text("hello world3").frame(height: 200).id("c")
                    Text("hello world4").frame(height: 200).id("d")
                    Text("hello world5").frame(height: 200).id("e")
                    Text("hello world6").frame(height: 200).id("f")
                    Text("hello world7").frame(height: 200).id("g")
                    Text("hello world6").frame(height: 200).id("h")
                    
                }.frame(maxWidth:.infinity)
               
                
                

            }
        }
    }
}

/*To get started, first create some sort of state that will track the coordinates being shown by the map. This uses MKCoordinateRegion, which takes a latitude/longitude pair for the center of the map, plus a coordinate span that controls how much is visible.*/

struct MapCoordinateView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 12.972442, longitude: 77.580643), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    var body: some View {
        Map(coordinateRegion: $region)
    }
}






/* can set the horizontal progress bar on any network or others */

//struct ContentView: View {
//    @State private var downloadAmount = 0.0
//
//    var body: some View {
//        VStack {
//            ProgressView("Downloading…", value: downloadAmount, total: 100)
//        }
//    }
//}
//

struct ProgressBarView: View {
    @State private var downloadAmount = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            ProgressView("Downloading…", value: downloadAmount, total: 100)
        }
        .onReceive(timer) { _ in
            if downloadAmount < 100{
                downloadAmount += 2
            }
        }
    }
}

/* vedio player in Swiftui*/

struct VideoPlayerView: View {
    var body: some View {

        VideoPlayer(player: AVPlayer(url:  URL(string: "https://bit.ly/swswift")!)) {
            VStack {
                Text("VideoPlayer")
                    .font(.title)
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.7))
                    .clipShape(Capsule())
                Spacer()
            }
        }

    }
}

/* create expanding list */
struct Bookmark: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    var items: [Bookmark]?

    
    
    // some example websites
    static let apple = Bookmark(name: "Apple", icon: "1.circle")
    
    static let bbc = Bookmark(name: "BBC", icon: "square.and.pencil")
    static let swift = Bookmark(name: "Swift", icon: "bolt.fill")
    static let twitter = Bookmark(name: "Twitter", icon: "mic")

    // some example groups
    static let example1 = Bookmark(name: "Favorites", icon: "star", items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
    static let example2 = Bookmark(name: "Recent", icon: "timer", items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
    static let example3 = Bookmark(name: "Recommended", icon: "hand.thumbsup", items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
}


struct BookMarkView: View {
    let items: [Bookmark] = [.example1, .example2, .example3]

    var body: some View {
        NavigationView {
            
            List(items, children: \.items) { row in
                Image(systemName: row.icon)
                NavigationLink(destination: Text(row.name)) {
                    Text(row.name)
                }
                
            }
        }
        
    }
}
//


/*creating scrolling pages of content using tabViewStyle*/
struct ScrollerPageView: View {
    var body: some View {
        Text("Hello, World")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
    }
}







struct TextEditorView: View{
    @State private var profileText: String = "SwiftUI has a TextEditor view for handling multi-line, scrolling text. You can set the font, change the colors as needed, and even adjust line spacing and how many lines can be created. You need to store the current value of your text field somewhere, using @State or similar. For example, we could create a text view to let the user enter profile "
    var body: some View {
        TextEditor(text: $profileText)
            .lineLimit(2) //will verify
            .foregroundColor(.black)
            .frame(width: 200, height: 200, alignment: .leading)

            .lineSpacing(10)
    }
        }


struct LazyVGridView: View {
    let data = (1...1000).map { "Item \($0)" }

//    let columns = [
//        GridItem(.adaptive(minimum: 80))
//    ]
    
    let columns = [
        GridItem(.fixed(100)),
        GridItem(.flexible())
//        GridItem(.flexible()),
//        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { item in
                    Text(item)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct LazyHGridView: View {
    let items = 1...100

    let rows = [
        GridItem(.fixed(200)),
    ]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, alignment: .center) {
                ForEach(items, id: \.self) { item in
                    Text(String(item))
                }
            }
        }
    }
}



struct TextFile: FileDocument {
    // tell the system we support only plain text
    static var readableContentTypes = [UTType.plainText]

    // by default our document is empty
    var text = ""

    // a simple initializer that creates new, empty documents
    init(initialText: String = "") {
        text = initialText
    }

    // this initializer loads data that has been saved previously
    init(fileWrapper: FileWrapper, contentType: UTType) throws {
        if let data = fileWrapper.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        }
    }

    // this will be called when the system wants to write our data to disk
    func write(to fileWrapper: inout FileWrapper, contentType: UTType) throws {
        let data = Data(text.utf8)
        fileWrapper = FileWrapper(regularFileWithContents: data)
    }
}


struct ColorPickerView: View {
    @State private var bgColor = Color.white

    var body: some View {
        VStack {
//            ColorPicker("Set the background color", selection: $bgColor)
            ColorPicker("Set the background color", selection: $bgColor, supportsOpacity: true)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(bgColor)
    }
}

struct ToolBarItemView: View {
    var body: some View {
        NavigationView {
            Text("Hello, World!").padding()
                .navigationTitle("SwiftUI")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack{
                            Button("Press Me") {
                                print("Pressed1")
                            }.padding(20)
                            
                            Button("Press Me") {
                                print("Pressed2")
                            }.padding(50)
                        }
                        
                    }
                    


                }
            
            
        }
    }
}


struct Sidebar: View {
    var body: some View {
        List(1..<100) { i in
            Text("Row \(i)")
        }
        .listStyle(SidebarListStyle())
    }
}


//------- 14th July -------

class User: ObservableObject {
    var username = "Kunal"
}


struct StateObjectProperty: View {
    @StateObject var user = User()
    
    var body: some View {
        Text("userName: \(user.username)")
    }
}

/* @state-> if the same view it is making it.
  @stateObject -> content view is owing it
 */


struct TabViewRestoreState: View {
    var  body: some View {
        NavigationView {
            List(1...300, id:\.self ) { i in
                NavigationLink(destination: Text("Details")) {
                    Text("Row \(i)")
                }
            }
        }.tabItem {
            Text("Tab")
        }
    }
}


struct AttributedString: View {
    var body: some View {
        Text("Quest").font(.largeTitle)
            .foregroundColor(.red)
        
        +
            Text("Global").font(.title)
            .foregroundColor(.green)
    }
}

struct DatePickerView: View {
    @State private var date = Date()
    var body: some View {
        VStack {
            Text("Enter your birthday").font(.largeTitle)
            DatePicker("Enter your birhday", selection: $date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .labelsHidden()
                .frame(maxHeight: 400)

            
            
        }
    }
}
