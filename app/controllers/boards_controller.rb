class BoardsController < ApplicationController
  def index
    # ページ番号が正しく指定されていればその番号を表示する
    page_param = params[:page].to_i.positive? ? params[:page].to_i : 1
    @boards = Board.includes(:user)
              .order(created_at: :desc)
              .page(page_param)
  end

  def new
    @board = Board.new
  end

  def cheers
    @cheer_boards = current_user.cheer_boards.includes(:user).order(created_at: :desc)
  end

  def create
    @board =current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, success: t("defaults.flash_message.created", item: Board.model_name.human)
    else
      flash.now[:danger] = t("defaults.flash_message.not_created", item: Board.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
  end

  def edit
    @board = current_user.boards.find(params[:id])
  end

  def update
    @board = current_user.boards.find(params[:id])
    if @board.update(board_params)
        redirect_to board_path(@board), success: t("defaults.flash_message.updated", item: Board.model_name.human)
    else
      flash.now[:danger] = t("defaults.flash_message.not_updated", item: Board.model_name.human)
      render :edit, status: :unprocessable_entity
    end
end
  def destroy
  board = current_user.boards.find(params[:id])
  board.destroy!
  redirect_to boards_path, success: t("defaults.flash_message.deleted", item: Board.model_name.human), status: :see_other
end
  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache, skincare_items: [], skin_troubles: [])
  end
end
