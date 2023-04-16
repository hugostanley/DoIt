# frozen_string_literal: true

# LandingPageController
# Pages related to landing page.
# These are the public pages
class LandingPageController < ApplicationController
  def index
    redirect_to user_tasks_feed_path if session[:is_logged_in] == true
  end
end
