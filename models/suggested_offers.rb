MAX_SUGGESTIONS = 3

class SuggestedOffers
  def initialize(job_offer)
    @main_offer_tags = job_offer.tags.split(',')
    @all_offers = []
  end

  def obtain
    result = Set.new
    @all_offers.each do |job_offer|
      job_offer_tags = job_offer.tags.split(',')
      job_offer_tags.each do |tag|
        result.add(job_offer) if @main_offer_tags.include?(tag) && result.size < MAX_SUGGESTIONS
      end
    end
    result.to_a
  end

  def add(job_offers)
    job_offers.each { |job_offer| @all_offers.append(job_offer) }
  end
end
