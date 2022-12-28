class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :name, :created_at
end
