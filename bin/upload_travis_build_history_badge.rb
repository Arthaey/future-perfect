require 'net/scp'

Net::SCP.upload!(
  "arthaey.com",
  ENV["FTP_USERNAME"],
  ENV["BADGE_IMAGE"],
  "images/public/travis-build-badges/#{ENV['BADGE_IMAGE']}",
  :ssh => { :password => ENV["FTP_PASSWORD"] }
)
