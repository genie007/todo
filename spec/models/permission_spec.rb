require 'spec_helper'

describe Permission do
    describe "Permission" do
        before(:each) do
            @user =Factory(:user)
        end
        
        it " User can have many permissions" do
            @user.permissions.should_not be_nil
        end
    end
end
