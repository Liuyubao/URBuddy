

import UIKit

enum DKAnimationType: Int {
    case DKAnimationUp
    case DKAnimationSnake
    case DKAnimationBound
}

let KLabelX = 5
let KLabelH = 20
let PHFont = 15.0

func angle2radian(angle: Double) -> Double {
    return (angle) / 180.0 * .pi
}

class DKAnimationTextField: UIView {
    //输入框文本颜色
    var textColor: UIColor! {
        didSet {
            textField!.textColor = self.textColor
        }
    }
    
    //占位符
    var placeStr: String! {
        didSet {
            placeLabel?.text = self.placeStr
        }
    }
    
    //占位符颜色
    var placeHoderColor: UIColor! {
        didSet {
            placeLabel?.textColor = self.placeHoderColor
        }
    }
    
    //占位符字体  和textField字体相同
    var placeHoderFont: UIFont! {
        didSet {
            placeLabel?.font = self.placeHoderFont
            textField!.font = self.placeHoderFont
        }
    }
    
    //文字对齐方式
    var textAlignment: NSTextAlignment! {
        didSet {
            placeLabel?.textAlignment = self.textAlignment
            textField!.textAlignment = self.textAlignment
        }
    }
    
    private var placeLabel: UILabel?
    //输入的文字类型
    var textInput: String = ""
    
    //动画类型
    var animationType: DKAnimationType!
    
    //
    var textField: UITextField!
    
    
    private var isNull: Bool!
    private var labelHeight: CGFloat = 0
    private var textFiledHeight: CGFloat = 0
    private var bottoomLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        isNull = true
        
        //默认动画
        animationType = DKAnimationType.DKAnimationUp
        textFiledHeight = frame.size.height - labelHeight
        
        //添加占位符
        let rectPlacer = CGRect(x: CGFloat(KLabelX), y: labelHeight, width: frame.size.width, height: textFiledHeight)
        placeLabel = UILabel(frame: rectPlacer)
        placeLabel?.font = UIFont.systemFont(ofSize: CGFloat(PHFont))
        placeHoderColor = UIColor.darkGray
        addSubview(placeLabel!)
        
        //添加输入框
        let rect_tf = CGRect(x: 20, y: labelHeight, width: frame.size.width - 20, height: textFiledHeight)
        textField = UITextField(frame: rect_tf)
        textField!.clearButtonMode = .whileEditing
        textField!.backgroundColor = UIColor.clear
        textField!.addTarget(self, action: #selector(valueChange(_:)), for: .editingDidBegin)
        textField!.addTarget(self, action: #selector(valueEnd(_:)), for: .editingDidEnd)
        
        addSubview(textField!)

        bottoomLabel = UILabel(frame: CGRect(x: 0.0, y: frame.size.height - 1, width: frame.size.width, height: 1.0))
        bottoomLabel?.backgroundColor = UIColor.gray
        addSubview(bottoomLabel!)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //监听textfield输入
    @objc func valueChange(_ TextField: UITextField) {
        switch animationType {
        case .DKAnimationBound?:
            animationBound()
        case .DKAnimationSnake?:
            animationShake()
        case .DKAnimationUp?:
            animationUp()
        case .none: break
    
        case .some(_): break

        }
        bottoomLabel?.backgroundColor = UIColor(red: 100/255, green: 182/255, blue: 245/255, alpha: 1)
        textInput = TextField.text!
    }
    
    //监听textfield的结束
    @objc func valueEnd(_ textFieldT: UITextField) {
        var labelRect = textField.frame
//        print("+++++++ \(labelRect)")
        labelRect.origin.x = CGFloat(KLabelX)
        if textFieldT.text?.count == 0 {
            isNull = true
            bottoomLabel?.backgroundColor = UIColor.gray
            UIView.animate(withDuration: 0.5, animations: {
                self.placeLabel?.frame = labelRect
                self.placeLabel?.font = UIFont.systemFont(ofSize: CGFloat(PHFont))
//                print("+++++++ \(labelRect)")
            }, completion: nil)
        }
    }
    
    
    //向上的动画
    func animationUp() {
        var labelRect = textField!.frame
        labelRect.origin.x = CGFloat(KLabelX)
        if isNull! {
            isNull = false
            labelRect.origin.y = (textField!.frame.origin.y) - (textField!.frame.size.height)
            //开始描写动画效果
            UIView .animate(withDuration: 0.5, animations: {
                self.placeLabel?.frame = labelRect
                self.placeLabel?.font = UIFont.systemFont(ofSize: CGFloat(PHFont) * 0.73)
            }, completion: nil)
        }
        
        
        
    }
    
    //抖动动画
    func animationShake() {
        var labelRect = textField!.frame
        labelRect.origin.x = CGFloat(KLabelX)
        if isNull! {
            isNull = false
            labelRect.origin.y = (textField!.frame.origin.y) - (textField!.frame.size.height)
            //开始描述动画
            UIView.animate(withDuration: 0.5, animations: {
                self.placeLabel?.frame = labelRect
                let rotation = CAKeyframeAnimation()
                rotation.keyPath = "transform.rotation"
                rotation.values = [angle2radian(angle: -5), angle2radian(angle: 5), angle2radian(angle: -5)]
                self.placeLabel?.layer .add(rotation, forKey: nil)
            }, completion: nil)
        }
        
        
        
    }
    
    //弹簧动画
    func animationBound() {
        var labelRect = textField!.frame
        
        if isNull! {
            isNull = false
            labelRect.origin.y = (textField!.frame.origin.y) - (textField!.frame.size.height)
           
            //开始描绘动画
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                self.placeLabel?.frame = labelRect
            }, completion: nil)
            
        }
    }
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
