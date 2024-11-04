class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :is_author, only: [:destroy, :edit, :update]
  before_action :is_an_authorized_user, only: [:create]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
    authorize Comment.new
  end

  # GET /comments/1 or /comments/1.json
  def show
    authorize @comment
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    authorize @comment
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user

    authorize @comment

    respond_to do |format|
      if @comment.save
        format.html { redirect_back fallback_location: root_path, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    authorize @comment
    
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to root_url, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    authorize @comment
  
    @comment.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: root_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:author_id, :photo_id, :body)
    end

    def is_an_authorized_user
      @photo = Photo.find(params.fetch(:comment).fetch(:photo_id))
      if current_user != @photo.owner && @photo.owner.private? && !current_user.leaders.include?(@photo.owner)
        redirect_back fallback_location: root_url, alert: "Not authorized"
      end
    end
end
