## MemeMaker
| Meme Yapma && Kaydetme |
|---------|
| ![Video 1](https://github.com/user-attachments/assets/babb90a7-4f56-4cea-be83-38a99b882555) | 


 <details>
    <summary><h2>Uygulamanın Amacı ve Senaryo Mantığı</h2></summary>
    Proje Amacı
   Bu uygulama, kullanıcıların seçtikleri bir görsele yazı ekleyerek kendi meme içeriklerini oluşturmasını sağlar. Kullanıcı, fotoğraf albümünden bir görsel seçebilir, metin girebilir ve bu oluşturduğu içeriği kaydedip paylaşabilir. Ayrıca, oluşturulan görsel direkt olarak ekran üzerinde görüntülenir
  </details>  


  <details>
    <summary><h2>viewDidLoad</h2></summary>
    viewDidLoad fonksiyonu, uygulama açıldığında çağrılır.
    Sağ üst köşeye bir "Add" butonu ekler. Bu buton, kullanıcının meme için metin girmesini sağlar.
    Sol üst köşeye sırasıyla "Camera" ve "Action" butonları ekler. "Camera", bir görsel seçmek için kullanılabilir; "Action" ise paylaşım işlevini yerine getirir
    
    ```
     override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(memesText))
    navigationItem.leftBarButtonItems = [
        UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(selectedImage)),
        UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    ]
    }



    ```
  </details> 


  <details>
    <summary><h2>shareTapped</h2></summary>
   Kullanıcının oluşturduğu görseli paylaşmasını sağlar.
   Eğer görsel bulunamazsa işlem iptal edilir ve bir hata mesajı konsola yazılır
    
    ```
    @objc func shareTapped() {
    guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
        print("Resim Bulunamadı")
        return
    }
    let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    present(vc, animated: true)
     }


    ```
  </details> 


  <details>
    <summary><h2>selectedImage</h2></summary>
   Kullanıcının cihazındaki fotoğraf albümünden görsel seçmesini sağlar.
   UIImagePickerController kullanarak, albümden görsel seçmek için bir arayüz sunar
    
    ```
    @objc func selectedImage() {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = .photoLibrary
    present(imagePicker, animated: true)
    }





    ```
  </details> 

  

  
  <details>
    <summary><h2>imagePickerController</h2></summary>
     Kullanıcının seçtiği görseli alır ve selectedImagee değişkenine kaydeder.
     Görsel seçme ekranını kapatır
    
    ```
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.originalImage] as? UIImage else {
        print("Görsel seçilemedi.")
        return
    }
    selectedImagee = image
    dismiss(animated: true)
    }


    ```
  </details> 


  <details>
    <summary><h2>memesText</h2></summary>
     Kullanıcıdan bir metin girmesini ister.
     Girdiği metni memeText değişkenine kaydeder
    
    ```
    @objc func memesText() {
    let ac = UIAlertController(title: nil, message: "Meme Için bir text giriniz", preferredStyle: .alert)
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



    ```
  </details>

  <details>
    <summary><h2>memeMakerClick</h2></summary>
     Seçilen görselin üzerine yazıyı ekler ve sonucu imageView içinde görüntüler.
     Görsel tam ekran boyutunda çizilir.
     Metin, görselin alt kısmına beyaz ve büyük bir fontla eklenir.
    
    ```
    @IBAction func memeMakerClick(_ sender: Any) {
    let screenSize = UIScreen.main.bounds.size
    let rendererSize = CGSize(width: screenSize.width, height: screenSize.width)

    let renderer = UIGraphicsImageRenderer(size: rendererSize)

    let img = renderer.image { ctx in
        if let mouse = selectedImagee {
            let imageRect = CGRect(x: 0, y: 0, width: rendererSize.width, height: rendererSize.width)
            mouse.draw(in: imageRect)
        }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 36),
            .foregroundColor: UIColor.white,
            .paragraphStyle: paragraphStyle
        ]

        let string = memeText
        let attributedString = NSAttributedString(string: string, attributes: attrs)

        let textRect = CGRect(x: 20, y: rendererSize.height - 80, width: rendererSize.width - 40, height: 60)
        attributedString.draw(with: textRect, options: .usesLineFragmentOrigin, context: nil)
    }

    imageView.image = img
    }




    ```
  </details>



  


<details>
    <summary><h2>Uygulama Görselleri </h2></summary>
    
    
 <table style="width: 100%;">
    <tr>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">Meme - 1</h4>
            <img src="https://github.com/user-attachments/assets/c4c3fa8d-7d6c-4614-a87b-fe65f4f41285" style="width: 100%; height: auto;">
        </td>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">Meme - 2</h4>
            <img src="https://github.com/user-attachments/assets/5486b593-08ab-41c8-ae07-1f27414ce6f8" style="width: 100%; height: auto;">
        </td>
    </tr>
</table>
  </details> 
