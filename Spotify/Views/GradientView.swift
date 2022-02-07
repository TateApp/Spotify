

import UIKit

class Gradient: UIView {

var _gradientColor = [CGColor]()
var _locations = [NSNumber]()
    
    init(frame: CGRect, gradientColor: [CGColor], location: [NSNumber], type: CAGradientLayerType?, startPoint: CGPoint?, endPoint: CGPoint?) {

super.init(frame: frame)
        _locations = location
        _gradientColor = gradientColor
if let layer = self.layer as? CAGradientLayer {

layer.colors = _gradientColor

layer.locations = _locations

    if type != nil {
        layer.type = type!
    }

    
    if startPoint != nil {
        layer.startPoint = startPoint!
    }
    if endPoint != nil {
        layer.endPoint = endPoint!
    }
   

}

}
override class var layerClass: AnyClass {

return CAGradientLayer.self

}
required init?(coder: NSCoder) {

fatalError("init(coder:) has not been implemented")

}

}

