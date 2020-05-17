require 'rails_helper'

RSpec.describe "Auths", type: :request do
	context 'POST Register' do
		it 'ensure name presence' do		
			post "/api/v1/register" , :params => {
													:password => '123456',
													:password_confirmation => '123456',
											        :email => Faker::Internet.unique.email,
											        :phone => Faker::PhoneNumber.cell_phone,
											        :birthday => Faker::Date.between(from: 40.years.ago, to: 20.years.ago),
											        :gender => (Faker::Gender.short_binary_type).upcase
											    }
			
			expect(response.content_type).to eq("application/json; charset=utf-8")
    		expect(response).to have_http_status(500)
		end

		it 'ensure email presence' do		
			post "/api/v1/register" , :params => {
													:name => Faker::Name.unique.name_with_middle,
													:password => '123456',
													:password_confirmation => '123456',
											        :phone => Faker::PhoneNumber.cell_phone,
											        :birthday => Faker::Date.between(from: 40.years.ago, to: 20.years.ago),
											        :gender => (Faker::Gender.short_binary_type).upcase
											    }
			
			expect(response.content_type).to eq("application/json; charset=utf-8")
    		expect(response).to have_http_status(500)
		end

		it 'ensure password and confirmation password are equal' do		
			post "/api/v1/register" , :params => {
													:name => Faker::Name.unique.name_with_middle,
													:password => '1234567',
													:password_confirmation => '123456',
											        :email => Faker::Internet.unique.email,
											        :phone => Faker::PhoneNumber.cell_phone,
											        :birthday => Faker::Date.between(from: 40.years.ago, to: 20.years.ago),
											        :gender => (Faker::Gender.short_binary_type).upcase
											    }
			
			expect(response.content_type).to eq("application/json; charset=utf-8")
    		expect(response).to have_http_status(500)
		end

		it 'returns a success response' do		
			post "/api/v1/register" , :params => {
													:name => Faker::Name.unique.name_with_middle,
													:password => '123456',
													:password_confirmation => '123456',
											        :email => Faker::Internet.unique.email,
											        :phone => Faker::PhoneNumber.cell_phone,
											        :birthday => Faker::Date.between(from: 40.years.ago, to: 20.years.ago),
											        :gender => (Faker::Gender.short_binary_type).upcase
											    }
			
			expect(response.content_type).to eq("application/json; charset=utf-8")
    		expect(response).to have_http_status(:ok)
		end
	end

	context 'POST Login' do
		it 'returns a failed response' do
			customer =  Customer.create(
		        name: Faker::Name.unique.name_with_middle,
		        password: '123456',
		        email: Faker::Internet.unique.email,
		        phone: Faker::PhoneNumber.cell_phone,
		        birthday: Faker::Date.between(from: 40.years.ago, to: 20.years.ago),
		        gender: (Faker::Gender.short_binary_type).upcase
		    )

			post "/api/v1/login" , :params => {
													:password => '1234567890',
													:email => customer.email,
											    }
			
			expect(response).to have_http_status(401)
		end

		it 'returns a success response' do
			customer =  Customer.create(
		        name: Faker::Name.unique.name_with_middle,
		        password: '123456',
		        email: Faker::Internet.unique.email,
		        phone: Faker::PhoneNumber.cell_phone,
		        birthday: Faker::Date.between(from: 40.years.ago, to: 20.years.ago),
		        gender: (Faker::Gender.short_binary_type).upcase
		    )

			post "/api/v1/login" , :params => {
													:password => '123456',
													:email => customer.email,
											    }
			
			expect(response.content_type).to eq("application/json; charset=utf-8")
    		expect(response).to have_http_status(:ok)
		end
	end
end
