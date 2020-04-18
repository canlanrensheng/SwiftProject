//
//  BaseViewController.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/2/26.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.navigationController != nil {
            let navBarHairlineImageView = self.findHairlineImageViewUnder(sView: self.navigationController!.navigationBar)
            navBarHairlineImageView.isHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.navigationController != nil {
            let navBarHairlineImageView = self.findHairlineImageViewUnder(sView: self.navigationController!.navigationBar)
            navBarHairlineImageView.isHidden = false
        }
    }
    
    func findHairlineImageViewUnder(sView: UIView) ->UIImageView {
        if sView.isKind(of: UIImageView.self) && sView.bounds.height <= 1 {
            return sView as! UIImageView
        }
        for sview in sView.subviews {
            let imgs = self.findHairlineImageViewUnder(sView: sview)
            if imgs.isKind(of: UIImageView.self) && imgs.bounds.height <= 1 {
                return imgs
            }
        }
        return UIImageView.init()
    }

}
