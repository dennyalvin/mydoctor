require 'rails_helper'

RSpec.describe "Bookings", type: :request do
	def authenticated_header
		customer =  Customer.create(
	        name: Faker::Name.unique.name_with_middle,
	        password: '123456',
	        email: Faker::Internet.unique.email,
	        phone: Faker::PhoneNumber.cell_phone,
	        birthday: Faker::Date.between(from: 40.years.ago, to: 20.years.ago),
	        gender: (Faker::Gender.short_binary_type).upcase
	    )

		token = JsonWebToken.encode({id: customer.id})
		{ 'Authorization': "#{token}" }
	end

	context 'GET Booking' do

		it 'returns unauthorized' do
			get "/api/v1/bookings"
			expect(response).to have_http_status(:unauthorized)			
		end

		it 'returns a success response' do			

			get "/api/v1/bookings", headers: authenticated_header
			
			expect(response.content_type).to eq("application/json; charset=utf-8")
    		expect(response).to have_http_status(:ok)
		end
	end

	context 'POST Create Booking' do

		it 'returns unauthorized' do
			post "/api/v1/bookings/create"
			expect(response).to have_http_status(:unauthorized)			
		end

		it 'ensure Customer has not made booking at same schedule' do
			#Faker Hospital
			hospital = 	Hospital.create(
					    	name: Faker::Company.name,
					    	address: Faker::Address.full_address
					    )

			#Faker Doctor
			doctor = Doctor.create(
		        name: Faker::Name.unique.name_with_middle
		    )
		    
		    fakerDate = Faker::Date.forward(days:14)
		    fakerOpeningHour = Faker::Time.between_dates(from: fakerDate, to: fakerDate, period: :afternoon)
		    fakerClosingHour = Faker::Time.between(from: fakerOpeningHour + 7200, to: fakerOpeningHour + 10800)

		    #Faker Doctor Schedule
		    schedule = DoctorSchedule.create(
		        doctor: doctor,
		        hospital: hospital,
		        date: fakerDate,
		        start_time: fakerOpeningHour,
		        end_time: fakerClosingHour
		    )

			
		    #First Booking
			post "/api/v1/bookings/create", headers: authenticated_header, :params => {:doctor_schedule_id => schedule.id , :patient_name => 'Hendra', :email => 'hendra@email.com', :phone => '0811112323', :birthday => '23-12-1989', :payment_type => 'BPJS' , :notes => 'Please ontime'}
			#expect(response.content_type).to eq("application/json; charset=utf-8")
    		#expect(response).to have_http_status(200)

			#Second Booking
			post "/api/v1/bookings/create", headers: authenticated_header, :params => {:doctor_schedule_id => schedule.id , :patient_name => 'Other Hendra', :email => 'other.hendra33@email.com', :phone => '087723323883', :birthday => '12-12-1990', :payment_type => 'Insurance' , :notes => 'Please ontime'}
            
			expect(response.content_type).to eq("application/json; charset=utf-8")
    		expect(response).to have_http_status(200)
		end

		it 'returns a success booking response' do
			#Faker Hospital
			hospital = 	Hospital.create(
					    	name: Faker::Company.name,
					    	address: Faker::Address.full_address
					    )

			#Faker Doctor
			doctor = Doctor.create(
		        name: Faker::Name.unique.name_with_middle
		    )
		    
		    fakerDate = Faker::Date.forward(days:14)
		    fakerOpeningHour = Faker::Time.between_dates(from: fakerDate, to: fakerDate, period: :afternoon)
		    fakerClosingHour = Faker::Time.between(from: fakerOpeningHour + 7200, to: fakerOpeningHour + 10800)

		    #Faker Doctor Schedule
		    schedule = DoctorSchedule.create(
		    	hospital: hospital,
		        doctor: doctor, date: fakerDate, start_time: fakerOpeningHour, end_time: fakerClosingHour
		    )

			post "/api/v1/bookings/create", headers: authenticated_header, :params => {:doctor_schedule_id => schedule.id , :patient_name => 'Hendra', :email => 'hendra@email.com', :phone => '0811112323', :birthday => '23-12-1989', :payment_type => 'BPJS' , :notes => 'Please ontime'}
            
			expect(response.content_type).to eq("application/json; charset=utf-8")
    		expect(response).to have_http_status(:ok)
		end
	end
end
