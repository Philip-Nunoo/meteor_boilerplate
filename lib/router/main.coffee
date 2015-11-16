Router.map ->
  @route "home",
    path: "/"
    template: 'home'
    loadingTemplate: null
    layoutTemplate: "homeLayout"
    onBeforeAction: ->
        if Meteor.user()?
            @redirect 'dashboard'
        else
            @next()