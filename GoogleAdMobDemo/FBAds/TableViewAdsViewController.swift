//
//  TableViewAdsViewController.swift
//  AdsTutorial
//
//  Created by Gabriel Theodoropoulos on 29/07/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import UIKit

class TableViewAdsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblAdsDemo: UITableView!
    
    var sampleData = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        createFakeData()
        configureTableView()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    // MARK: Custom Methods
    
    func configureTableView() {
        tblAdsDemo.delegate = self
        tblAdsDemo.dataSource = self
        tblAdsDemo.register(UINib(nibName: "SampleCell", bundle: nil), forCellReuseIdentifier: "idCellSample")
        tblAdsDemo.reloadData()
    }
    
    
    func createFakeData() {
        for i in 0..<20 {
            sampleData.append("Sample Content #\(i+1)")
        }
    }

    
    
    // MARK: UITableView Delegate and Datasource methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }
    
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCellSample", for: indexPath as IndexPath) as! SampleCell
        cell.lblTitle.text = sampleData[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
