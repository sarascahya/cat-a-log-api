class ApplicationController < ActionController::API
  def json_data(data, serializer_name = nil)
    ActiveModelSerializers::SerializableResource.new(data, serializer: serializer_name)
  end
end
