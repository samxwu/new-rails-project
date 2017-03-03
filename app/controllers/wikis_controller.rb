class WikisController < ApplicationController
    def index
        #@wikis = Wiki.all
        @wikis = policy_scope(Wiki)
    end
    
    def show
        @wiki = Wiki.find(params[:id])
    end
    
    def new
        @wiki = Wiki.new
    end
    
    def create
        @wiki = Wiki.new
        @wiki.title = params[:wiki][:title]
        @wiki.body = params[:wiki][:body]
        @wiki.private = params[:wiki][:private]
        @wiki.user_id = current_user.id

        
        if @wiki.save
            redirect_to @wiki, notice: "Wiki was saved successfully."
        else
            flash.now[:alert] = "Error creating Wiki topic. Please try again."
            render :new
        end
    end
    
    def edit
        @wiki = Wiki.find(params[:id])
    end
    
    def update
        @wiki = Wiki.find(params[:id])
        authorize @wiki
        
        @wiki.title = params[:wiki][:title]
        @wiki.body = params[:wiki][:body]
        @wiki.private = params[:wiki][:private]
        
        
        @add_collaborators = params[:add_collaborators]
        addCollaborators(@add_collaborators, @wiki.id)
        
        @remove_collaborators = params[:remove_collaborators]
        removeCollaborators(@remove_collaborators, @wiki.id)
        
        
        if @wiki.save
            flash[:notice] = "Wiki was updated."
            redirect_to @wiki
        else
            flash.now[:alert] = "Error saving wiki. Please try again."
            render :edit
        end
    end
    
    def destroy
        @wiki = Wiki.find(params[:id])
        
        if @wiki.destroy
            flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
            redirect_to action: :index
        else
            flash.now[:alert] = "There was an error deleting the Wiki."
            render :show
        end
    end
    
    private
    
    def addCollaborators(emails, wiki_id)
        email_list = emails.split(";")
        email_list.each do |email|
            if Collaborator.where("email = ? AND wiki_id = ?", email, wiki_id).count == 0
                Collaborator.create(user_id: User.where("email = ?", email).pluck(:id).first, wiki_id: wiki_id, email: email)
            end
        end
    end
    
    
    def removeCollaborators(emails, wiki_id)
        email_list = emails.split(";")
        email_list.each do |email|
            if Collaborator.where("email = ? AND wiki_id = ?", email, wiki_id).count > 0
                Collaborator.where("email = ? AND wiki_id = ?", email, wiki_id).destroy_all
            end
        end
    end
    
    
    
    
end
