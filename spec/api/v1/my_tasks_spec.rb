require 'spec_helper'

describe "api/v1/mytasks" , :type => :api do
    let(:user) { Factory(:user) }
    let(:token) { user.authentication_token }
    let(:taskName) { "Buy Milk!"}
    before do
        @task = Factory(:myTask, :name =>taskName,:user => user )
        @user2 = Factory(:user)
        @task2 = Factory(:myTask, :name => "Access Denied", :user => @user2)
    end
    context " tasks viewable by this user" do
        let(:url) { "/api/v1/tasks"  }
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
    context "creating a task" do 
        let(:url)  { "/api/v1/tasks" }
        it "successful JSON" do
            post "#{url}.json", :token => token , :task => { :name => "Inspector" ,:user_id => user.id }
            task = MyTask.find_by_name("Inspector")
            task.should_not be_nil
            route ="/api/v1/tasks/#{task.id}"
            last_response.status.should eql(201)
            last_response.headers["Location"].should eql(route)
            last_response.body.should eql(task.to_json)
        end
        it "unsuccessful JSON" do
            post "#{url}.json", :token => token , :task => {  }
            task = MyTask.find_by_name("Inspector")
            task.should be_nil
            last_response.status.should eql(422)
            errors = {:name => ["can't be blank"],:user_id => ["can't be blank"] }.to_json
            last_response.body.should eql(errors)
        end
    end
    context "viewing a task" do
        let(:url) { "/api/v1/tasks/#{@task.id}"}
        it "JSON" do
            get "#{url}.json" , :token => token 
            last_response.status.should eql(200)
            last_response.body.should eql(@task.to_json)
            task_response = JSON.parse(last_response.body)
            task_response["name"] .should eql(taskName)
         end
    end
    context "updating a task" do
        let(:url) { "/api/v1/tasks/#{@task.id}"}
        it "successful JSON" do
            @task.name.should eql(taskName)
            put "#{url}.json", :token => token , :task => { :name => "Updated Task" }
            last_response.status.should eql(200)
            @task.reload
            @task.name.should eql("Updated Task")
            last_response.body.should eql("{}")
        end
        it "unsuccessful JSON" do
            @task.name.should eql(taskName)
            put "#{url}.json", :token => token , :task => { :name => "" }
            last_response.status.should eql(422)
            @task.reload
            @task.name.should eql(taskName)
            errors = {:name => ["can't be blank"]}
            last_response.body.should eql(errors.to_json)
        end
    end
    context "deleting a task" do
        let(:url) { "/api/v1/tasks/#{@task.id}"}
        it "JSON" do
            delete "#{url}.json", :token => token 
            last_response.status.should eql(200)
        end
    end
end