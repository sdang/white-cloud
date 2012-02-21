class SignOutController < ApplicationController
  before_filter :authenticate_user!, :authorized_user!
  def index
  end

end
