class Admin::DashboardController < ApplicationController
  layout "admin.html.erb"
  def index
  end
  http_basic_authenticate_with :name => ENV["CP_USER"], :password => ENV["CP_PASSWORD"]

end
