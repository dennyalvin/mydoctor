class Api::V1::DoctorController < ApplicationController
    def index
        @doctors = Doctor.all
        render json: @doctors
    end
end
