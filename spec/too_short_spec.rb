require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TooShort" do
  before do
    TooShort.options[:host] = 'http://2short.de'
  end
  describe "expand" do
    it "should expand the given hash" do
      @foo = mock('food')
      class Foo
        has_a_short_url
      end
      Foo.stub!(:find_by_id).with(123456).and_return(@foo)
      TooShort.expand_to_object(:hash => '2n9c').should == @foo
    end
  end
end