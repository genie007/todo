class MyTask < ActiveRecord::Base
    belongs_to :user
    has_many :permissions , :as => :model
    validates :name , :presence => true , :uniqueness => { :scope => :user_id, :case_sensitive => false,:message => "should be unique for a user"}
    validates:user_id ,:presence => true 
    
    scope :accessed_by, lambda { |user,action|
    joins(:permissions).where(:permissions => { :action => action.to_s,
    :user_id => user.id })
    }
    def self.for(user,action)
        MyTask.find_all_by_user_id(user) | MyTask.accessed_by(user,action)
    end

    
end
