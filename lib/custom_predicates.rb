# frozen_string_literal: true

module CustomPredicates
  include Dry::Logic::Predicates

  predicate(:email?) do |value|
    return false unless value.is_a?(String)

    regex = /^([a-zA-Z0-9_\-\.\$\^\%\+]{1,63})@([a-zA-Z0-9_\-]{1,63})(\.[a-zA-Z]{2})*\.([a-zA-Z]{2,11})$/
    !regex.match(value).nil? && value.length < 255
  end

  predicate(:some_another_predicate) do |value|
    !/^([a-z0-9а-я]+(-[a-z0-9а-я]+)*\.)+[a-zа-я]{2,}$/.match(value).nil?
  end
end
