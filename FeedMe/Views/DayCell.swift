//
//  DayCell.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 13/07/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import UIKit
import CoreImage

class DayCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var dayImage: UIImageView!
    @IBOutlet weak var imageSuperView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Get image rendering context
        let context = CIContext();
        
        // Convert image to CIImage
        let aUIImage = dayImage.image;
        guard let aCGImage = aUIImage?.cgImage else { fatalError("Image cannot be extracted from Image View") }
        var aCIImage = CIImage(cgImage: aCGImage)
        let originalImageExtent = aCIImage.extent // Save orginal image extent for final cropping
        
        // Apply brightness filter
        guard let brightnessFilter = CIFilter(name: "CIColorControls") else { fatalError("Cannot create color filter") }
        brightnessFilter.setValue(aCIImage, forKey: kCIInputImageKey)
        brightnessFilter.setValue(NSNumber(value: -0.25), forKey: kCIInputBrightnessKey);
        guard let colouredImage = brightnessFilter.outputImage else { fatalError("Cannot apply color filter") }
        aCIImage = colouredImage
        
        // Apply blur filter
        guard let gaussianFilter = CIFilter(name: "CIGaussianBlur") else { fatalError("Cannot create blur filter") }
        gaussianFilter.setValue(aCIImage, forKey: kCIInputImageKey)
        gaussianFilter.setValue(3.3, forKey: kCIInputRadiusKey)
        guard let blurredImage = gaussianFilter.outputImage else { fatalError("Cannot convert back image from filter")  }
        aCIImage = blurredImage
        
        // Display image
        guard let imageRef = context.createCGImage(aCIImage, from: originalImageExtent) else { fatalError("Cannot convert image to CG format") }
        dayImage.image = UIImage(cgImage: imageRef)
                        
        // Round image corners
        dayImage.layer.cornerRadius = dayImage.frame.size.height / 15
        
        // Add shadow to image super view
        imageSuperView.layer.cornerRadius =     imageSuperView.frame.size.height / 15
        imageSuperView.layer.shadowColor = UIColor.black.cgColor
        imageSuperView.layer.shadowOffset = CGSize(width: 0, height: 1)
        imageSuperView.layer.shadowOpacity = 0.25
        imageSuperView.layer.shadowRadius = 4.0
        imageSuperView.clipsToBounds = false               
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
