import SwiftUI


@main
struct SwiftUI_Scale_View_From_PointApp: App {
    
    @State var isScaled: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                
                Color.black.edgesIgnoringSafeArea(.all)
                
                ScaleUpContainerView(content: {
                    if isScaled {
                        Color.red
                            .cornerRadius(20)
                    } else {
                        Color.white
                            .cornerRadius(20)
                    }
                }, padding: .init(top: 20,
                                  leading: 20,
                                  bottom: 20,
                                  trailing: 20),
                                     originPoint: CGPoint(x: 100, y:100),
                                     originSize: CGSize(width: 44, height: 44),
                                     isScaled: $isScaled)
                
                
            }

        }
    }
}
