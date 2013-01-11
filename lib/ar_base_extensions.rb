module TooShort
  module ARBaseExtensions
    
    
    # To be included in your model, i.e
    # class Post
    #   has_a_short_url
    # end
    #
    # Takes the following options:
    #   host: short URL host to use (alternatively to be defined in an initializer file)
    #   scope: the scope for this model, necessary when short URLs are used in multiple models
    #
    def has_a_short_url(options={})
      short_url_options = TooShort.options.merge(options)
      short_url_options.symbolize_keys!
      class_attribute :short_url_options
      self.short_url_options = short_url_options
      
      TooShort.register_class(self.to_s, short_url_options[:scope])
      
      class_eval do
        include InstanceMethods
      end
    end
    
  end
  module InstanceMethods
    def short_url
      validate_and_cleanup_short_url_options(short_url_options)
      hash = TooShort.id_to_hash(self.id)
      [short_url_host, short_url_scope, hash].compact.join('/')
    end
    
    private
    
    def validate_and_cleanup_short_url_options(options)
      if not @validated_short_url_options
        if options[:host].blank?
          raise TooShort::TooShortMissingOptionError.new("You need to specify a short url host")
        end
        @validated_short_url_options = true
      end
      if not @cleaned_up_short_url_options
        options[:host].gsub!(/\/$/, '')
        options[:host] = "http://#{options[:host]}" unless options[:host] =~ /^https?:\/\//
        options[:scope].gsub!(/\/$/, '') if options[:scope]
        options[:scope].gsub!(/^\//, '') if options[:scope]
        @cleaned_up_short_url_options = true
      end
    end
    
    def short_url_scope
      short_url_options[:scope]
    end
    
    def short_url_host
      short_url_options[:host]
    end
    
    def short_url_options
      self.class.read_inheritable_attribute :short_url_options
    end
    
  end
end