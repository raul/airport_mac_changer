require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "airport_mac_changer"
    gem.summary = %Q{Quickly change your Airport's MAC address}
    gem.description = %Q{Script to change your Airport's MAC address}
    gem.email = "raul@murciano.net"
    gem.homepage = "http://github.com/raul/airport_mac_changer"
    gem.authors = ["Raul Murciano"]
    gem.files = Dir.glob('lib/**/*.rb')
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "airport_mac_changer #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
