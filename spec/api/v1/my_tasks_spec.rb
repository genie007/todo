require 'spec_helper'

describe "api/v1/mytasks" , :type => :api do
    let(:user) { Factory(:user) }
    let(:token) { user.authentication_token }
    let(:taskName) { "Buy Milk!"}
    before do
        @task = Factory(:myTask, :name =>taskName,:user => user )
        @user2 = Factory(:user)
        @task2 = Factory(:myTask, :name => "Access Denied", :user => @user2)
        user.permissions.create!(:action => 'view', :model => @task)
        @task2 = Factory(:myTask, :user=>user)
    end
    context " tasks viewable by this user" do
        let(:url) { "api/v1/tasks"  }
        it "json" do
            get "#{url}.json", :token => token
            tasks_json =MyTask.for(user,"view").to_json
            last_response.body.should eql(tasks_json)
            tasks =JSON.parse(last_response.body)
            tasks.any? do |t|
                t["name"] == taskName
            end.should be_true
            tasks.any? do |t|
                t["name"]== "Access Denied"
            end.should be_false
        end
       it "XML" do 
           get "#{url}.xml", :token => token
           tasks_xml =MyTask.for(user,"view").to_xml
           last_response.body.should eql(tasks_xml)
           tasks =Nokogiri::XML(last_response.body)
           tasks.css("name").any? do |t|
             t.text == taskName
           end.should be_true
           tasks.css("name").any? do |t|
               t.text == "Access Denied"
           end.should be_false
       end 
    end
end