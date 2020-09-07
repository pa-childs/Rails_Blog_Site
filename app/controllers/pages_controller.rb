# frozen_string_literal: true

# Controller that defines static pages
class PagesController < ApplicationController
  def home
    redirect_to articles_path if logged_in?
  end

  def about; end
end
