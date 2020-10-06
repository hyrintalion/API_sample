# frozen_string_literal: true

class Api::Base::ApplicationController < ActionController::Base
  def permitted_role!(_role)
    true
  end
end
