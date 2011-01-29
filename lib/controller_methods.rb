module TooShort
  module ControllerMethods

    def expand
      if @expanded_object = TooShort.expand_to_object(params)
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
  end
end