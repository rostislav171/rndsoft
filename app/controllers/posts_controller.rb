class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  # ПОЛУЧИТЬ /posts или /posts.json
  def index
    @posts = Post.all
  end

  # ПОЛУЧИТЬ /posts/1 или /posts/1.json
  def show
  end

  # СОЗДАТЬ /posts/new
  def new
    @post = Post.new
  end

  # РЕДАКТИРОВАТЬ /posts/1/edit
  def edit
  end

  # ОТПРАВИТЬ /posts или /posts.json
   def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        current_user.increment!(:posts_count)

        format.html { redirect_to post_url(@post), notice: 'Пост успешно создан.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # ОБНОВИТЬ /posts/1 или /posts/1.json
  def update
    respond_to do |format|
      if @post.edits_count.nil? || @post.edits_count >= 5
        flash[:error] = 'Превышено максимальное количество редакций для этой новости.'
        redirect_to @post
      else
        if @post.update(post_params)
          @post.increment!(:edits_count)

          flash[:notice] = 'Редакция успешно сохранена.'

          format.html { redirect_to post_url(@post), notice: 'Пост успешно обновлен.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  # УДАЛИТЬ /posts/1 или /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Пост успешно удален.' }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content).merge(user_id: current_user.id)
  end

  def authorize_user!
    unless current_user.editor? || current_user == @post.user
      flash[:error] = 'У вас нет прав на редактирование этого поста.'
      redirect_to @post
    end
  end

end
