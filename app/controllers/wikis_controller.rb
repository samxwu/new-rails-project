class WikisController < ApplicationController
    def index
        @wikis = Wiki.all
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
end
