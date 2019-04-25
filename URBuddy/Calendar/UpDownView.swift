
import UIKit
let ScreenHeight = UIScreen.main.bounds.size.height
let ScreenWidth = UIScreen.main.bounds.size.width
class UpDownView: UIView ,UIGestureRecognizerDelegate{
    //白色view用来装一些控件
    var WhiteView: UIView =  UIView()
    var whiteViewStartFrame: CGRect = CGRect.init(x: 0, y: ScreenHeight, width: ScreenWidth, height: 450)
    var whiteViewEndFrame: CGRect = CGRect.init(x: 0, y: ScreenHeight - 450, width: ScreenWidth, height: 450)
    //确定按钮
    var okBtn: UIButton = UIButton()
    //背景区域的颜色和透明度
    var backgroundColor1:UIColor  = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
    var defaultTime:CGFloat = 0.5
    //初始化视图
    func initPopBackGroundView() -> UIView {
        self.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        self.backgroundColor = backgroundColor1
        self.isHidden = true
        //设置添加地址的View
        self.WhiteView.frame = whiteViewStartFrame
        WhiteView.backgroundColor = UIColor.white
        self.addSubview(WhiteView)
        //添加点击手势
        let tap: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapBtnAndcancelBtnClick))
        tap.delegate = self
        self.addGestureRecognizer(tap)
        okBtn = UIButton.init(type: UIButton.ButtonType.custom)
        okBtn.frame = CGRect.init(x:ScreenWidth - 60, y: 10, width: 40, height: 40)
        okBtn.tag = 1
        okBtn.setTitle("取消", for: UIControl.State.normal)
        okBtn.setTitleColor(ZHFColor.zhf_color(withHex: 0x42D2BE), for: UIControl.State.normal)
        okBtn.addTarget(self, action: #selector(tapBtnAndcancelBtnClick), for: UIControl.Event.touchUpInside)
        WhiteView.addSubview(okBtn)
        return self
    }
    //弹出的动画效果
    func addAnimate() {
        
    }
    //收回的动画效果
    @objc func tapBtnAndcancelBtnClick() {
        for view in WhiteView.subviews {
            view.removeFromSuperview()
        }
        UIView.animate(withDuration: TimeInterval(defaultTime), animations: {
            self.WhiteView.frame = self.whiteViewStartFrame
        }) { (_) in
            self.isHidden = true
        }
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        //点击WhiteView不回收
        if (touch.view?.isDescendant(of: self.WhiteView))!{
            return false
        }
        return true
    }
}