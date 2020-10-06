class UserRepresenter < Representable::Decorator
  include Representable::Hash
  include Representable::Hash::AllowSymbols

  property :id
  property :email
  property :name
  property :avatar

  def avatar
    # from another model
    represented.avatar
  end
end
