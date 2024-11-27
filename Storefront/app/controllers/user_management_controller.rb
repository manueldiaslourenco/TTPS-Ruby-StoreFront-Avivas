class UserManagementController < ApplicationController

  before_action :authenticate_user!


  def index
    #@users = User.active.where.not(id: current_user.id)
    @users= User.all
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: 'Usuario creado exitosamente.'
    else
      render :new
    end
  end

  def destroy
    user = User.find(params[:id])
    
    # Cambiar la contraseña de manera aleatoria
    random_password = SecureRandom.hex(8)  # Genera una contraseña aleatoria
    user.update(password: random_password, password_confirmation: random_password)
    
    # Realizar el borrado lógico
    user.soft_delete
    
    # Liberar el email y el username (lo haremos al "borrar" el usuario)
    # user.update(email: "#{user.email.split('@').first}_deleted_#{Time.now.to_i}@example.com", username: "#{user.username}_deleted_#{Time.now.to_i}")
    
    redirect_to admin_users_path, notice: "Usuario desactivado correctamente"
  end

  private

  def user_params
    # Aquí defines los parámetros permitidos, como el email, contraseña y rol
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :phone, :role)
  end


end