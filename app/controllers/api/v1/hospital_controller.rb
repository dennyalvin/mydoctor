class Api::V1::HospitalController < ApplicationController
    def index
        @hospitals = Hospital.all
        render json: @hospitals
    end
end
