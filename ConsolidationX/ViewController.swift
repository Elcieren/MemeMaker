//
//  ViewController.swift
//  ConsolidationX
//
//  Created by Eren Elçi on 30.11.2024.
//

import UIKit

class ViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    @IBOutlet var imageView: UIImageView!
    var memeText: String = ""
    var selectedImagee: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(memesText))
        navigationItem.leftBarButtonItems = [
                UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(selectedImage)),
                UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
            ]
        
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("Resim Bulunamadı")
            return
        }
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @objc func selectedImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
                print("Görsel seçilemedi.")
                return
            }
            selectedImagee = image
            dismiss(animated: true)
        
    }
    
    @objc func memesText() {
        let ac = UIAlertController(title: nil, message: "Meme Icin bir text giriniz", preferredStyle: .alert)
        ac.addTextField { textField in
            textField.placeholder = "Text"
        }
        let ok = UIAlertAction(title: "Ok", style: .default) { _ in
            guard let text = ac.textFields?.first?.text else { return }
            self.memeText = text
            print(self.memeText)
        }
        ac.addAction(ok)
        present(ac, animated: true)
        
    }

    @IBAction func memeMakerClick(_ sender: Any) {
        // Ekran boyutunu al
           let screenSize = UIScreen.main.bounds.size
           let rendererSize = CGSize(width: screenSize.width, height: screenSize.width) // Kare görüntü için

           let renderer = UIGraphicsImageRenderer(size: rendererSize)

           let img = renderer.image { ctx in
               // Görseli çizdir
               if let mouse = selectedImagee {
                   let imageRect = CGRect(x: 0, y: 0, width: rendererSize.width, height: rendererSize.width) // Görsel tam ekran boyutunda
                   mouse.draw(in: imageRect)
               }

               // Metin hizalaması için stil
               let paragraphStyle = NSMutableParagraphStyle()
               paragraphStyle.alignment = .center

               // Metin özellikleri
               let attrs: [NSAttributedString.Key: Any] = [
                   .font: UIFont.boldSystemFont(ofSize: 36), // Yazı boyutu
                   .foregroundColor: UIColor.white,         // Yazı rengi
                   .paragraphStyle: paragraphStyle
               ]

               // Kullanıcının girdiği metin
               let string = memeText
               let attributedString = NSAttributedString(string: string, attributes: attrs)

               // Metni çizdir (görselin altına)
               let textRect = CGRect(x: 20, y: rendererSize.height - 80, width: rendererSize.width - 40, height: 60)
               attributedString.draw(with: textRect, options: .usesLineFragmentOrigin, context: nil)
           }

           // Görüntüyü imageView'da göster
           imageView.image = img
    }
    
}

