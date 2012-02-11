class Admin::SignOutsController < ApplicationController
  # GET /admin/sign_outs
  # GET /admin/sign_outs.json
  def index
    @admin_sign_outs = Admin::SignOut.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_sign_outs }
    end
  end

  # GET /admin/sign_outs/1
  # GET /admin/sign_outs/1.json
  def show
    @admin_sign_out = Admin::SignOut.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_sign_out }
    end
  end

  # GET /admin/sign_outs/new
  # GET /admin/sign_outs/new.json
  def new
    @admin_sign_out = Admin::SignOut.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_sign_out }
    end
  end

  # GET /admin/sign_outs/1/edit
  def edit
    @admin_sign_out = Admin::SignOut.find(params[:id])
  end

  # POST /admin/sign_outs
  # POST /admin/sign_outs.json
  def create
    @admin_sign_out = Admin::SignOut.new(params[:admin_sign_out])

    respond_to do |format|
      if @admin_sign_out.save
        format.html { redirect_to @admin_sign_out, notice: 'Sign out was successfully created.' }
        format.json { render json: @admin_sign_out, status: :created, location: @admin_sign_out }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_sign_out.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/sign_outs/1
  # PUT /admin/sign_outs/1.json
  def update
    @admin_sign_out = Admin::SignOut.find(params[:id])

    respond_to do |format|
      if @admin_sign_out.update_attributes(params[:admin_sign_out])
        format.html { redirect_to @admin_sign_out, notice: 'Sign out was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_sign_out.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/sign_outs/1
  # DELETE /admin/sign_outs/1.json
  def destroy
    @admin_sign_out = Admin::SignOut.find(params[:id])
    @admin_sign_out.destroy

    respond_to do |format|
      format.html { redirect_to admin_sign_outs_url }
      format.json { head :ok }
    end
  end
end
