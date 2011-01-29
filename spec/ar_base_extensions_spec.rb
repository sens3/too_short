require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class ModelStub < ActiveRecord::Base
  def self.columns() @columns ||= []; end
  def id() 123456; end
end


describe "TooShort ActiveRecord::Base extensions" do
  
  describe "short_url" do
    
    before do
      TooShort::ClassRegistry.instance.clear
      TooShort.options[:host] = 'http://2short.de'
    end
    
    it "should return the short url" do
      class Foo < ModelStub
        has_a_short_url
      end
      Foo.new.short_url.should == "http://2short.de/2n9c"
    end
    
    describe "if the host is not set" do
      before do
        TooShort.options[:host] = nil
      end
      it "should return an error" do
        class Foo < ModelStub
          has_a_short_url
        end
        lambda{Foo.new.short_url}.should raise_error(TooShort::TooShortMissingOptionError, "You need to specify a short url host")
      end
    end
    
    describe "if the host is set on the model" do
      before do
        class Foo < ModelStub
          has_a_short_url :host => 'http://2short.it'
        end 
      end
      it "should return the short url for the specified host" do
        Foo.new.short_url.should == "http://2short.it/2n9c"
      end
    end
    
    describe "if a scope is set" do
      before do
        class Foo < ModelStub
          has_a_short_url :scope => 'f'
        end
      end
      it "should return the short url scoped by the class hash" do
        Foo.new.short_url.should == "http://2short.de/f/2n9c"
      end
    end
    
    it "should remove trailing slashes from the host" do
      class Foo < ModelStub
        has_a_short_url :host => 'http://2short.es/'
      end
      Foo.new.short_url.should == "http://2short.es/2n9c"
    end
    
    it "should remove slashes around the scope" do
      class Foo < ModelStub
        has_a_short_url :scope => '/p/'
      end
      Foo.new.short_url.should == "http://2short.de/p/2n9c"
    end
    
    it "should prepend http:// if necessary" do
      TooShort.options[:host] = '2short.it'
      class Foo < ModelStub
        has_a_short_url
      end
      Foo.new.short_url.should == "http://2short.it/2n9c"
    end
    
    it "should not prepend http:// if https:// was specified" do
      TooShort.options[:host] = 'https://2short.it'
      class Foo < ModelStub
        has_a_short_url
      end
      Foo.new.short_url.should == "https://2short.it/2n9c"
    end
    
  end
  
  it "should return an error when included more than once with no scope" do
    lambda {
      class Foo < ModelStub
        has_a_short_url
      end
      
      class Bar < ModelStub
        has_a_short_url
      end
    }.should raise_error(TooShort::TooShortInvalidOptionError, "Duplicate usage of scope '', used in classes Foo and Bar")
  end
  
  it "should return an error when included more than once with the same scope" do
    lambda {
      class Foo < ModelStub
        has_a_short_url :scope => 'x'
      end
      
      class Bar < ModelStub
        has_a_short_url :scope => 'x'
      end
    }.should raise_error(TooShort::TooShortInvalidOptionError, "Duplicate usage of scope 'x', used in classes Foo and Bar")
  end
  
end