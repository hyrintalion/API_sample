# frozen_string_literal: true

class Api::Base::BannersController < Api::Base::ApplicationController
  # GET /show_user
  def show_user
    permitted_role!(:admin)
    user = User.find_by(params[:id])
    return render_api_result([error: 'User not found']) unless user

    render_api_result(UserRepresenter.new(user).to_hash)
  end

  # POST /add_user
  def add_user
    permitted_role!(:admin)
    result = User::Add.new.call(
      name: params[:name],
      email: params[:email]
    )
    RL.info("User::Add #{result.value_or(result.failure)}")
    raise ActionError, result.failure.symbolize_keys if result.failure?

    render_api_result(UserRepresenter.new(result.value!).to_hash)
  end
end
