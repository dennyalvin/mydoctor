class Api::V1::DoctorScheduleController < ApplicationController
    def index
        @schedules = DoctorSchedule.all
        render json: @schedules
    end
end
