class DoctorSerializer < ActiveModel::Serializer
  attributes :id, :name, :categories

  def categories
      object.doctor_category.map do |cat|      		
      	{
      		id:cat.id,
      		category_id:cat.category_id,
      		category_name:cat.category.name
      	}
      end
  end
end
