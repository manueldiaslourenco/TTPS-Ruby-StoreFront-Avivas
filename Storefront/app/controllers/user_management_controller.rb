class UserManagementController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :user, class: 'User'


  def index
    @users = User.active.where.not(id: current_user.id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    authorize! :create, @user
    if @user.save
      redirect_to admin_users_path, notice: 'Usuario creado exitosamente.'
    else
      render :new
    end
  end

  def destroy
    user = User.find(params[:id])
    
    authorize! :destroy, @user

    random_password = SecureRandom.hex(8)
    user.update(password: random_password, password_confirmation: random_password)
    
    user.soft_delete
    
    redirect_to admin_users_path, notice: "Usuario desactivado correctamente"
  end

  private

  def user_params
    # Aquí defines los parámetros permitidos, como el email, contraseña y rol
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :phone, :role)
  end


end