# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version : ruby 2.5.1p57

* Rails version : Rails 6.0.3

* Yarn version : 1.22.4

* System dependencies : mysql2

* Configuration
```bash
Set Database config on config/database/database.yml
```

* How to run the test suite
```bash
$ bundle exec rspec
```

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
```bash
$ rails db:create db:migrate db:seed
$ rails s
```

* EndPoints

```
GET '/doctors' : to see all available doctors

GET '/schedules' : to see all available doctor's schedule

GET '/hospitals', : to see all available hospitals

POST '/register', to make a registration
Payload: 
{
	"name" : "Jaqcluine",
	"email" :"jaqs@gmail.com",
	"phone" : "+62823155222222",
	"birthday" : "2008-12-02",
	"gender" : "F",
	"password" : "123456",
	"password_confirmation" : "123456"
}

POST '/login', to make login
Payload:
{
	"email" : "dennyalvin23@gmail.com",
	"password" : "123456"
}

POST '/bookings/create' : to make booking Doctor's Schedule (Must be logged in user)
Payload:
{
	"doctor_schedule_id" : 1,
	"patient_name" : "Denny",
	"email" : "denny@gmail.com",
	"phone" : "0811232123",
	"birthday" : "23-12-1989",
	"payment_type": "BPJS",
	"notes" : "Please ontime"
}

GET '/bookings' : to get Logged in Customer's Booking
```