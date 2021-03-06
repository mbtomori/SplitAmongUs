class ListsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @list = current_user.lists.new(list_params)
    if current_user.save
      render json: @list
    else
      render status: :unprocessable_entity, json: { error: @list.errors[:name].join(',') }
      # this still needs to account to errors in the modal
      # so render the modal
      # redirect_to dashboard_index_path
    end
  end

  def index
    render json: current_user.lists.order(:created_at)
  end

  def show
    @list = List.find(params[:id])
    respond_to { |format|
      format.html { render :show, request.xhr? ? { layout: false } : {} }
      format.json { render json: @list }
    }
  end

  def update
    @list = List.find(params[:id])
    if @list.update_attributes(list_params)
      render json: @list
    else
      render status: :unprocessable_entity, json: { error: @list.errors[:name].join(',') }
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to dashboard_index_path
    # render json: @list
  end

  def stats
    list = List.find(params[:id])
    render partial: 'lists/total', locals: { list: list }
  end

  private
    def list_params
      params.require(:list).permit(:name, :total_amount)
    end
end
