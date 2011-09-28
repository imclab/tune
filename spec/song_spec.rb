require 'spec_helper'

describe Song do
  context ":parse" do
    before do
      @subject = Song.parse(IO.read(Rails.root.join("spec/fixtures.html")))
    end
    
    it "should parse" do
      @subject.should == ""
    end
  end
end
