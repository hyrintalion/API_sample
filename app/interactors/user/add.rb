# frozen_string_literal: true

class User::Add < ApplicationInteractor
  include Dry::Transaction

  Schema = Dry::Validation.Schema do
    configure do
      config.messages = :i18n
      predicates(CustomPredicates)
    end

    required(:name).value(:filled?)
    required(:email).value(:str?, :email?)
  end

  step :validate
  step :check_email_duplicates
  step :some_other_actions
  step :add_email
  map :you_can_add_logs_here

  # @input name [User] - user name
  # @input email [User] - user email

  def validate(input)
    input = input.to_hash.deep_symbolize_keys! if input.is_a?(Hash)

    result = schema.call(input)
    return Success(result.to_h) if result.success?

    field = result.errors.keys.first
    Failure(::Errors::FieldFormatError.new(field, result.errors[field].first).to_h)
  end

  def check_email_duplicates(input)
    users_with_same_email = User.find_by(email: input[:email], email_verify: true)
    if users_with_same_email.present?
      Failure(
        result: 'AlreadyExistsError',
        text: I18n.t!('errors.already_exists_email_error', locale: :en),
        description: 'email is already verified for another user'
      )
    else
      Success(input)
    end
  end

  def some_other_actions(input)
    Success(input)
  end

  def add_user(input)
    input[:user] = User.create!(input)
    Success(input)
  end

  def you_can_add_logs_here(input)
    add_complicated_log(with_some_data)
  end

  private

  def add_complicated_log(_with_some_data)
    true
  end
end
