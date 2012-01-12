class Api::V1::TasksController < Api::V1::BaseController 
    before_filter :find_task , :only => [:show]
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
    def show
        task =MyTask.find(params[:id])
        respond_with task
    end
  private
    def find_task
        @task = MyTask.for(current_user,"view").find(params[:id])
        rescue ActiveRecord::RecordNotFound
            error = { :error => "Task not found."}
            respond_with error, :status => 404
    end
end