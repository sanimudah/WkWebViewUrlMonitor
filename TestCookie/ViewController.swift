//
//  ViewController.swift
//  TestCookie
//
//  Created by Abd Sani Abd Jalal on 19/09/2022.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var tableView: UITableView!
    var urlArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        // Do any additional setup after loading the view.
//        let urlString = "https://www.mudah.my"
        let urlString = "http://localhost:3000/"
        var request = URLRequest(url: URL(string: urlString)!)
        request.setValue("xoxo-gossip-girl", forHTTPHeaderField: "x-mudah-hd")
        webView.customUserAgent = "sani-is-here"
        webView.load(request)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("Navigation response!")
//        print(webView)
//        print(navigationResponse)
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("-- Decide Policy --")
        
        switch navigationAction.navigationType {
        case .backForward:
            print("Back Forward")
        case .formResubmitted:
            print("Form Resubmitted")
        case .formSubmitted:
            print("Form Submitted")
        case .linkActivated:
            print("Link Activated")
        case .other:
            print("Other")
        case .reload:
            print("Reload")
        default:
            print("What Type is this?")
        }
        decisionHandler(.allow)
        return
        
        if let host = navigationAction.request.url?.host, let urlToGo = navigationAction.request.url {
            print(host)
            print(urlToGo)
            if navigationAction.navigationType == .linkActivated {
                urlArray.insert(urlToGo.absoluteString, at: 0)
                tableView.reloadData()
            }
            
            if host == "www.apple.com" {
                decisionHandler(.allow)
                return
            }
        }
        
        decisionHandler(.allow)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = urlArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        urlArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    
}
