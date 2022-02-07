import UIKit
import WebKit


class AuthViewController : UIViewController, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else {
            return
        }
        //Exchange the code for access token
        
        let component = URLComponents.init(string: url.absoluteString)
        guard let code  = component?.queryItems?.first(where: {  $0.name == "code" })?.value else {
            return
        }
        print("Code : \(code)")
        webView.isHidden = true
        AuthManager.shared.exchangeCodeForToken(code: code, completion: { [weak self] done in
       
            print("Done!")
            DispatchQueue.main.async {
                self?.protocolVar?.passBack()
               
           
            }

               
          
        })
    }
    var protocolVar : signInCompleted?
    var webView : WKWebView = {
        let config  = WKWebViewConfiguration()
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground

        setupWebView()
        
    }
    func setupWebView() {
        self.view.addSubview(webView)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        webView.load(URLRequest(url: AuthManager.shared.signInURL!))
    }
   
}
