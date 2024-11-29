# frozen_string_literal: true

class PhonesController < ApplicationController
  before_action :set_phone, only: %i[show edit update destroy]

  def index
    @phones = Phone.all
  end

  def show; end

  def new
    @phone = Phone.new
  end

  def create
    @phone = Phone.new(phone_params)
    if @phone.save
      redirect_to @phone, notice: 'Telefone criado com sucesso.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @phone.update(phone_params)
      redirect_to @phone, notice: 'Telefone atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @phone.destroy
    redirect_to phones_url, notice: 'Telefone excluído com sucesso.'
  end

  private

  def set_phone
    @phone = Phone.find(params[:id])
  end

  def phone_params
    params.require(:phone).permit(:number, :phone_type, :reference_name, :proponent_id)
  end
end
