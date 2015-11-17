@CustomerController = RouteController.extend
  layoutTemplate: 'customerLayout'
  onBeforeAction: ->
    unless Meteor.user()
      @redirect '/'
    else
        @next()

Router.map ->
  @route "dashboard",
    path: "/dashboard"
    template: "dashboard"
    controller: 'CustomerController'
    data: ->
      
    onAfterAction: ->
      # Session.set 'title', TAPi18n.__ 'titleCustomerDashboard'
