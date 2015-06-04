#!/usr/bin/env ruby
puts 'preparing application to be deployed to production'
puts 'you need to run this from the application root directory'

class Task
	
	All = []
	
	attr_reader :label
	
	def self.execute!()
		self::All.each {|task| puts task.label ; task.invoke! }
	end
	
	def initialize(l, &action)
		@label = l
		@action = action
		Task::All << self
	end
	
	def invoke!()
		@action.call
	end
end

Task.new('delete old prod tar.gz') {`rm ./sabras-site.tar.gz`}

Task.new('bundle update') { `./bin/bundle update` }
Task.new('bundle install') { `./bin/bundle install` }

Task.new('precompile assets') do 
	`rm -rf ./public/assets`
	`./bin/rake assets:precompile`
	Dir['./public/assets/**/*.gz'].each do |fname|
		puts "\tcleanup: rm #{fname}"
		`rm #{fname}`
	end
end

#Task.new('bundle package -> vendor/cache') { 
#	#`rm ./vendor/cache/*` ; 
#	`./bin/bundle --path=vendor/bundle package` 
#}

#Task.new('create setenv file') do
#	File.open('./config/setenv.rb', 'w+') {|f| f.puts '$RailsEnv =  \'production\''}
#end
	
Task.new('compress into archive') do
	excludes = [
		'../sabrassoft_rails/.*',
		'../sabrassoft_rails/sabras-site.tar.gz',
		'../sabrassoft_rails/log/*',
		'../sabrassoft_rails/tmp/*',
	].map {|ex| "--exclude='#{ex}'"}
	puts "tar #{excludes.join(' ')} -czf ../sabras-site.tar.gz ../sabrassoft_rails"
	`tar #{excludes.join(' ')} -czf ../sabras-site.tar.gz ../sabrassoft_rails`
	`cp ../sabras-site.tar.gz .`
end
	
Task.execute!

