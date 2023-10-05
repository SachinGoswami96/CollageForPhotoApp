//
//  ViewController.swift
//  CollagePhotoDemo
//
//  Created by Sachingiri Goswami on 03/10/23.
//

import UIKit

struct Ration{
    var name : String
    var ration: CGFloat
}

class ViewController: UIViewController {
    
    let reuseIdentifier = "Cell" // also enter this string as the cell identifier in the storyboard
    var items :  [Ration] = [Ration(name: "1:1", ration: 1/1), Ration(name: "5:4", ration: 5/4), Ration(name: "4:3", ration: 4/3),Ration(name: "3:2", ration: 3/2),Ration(name: "16:10", ration: 16/10)]
    
    
    @IBOutlet weak var conerSlider: UISlider!
    @IBOutlet weak var PaddingSlider: UISlider!
    @IBOutlet weak var clnView: UICollectionView!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    let imageView2  = UIImageView()
    let imageView1  = UIImageView()
    let containerView = UIView()
    var selectedRow : Int = 0
    
    
    @IBOutlet weak var conRation: NSLayoutConstraint!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after loading the view.
        PaddingSlider.addTarget(self, action: #selector(paddingValueChanged(_:)), for: .valueChanged)
        conerSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        // Create a container UIView with a custom shape using UIBezierPath
       

        containerView.backgroundColor = UIColor.yellow
            view.addSubview(containerView)

            containerView.translatesAutoresizingMaskIntoConstraints = false
            let horizontalConstraint = NSLayoutConstraint(item: containerView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: containerView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 0.77, constant: 0)
            let widthConstraint = NSLayoutConstraint(item: containerView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 350)
//        let heightConstraint = NSLayoutConstraint(item: containerView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: containerView, attribute: NSLayoutConstraint.Attribute.width, multiplier: ratio, constant: 0)
        

            view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint])
              
        setRation(ratio: 1/1)

    }

