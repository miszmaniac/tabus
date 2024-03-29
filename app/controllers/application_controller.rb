# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

   before_filter :set_locale

  def set_locale
    I18n.locale = params[:locale] || :pl
  end

  def default_url_options(options={})
    { :locale => I18n.locale }
  end

end
