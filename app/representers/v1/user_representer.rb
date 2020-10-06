class V1::UserRepresenter < Representable::Decorator
  include Representable::Hash
  include Representable::Hash::AllowSymbols

  property :id
  property :email
  property :name
  property :avatar
  property :will_be_active

  def avatar
    # from another model
    represented.avatar
  end

end
