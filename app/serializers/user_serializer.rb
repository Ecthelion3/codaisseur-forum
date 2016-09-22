class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :created_at, :updated_at, :authentication_token

  def authentication_token
    return object.authentication_token if instance_options[:prefixes].include?("devise")
  end
end
