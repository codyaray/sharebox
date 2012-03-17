require 'open-uri'

class AssetsController < ApplicationController
  before_filter :authenticate_user!  # authenticate for users before any methods is called

  def index
    @assets = current_user.assets
  end

  def show
    @asset = current_user.assets.find(params[:id])
  end

  def new
    @asset = current_user.assets.new
    if params[:folder_id] # if we want to upload a file inside another folder
      @current_folder = current_user.folders.find(params[:folder_id])
      @asset.folder_id = @current_folder.id
    end
  end

  def create
    @asset = current_user.assets.new(params[:asset])
    if @asset.save
      flash[:notice] = "Successfully uploaded the file."

      if @asset.folder # checking if we have a parent folder for this file
        redirect_to browse_path(@asset.folder) # then we redirect to the parent folder
      else
        redirect_to root_url
      end
    else
      render :action => 'new'
    end
  end

  def edit
    @asset = current_user.assets.find(params[:id])
  end

  def update
    @asset = current_user.assets.find(params[:id])
    if @asset.update_attributes(params[:asset])
      redirect_to @asset, :notice  => "Successfully updated asset."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @asset = current_user.assets.find(params[:id])
    @parent_folder = @asset.folder # grabbing the parent folder before deleting the record
    @asset.destroy
    flash[:notice] = "Successfully deleted the file."
    if @parent_folder
      redirect_to browse_path(@parent_folder)
    else
      redirect_to root_url
    end
  end

  # this action will let the users download the files (after a simple authorization check)
  def get
    # first find the asset within own assets
    asset = current_user.assets.find_by_id(params[:id])

    # if not found in own assets, check if the current_user has share access to the parent folder of the file
    asset ||= Asset.find(params[:id]) if current_user.has_share_access?(Asset.find_by_id(params[:id]).folder)

    if asset
      # Parse the URL for special characters first before downloading
      data = open(asset.uploaded_file.url)
      
      # use the send_data method to send the above bindary "data" as a file
      send_data data, :filename => asset.file_name

      #redirect to amazon S3 url which will let the user download the file automatically  
      # redirect_to asset.uploaded_file.url, :type => asset.uploaded_file_content_type
    else
      flash[:error] = "Don't be cheeky! Mind your own assets!" + ":Rails_ROOT/config/amazon_s3.yml"
      redirect_to assets_path
    end
  end
end
