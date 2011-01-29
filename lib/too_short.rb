require 'active_record'
require 'ar_base_extensions'
require 'controller_methods'
require 'singleton'

module TooShort
  class TooShortInvalidOptionError < StandardError; end
  class TooShortMissingOptionError < StandardError; end
  
  BASE = 36
  
  # Options are:
  # <em>host<em>: The short URL host you wish to use, i.e. http://2sh.de (required)
  def self.options
    @options ||= {}
  end
  
  # Used to translate the given hash (and scope) into an object
  # class_scope is optional.
  def self.expand_to_object(class_scope, hash)
    klass = short_url_klass class_scope
    id = hash_to_id hash
    klass.find_by_id(id) if klass and id
  end
  
  def self.register_class(class_name, class_scope)
    ClassRegistry.instance.register(class_name, class_scope)
  end
  
  private
  
  def self.short_url_klass(class_scope)
    if class_name = ClassRegistry.instance.lookup(class_scope)
      Kernel.const_get class_name
    end
  end
  
  def self.hash_to_id(hash)
    hash.to_i(BASE)
  end
  
  def self.id_to_hash(id)
    id.to_s(BASE)
  end
  
  # Holds the model classes that use TooShort
  # It's basically a map storing :scope => :class_name
  # I.e. 'p' => 'Post'
  #
  # Only used internally.
  class ClassRegistry
    include Singleton
    def registry
      @registry ||= {}
    end
    
    def register(class_name, class_scope)
      registered_class_name = registry[class_scope]
      if registered_class_name && registered_class_name != class_name
        raise TooShortInvalidOptionError.new("Duplicate usage of scope '#{class_scope.to_s}', used in classes #{registered_class_name} and #{class_name}")
      end
      registry[class_scope] = class_name
    end
    
    def lookup(class_scope)
      registry[class_scope]
    end
    
    # only used for specs
    def clear
      @registry = {}
    end
    
  end
  
end

ActiveRecord::Base.class_eval { extend TooShort::ARBaseExtensions }
