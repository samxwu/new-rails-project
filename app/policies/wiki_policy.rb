class WikiPolicy < ApplicationPolicy
    attr_reader :user, :wiki
    
    def initialize(user, record)
        @user = user
        @wiki = record
    end
    
    def update?
        user.admin? || user.id == wiki.user_id || wiki.private? == false 
    end
    

end
