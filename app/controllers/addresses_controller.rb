# frozen_string_literal: true

class AddressesController < ApplicationController
  before_action :set_address, only: %i[show edit update destroy]

  def index
    @addresses = Address.all
  end

  def show; end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to @address, notice: 'Endereço criado com sucesso.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @address.update(address_params)
      redirect_to @address, notice: 'Endereço atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @address.destroy
    redirect_to addresses_url, notice: 'Endereço excluído com sucesso.'
  end

  private

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:street, :number, :neighborhood, :city, :state, :zip_code, :proponent_id)
  end
end
