require 'spec_helper'
require "cancan/matchers"
describe Ability do 
  describe "Authorizations" do 
     before(:each) do
          @user = Factory(:user)
          @ability = Ability.new(@user)
      end
    context "User is a Task Owner" do 
       describe "should allow management of own Tasks" do
        it "should allow management of tasks " do
            @ability.should be_able_to(:manage, Factory(:myTask,:name => "Buy Milk",:user=> @user))
        end
      end
    context "User is not a Task Owner" do
      describe " should allow actions on tasks that has permission to" do
        it " should allow view on task" do
            user2= Factory(:user)
            user2.id.should_not eql @user.id
            task = Factory(:myTask,:user => user2);
            task.should be_valid
            @ability.should_not be_able_to(:view, task);
        end
      end
    end
    end
  end
end
