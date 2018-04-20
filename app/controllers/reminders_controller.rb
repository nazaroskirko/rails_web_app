class RemindersController < ApplicationController
  before_action :logged_in_user
  def connection

    respond_to do |format|
      format.js {}
    end
  end
end
