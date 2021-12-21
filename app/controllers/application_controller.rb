class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found

  def render_not_found
    render 'public/404,html.erb'
  end
end
