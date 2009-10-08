<<<<<<< HEAD
$LOAD_PATH.unshift(File.dirname(__FILE__) + "/arthur")

module Artventure
  LIB_FILES = %w[arthur items main map]
=======
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
  
  LIB_FILES = %w[ sprite arthur items map game hud main ]
>>>>>>> e4bee5205049a40ee6751b0591a334083d03f63d
  ROOT_DIR  = File.dirname(__FILE__) + "/.."
  DATA_DIR  = ROOT_DIR + "/data"
end

<<<<<<< HEAD
=======
# load all source files for the project
>>>>>>> e4bee5205049a40ee6751b0591a334083d03f63d
Artventure::LIB_FILES.each{|file| require file}