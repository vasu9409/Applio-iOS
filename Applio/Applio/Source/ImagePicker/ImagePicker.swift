//
//  ImagePicker.swift
//  Applio
//
//  Created by Vasu Savaliya on 09/05/24.
//

import Foundation
import UIKit
import UniformTypeIdentifiers
import PDFKit
import MBProgressHUD

public protocol ImagePickerDelegate: AnyObject {
    func didSelect(image: UIImage?)
    func didSelectPDF(data: Data?)
    func didRemove()
}

open class ImagePicker: NSObject, UINavigationControllerDelegate, UIDocumentPickerDelegate {

    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    
    var isDocumentImage = false

    public init(delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()
        
        super.init()

        self.presentationController = getRootViewController()
        self.delegate = delegate

        self.pickerController.delegate = self
        self.pickerController.allowsEditing = false
        self.pickerController.mediaTypes = ["public.image"]
    }

    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }

        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            getRootViewController()?.present(self.pickerController, animated: true)
        }
    }
    
    func openCamera() {
        self.pickerController.sourceType = .camera
        self.pickerController.cameraDevice = .front
        getRootViewController()?.present(self.pickerController, animated: true)
    }

    public func present(from sourceView: UIView, isRemoveEnable: Bool = true, isDocumentImage: Bool = false) {
        self.isDocumentImage = isDocumentImage
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if let action = self.action(for: .camera, title: "Open Camera") {
            if let icon = UIImage(named: "camera") {
                action.setValue(icon, forKey: "image")
            }
            action.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            alertController.addAction(action)
        }
        
        if let action = self.action(for: .photoLibrary, title: "Choose From Photo Gallery") {
            if let icon = UIImage(named: "gallery") {
                action.setValue(icon, forKey: "image")
            }
            action.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            alertController.addAction(action)
        }
        
        if self.isDocumentImage {
            
            let files = UIAlertAction(title: "Choose From Library", style: .default) { [unowned self] _ in
                self.openFile()
            }
            files.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            if let icon = UIImage(named: "folder") {
                files.setValue(icon, forKey: "image")
            }
            
            alertController.addAction(files)
        }
        
        if isRemoveEnable {
            let action = UIAlertAction(title: "Remove \(self.isDocumentImage ? "Document" : "Profile")", style: .default) { [unowned self] _ in
                self.delegate?.didRemove()
            }
            action.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            if let icon = UIImage(named: "remove_doc") {
                action.setValue(icon, forKey: "image")
            }
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        alertController.view.tintColor = UIColor.black

        getRootViewController()?.present(alertController, animated: true)
    }
    
    public func presentForSelfie(from sourceView: UIView, isRemoveEnable: Bool = true, isDocumentImage: Bool = false) {
        self.isDocumentImage = isDocumentImage
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if let action = self.action(for: .camera, title: "Open Camera") {
            if let icon = UIImage(named: "camera") {
                action.setValue(icon, forKey: "image")
            }
            action.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        alertController.view.tintColor = UIColor.black

        getRootViewController()?.present(alertController, animated: true)
    }
    
    
    func openFile() {
        let contentTypes: [UTType] = [
            .pdf,
            .png,
            .jpeg
        ]

        let documentPicker = UIDocumentPickerViewController.init(forOpeningContentTypes: contentTypes, asCopy: true)
        documentPicker.modalPresentationStyle = .formSheet
        documentPicker.delegate = self
        getRootViewController()?.present(documentPicker, animated: true)
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(urls)
        let mimType = urls.first?.mimeType()
        
        guard let url = urls.first else { return }
        
        if mimType == .PNG || mimType == .JPG {
            
            do{
                let gZippedData = try Data(contentsOf: url)
                self.delegate?.didSelect(image: UIImage(data: gZippedData))
            } catch {
                print(error.localizedDescription)
            }
        } else {
            do {
                let data = try Data(contentsOf: url)
                self.delegate?.didSelectPDF(data: data)
                return
            } catch {
                print("Error")
            }
            getImageFromPDF(url: url)
        }
        
    }
    
    func getImageFromPDF(url: URL) {
        // Instantiate a `CGPDFDocument` from the PDF file's URL.
        guard let document = CGPDFDocument(url as CFURL) else { return }

        // Get the first page of the PDF document. Note that page indices start from 1 instead of 0.
        guard let page = document.page(at: 1) else { return }

        // Fetch the page rect for the page we want to render.
        let pageRect = page.getBoxRect(.mediaBox)

        // Optionally, specify a cropping rect. Here, we don’t want to crop so we keep `cropRect` equal to `pageRect`.
        let cropRect = pageRect

        let renderer = UIGraphicsImageRenderer(size: cropRect.size)
        let img = renderer.image { ctx in
            // Set the background color.
            UIColor.white.set()
            ctx.fill(CGRect(x: 0, y: 0, width: cropRect.width, height: cropRect.height))

            // Translate the context so that we only draw the `cropRect`.
            ctx.cgContext.translateBy(x: -cropRect.origin.x, y: pageRect.size.height - cropRect.origin.y)

            // Flip the context vertically because the Core Graphics coordinate system starts from the bottom.
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)

            // Draw the PDF page.
            ctx.cgContext.drawPDFPage(page)
        }
        self.delegate?.didSelect(image: img)

    }
    
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        guard let image else { controller.dismiss(animated: true, completion: nil); return }
        MBProgressHUD.showAdded(to: getRootViewController()?.view ?? UIView(), animated: true)
        self.delegate?.didSelect(image: image)
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

        self.pickerController(picker, didSelect: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)

    }
}

extension URL {
    public func mimeType() -> Mime {
        if let mimeType = UTType(filenameExtension: self.pathExtension)?.preferredMIMEType {
            switch mimeType {
            case "application/pdf":
                return .PDF
            case "image/png":
                return .PNG
            case "image/jpg":
                return .JPG
            case "image/jpeg":
                return .JPEG
            default:
                return .NONE
            }
        }
        else {
            return .NONE
        }
    }
}


public enum Mime: String {
    
    case PDF = "pdf"
    case PNG = "png"
    case JPG = "jpg"
    case JPEG = "jpeg"
    case NONE = "octet-stream"
   
}



extension Data {
    
    func getImage() -> UIImage?  {
        if self.isPDF {
            return getImageFromPDF()
        } else {
            return UIImage(data: self)
        }
    }
    
    func getImageFromPDF() -> UIImage? {
        // Get the first page of the PDF document. Note that page indices start from 1 instead of 0.
        guard let page = PDFDocument(data: self)?.page(at: 0) else { return nil }
        return getUIImage(from: page)

    }
    
    
    func getUIImage(from page: PDFPage) -> UIImage {
        let rect = page.bounds(for: PDFDisplayBox.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        let image = renderer.image(actions: { context in
            let cgContext = context.cgContext
            cgContext.setFillColor(gray: 1, alpha: 1)
            cgContext.fill(rect)
            cgContext.translateBy(x: 0, y: rect.size.height)
            cgContext.scaleBy(x: 1, y: -1)
            page.draw(with: PDFDisplayBox.mediaBox, to: cgContext)
        })
        return image
    }
    
}
