class PostsController < ApplicationController
  include Authorization

  before_action :authorize_user
  skip_before_action :authorize_user, only: [ :index, :show ]

  def index
    # @posts = Post.all
    p "#{params[:category_ids]} -----------------------------------------"
    if params[:category_ids].present?
      @posts = Post.joins(:categories).where(categories: { id: params[:category_ids] }).distinct
    else
      @posts = Post.all
    end
    @categories = Category.order(name: :asc)
  end

  def new
    @post = Post.new
    @post.sections.build
    @categories = Category.all
  end

  def create
    @post = Post.new(title: post_params[:title], user_id: session[:user_id])
    if @post.save
      if post_params[:category_ids].present?
        category_ids = post_params[:category_ids].map(&:to_i)
        @post.categories = Category.find(category_ids)
      end
      p "HERE 1 --------------------------------------------"
      if post_params[:sections].present?
        p "HERE 2 ------------------------------------------"
        p post_params
        p post_params[:sections]
        post_params[:sections].each do |section_params|
          p "Section Params"
          p section_params[:title]
          p section_params[:body]
          @post.sections.create(title: section_params[:title], body: section_params[:body])
        end
      end

      redirect_to @post, notice: "Post created."
    else
      redirect_to new_post_path, alert: "Could not create post"
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    @categories = Category.all
  end

  def update
    @post = Post.find(params[:id])

    # Update categories if provided
    if post_params[:category_ids].present?
      category_ids = post_params[:category_ids].map(&:to_i)
      @post.categories = Category.find(category_ids)
    end

    # Update the title and sections
    if post_params[:sections_attributes].present?
      post_params[:sections_attributes].each do |index, section_params|
        if section_params[:_destroy] == "1"
          section = @post.sections.find_by(id: section_params[:id])
          section&.destroy if section
        else
          section = @post.sections.find_or_initialize_by(id: section_params[:id])
          section.update(section_params.except(:_destroy))
        end
      end
    end
    @post.assign_attributes(post_params.except(:sections_attributes, :category_ids))
    # unless post_params[:sections_attributes]
    #   @post.sections.destroy_all
    # end

    if @post.save
      redirect_to @post, notice: "Edit successful."
    else
      redirect_to edit_post_path(@post), alert: "Edit not successful."
    end
  end



  def destroy
  end

  def post_params
    params.require(:post).permit(:title, category_ids: [], sections_attributes: [ :id, :title, :body, :_destroy ])
  end
end
