class BlocksController < ApplicationController
  def index
    @blocks = Block.order(height: :desc).page(params[:page]).per(20)
  end

  def show
  end
end
