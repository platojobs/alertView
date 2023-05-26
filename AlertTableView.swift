//
//  AlertTableView.swift
//  APP_Text
//
//  Created by Jobs Plato on 2023/5/26.
//

import UIKit

class AlertTableView: UITableViewCell {

    var block:(()->())? = nil
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var contexView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static let aletrView : AlertTableView = Bundle.main.loadNibNamed("AlertTableView", owner: AlertTableView.self)?.last as! AlertTableView;
    
    
    func show(){
        self.isHidden = false
        let transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)
        self.contexView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2)
        
        self.contexView.alpha = 0;
        self.frame = CGRect(x: 0, y: 0, width: APPSCREENWIDTH, height: APPSCREENHEIGHT)
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 10,animations: {
            
                self.contexView.transform = transform
                self.contexView.alpha = 1
                self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
                
            
        }) { [self] finished in
            self.perform(#selector(dismissAlert(view:)), with: self, afterDelay: 1.0)
        }
        
        
    }
    
    @objc func dismissAlert(view:UIView){
        self.dismiss()
        guard let bb = self.block else{
            return
        }
        bb()
    }
    
    func dismiss(){
        
        UIView.animate(withDuration: 0.3) {
            self.contexView.transform = CGAffineTransformMakeScale(0.02, 0.02)
        }completion: { finish in
            self.removeFromSuperview()
        }
        
        
    }
    
    static func title(title: String,show:(()->())?)->(AlertTableView){
        let alertview = AlertTableView.aletrView
        alertview.title.text = title
        alertview.block = show
        alertview .show()
        return alertview
    }
    
    
    @IBAction func sender(_ sender: UIButton) {
        self.dismiss()
    }
    
}
