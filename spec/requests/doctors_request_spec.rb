require 'rails_helper'

RSpec.describe "Doctors", type: :request do
	categories = Category.create([{name: 'Anak' }, { name: 'Bedah' }, {name:'Gigi'}, {name:'Jantung'},{name:'Mata'},{name:'Umum'} ])
	
	10.times do
	    doctor = Doctor.create(
	        name: Faker::Name.unique.name_with_middle
	    )

	    DoctorCategory.create(
	        doctor: doctor, category: categories[rand(6)]
	    )
	    
	end

	context 'GET Doctors' do
		it 'should return doctors total records' do

			get "/api/v1/doctors" 

			expect(response.content_type).to eq("application/json; charset=utf-8")
    		expect(response).to have_http_status(200)
		end
	end
end
