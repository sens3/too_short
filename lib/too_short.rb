require 'active_record'
require 'ar_base_extensions'
require 'controller_methods'
require 'singleton'

module TooShort
  class TooShortInvalidOptionError < StandardError; end
  class TooShortMissingOptionError < StandardError; end
  
  def self.options
    @options ||= {}
  end
  
  def self.register_class(class_name, class_scope)
    ClassRegistry.instance.register(class_name, class_scope)
  end
  
  def self.expand_to_object(params={})
    params.symbolize_keys!
    klass = short_url_klass(params[:scope])
    id = hash_to_id(params[:hash])
    klass.find_by_id(id) if klass and id
  end
  
  private
  
  def self.short_url_klass(class_scope)
    if class_name = ClassRegistry.instance.lookup(class_scope)
      Kernel.const_get class_name
    end
  end
  
  def self.hash_to_id(hash)
    hash.to_i(36)
  end
  
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
    
    def clear
      @registry = {}
    end
    
  end
  
end

ActiveRecord::Base.class_eval { extend TooShort::ARBaseExtensions }
