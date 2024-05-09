Pod::Spec.new do |spec|

  spec.name         = "Applio"
  spec.version      = "1.0.7"
  spec.summary      = "We are creating some function which have use daily."
  spec.description  = "AppCommonLib is a versatile and efficient library that provides a collection of essential, reusable functions for various app development projects. Simplify your coding process and enhance productivity by incorporating these common functions into your applications. This open-source library is designed to streamline development tasks, reduce redundancy, and foster collaboration among developers. Empower your app development with AppCommonLib! 🚀

Remember to tailor the description according to the actual name of your repository and the specific functionalities it offers. Also, feel free to add any additional details or features that set your library apart."
  spec.homepage     = "hhttps://github.com/vasu9409/Applio"
  spec.license      = "MIT"
  spec.author       = { "Vasu Savaliya" => "vasusavaliya0000@gmail.com" }
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/vasu9409/Applio.git", :tag => "1.0.7" }
  spec.source_files  = "Applio/**/*.{h,m,swift}"
  spec.swift_version = '5.0'
  spec.dependency 'Alamofire'


end
