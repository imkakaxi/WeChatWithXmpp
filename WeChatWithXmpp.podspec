

Pod::Spec.new do |s|

  s.name         = "WeChatWithXmpp"
  s.version      = "1.0.0"
  s.summary      = "使用xmpp框架模仿微信聊天"
  s.description  = <<-DESC
wodfajsdf  dfkasdj fa dskfja sd  sdfkjas df  sadfja s  sdfaj l ;lasdfja  as dfaj lk
                   DESC

  s.homepage     = "https://github.com/imkakaxi/WeChatWithXmpp"

  s.license      = "MIT (example)"

  s.author             = { "imkakaxi" => "email@address.com" }

   s.platform     = :ios
  # s.platform     = :ios, "5.0"

  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/imkakaxi/WeChatWithXmpp.git", :tag => "1.0.0" }

  s.source_files  = "WeChatXmpp/WeChatXmpp/ChatModel.{h,m}"


  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.dependency "JSONKit", "~> 1.4"

end
