require 'spec_helper'

describe User do
 it "should be valid" do
    user = Factory(:user)
    user.should be_valid
  end
end
