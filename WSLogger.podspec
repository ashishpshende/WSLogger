
Pod::Spec.new do |s|
 # ―――  Basic Information  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.name         = "WSLogger"
  s.version      = "1.0.0"
  s.summary      = "WSLogger is custome logging library which allows you to log you activities. WSLogger helps you log your activities
                            on your server with some basic parameters and your customized parameters"

  s.description  = <<-DESC
                    This library dependent on FMDB and AFNetworking.
                   A longer description of WSLogger in Markdown format.
                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/itsmeash/WSLogger"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = { :type => "WhiteSnow Softwares", :file => "LICENSE.txt" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.author             = { "itsmeash" => "ashishpshende@gmail.com" }
  s.social_media_url   = "http://twitter.com/itsmeash"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.platform     = :ios


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source       = {
                        :git => "https://github.com/itsmeash/WSLogger.git", :tag => "1.0.0",
                        :tag=>"1.0.0"
                        }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source_files  = '*.{h,m}',

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.resource  = "LoggerDB.sqlite"

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking'
  s.dependency 'FMDB/common'
  s.dependency "JSONKit"

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
   s.requires_arc = true


end
