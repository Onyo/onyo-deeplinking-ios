Pod::Spec.new do |s|

    s.name         = "OnyoDeepLink"
    s.version      = "0.1.0"
    s.summary      = "Framework to access Onyo through Deep Linking"
    s.homepage     = "https://github.com/Onyo/onyo-deeplinking-ios.git"
    s.description  = "Onyo Deep Linking framework to let third party apps access Onyo app"
    s.license      = { :type => "MIT", :file => "LICENSE" }

    s.author       = { "MatheusCavalca" => "matheus@onyo.com" }

    s.platform     = :ios, "8.0"
    s.requires_arc = true

    s.source       = { :git => "https://github.com/Onyo/onyo-deeplinking-ios.git", :tag => s.version.to_s }

    s.dependency 'Branch'

    s.source_files = "OnyoDeepLink/**/*.{swift}"

end