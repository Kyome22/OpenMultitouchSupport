Pod::Spec.new do |spec|
    spec.name = "OpenMultitouchSupport"
    spec.version = "1.1"
    spec.summary = "This enables you easily to observe global multitouch events on the trackpad. [macOS] [MultitouchSupport.framework]"
    spec.description = <<-DESC
        This enables you easily to observe global multitouch events on the trackpad (Built-In only).
        I created this framework to make MultitouchSupport.framework (Private Framework) easy to use.
        This framework refers to M5MultitouchSupport.framework very much. This project includes a demo.
    DESC
    spec.homepage = "https://github.com/Kyome22/OpenMultitouchSupport"
    spec.license = { :type => "MIT", :file => "LICENSE" }
    spec.author = { "Takuto Nakamura" => "kyomesuke@icloud.com" }
    spec.social_media_url = "https://twitter.com/Kyomesuke"
    spec.platform = :osx
    spec.osx.deployment_target = "10.12"
    spec.requires_arc = true
    spec.source = { :git => "https://github.com/Kyome22/OpenMultitouchSupport.git", :tag => "#{spec.version}" }
    spec.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '/System/Library/PrivateFrameworks/' }
    spec.frameworks = 'Cocoa', 'MultitouchSupport'
    spec.source_files = "OpenMultitouchSupport/*.{h,m}"
    spec.private_header_files = 'OpenMultitouchSupport/*Internal.h'
end
