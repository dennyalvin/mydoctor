require 'jwt'

class Api::V1::AuthController < ApplicationController
	def register
		@customer = Customer.new()
		@customer.name = customer_params[:name]
		@customer.email = customer_params[:email]
		@customer.phone = customer_params[:phone]
		@customer.birthday = customer_params[:birthday]
		@customer.gender = customer_params[:gender]
		@customer.password = customer_params[:password]
		@customer.password_confirmation = customer_params[:password_confirmation]

		if @customer.save()
			return render json: @customer
		else
            return render json: {errors: @customer.errors.full_messages}
        end
	end

	def login
		@customer = Customer.find_by(email: customer_params[:email])
        if @customer.present? && @customer.authenticate(customer_params[:password])
            token = JWT.encode({id: @customer.id}, Rails.application.secrets.secret_key_base, 'HS256')
            return render json: {token: token}
		end

        head(:unauthorized)
	end

	private
        def customer_params
            params.permit(:name, :email, :phone, :gender, :birthday, :password, :password_confirmation)
        end
end
