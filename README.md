# Service Status

Service Status is a Ruby on Rails application that informs customers of whether Readme
is up or down along with a number of time stamped status messages.

## Running the application locally

* Clone this repository:
```
git clone git@github.com:anymoto/service_status.git
```

* Install the dependencies:
```
bundle install
```

* Create the database and run the migrations:
```
bundle exec rake db:create && bundle exec rake db:migrate
```

* Start your local server:
```
rails server
```

* Go to the [home page](http://localhost:3000)
The first time the application runs, your database will be empty, and you won't
see any status.

* The status and new messages can be updated from the command line using cURL. But first, you'll need to create a user and get your token in order to be able to post a new status:

In the Rails console type:
```
u = User.new(email: USER_EMAIL)
u.save!
u.authentication_token
```

Once you get your token, you'll be able to post a new service status, like this:
```
curl -H 'Authorization: Token token=USER_TOKEN' --data "status_message[status]=UP&status_message[message]=Service was restored" http://localhost:3000/api/v1/status_messages
```

* Once the status is stored, you will be able to see a populated list in the [home page](http://localhost:3000).

## API Reference

Locally, you will find the [API documentation here](http://localhost:3000/api).
