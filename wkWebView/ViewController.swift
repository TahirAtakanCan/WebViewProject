//
//  ViewController.swift
//  wkWebView
//
//  Created by Tahir Atakan Can on 28.12.2023.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView()
        webView.navigationDelegate = self
        
        let contentController = webView.configuration.userContentController
        contentController.add(self , name: "buttonClicked")
        
        view = webView
        
        let url = URL(string: "https://2.elveri.com/")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Bir gecikme ekleyerek JavaScript kodunu çalıştır
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.webView.evaluateJavaScript(self.addButtonScript) { (result, error) in
                if let error = error {
                    print("JavaScript Error: \(error)")
                }
            }
        }
    }
    
    let addButtonScript = """
        var button = document.createElement('button');
        button.innerHTML = 'Click me';
        button.style.padding = '10px';
        button.style.backgroundColor = 'blue';
        button.style.color = 'white';
        var abcElement = document.querySelector('.header-selectors-wrapper');

        if (abcElement) {
            abcElement.appendChild(button);
            button.addEventListener('click', function() {
                console.log("atakan");
                // Swift kodunu çağır
                window.webkit.messageHandlers.buttonClicked.postMessage(null);
            });
        }
    """
    
    /*func openTapped() {
        let ac = UIAlertController(title: "JS", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ButtonClicked", style: .default, handler: clickedButton))
        present(ac, animated: true)
    }*/
    
    func clickedButton(action: UIAlertAction) {
        // Bu metodun içine tıklanan butonun özel işlevselliği eklenir (örneğin, alert gösterme)
        let alertController = UIAlertController(title: "Button Clicked", message: "Button was clicked!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // JavaScript tarafından postMessage ile gönderilen mesajı işle
        if message.name == "buttonClicked" {
            // JavaScript tarafından gönderilen mesaj, burada işlenir
            clickedButton(action: UIAlertAction())
        }
    }
}
