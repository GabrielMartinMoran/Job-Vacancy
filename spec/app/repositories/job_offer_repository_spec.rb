require 'integration_spec_helper'

describe JobOfferRepository do
  let(:repository) { described_class.new }

  let(:owner) do
    user = User.new(name: 'Joe', email: 'joe@doe.com', crypted_password: 'secure_pwd',
                    short_bio: 'A' * 50)
    UserRepository.new.save(user)
    user
  end

  describe 'search_by_tags' do
    let!(:main_offer) do
      main_offer = JobOffer.new(title: 'a title',
                                updated_on: Date.today,
                                is_active: true,
                                user_id: owner.id, tags: 'programmer,web,ruby')
      repository.save(main_offer)
      main_offer
    end

    let!(:offer_programmer) do
      offer_programmer = JobOffer.new(title: 'a title',
                                      updated_on: Date.today,
                                      is_active: true,
                                      user_id: owner.id, tags: 'programmer')
      repository.save(offer_programmer)
      offer_programmer
    end

    let!(:offer_programmer_web) do
      offer_programmer_web = JobOffer.new(title: 'a title',
                                          updated_on: Date.today,
                                          is_active: true,
                                          user_id: owner.id, tags: 'programmer,web')
      repository.save(offer_programmer_web)
      offer_programmer_web
    end

    let!(:offer_programmer_web_ruby) do
      offer_programmer_web_ruby = JobOffer.new(title: 'a title',
                                               updated_on: Date.today,
                                               is_active: true,
                                               user_id: owner.id, tags: 'programmer,web,ruby')
      repository.save(offer_programmer_web_ruby)
      offer_programmer_web_ruby
    end

    let!(:offer_no_tags) do
      offer_no_tags = JobOffer.new(title: 'a title',
                                   updated_on: Date.today,
                                   is_active: true,
                                   user_id: owner.id)
      repository.save(offer_no_tags)
      offer_no_tags
    end

    let!(:offer_other_tags) do
      offer_other_tags = JobOffer.new(title: 'a title',
                                      updated_on: Date.today,
                                      is_active: true,
                                      user_id: owner.id, tags: 'python,whitespace,basic')
      repository.save(offer_other_tags)
      offer_other_tags
    end

    it 'should retrieve offers with tag matches' do
      result = repository.search_by_tags(main_offer.tags_list)
      offer_programmer_db = repository.find(offer_programmer.id)
      offer_programmer_web_db = repository.find(offer_programmer_web.id)
      offer_programmer_web_ruby_db = repository.find(offer_programmer_web_ruby.id)
      result_id = []
      result.each do |offer|
        result_id << offer.id
      end
      expect(result_id).to include(offer_programmer_db.id, offer_programmer_web_db.id, offer_programmer_web_ruby_db.id)
    end

    it 'should not retrieve offers with no tag matches' do
      result = repository.search_by_tags(main_offer.tags_list)
      offer_no_tags_db = repository.find(offer_no_tags.id)
      offer_other_tags_db = repository.find(offer_other_tags.id)
      main_offer_db = repository.find(offer_other_tags.id)
      result_id = []
      result.each do |offer|
        result_id << offer.id
      end
      expect(result_id).not_to include(offer_no_tags_db.id, offer_other_tags_db.id, main_offer_db.id)
    end
  end

  describe 'deactive_old_offers' do
    let!(:today_offer) do
      today_offer = JobOffer.new(title: 'a title',
                                 updated_on: Date.today,
                                 is_active: true,
                                 user_id: owner.id)
      repository.save(today_offer)
      today_offer
    end

    let!(:thirty_day_offer) do
      thirty_day_offer = JobOffer.new(title: 'a title',
                                      updated_on: Date.today - 45,
                                      is_active: true,
                                      user_id: owner.id)
      repository.save(thirty_day_offer)
      thirty_day_offer
    end

    it 'should deactivate offers updated 45 days ago' do
      repository.deactivate_old_offers

      updated_offer = repository.find(thirty_day_offer.id)
      expect(updated_offer.is_active).to eq false
    end

    it 'should not deactivate offers created today' do
      repository.deactivate_old_offers

      not_updated_offer = repository.find(today_offer.id)
      expect(not_updated_offer.is_active).to eq true
    end
  end

  describe 'find' do
    let!(:offer) do
      offer = JobOffer.new(title: 'a title',
                           updated_on: Date.today,
                           is_active: true,
                           user_id: owner.id, tags: 'programmer',
                           users_notified: true,
                           max_valid_date: Date.new(2019))
      repository.save(offer)
      offer
    end

    it 'should load users_notified' do
      obtained = repository.find(offer.id)
      expect(obtained.users_notified).to eq(offer.users_notified)
    end

    it 'should load max_valid_date' do
      obtained = repository.find(offer.id)
      expect(obtained.max_valid_date.to_s).to eq(offer.max_valid_date.to_s)
    end
  end

  describe 'all_showable' do
    let!(:showable_offer1) do
      showable_offer1 = JobOffer.new(title: 'a showable_offer1',
                                     updated_on: Date.today,
                                     is_active: true,
                                     user_id: owner.id)
      repository.save(showable_offer1)
      showable_offer1
    end

    let!(:showable_offer2) do
      showable_offer2 = JobOffer.new(title: 'a showable_offer2',
                                     updated_on: Date.today,
                                     is_active: true,
                                     user_id: owner.id,
                                     max_valid_date: Date.today + 10)
      repository.save(showable_offer2)
      showable_offer2
    end

    let!(:not_showable_offer1) do
      not_showable_offer1 = JobOffer.new(title: 'a not_showable_offer1',
                                         updated_on: Date.today,
                                         is_active: true,
                                         user_id: owner.id,
                                         max_valid_date: Date.today - 10)
      repository.save(not_showable_offer1)
      not_showable_offer1
    end

    let!(:not_showable_offer2) do
      not_showable_offer2 = JobOffer.new(title: 'a not_showable_offer2',
                                         updated_on: Date.today,
                                         is_active: false,
                                         user_id: owner.id,
                                         max_valid_date: Date.today + 10)
      repository.save(not_showable_offer2)
      not_showable_offer2
    end

    it 'should retrieve showable offers' do
      result = repository.all_showable
      not_showable_offer_1_db = repository.find(not_showable_offer1.id)
      not_showable_offer_2_db = repository.find(not_showable_offer2.id)
      showable_offer_1_db = repository.find(showable_offer1.id)
      showable_offer_2_db = repository.find(showable_offer2.id)
      result_id = []
      result.each { |offer| result_id << offer.title }
      expect(result_id).to include(showable_offer_1_db.title, showable_offer_2_db.title)
      expect(result_id).not_to include(not_showable_offer_1_db.title, not_showable_offer_2_db.title)
    end
  end
end
