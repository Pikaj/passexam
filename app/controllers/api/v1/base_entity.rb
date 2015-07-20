class API::V1::BaseEntity < Grape::Entity
  format_with(:string) { |val| val.to_s }
  format_with(:integer) { |val| val.to_i }
  format_with(:float) { |val| val.to_f }
  format_with(:bool) { |val| to_boolean(val) }
  format_with(:array) { |val| val.to_a }
end

def to_boolean(str)
  str == 'true' or str == true
end
