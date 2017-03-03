class WikiPolicy < ApplicationPolicy
    attr_reader :user, :wiki
    
    def initialize(user, record)
        @user = user
        @wiki = record
    end
    
    def update?
        user.admin? || user.id == wiki.user_id || wiki.private? == false || Collaborator.where('user_id = ? AND wiki_id = ?', user.id, wiki.id).count > 0 
    end
    
   class Scope 
       attr_reader :user, :scope
       
       def initialize(user, scope)
           @user = user
           @scope = scope
       end
       
       def resolve
           wikis = []
            if user.role == 'admin'
                wikis = scope.all
            elsif user.role == 'premium'
                all_wikis = scope.all
                all_wikis.each do |wiki|
                    if wiki.private? == false || wiki.user_id == user.id || wiki.collaborators.pluck(:user_id).include?(user.id)
                        wikis << wiki
                    end
                end
            else
                all_wikis = scope.all
                wikis = []
                all_wikis.each do |wiki|
                    if wiki.private? == false || wiki.collaborators.pluck(:user_id).include?(user.id)
                        wikis << wiki
                    end
                end
            end
            wikis
        end
   end
    
    
end
