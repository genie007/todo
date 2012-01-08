class Api::V1::TasksController < Api::V1::BaseController  
    def index  
        respond_with(MyTask.all) 
    end
end