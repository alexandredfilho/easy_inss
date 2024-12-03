class ProponentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    @proponents = @user.proponents.includes(:address, :phones, :salary).page(params[:page]).per(5)
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
      flash[:notice] = 'The Proponent was created successfully!'
      redirect_to user_proponents_path(@user)
    else
      flash[:alert] = @proponent.errors.full_messages.join('<br>').html_safe
      render :new
    end
  end

  def edit
    @proponent = @user.proponents.find(params[:id])
  end

  def update
    @proponent = @user.proponents.find(params[:id])

    if @proponent.update(proponent_params)
      flash[:notice] = 'the Proponent has been updated successfully!'
      redirect_to user_proponents_path(@user)
    else
      flash[:alert] = @proponent.errors.full_messages.join('<br>').html_safe
      render :edit
    end
  end

  def destroy
    @proponent = @user.proponents.find(params[:id])

    if @proponent.destroy
      flash[:notice] = 'The Proponent was successfully deleted!'
    else
      flash[:alert] = @proponent.errors.full_messages.join('<br>').html_safe
    end

    respond_to do |format|
      format.html { redirect_to user_proponents_path(@user), status: :see_other }
      format.json { head :no_content }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@proponent) }
    end
  end

  private

  def set_user
    @user = current_user

    raise ActiveRecord::RecordNotFound, 'User not found' if @user.nil?
  end

  def proponent_params
    params.require(:proponent).permit(
      :name, :cpf, :date_of_birth,
      address_attributes: address_attributes,
      phones_attributes: phones_attributes,
      salary_attributes: salary_attributes
    ).tap do |whitelisted|
      format_salary_amount(whitelisted[:salary_attributes])
    end
  end

  def format_salary_amount(salary_attributes)
    return unless salary_attributes[:amount]

    amount = salary_attributes[:amount]
    salary_attributes[:amount] = amount.gsub('R$', '').gsub('.', '').gsub(',', '.').to_f
  end

  def address_attributes
    %i[id street number neighborhood city state zip_code _destroy]
  end

  def phones_attributes
    %i[id number phone_type reference_name _destroy]
  end

  def salary_attributes
    %i[id amount _destroy]
  end
end
