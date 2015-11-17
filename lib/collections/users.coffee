
Schemas.UserProfile = new SimpleSchema(

  picture:
    type: String
    optional:true
    label: -> TAPi18n.__ 'userProfilePicture'
    autoform:
      afFieldInput:
        type: 'fileUpload'
        collection: 'ProfilePictures'

  firstName:
    type: String
    optional: true
    label: -> TAPi18n.__ 'userFirstName'

  lastName:
    type: String
    optional: true
    label: -> TAPi18n.__ 'userLastName'

  birthday:
    type: Date
    optional: true
    label: -> TAPi18n.__ 'userBirthday'

  country:
    type: String
    optional: true
    label: -> TAPi18n.__ 'country'
    autoform: 
      options: ->        
        obj = {label: country, value: country} for country in Utils.countryList

  zipCode:
    type: String
    optional: true
    label: -> TAPi18n.__ 'zipCode'

  city:
    type: String
    optional: true
    label: -> TAPi18n.__ 'city'

  billingAddress:
    type: String
    optional: true
    label: -> TAPi18n.__ 'billingAddress'
    autoform: 
      rows: 3
)

Schemas.UserPhone = new SimpleSchema(
  number:
    type: String
    optional: true
    max: 15
    label: -> TAPi18n.__ 'userPhoneNumber'

  code:
    type: String
    optional: true
    label: -> TAPi18n.__ 'userPhoneCode'

  verified:
    type: Boolean
    optional:true
    label: -> TAPi18n.__ 'verified'
    defaultValue: false
)

# User schema
Schemas.User = new SimpleSchema
  emails:
    type: [Object]
    optional: true

  "emails.$.address":
    type: String
    regEx: SimpleSchema.RegEx.Email
    label: -> TAPi18n.__ 'email'

  "emails.$.verified":
    type: Boolean
    label: -> TAPi18n.__ 'userEmailVerified'

  createdAt:
    type: Date

  profile:
    type: Schemas.UserProfile
    defaultValue: {}

  phone:
    type: Schemas.UserPhone
    optional: true

  services:
    type: Object
    optional: true
    blackbox: true

  roles:
    type: [String]
    blackbox: true
    optional: true


Meteor.users.attachSchema Schemas.User

Meteor.users.helpers
  fullName: () ->
    (@profile.firstName || '')  + ' ' + (@profile.lastName || '')
  isAdmin: ->
    @roles.indexOf('admin') > -1
  isCustomer: ->
    @roles.indexOf('custmoer') > -1
  isBanned: ->
    @status == 'banned'
  email: ->
    @emails[0].address
  phoneNumber: ->
    @phone.number