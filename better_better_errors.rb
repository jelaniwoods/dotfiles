#!/usr/bin/env ruby
# wget  -O bin/rb "https://tinyurl.com/" && chmod 777 bin/rb && bin/rb
require "open-uri"

file_path = "config/environments/development.rb"

dev = File.open(file_path, File::RDWR)

contents = dev.read

find_line = /BetterErrors::Middleware.allow_ip! '10.138.0.0\/16'/
new_config = <<~RUBY
config.web_console.whitelisted_ips = '0.0.0.0/0.0.0.0'
  BetterErrors::Middleware.allow_ip! '0.0.0.0/0.0.0.0'
RUBY

new_content = contents.gsub(find_line, new_config)
File.open(file_path, 'w') { |file| file.write(new_content) }
