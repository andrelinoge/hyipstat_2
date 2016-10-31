class Admin::ApplicationController < ApplicationController
  before_action :set_default_locale

  layout 'admin'


  private

  def set_default_locale
    FastGettext.locale = 'ru'
  end
end
