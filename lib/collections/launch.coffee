@Launch = new Mongo.Collection 'launch'

Schemas.Launch = new SimpleSchema(
    owner:
        type: String
        label: -> TAPi18n.__ 'owner'
        autoValue: ->
            if this.isInsert
                Meteor.userId()
        regEx: SimpleSchema.RegEx.Id
        autoform: 
            omit: true

    createdAt:
        type: Date
        autoValue: ->
            new Date() if @isInsert
        autoform: 
            omit: true

    title:
        type: String
        label: -> TAPi18n.__ 'title'
        optional: false

    content:
        type: String
        label: -> TAPi18n.__ 'description'
        autoform:
            rows: 3
        optional: false
        custom: ->
            if @isUpdate and not @value
                return 'required'

    industry:
        type: [String]
        label: -> TAPi18n.__ 'industry'

    founders:
        type: String
        label: -> TAPi18n.__ 'founders'

    launchDate:
        type: Date
        label: -> TAPi18n.__ 'launchDate'
)

Launch.attachSchema Schemas.Launch