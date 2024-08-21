//
//  ViewController.swift
//  PracticeProject
//
//  Created by Aditya on 21/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeAPICall()
    }
    
    private func makeAPICall() {
        foo { [weak self] completion in
            switch completion {
            case .success(let data):
                debugPrint(data)
            case .failure(let error as ExpectedErrors):
                self?.handleError(for: error)
            case .failure(_):
                debugPrint("Unexpected Error")
            }
        }
    }
    func handleError(for error: ExpectedErrors) {
        switch error {
        case .dataConverionError:
            debugPrint("dataConverionError")
        case .urlInvalid:
            debugPrint("urlInvalid")
        case .errorWhileCalling:
            debugPrint("errorWhileCalling")
        case .responseError:
            debugPrint("responseError")
        case .responseErrorWithCode(_):
            debugPrint("responseErrorWithCode")
        case .dataParsingError:
            debugPrint("dataParsingError")
        }
    }
}
