import SwiftUI


public struct ScaleUpContainerView<Content>: View where Content: View {
    
    @Binding var isScaled: Bool
        
    func getSize(gp: GeometryProxy) -> CGSize {
        if isScaled {
            return CGSize(width: gp.size.width - (padding.leading + padding.trailing),
                          height: gp.size.height - (padding.top + padding.bottom))
        } else {
            return CGSize(width: originSize.width, height: originSize.height)
        }
    }
    
    func getOrigintPoint(gp: GeometryProxy) -> CGPoint {
        if isScaled {
            return CGPoint(x: gp.size.width / 2.0,
                           y: gp.size.height / 2.0)
        } else {
            return CGPoint(x: originPoint.x, y: originPoint.x)
        }
    }

    
    private let padding: EdgeInsets
    private let originPoint: CGPoint
    private let originSize: CGSize
    private let presentationDelay: CGFloat
    private let content: Content

    public init(@ViewBuilder content: () -> Content, padding: EdgeInsets,
                originPoint: CGPoint,
                originSize: CGSize,
                presentationDelay: CGFloat = 0.4,
                isScaled: Binding<Bool>) {
        self.content = content()
        self.padding = padding
        self.originSize = originSize
        self.originPoint = originPoint
        self.presentationDelay = presentationDelay
        self._isScaled = isScaled
    }
    
    public var body: some View {
        
        GeometryReader { gr in
            
            ZStack {
                
                content
                    .edgesIgnoringSafeArea(.bottom)
                    .frame(width: getSize(gp: gr).width, height: getSize(gp: gr).height)
                    .position(x: getOrigintPoint(gp: gr).x, y: getOrigintPoint(gp: gr).y)

            }

        }
        .onAppear {
           
            DispatchQueue.main.asyncAfter(deadline: .now() + presentationDelay) {
                withAnimation {
                    isScaled = true
                }
            }
        }
        
    }
}
