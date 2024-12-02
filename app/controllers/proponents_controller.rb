class ProponentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    @proponents = @user.proponents.includes(:address, :phones, :salary)
  end

  def show
    @proponent = @user.proponents.find(params[:id])
  end

  def new
    @proponent = @user.proponents.new
    @proponent.build_address
    @proponent.phones.build
    @proponent.build_salary
  end

  def create
    @proponent = @user.proponents.new(proponent_params)
    if @proponent.save
      redirect_to user_proponents_path(@user), notice: 'Proponente criado com sucesso.'
    else
      render :new
    end
  end

  def edit
    @proponent = @user.proponents.find(params[:id])
  end

  def update
    @proponent = @user.proponents.find(params[:id])
    if @proponent.update(proponent_params)
      redirect_to user_proponents_path(@user), notice: 'Proponente atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @proponent = @user.proponents.find(params[:id])
    @proponent.destroy

    redirect_to user_proponents_path(@user), notice: 'Proponente excluído com sucesso.'
  end

  private

  def set_user
    @user = current_user

    raise ActiveRecord::RecordNotFound, 'User not found' if @user.nil?
  end

  def proponent_params
    params.require(:proponent).permit(
      :name, :cpf, :date_of_birth,
      address_attributes: %i[id street number neighborhood city state zip_code _destroy],
      phones_attributes: %i[id number phone_type reference_name _destroy],
      salary_attributes: %i[id amount _destroy]
    )
  end
end
