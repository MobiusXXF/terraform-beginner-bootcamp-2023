# Week 2 - Connecting to TerraTowns
<ins>Table of Contents</ins>
- []()

## Working with Ruby

### Bundler

Bundler is package manager for Ruby and it is the primary way to install Ruby packagaes, known as gems, for Ruby.

### Install Gems

You need to create a Gemfile and define your gems in that file.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the  `bundle install` command

This will install the gems on the system globally (unlike node.js which installs packages in place in a folder caled node_modules)

A Gemfile.lock will be create to lock in the Gem versios used in this project.

### Executing Ruby scripts w/ bundler

We use `bundle exec` to tell future ruby scriots to use the hems we installed. This is the way we set context.

### Sinatra

Sinatra us a micro-web framework for ruby to build web apps. Great for mock or dec server or for very simple projects. Allowing you to create a web server in a single file.

[Sinatra Ruby](https://sinatrarb.com/)

## Terratowns Mock Server

### Running the Web Server

We can run the web server by executing the follwoing commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in the `server.rb` file.