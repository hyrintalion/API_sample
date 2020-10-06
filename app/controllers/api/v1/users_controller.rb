class Api::V1::BannersController < Api::Base::BannersController
  # POST /add_user
  def add_user
    permitted_role!(:admin)
    result = User::Add.new.call(
      name: params[:name],
      email: params[:email],
      will_be_active: (Time.zone.now - 1.year).to_i
    )
    RL.info("User::Add #{result.value_or(result.failure)}")
    raise ActionError, result.failure.symbolize_keys if result.failure?

    render_api_result(UserRepresenter.new(result.value!).to_hash)
  end
end
