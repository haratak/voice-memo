//
//  IntentViewController.swift
//  VoiceMemoIntentsUI
//
//  Created by Takuya Hara on 2021/03/31.
//

import IntentsUI

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling {
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    // MARK: - INUIHostedViewControlling
    
    // Prepare your view controller for the interaction to handle.
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        // Do configuration here, including preparing views and calculating a desired size for presentation.
        guard let intent = interaction.intent as? CreateMemoIntent else {
            completion(false,Set(),.zero)
            return
        }
        
        
        if let number = intent.number{
            self.contentLabel.text = "耳標番号は \(number) ですか？"
        }else{
            self.contentLabel.text = "耳標番号を指定してください。"
        }
        completion(true, parameters, self.desiredSize)
    }
    
    var desiredSize: CGSize {
        return CGSize.init(width: 10, height: 100)
    }
    
}
