//
//  TextViewController.swift
//  BrokenImagePickers
//
//  Created by Foggin, Oliver (Developer) on 26/09/2021.
//

import UIKit
import SwiftUI

struct MyTextView: UIViewControllerRepresentable {
  func makeUIViewController(context: Context) -> UINavigationController {
    UINavigationController(rootViewController: TextViewController())
  }
  
  func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
  }
}

class TextViewController: UITableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.searchController = UISearchController()
    navigationItem.hidesSearchBarWhenScrolling = false
    
    title = "My Text View"
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    cell.textLabel?.text = "\(indexPath.row)"
    
    return cell
  }
}
