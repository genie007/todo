class Api::V1::TasksController < Api::V1::BaseController  
    def index  
        respond_with(MyTask.for(current_user, :action => 'view')) 
    end
    def create
        task = MyTask.create(params[:task], :user => current_user)
        if task.valid?
            respond_with task, :location=> api_v1_task_path(task)
        else
            respond_with task
        end
    end
end