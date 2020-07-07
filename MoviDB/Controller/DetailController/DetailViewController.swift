//
//  DetailViewController.swift
//  MoviDB
//
//  Created by Apple on 7/3/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController  {
    
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelHomepage: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    var result: Result?

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        configUI()
        // Do any additional setup after loading the view.
    }
    
    func config() {
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
    }
    
    func configUI() {
        headerTitle.text = result?.title
        labelReleaseDate.text = result?.release_date
        for element in result?.genre_ids ?? [0] {
            labelDuration.text! += String(element)
        }
        labelDuration.text = String(format: "%.0f",result?.popularity ?? 0) + " minutes"
        labelHomepage.text = result?.backdrop_path
        labelOverview.text = result?.overview
        if let posterPath = result?.poster_path {
            let urlStr = MoviViewController.hostUrl + posterPath
            if let url = URL(string: urlStr) {
                do {
                    let data = try Data(contentsOf: url)
                    img.image = UIImage(data: data)
                } catch {
                    print("err load image")
                }
            }
        }
    }
    
}

extension DetailViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell") as? DetailTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    
}
