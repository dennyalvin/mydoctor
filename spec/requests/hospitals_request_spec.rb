require 'rails_helper'

RSpec.describe "Hospitals", type: :request do
	
	10.times do
	    hospitals = Hospital.create(
	    	name: Faker::Company.name,
	    	address: Faker::Address.full_address
	    )
	    
	end

	context 'GET Hospitals' do
		it 'should return hospitals total records' do

			get "/api/v1/hospitals" 

			expect(response.content_type).to eq("application/json; charset=utf-8")
    		expect(response).to have_http_status(200)
		end
	end
end
