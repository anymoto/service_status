# Litmus Status

Litmus Status is a Ruby on Rails application that informs customers of whether Litmus
is up or down along with a number of time stamped status messages.

## Running the application locally

* Clone this repository:
```
git clone git@github.com:anymoto/litmus_status.git
```

* Create the database and run the migrations:
```
bundle exec rake db:create && bundle exec rake db:migrate
```

* Install the dependencies:
```
bundle install
```

* Start your local server:
```
rails server
```

* Go to the [home page](http://localhost:3000)
The first time the application runs, your database will be empty, and you won't
see any status.

* The status and new messages can be updated from the command line using cURL:
```
curl --data "status_message[status]=UP&status_message[message]=Service was restored" http://localhost:3000/api/v1/status_messages
```

* Once the status is stored, you will be able to see a populated list in the [home page](http://localhost:3000).

## API Reference

Locally, you will find the [API documentation here](http://localhost:3000/api).
