class UsersController < ApplicationController

  # GET /users
  # GET /users.json
  def index
    @title = 'Users'
    @users = User.all

    respond_to do |format|
      if @user.is_admin?
        format.html # index.html.erb
        format.json { render json: @users }
      else
        format.html { redirect_to root_path,
                      notice: "No peeking at other people's stuff!" }
      end
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @title = User.username || User.email
    @user = User.find(params[:id])
    return if ! can_access @user

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @title = "Add User"
    @user = User.new
    return if ! can_access @user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @title = "Edit User"
    @user = User.find(params[:id])
    return if ! can_access @user
  end

  # POST /users
  # POST /users.json
  def create
    @title = "New User"
    @user = User.new(params[:user])
    return if ! can_access @user

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path,
                      notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @title = "Edit User"
    @user = User.find(params[:id])
    return if ! can_access @user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user,
                      notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @title = "Delete User"
    @user = User.find(params[:id])
    return if ! can_access @user
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
end
