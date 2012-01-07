require 'spec_helper'
require "cancan/matchers"
describe Ability do 
  describe "Authorizations" do 
    context "User is a Task Owner" do 
      before(:each) do
        @user = Factory(:user)
        @ability = Ability.new(@user)
      end
      describe "should allow management of Tasks" do
        it "should allow management of tasks " do
          @ability.should be_able_to(:manage, Task.create(:name => "Buy Milk",:user_id=> @user))
        end
      end
    end
  end
end
