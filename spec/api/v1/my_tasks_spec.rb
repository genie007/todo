require 'spec_helper'

describe "api/v1/mytasks" , :type => :api do
    let(:user) { Factory(:user) }
    let(:token) { user.authentication_token }
    let(:taskName) { "Buy Milk!"}
    before do
        @task = Factory(:myTask, :name =>taskName )
        user.permissions.create!(:action => 'view', :model => @task)
        @task2 = Factory(:myTask, :user=>@user)
    end
    context " tasks viewable by this user" do
        let(:url) { "api/v1/tasks"  }
        it "json" do
            get "#{url}.json"
            tasks_json =MyTask.all.to_json
            last_response.body.should eql(tasks_json)
            puts last_response.body
            tasks =JSON.parse(last_response.body)
            tasks.any? do |t|
                t["name"] == taskName
            end.should be_true
        end
      
    end
end