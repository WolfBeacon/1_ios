//
//  LoginViewController.swift
//  WolfBeacon
//
//  Created by Avikant Saini on 12/21/17.
//  Copyright © 2017 WolfBeacon. All rights reserved.
//

import UIKit
import Auth0

class LoginViewController: UIViewController {
	
	let credentialsManager = CredentialsManager(authentication: Auth0.authentication())

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		guard credentialsManager.hasValid() else {
			// No valid credentials exist, present the hosted login page
			
			Auth0
				.webAuth()
				.scope("openid profile")
				.audience("https://wolf-beacon.auth0.com/userinfo")
				.start {
					switch $0 {
					case .failure(let error):
						// Login error handling...
						print("Error: \(error)")
					case .success(let credentials):
						print("Login successful")
						if self.credentialsManager.store(credentials: credentials) {
							print("Credentials saved successfully")
						} else {
							print("Credentials not saved")
						}
					}
			}
			return
		}
		
		credentialsManager.credentials { error, credentials in
			guard error == nil, let credentials = credentials else {
				// Handle error
				print("Error: \(String(describing: error))")
				return
			}
			print("Credentials: \(credentials)")
		}
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
