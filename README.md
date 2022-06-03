# What is Homeboy
Homeboy is a very simple reservations API app. It is capable of accepting (time of writing 2 varying payloads)
payloads and process it to create reservation and guest informations.

# Getting Started
### Clone this repo
```sh
$ git clone git@github.com:rgabriel01/homeboy.git
$ cd homeboy
```

### Installing Gems
**note** that you should be on the directory of the project before doing this step
**ruby version** version 2.7.0 is preferred along with Rails 7
Install bundler gem
```sh
$ gem install bundler
```
Install Rails
```sh
$ gem install bundler
```
Run bundler to install gems
```sh
$ bundle install
```

### Trying Out Rails Console
```sh
$ rails c
``` 

### actually starting this app
On the repo directory
```sh
$ rails s
```
# Under the hood
So, how does this work really.
It's very simple using a **post** type of request, a payload as parameters and the path **/reservations**
and you're ready to go

As of writing 2 payloads are supported
**Payload 1**
```json
{
    "reservation_code": "HHH12345678",
    "start_date": "2021-04-14",
    "end_date": "2021-04-18",
    "nights": 4,
    "guests": 4,
    "adults": 2,
    "children": 2,
    "infants": 0,
    "status": "accepted",
    "guest": {
        "first_name": "Wayne",
        "last_name": "Woodbridge",
        "phone": "639123456789",
        "email": "zeta@bnb.com"
    },
    "currency": "AUD",
    "payout_price": "4200.00",
    "security_price": "500",
    "total_price": "4700.00"
}
```
**Payload 2**
```json
{
    "reservation": {
        "code": "TYU12345678",
        "start_date": "2021-03-12",
        "end_date": "2021-03-16",
        "expected_payout_amount": "3800.00",
        "guest_details": {
            "localized_description": "4 guests",
            "number_of_adults": 2,
            "number_of_children": 2,
            "number_of_infants": 0
        },
        "guest_email": "dd@bnb.com",
        "guest_first_name": "Wayne",
        "guest_last_name": "Woodbridge",
        "guest_phone_numbers": [
            "639123456789",
            "639123456789"
        ],
        "listing_security_price_accurate": "500.00",
        "host_currency": "AUD",
        "nights": 4,
        "number_of_guests": 4,
        "status_type": "accepted",
        "total_paid_amount_accurate": "4300.00"
    }
}
```

Reponses are simple as well
**Success response**
```json
{
    "success": true,
    "data": {
        "guest": {
            "id": 6,
            "email": "dd@bnb.com",
            "first_name": "Wayne",
            "last_name": "Woodbridge",
            "created_at": "2022-06-03T11:18:36.466Z",
            "updated_at": "2022-06-03T11:18:36.466Z"
        },
        "reservation": {
            "id": 6,
            "code": "TYU12345678",
            "guest_id": 6,
            "start_date": "2021-03-12",
            "end_date": "2021-03-16",
            "nights": 4,
            "adult_guest_count": 2,
            "children_guest_count": 2,
            "infant_guest_count": 0,
            "security_price": "500.0",
            "payout_price": "3800.0",
            "total_price": "4300.0",
            "currency": "AUD",
            "status": "accepted",
            "created_at": "2022-06-03T11:18:36.477Z",
            "updated_at": "2022-06-03T11:18:36.477Z"
        }
    }
}
```
**Fail response**
```json
{
    "success": false,
    "data": {
        "error": "Invalid reservation payload format: code"
    }
}
```

# Happy Hacking!
