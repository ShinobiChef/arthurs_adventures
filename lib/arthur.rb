# In case you use Gosu via rubygems.
begin
  require 'rubygems'
rescue LoadError
  # In case you don't.
end

# load external dependencies
require 'gosu'

$LOAD_PATH.unshift(File.dirname(__FILE__) + "/arthur")

module Artventure
  include Gosu
  
  LIB_FILES = %w[ sprite arthur items map game hud main resources ]
  ROOT_DIR  = File.dirname(__FILE__) + "/.."
  DATA_DIR  = ROOT_DIR + "/data"
  
  VERSION = '0.4'
end

# load all source files for the project
Artventure::LIB_FILES.each{|file| require file}