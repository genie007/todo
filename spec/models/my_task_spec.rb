require 'spec_helper'

describe MyTask do
  before do
   @taskName ="MyTask1"
   @user = Factory(:user)
  end 
  it "should have a unique name for a user" do
      task1 = Factory(:myTask, :name => @taskName, :user => @user)
      task2 = Factory.build(:myTask, :name  => @taskName , :user=> @user) 
      task1.should be_valid
      task1.user.id.should eql task2.user.id
      task2.should_not be_valid
  end
  it " can have same name for different users" do
      task1 = Factory(:myTask, :name =>@taskName)
      task2 = Factory(:myTask, :name => @taskName)
      task1.should be_valid
      task2.should be_valid
      task1.user.id.should_not eql task2.user.id
  end
  it " should be unique and case insensitive" do
      task1 = Factory(:myTask, :name => @taskName.downcase, :user => @user)
      task2 = Factory.build(:myTask, :name  => @taskName.upcase , :user=> @user) 
      task1.should be_valid
      task2.should_not be_valid
  end
end
