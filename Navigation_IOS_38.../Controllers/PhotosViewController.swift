//
//  PhotosViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 05.10.2023.
//

import UIKit
import StorageService
import iOSIntPackage

class PhotosViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let photo = imageCollection[indexPath.row]
        
        cell.photo = photo
        
        return cell
    }
    
    var imagePublisherFacade: ImagePublisherFacade?
    
    private var imageCollection: [UIImage] = []
    private let spasing = 8.0
    private let count = 3.0
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spasing
        layout.minimumInteritemSpacing = spasing
        layout.sectionInset = UIEdgeInsets(top: spasing, left: spasing, bottom: spasing, right: spasing)
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return collectionView
    }()
    
    //repeatCount(_:autoreverses:)
   // func addImagesWithTimer(iv: UIImageView) {
      //  let addImagesWithTimer:CABasicAnimation = CABasicAnimation(keyPath: "position")
      //  addImagesWithTimer.repeatCount = 10
       /// addImagesWithTimer.autoreverses = true
      // addImagesWithTimer.speed = 0.5
        
      //  var from_point:CGPoint = CGPointMake(iv.center.x - 5, iv.center.y)
       // var from_value:NSValue = NSValue(cgPoint: from_point)
        
      //  var to_point:CGPoint = CGPointMake(iv.center.x + 5, iv.center.y)
      //  var to_value:NSValue = NSValue(cgPoint: to_point)
        
      //  addImagesWithTimer.fromValue = from_value
      //  addImagesWithTimer.toValue = to_value
      //  iv.layer.add(addImagesWithTimer, forKey: "position")
   // }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        setupView()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Photo Gallery"
        
       // imagePublisherFacade?.subscribe(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        collectionView.frame = CGRect(
            x: view.safeAreaInsets.left,
            y: view.safeAreaInsets.top,
            width: view.frame.width,
            height: view.frame.height - view.safeAreaInsets.top
        )
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    //    imagePublisherFacade?.removeSubscription(for: self)
     //   imagePublisherFacade?.rechargeImageLibrary()
    }
    
}


//extension PhotosViewController: ImageLibrarySubscriber {
//    func receive(images: [UIImage]) {
 //       self.imageCollection = images
 //   }
//}

//protocol ObserverProtocol: AnyObject {
//    var observations: [NSKeyValueObservation] {get set}
 //   func removeAllObservation()
//}

//тот кто наблюдает за событием
//final class Observer: ObserverProtocol {
 //   func removeAllObservation() {
    //    observations.removeAll()
  //  }
    
  //  var observations: [NSKeyValueObservation] = []
    
 //   static let shared = Observer()
 //   private init() {}
    
//}



