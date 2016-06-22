# Banlist

A simple application to track names of people who have been banned.

To start:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Online Demo

https://banlist.herokuapp.com/

Gaze upon the incredible security of the accounts below:

Admin:

* Username: admin@substratalcode.com
* Password: password

Normal:

* Username: test@substratalcode.com
* Password: password

## To Do

- [x] Banned schema
- [x] Banned controller and views
- [x] Banned list
- [ ] Search list
- [x] Users
- [x] User authentication
- [ ] User authorization (admin, non-admin)
- [ ] Sass compiling
- [ ] Explore Brunch
