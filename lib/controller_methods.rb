module TooShort
  
  # To be included in the controller that should handle short URLs, i.e
  # class ShortUrlsController < ApplicationController
  #   include TooShort::ControllerMethods
  # end
  #
  # response handling can be customized by overwriting these methods
  # respond_to_valid_short_url
  # respond_to_invalid_short_url
  #
  # the object that was looked up can be accessed via @object_from_short_url
  module ControllerMethods
    def expand
      require_all_model_classes
      if @object_from_short_url = TooShort.expand_to_object(params[:scope], params[:hash])
        respond_to_valid_short_url
      else
        respond_to_invalid_short_url
      end    
    end
    
    def respond_to_valid_short_url
      redirect_to @object_from_short_url
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
      Dir.entries(Rails.root.to_s + '/app/models/').select{|f| f =~ /^\w/}.each do |f| 
        f.sub('.rb', '').classify.constantize
      end if defined?(Rails)
    end
    
  end
end