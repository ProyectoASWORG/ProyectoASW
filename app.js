{
  "environments": {
    "test": {
      "addons":[
         "heroku-redis",
         "heroku-postgresql"
      ]
    }
  },
  "env":{
    "RAILS_ENV": "production",
    "RACK_ENV": "production",
    "RAILS_SERVE_STATIC_FILES": "true"
  }
}
