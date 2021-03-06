# CodeDivision Bootcamp

This repository is a collection of the challenges and projects I've written throughout my 9-weeks [Code Division Bootcamp](http://codedivision.academy/).

## Curriculum Highlights

| Week | Description |
| ---- | ----------- |
| 1 | Introduction to Programming with Ruby (writing instructions computers can understand) |
| 2 | Object-oriented Design (modelling real world object in code) |
| 3 | Databases (storing data for persistence) |
| 4 | Web Fundamentals (understand how the web works and how to write simple dynamic applications like Bit.ly, Twitter, etc.) |
| 5 | Web Frontend (make your app beautiful, useable and interactive) |
| 6 | Production Web Apps (learn to build robust real-world apps that communicate with external services such as Facebook, Twitter and more) |
| 7 | Rails Crash Course (learn one of the most popular frameworks used by many popular companies such as Groupon, Twitter, Shopify, Github and more!) |
| 8 - 9 | Build your own idea in a team |

### Final Project
**Psstt.me**: An anonymous, targeted opinion-sourcing platform. 

Live demo: http://pssttme.herokuapp.com/ . 

This project was then converted into a start-up which can be seen [here](https://pssttme-beta.herokuapp.com/)

### Extra
Throughout my journey of this bootcamp, I've experienced issues with installing Ruby as well as Rails on a Windows machine. Hence, I've created a `box` for Vagrant. 

> Vagrant provides a simple, elegant way to manage and provision Virtual Machines.

This Vagrant `box` includes
- Ubuntu 14.04 (32-bit)
- Ruby 2.2.0 (With rubygems, and bundler)
- Ruby on Rails 4.2.0
- Git
- SQLite3
- Redis
- Postgres
- NodeJS: executable Javascript runtime for Rails
- Nokogiri dependencies (libxml2, libxml2-dev, libxslt1-dev)

You can refer to the documentation [here](https://gist.github.com/imJChing/be0467043838565497b0)

You may experience slow page load while using Vagrant on Windows due to shared folders. A fix for this would be to use [WinSCP](https://winscp.net/eng/download.php) and connect to your Vagrant host. Then, utilize its [Keep Remote Directory up to Date](https://winscp.net/eng/docs/task_keep_up_to_date) feature to synchronize your local files with your VM files.
