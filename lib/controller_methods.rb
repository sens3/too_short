module TooShort
  module ControllerMethods
    def expand
      require_all_model_classes
      if @expanded_object = TooShort.expand_to_object(params[:scope], params[:hash])
        respond_to_valid_short_url
      else
        respond_to_invalid_short_url
      end    
    end
  
    def respond_to_valid_short_url
      redirect_to @expanded_object
    end
  
    def respond_to_invalid_short_url
      respond_to do |wants|
        error_hash = {:error => 'Invalid short url'}
        wants.html  { render :text  => error_hash[:error]}
        wants.xml   { render :xml   => error_hash}
        wants.json  { render :json  => error_hash}        
      end
    end
    
    private
    
    def require_all_model_classes
      # Rails only loads classes when they are used
      # To populate our registry we require each file in app/models
      Dir.glob(RAILS_ROOT + '/app/models/*.rb').each { |file| require file } if defined?(RAILS_ROOT)
    end
    
  end
end