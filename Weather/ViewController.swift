//
//  ViewController.swift
//  Weather
//
//  Created by Alisher on 2/10/21.
//  Copyright © 2021 Alisher. All rights reserved.
//

import UIKit
import Alamofire
import DropDown

class ViewController: UIViewController {
    
    let menu = DropDown()

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var feelsLikeTemp: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var url = Constants.host
    var myData: Model?
    
    private var decoder: JSONDecoder = JSONDecoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MyCollectionViewCell.nib, forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        tableView.register(MyTableViewCell.nib, forCellReuseIdentifier: MyTableViewCell.identifier)
        cityName.text = "Astana"
        fetchData()
    }
    
    @IBAction func chooseCity(_ sender: UIButton) {
        menu.dataSource = ["Astana", "Almaty", "Pavlodar"]
        menu.anchorView = sender
        menu.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        menu.show()
        menu.selectionAction = { index, title in
            if (title == "Astana") {
                self.url = Constants.host
                self.cityName.text = "Astana"
                self.fetchData()
            } else if (title == "Almaty") {
                self.url = Constants.host1
                self.cityName.text = "Almaty"
                self.fetchData()
            } else if (title == "Pavlodar") {
                self.url = Constants.host2
                self.cityName.text = "Pavlodar"
                self.fetchData()
            }
            sender.setTitle(title, for: .normal)
        }
    }
    
    func updateUI() {
        temp.text = "\(myData?.current?.temp ?? 0.0)"
        feelsLikeTemp.text = "Feels like: \(myData?.current?.feels_like ?? 0.0)"
        desc.text = myData?.current?.weather?.first?.description
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    
    func fetchData(){
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(_):
                guard let data = response.data else { return }
                guard let answer = try? self.decoder.decode(Model.self, from: data) else { return }
                self.myData = answer
                self.updateUI()
            case .failure(let err):
                print(err.errorDescription ?? "")
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData?.daily?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //return UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier, for: indexPath) as! MyTableViewCell
        let item = myData?.daily?[indexPath.row]
        cell.day.text = getDayForDate(Date(timeIntervalSince1970: Double(item?.dt ?? 0)))
        cell.temp.text = "\(item?.temp?.day ?? 0.0)"
        cell.feels.text = "\(item?.feels_like?.day ?? 0.0)"
        cell.desc.text = item?.weather?.first?.description
        return cell
    }
    
    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: inputDate)
    }
}


extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myData?.hourly?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        let item = myData?.hourly?[indexPath.item]
        cell.temp.text = "\(item?.temp ?? 0.0)"
        cell.feelsLike.text = "\(item?.feels_like ?? 0.0)"
        cell.desc.text = item?.weather?.first?.description
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
