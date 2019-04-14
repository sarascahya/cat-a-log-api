class ApplicationSerializer < ActiveModel::Serializer
  def json_data(data, serializer_name = nil)
    ActiveModelSerializers::SerializableResource.new(data, serializer: serializer_name).as_json
  end
end
