$LOAD_PATH.unshift(File.dirname(__FILE__) + "/arthur")

module Artventure
  LIB_FILES = %w[arthur items main map]
  ROOT_DIR  = File.dirname(__FILE__) + "/.."
  DATA_DIR  = ROOT_DIR + "/data"
end

Artventure::LIB_FILES.each{|file| require file}