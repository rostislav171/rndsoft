# app/controllers/statistics_controller.rb
class StatisticsController < ApplicationController
  def index
    @users = User.all
  end
end
