require 'rails_helper'
require 'faker'

RSpec.describe Booking, type: :model do
    context 'validation tests' do 
    	# Faker Customer
    	customer = Customer.create(
	        name: Faker::Name.unique.name_with_middle,
	        password: '123456',
	        email: Faker::Internet.unique.email,
	        phone: Faker::PhoneNumber.cell_phone,
	        birthday: Faker::Date.between(from: 40.years.ago, to: 20.years.ago),
	        gender: (Faker::Gender.short_binary_type).upcase
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
	        doctor: doctor, date: fakerDate, start_time: fakerOpeningHour, end_time: fakerClosingHour
	    )

		hospital = 	Hospital.create(
				    	name: Faker::Company.name,
				    	address: Faker::Address.full_address
				    )
        it 'ensures patient_name presence' do

        	booking = Booking.create(
        		customer: customer,
        		doctor: doctor,
        		hospital: hospital,
        		schedule_date: schedule.date,
            	start_time: schedule.start_time,
            	end_time: schedule.end_time,
            	status: 'BOOKED'
        	)

        	booking_detail = BookingDetail.new(
        		booking: booking,
                email: customer.email,
                phone: customer.phone,
                birthday: customer.birthday,
                payment_type: 'BPJS'
        	).save
            expect(booking_detail).to eq(false)
        end

        it 'ensures patient email presence' do

        	booking = Booking.create(
        		customer: customer,
        		doctor: doctor,
        		hospital: hospital,
        		schedule_date: schedule.date,
            	start_time: schedule.start_time,
            	end_time: schedule.end_time,
            	status: 'BOOKED'
        	)

        	booking_detail = BookingDetail.new(
        		booking: booking,
                patient_name: customer.name,
                phone: customer.phone,
                birthday: customer.birthday,
                payment_type: 'BPJS'
        	).save
            expect(booking_detail).to eq(false)
        end

        it 'ensures patient phone presence' do

        	booking = Booking.create(
        		customer: customer,
        		doctor: doctor,
        		hospital: hospital,
        		schedule_date: schedule.date,
            	start_time: schedule.start_time,
            	end_time: schedule.end_time,
            	status: 'BOOKED'
        	)

        	booking_detail = BookingDetail.new(
        		booking: booking,
                patient_name: customer.name,
                email: customer.email,
                birthday: customer.birthday,
                payment_type: 'BPJS'
        	).save
            expect(booking_detail).to eq(false)
        end

        it 'ensures patient birthday presence' do

        	booking = Booking.create(
        		customer: customer,
        		doctor: doctor,
        		hospital: hospital,
        		schedule_date: schedule.date,
            	start_time: schedule.start_time,
            	end_time: schedule.end_time,
            	status: 'BOOKED'
        	)

        	booking_detail = BookingDetail.new(
        		booking: booking,
                patient_name: customer.name,
                email: customer.email,
                phone: customer.phone,
                payment_type: 'BPJS'
        	).save
            expect(booking_detail).to eq(false)
        end

        it 'make booking successfully' do

        	booking = Booking.create(
        		customer: customer,
        		doctor: doctor,
        		hospital: hospital,
        		schedule_date: schedule.date,
            	start_time: schedule.start_time,
            	end_time: schedule.end_time,
            	status: 'BOOKED'
        	)

        	booking_detail = BookingDetail.new(
        		booking: booking,
                patient_name: customer.name,
                email: customer.email,
                phone: customer.phone,
                birthday: customer.birthday,
                payment_type: 'BPJS'
        	).save
            expect(booking_detail).to eq(true)
        end
    end
end
