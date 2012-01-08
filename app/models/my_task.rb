class MyTask < ActiveRecord::Base
    belongs_to :user
    validates :name , :presence => true , :uniqueness => { :scope => :user_id, :case_sensitive => false,:message => "should be unique for a user"}
end
