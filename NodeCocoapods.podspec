Pod::Spec.new do |spec|
  # Node was taken, so using NodeCocoapods here ... we'll see how that works
  # in code do `#if COCOAPODS` to use correct import
  spec.name         = 'NodeCocoapods'
  spec.version      = '2.1.1'
  spec.license      = 'MIT'
  spec.homepage     = 'https://github.com/vapor/node'
  spec.authors      = { 'Vapor' => 'contact@vapor.codes' }
  spec.summary      = 'A formatted data encapsulation meant to facilitate the transformation from one object to another.'
  spec.source       = { :git => "#{spec.homepage}.git", :tag => "#{spec.version}" }
  spec.ios.deployment_target = "8.0"
  spec.osx.deployment_target = "10.9"
  spec.watchos.deployment_target = "2.0"
  spec.tvos.deployment_target = "9.0"
  spec.requires_arc = true
  spec.social_media_url = 'https://twitter.com/codevapor'
  spec.default_subspec = "Default"

  spec.subspec "Default" do |ss|
    ss.source_files = 'Sources/**/*.{swift}'
    ss.dependency 'Core', '~> 2.1.2'
    ss.dependency 'Bits', '~> 0.1.2'
    ss.dependency 'Debugging', '~> 1.1.0'
  end
end
