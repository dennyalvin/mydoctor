class Api::V1::BookingController < ApplicationController
    before_action :authorize_request

    def index
        @bookings = Booking.where(customer_id: @current_user.id)
        render json: @bookings
    end

    def create

        # Check is valid customer
        @customer = Customer.find_by(id: @current_user.id)
        if @customer == nil
            return render json: {errors: ['Invalid Customer']}, status: :bad_request
        end

        # Check is valid Schedule
        schedule_id = booking_params[:doctor_schedule_id]
        @schedule = DoctorSchedule.find_by(id: schedule_id)
        if @schedule == nil
            return render json: {errors: ['Invalid Schedule']}, status: :bad_request
        end

        # Check was user already booked at same schedule
        is_already_booked = Booking.where(customer_id: @customer.id,schedule_date: @schedule.date, start_time: @schedule.start_time, end_time: @schedule.end_time).count
        if is_already_booked > 0
            return render json: {errors: ['You have booked on this schedule']}, status: :bad_request
        end

        # Check is Booking within 30 minutes before start schedule
        merged_datetime = DateTime.new(@schedule.date.year, @schedule.date.month,
                               @schedule.date.day, @schedule.start_time.hour,
                               @schedule.start_time.min, @schedule.start_time.sec,"+07")

        if (Time.now + 1800) > merged_datetime
            return render json: {errors: ['Please book 30 minutes before the schedule'] } , status: :bad_request
        end
        
        
        ActiveRecord::Base.transaction do
            # Check Doctor's Booking Count
            booking_count = Booking.where(doctor_id: @schedule.doctor_id, schedule_date: @schedule.date, start_time: @schedule.start_time, end_time: @schedule.end_time).count
            if booking_count >= 10
                return render json: {errors: ['Booking is full'] }, status: :bad_request
            end
        
            @booking = Booking.new()
            @booking.customer = @customer
            @booking.doctor = @schedule.doctor
            @booking.hospital = @schedule.hospital
            @booking.schedule_date = @schedule.date
            @booking.start_time = @schedule.start_time
            @booking.end_time = @schedule.end_time
            @booking.status = 'BOOKED'

            if @booking.save
                @booking_detail = BookingDetail.new()
                @booking_detail.booking = @booking
                @booking_detail.patient_name = booking_params[:patient_name]
                @booking_detail.email = booking_params[:email]
                @booking_detail.phone = booking_params[:phone]
                @booking_detail.birthday = booking_params[:birthday]
                @booking_detail.payment_type = booking_params[:payment_type]
                @booking_detail.notes = booking_params[:notes]

                if @booking_detail.save
                    return render json: @booking
                else
                    return render json: {errors: @booking_detail.errors.full_messages}, status: :bad_request
                end
            else
                return render json: {errors: @booking.errors.full_messages}, status: 500
            end
        end
    end

    private
        def booking_params
            params.permit(:doctor_schedule_id, :patient_name, :email, :phone, :birthday, :payment_type, :notes)
        end
end
