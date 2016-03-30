README
==

Description
===
An app to send emails newsletter-style:
* Automatically failover to a second email sending service if the first one fails
* Recipients has and belongs to many Campaigns and vice versa, so user can add multiple recipients to each campaign. Each recipient will receive a separate email.
* Use dynamic recipient variables in campaign email body:
 * |first_name|
 * |last_name|
 * |salutation|
 * |email_address|
* Add and send campaign immediately or save draft and send later (sent campaigns show time sent)

Technology used
===
* Mailgun and Mandrill API to send emails
* ember-cli-rails gem to integrate ember cli and rails in one project
 * Easy deployment
 * End to end integration tests (was not able to get this to work on my app with capybara)
* Rails 4.2.5
* Ember 2.4
* Postgres db
* JSONAPI format as this is heavily recommended by both Ember and ActiveModelSerializer (AMS). HABTM relationships have difficulties with using the normal active model adapter for Rails and Ember (causes recursive infinite loop)
 * Used AMS 10.0rc4 (latest version) since JSONAPI support was added in 10.0 and deserialization support for JSONAPI was added in release candidate 4.
 * Used ember ajax 2.0 beta version as it has support for sending data in JSONAPI format with custom ajax requests

Todo
===
* Currently only have passing Rails tests. Ember tests are not working at all. Must write and have passing unit tests at least for all button actions.
* Capybara is not able to recognize the ember templates so end-to-end integration tests don't work. Fix this and uncomment capybara feature tests.
* Refactor code to make it more DRY. For example new and edit for both campaigns and recipients on the front-end are virtually the same. Can use mixins and partials to reduce the amount of code necessary.
* Fix bug where Ember makes secondary ajax request to show controller after destroying a record. This might be an ember data bug since app is using beta version.
* Fix bug where refreshing on page leads to json output. This is due to Ember not using the "/#/" format in url changes.
* Allow user to register, login, and add credentials for their own Mailgun and Mandrill account.
