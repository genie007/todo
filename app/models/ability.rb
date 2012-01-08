class Ability
  include CanCan::Ability

  def initialize(user)
     can :manage , MyTask do |task|
        task.try(:user) == user
     end    

      user.permissions.each do |permission|
          can permission.action.to_sym, permission.model_type.constantize do |model|
              model.nil? ||
              permission.model_id.nil? ||
              permission.model_id == model.id
          end
      end
  end
end
