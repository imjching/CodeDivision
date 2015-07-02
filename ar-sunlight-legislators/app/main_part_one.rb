require_relative 'models/CongressMember'
require_relative 'models/Sen'
require_relative 'models/Rep'
require_relative 'models/Com'
require_relative 'models/Del'

def members_state_order_by_last_name(input_state)
    results = ""

    results << "Senators:\n"
    senators = Sen.where(state: input_state).order(:lastname)
    senators.each do |member|
        results << "  #{member.firstname} #{member.lastname} (#{member.party})\n"
    end

    results << "Representatives:\n"
    senators = Rep.where(state: input_state).order(:lastname)
    senators.each do |member|
        results << "  #{member.firstname} #{member.lastname} (#{member.party})\n"
    end

    results
end

def percentage_gender_active(input_gender)
    results = ""

    senators = Sen.where(in_office: 1)
    senators_gender = senators.where(gender: input_gender == "M" ? 1 : 0).count
    results << "Male Senators: #{senators_gender} (#{100 * senators_gender / senators.count}%)\n"

    representatives = Rep.where(in_office: 1)
    representatives_gender = representatives.where(gender: input_gender == "M" ? 1 : 0).count
    results << "Male Representatives: #{representatives_gender} (#{100 * representatives_gender / representatives.count}%)\n"

    results
end

def states_list_active_order_by_count
    results = ""

    CongressMember.where(in_office: 1).group(:state).order("COUNT(*) DESC").count.keys.each do |key|
        senators_count = Sen.where(state: key, in_office: 1).count
        representatives_count = Rep.where(state: key, in_office: 1).count
        results << "#{key}: #{senators_count} Senators, #{representatives_count} Representative(s)\n"
    end

    results
end

def members_count
    results = ""

    senators_count = Sen.count
    representatives_count = Rep.count

    results << "Senators: #{senators_count}\n"
    results << "Representatives: #{representatives_count}"

    results
end

def delete_inactive_members
    CongressMember.destroy_all(in_office: 0)
end

puts members_state_order_by_last_name('CA')
puts percentage_gender_active('M')
puts states_list_active_order_by_count
puts members_count
delete_inactive_members
puts members_count