class PacksController < ApplicationController
  before_action :find_pack, only: %i[show edit update destroy current]

  def index
    @packs = current_user.packs
  end

  def show; end

  def new
    @pack = Pack.new
  end

  def edit; end

  def create
    @pack = Pack.new(pack_params)
    @pack.user_id = current_user.id

    if @pack.save
      redirect_to @pack
    else
      render :new
    end
  end

  def update
    if @pack.update(pack_params)
      redirect_to @pack
    else
      render :edit
    end
  end

  def destroy
    current_user.update(current_pack_id: nil) if current_user.current_pack_id == @pack.id
    @pack.destroy

    redirect_to packs_path
  end

  def current
    current_user.update(current_pack_id: @pack.id)
    redirect_to packs_path
  end

  private

  def find_pack
    @pack = Pack.find(params[:id])
  end

  def pack_params
    params.require(:pack).permit(:name)
  end
end