@objc func sliderValueChanged(_ sender: UISlider) {
    
    drawCanvas( cornerRadius: CGFloat(sender.value), padding:  CGFloat(PaddingSlider.value))
    drawSecoundImage( cornerRadius: CGFloat(sender.value), padding:  CGFloat(PaddingSlider.value))

}
    
    @objc func paddingValueChanged(_ sender: UISlider) {
  
        drawCanvas( cornerRadius: CGFloat(conerSlider.value), padding:  CGFloat(sender.value))
        drawSecoundImage( cornerRadius: CGFloat(conerSlider.value), padding:  CGFloat(sender.value))
    }
    
    func setRation(ratio: CGFloat){
       
        let heightConstraint = NSLayoutConstraint(item: containerView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: containerView, attribute: NSLayoutConstraint.Attribute.width, multiplier: ratio, constant: 0)
        

            view.addConstraints([heightConstraint])

       
        DispatchQueue.main.asyncAfter(deadline: .now() , execute: {
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: self.containerView.frame.size.width, y: 0))
     
            path.addLine(to: CGPoint(x: self.containerView.frame.size.width, y: self.containerView.frame.size.height))
            path.addLine(to: CGPoint(x: 0, y: self.containerView.frame.size.height))
            path.close()

            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            self.containerView.layer.mask = shapeLayer
            

            // Add three UIImageViews to the container UIView
            self.imageView1.image =  UIImage(named: "Emoji2")
            self.imageView1.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height / 1.6)
          
            self.containerView.addSubview(self.imageView1)
     

            self.imageView2.image = UIImage(named: "Emoji2")
            self.imageView2.frame = CGRect(x: 0, y: self.imageView1.frame.size.height / 1.6, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height / 1.6)
            self.containerView.addSubview(self.imageView2)
     
            self.drawCanvas( cornerRadius: CGFloat(self.conerSlider.value), padding:  CGFloat(self.PaddingSlider.value))
            self.drawSecoundImage( cornerRadius: CGFloat(self.conerSlider.value), padding:  CGFloat(self.PaddingSlider.value))
     
        })
    }
    
     func drawCanvas( cornerRadius: CGFloat, padding:  CGFloat) {
  
        // for firat image
        
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: padding, y: cornerRadius + padding))
        let control4 = CGPoint(x: padding, y: padding )
        
        path1.addQuadCurve(to: CGPoint(x: cornerRadius + padding, y: padding), controlPoint: control4)
        
        path1.addLine(to: CGPoint(x: imageView1.frame.size.width - cornerRadius - padding , y: padding ))
        let control1 = CGPoint(x: self.imageView1.frame.size.width - padding, y: padding)
        path1.addQuadCurve(to: CGPoint(x: self.imageView1.frame.size.width - padding, y: cornerRadius + padding), controlPoint: control1)
        
         path1.addLine(to: CGPoint(x: (imageView1.frame.size.width - padding), y: (imageView1.frame.size.height / 1.6 - cornerRadius - padding)))
        
         let control2 = CGPoint(x: self.imageView1.frame.size.width - padding, y: imageView1.frame.size.height / 1.6 - padding )
        
         path1.addQuadCurve(to: CGPoint(x: self.imageView1.frame.size.width - cornerRadius - padding, y: (imageView1.frame.size.height / 1.6 - padding)), controlPoint: control2)
        
        path1.addLine(to: CGPoint(x: cornerRadius + padding, y: imageView1.frame.size.height - padding))
        
        let control3 = CGPoint(x: padding, y: imageView1.frame.size.height - padding)
        
        path1.addQuadCurve(to: CGPoint(x: padding, y: (imageView1.frame.size.height - cornerRadius - padding)), controlPoint: control3)
        
        path1.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path1.cgPath
       
        
        imageView1.layer.mask = shapeLayer
      
    }
    
    func drawSecoundImage( cornerRadius: CGFloat, padding:  CGFloat) {
 
       // for firat image
       
       let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: padding, y: cornerRadius + padding + imageView2.frame.size.height / 2.7))
        let control4 = CGPoint(x: padding, y: padding + imageView2.frame.size.height / 2.7 )
       
        path1.addQuadCurve(to: CGPoint(x: cornerRadius + padding, y: padding + imageView2.frame.size.height / 2.7), controlPoint: control4)
       
       path1.addLine(to: CGPoint(x: imageView2.frame.size.width - cornerRadius - padding , y: padding ))
       let control1 = CGPoint(x: self.imageView2.frame.size.width - padding, y: padding)
       path1.addQuadCurve(to: CGPoint(x: self.imageView2.frame.size.width - padding, y: cornerRadius + padding), controlPoint: control1)
       
       path1.addLine(to: CGPoint(x: (imageView2.frame.size.width - padding), y: (imageView2.frame.size.height  - cornerRadius - padding)))
       
       let control2 = CGPoint(x: self.imageView2.frame.size.width - padding, y: imageView2.frame.size.height  - padding )
       
       path1.addQuadCurve(to: CGPoint(x: self.imageView2.frame.size.width - cornerRadius - padding, y: (imageView2.frame.size.height - padding)), controlPoint: control2)
       
       path1.addLine(to: CGPoint(x: cornerRadius + padding, y: imageView2.frame.size.height - padding))
       
       let control3 = CGPoint(x: padding, y: imageView2.frame.size.height - padding)
       
       path1.addQuadCurve(to: CGPoint(x: padding, y: (imageView2.frame.size.height - cornerRadius - padding)), controlPoint: control3)
       
       path1.close()
       
       let shapeLayer = CAShapeLayer()
       shapeLayer.path = path1.cgPath
      
       
       imageView2.layer.mask = shapeLayer
        
     
   }
    
    
     
}

extension ViewController:  UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
       
        cell.myLabel.textColor = selectedRow ==  indexPath.row ? .blue : .gray
        cell.myLabel.text = "\(self.items[indexPath.row].name)" // The row value is the same as the index of the desired text within the array.
//        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
//        containerView.removeFromSuperview()
//        setRation(ratio: self.items[indexPath.row].ration)
        selectedRow = indexPath.row
        collectionView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 , execute: {
            self.setRation(ratio: self.items[indexPath.row].ration)
            
        })
    }
}

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myLabel: UILabel!
}
