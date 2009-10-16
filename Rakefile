require 'rake'
require 'rake/rdoctask'

task :default => :todo

desc "Show all TODO tasks from the source code to help with improvements of the project"
task :todo do
  # gather todo items from source
  @all_todos = Hash.new()
  files = Dir["**/*.rb"]

  files.each do |filename|
    File.readlines(filename).each do |line|
      if line =~ /TODO:(.+)$/
        @all_todos[filename] ||= []
        @all_todos[filename] << $1
      end
    end
  end
  
  # output data
  index = 0
  puts ""
  @all_todos.each do |filename, todos|
    puts "#{filename}"
    puts "=" * filename.length
    todos.each do |todo|
      puts "  #{index += 1}. #{todo}"
    end
  end
end


# namespace :test do
  
# end