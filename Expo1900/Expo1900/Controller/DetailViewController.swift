//
//  DetailViewController.swift
//  Expo1900
//
//  Created by Hisop on 2023/11/02.
//

import UIKit

final class DetailViewController: UIViewController {
    var name: String = ""
    var imageName: String = ""
    var detailDescription: String = ""
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var explanation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.title = "한국의 출품작"
        configureUI()
    }

    private func configureUI() {
        navigationItem.title = name
        imageView.image = UIImage(named: imageName)
        
        explanation.text = detailDescription
    }
}
