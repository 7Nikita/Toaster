//
//  ToastsViewController.swift
//  Toaster
//
//  Created by Nikita Pekurin on 9/3/20.
//  Copyright © 2020 Nikita Pekurin. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ToastsViewController: UIViewController {

    private let database = Database.database().reference()
    private let toastCellReuseId = "toastCell"
    private let toastTableViewCellNibId = "ToastTableViewCell"
    
    private var toasts = [Toast]()
    
    @IBOutlet weak var toastsTableView: UITableView! {
        didSet {
            toastsTableView.delegate = self
            toastsTableView.dataSource = self
        }
    }
    
    @IBOutlet weak var handleView: UIView! {
        didSet {
            handleView.roundCorners(top: true, cornerRadius: 30.0)
        }
    }
    
    override func viewDidLoad() {
        self.view.roundCorners(top: true, cornerRadius: 30.0)
        toastsTableView.register(UINib(nibName: toastTableViewCellNibId, bundle: nil), forCellReuseIdentifier: toastCellReuseId)
        database.child("alco").observeSingleEvent(of: .value, with: { [weak self] snapshot in
            let value = snapshot.value as? NSArray
            if let value = value {
                for content in value {
                    let toast = Toast(content: content as? String ?? "")
                    self?.toasts.append(toast)
                }
            }
            DispatchQueue.main.async {
                self?.toastsTableView.reloadData()
            }
        })
    }
    
}

extension ToastsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let toast = toasts[indexPath.row]
        let cell = toastsTableView.dequeueReusableCell(withIdentifier: toastCellReuseId, for: indexPath) as! ToastTableViewCell
        cell.toastContentLabel.text = toast.content
        return cell
    }
}
