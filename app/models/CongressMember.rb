require_relative '../../db/config'

class CongressMember < ActiveRecord::Base

# Looking at the data, figure out what is the best way to model it. Consider the following requirements:

# Given a state, I can obtain a list of representatives in the House for that state.
# Given a state, I can obtain the two senators for that state.
# Given a political party, I can obtain a list of senators with that party affiliation.
# Given a political party, I can obtain a list of representatives in the House with that party affiliation.
# Given a senator or representative, I can obtain any of the following attributes: name, phone, fax, website, webform(for email), party affiliation, gender, birthdate, and twitter_id.
# Given a senator or representative, I can determine whether s/he is currently actively in office.
# Before you begin, think carefully about how to best use ActiveRecord to model things. How many tables do you need? How many models? Does each model have its own table? What kind of validations (if any) should there be on the models?

end