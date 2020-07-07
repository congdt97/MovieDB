//
//  MoviViewController.swift
//  MoviDB
//
//  Created by Apple on 7/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire


class MoviViewController: UIViewController {
    @IBOutlet weak var colectionView: UICollectionView!
    let url = "https://api.themoviedb.org/3/movie/popular?api_key=248dcdb137d6addad8444cd2a037445a&language=en&page=1"
    static let hostUrl = "https://image.tmdb.org/t/p/w500"
    var resu: [Result]?

    override func viewDidLoad() {
        super.viewDidLoad()
        requestAPI()
        config()
        
        // Do any additional setup after loading the view.
    }
    
    func requestAPI() {
        AF.request(url, method: .get).responseJSON { [weak self] (response) in
            if let value = response.value {
                if let json = value as? [String: Any] {
                    let movies = MovieModel(JSON: json)
                    if let result = movies?.results {
//                        print(result.count)
//                        print(result[0].poster_path)
                        self?.resu = result
                        self?.colectionView.reloadData()
                    }
                }
            }
        }
    }
    
    func config() {
        colectionView.delegate = self
        colectionView.dataSource = self
        colectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
    }
}

extension MoviViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resu?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let re = resu?[indexPath.row],let cell = colectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let posterPath = re.poster_path {
            let urlStr = MoviViewController.hostUrl + posterPath
            if let url = URL(string: urlStr) {
                do {
                    let data = try Data(contentsOf: url)
                    cell.imgMovie.image = UIImage(data: data)
                } catch {
                    print("err load image")
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 2 - 6
        let height: CGFloat = 250
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailViewController") as? DetailViewController
        guard let re = self.resu?[indexPath.row] else {
            return
        }
        vc?.result = re
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
