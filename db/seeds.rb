# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

require 'faker'

categories = Category.create([{name: 'Anak' }, { name: 'Bedah' }, {name:'Gigi'}, {name:'Jantung'},{name:'Mata'},{name:'Umum'} ])
hospitals = Hospital.create([{name: 'Rs. Ibu dan anak sehat', address: 'Jl. Jagakarsa Raya No.3 Jakarta Selatan'}, {name:'Rs. Mutiara Ananda', address: 'Jl. Harjosari No. 87 Jakarta Barat'}, {name: 'Rs Harapan Kita', address: 'Jl. Jambu Biji No. 33 Jakarta Utara'}])

10.times do
    doctor = Doctor.create(
        name: Faker::Name.unique.name_with_middle
    )

    DoctorCategory.create(
        doctor: doctor, category: categories[rand(6)]
    )
    
    fakerDate = Faker::Date.forward(days:14)
    fakerOpeningHour = Faker::Time.between_dates(from: fakerDate, to: fakerDate, period: :afternoon)
    fakerClosingHour = Faker::Time.between(from: fakerOpeningHour + 7200, to: fakerOpeningHour + 10800)
    DoctorSchedule.create(
        doctor: doctor, 
        hospital: hospitals[rand(3)],
        date: fakerDate, 
        start_time: fakerOpeningHour, 
        end_time: fakerClosingHour
    )
end

customer = Customer.create(
        name: 'Denny',
        password: '123456',
        email: 'dennyalvin23@gmail.com',
        phone: '0813412312333',
        birthday: Faker::Date.between(from: 40.years.ago, to: 20.years.ago),
        gender: 'M'
    )

20.times do
    customer = Customer.create(
        name: Faker::Name.unique.name_with_middle,
        password: '123456',
        email: Faker::Internet.unique.email,
        phone: Faker::PhoneNumber.cell_phone,
        birthday: Faker::Date.between(from: 40.years.ago, to: 20.years.ago),
        gender: (Faker::Gender.short_binary_type).upcase
    )
end


