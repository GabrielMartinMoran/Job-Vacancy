class SuggestedOffers
  def initialize(job_offer)
    @main_offer = job_offer
    @all_offers = []
  end

  def obtain
    result = []
    @all_offers.each do |job_offer|
      result.append(job_offer) if job_offer.tags == @main_offer.tags
    end
    result
  end

  def add(job_offers)
    job_offers.each { |job_offer| @all_offers.append(job_offer) }
  end
end
