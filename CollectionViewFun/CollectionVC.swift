//
//  CollectionVC.swift
//  CollectionViewFun
//
//  Created by Rahul Dhiman on 25/06/21.
//

import UIKit

class CollectionVC: UIViewController {
	@IBOutlet var collection: UICollectionView!
	@IBOutlet var labelStepperCount: UILabel!
	@IBOutlet var stepper: UIStepper!

	let spacing:CGFloat = 10
	var numberOfCellsInRow:CGFloat = 2
	
	lazy var flowLayout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		// <-- & --> spacing []<-->[]
		layout.minimumInteritemSpacing = spacing
		
		//  []
		//  |
		//  []    ->
		layout.minimumLineSpacing = spacing
		
		layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
		return layout
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		stepper.value = Double(numberOfCellsInRow)
		collection.collectionViewLayout = flowLayout
		labelStepperCount.text = "\(numberOfCellsInRow)"
    }
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		collection.reloadData()
	}
	@IBAction func stepperValueChanged(_ sender: UIStepper) {
		numberOfCellsInRow = CGFloat(sender.value)
		labelStepperCount.text = "\(sender.value)"
		collection.reloadData()
	}
}
extension CollectionVC: UICollectionViewDelegate {
	
}
extension CollectionVC: UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 2
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if section == 0 {
			return 1
		} else {
			return 60
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
		if indexPath.section == 0 {
			cell.backgroundColor = .yellow
		} else {
			cell.backgroundColor = .cyan
		}
		return cell
	}
}

extension CollectionVC: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let height: CGFloat = 50
		
		if indexPath.section == 0 { // full width for first section
			return CGSize(width: collectionView.frame.width , height: height)
		} else {
			let width = (collectionView.frame.width) - (spacing * (numberOfCellsInRow-1)) - 1
			return CGSize(width: width/numberOfCellsInRow , height: height)
		}

	}
}
