//
//  UIScrollView+Extention.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/4/20.
//  Copyright © 2020 张金山. All rights reserved.
//

import Foundation

public extension UIScrollView {
    
    /// 当前scrollView长截屏
    func longScreenshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(contentSize, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let previousFrame = frame
        frame = CGRect(origin: frame.origin, size: contentSize)
        layer.render(in: context)
        frame = previousFrame
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// 安全滑动到底部(不会滑到无效区域)
    /// - Parameter animated: 是否动画
    func safeScrollToBottom(animated: Bool = true) {
        let contentOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        safeSetContentOffset(contentOffset: contentOffset, animated: animated)
    }
    
    /// 安全滑动到直到contentOffset(不会滑到无效区域)
    /// - Parameters:
    ///   - contentOffset: 想要滑到的contentOffset
    ///   - animated: 是否动画
    func safeSetContentOffset(contentOffset: CGPoint, animated: Bool) {
        var offset = contentOffset
        var xMaxOffset: CGFloat, yMaxOffset: CGFloat, xMinOffset: CGFloat, yMinOffset: CGFloat
        if #available(iOS 11.0, *) {
            xMinOffset = -adjustedContentInset.left
            yMinOffset = -adjustedContentInset.top
            xMaxOffset = contentSize.width + adjustedContentInset.right - frame.size.width
            yMaxOffset = contentSize.height + adjustedContentInset.bottom - frame.size.height
        } else {
            xMinOffset = -contentInset.left
            yMinOffset = -contentInset.top
            xMaxOffset = contentSize.width + contentInset.right - frame.size.width
            yMaxOffset = contentSize.height + contentInset.bottom - frame.size.height
        }
        
        if offset.x > xMaxOffset {
            offset.x = xMaxOffset
        }
        if offset.y > yMaxOffset {
            offset.y = yMaxOffset
        }
        if offset.x < xMinOffset {
            offset.x = xMinOffset
        }
        if offset.y < yMinOffset {
            offset.y = yMinOffset
        }
        setContentOffset(offset, animated:animated)
    }
}
