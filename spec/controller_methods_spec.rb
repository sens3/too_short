require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'action_controller'

class ShortUrlController < ActionController::Base
  include TooShort::ControllerMethods
end

describe "TooShort ControllerMethods" do
  before do
    @controller = ShortUrlController.new
  end
  describe "expand" do
    before do
      @controller.stub!(:respond_to_valid_short_url)
      @controller.stub!(:respond_to_invalid_short_url)
      @params = {'scope' => 'f', 'hash' => '2n9c', 'format' => 'xml'}
      @controller.stub!(:params).and_return(@params)
    end
    after do
      @controller.expand
    end
    it "should get the object for the short url" do
      TooShort.should_receive(:expand_to_object).with(@params)
    end
    it "should respond to a valid short url" do
      TooShort.stub!(:expand_to_object).and_return(mock('expanded object'))
      @controller.should_receive(:respond_to_valid_short_url)
    end
    it "should respond to an invalid short url" do
      TooShort.stub!(:expand_to_object).and_return(nil)
      @controller.should_receive(:respond_to_invalid_short_url)
    end
  end
  
end