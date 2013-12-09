Pod::Spec.new do |s|
  s.name         = "SGCocoaHelpers"
  s.platform     = :ios
  s.version      = "1.0.1"
  s.summary      = "Cocoa Helpers are a collection of useful categories for the standard Apple Cocoa/UIKit classes"
  s.homepage     = "https://github.com/shanegao/SGCocoaHelpers"
  s.license      = "MIT"
  s.authors      = { "Shane Gao" => "weigaox@gmail.com"}
  s.source       = { :git => "https://github.com/shanegao/SGCocoaHelpers.git", :tag => '1.0.0' }
  s.framework    = 'QuartzCore', 'UIKit', 'MapKit', 'CoreLocation'
  s.source_files = 'Helpers/*.{h,m,c}'
  s.requires_arc = true
end
