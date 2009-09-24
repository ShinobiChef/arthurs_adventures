module Artventure

  # cache images to make sure image is only once in memory
  # Use like: image = Resource['items/gold3']
  module Resource
    extend self

    ALL_IMAGES = {}
    
    def [](filename, window, image_options = false)
      ALL_IMAGES[filename] ||= load_image(window, filename, image_options)
    end
    
    # TODO: implement helper for loading images and music
    
    private      
   
      def load_image(window, filename, image_options = false)
        Image.new(window, DATA_PATH+'/'+filename, image_options)
      end

  end
  
end