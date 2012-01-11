class MyTask < ActiveRecord::Base
    belongs_to :user
    has_many :permissions , :as => :model
    validates :name , :presence => true , :uniqueness => { :scope => :user_id, :case_sensitive => false,:message => "should be unique for a user"}
    validates:user_id ,:presence => true 

    def self.for(user,action)
 	MyTask.where(
	"my_tasks.id IN 
      (
        SELECT my_tasks.id FROM my_tasks
		WHERE user_id = ?
		UNION
		SELECT my_tasks.id FROm my_tasks 
		INNER JOIN permissions 
		ON my_tasks.id = permissions.model_id 
		WHERE permissions.model_type = ? and permissions.action = ? 
      ) 
     ", user.id,:MyTask,action.to_s )
    end
end
