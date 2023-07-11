//
//  WebViewController.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 10.07.2023.
//

import UIKit
import WebKit
import SnapKit

class WebViewController: UIViewController {

    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.isScrollEnabled = false
        webView.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(webView)
        guard let url = URL(string: "https://www.youtube.com/watch?v=W0247RL9gfE") else {return}
         
        DispatchQueue.main.async { [self] in
            webView.load(URLRequest(url: url ))
        }
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    func setupConstraints() {
    
        webView.snp.makeConstraints { make in
            make.height.equalTo(300)
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(100) // Set the new top height by adding an offset to the superview's top
        }
    }

}
