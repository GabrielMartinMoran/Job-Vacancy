class SuggestedOffers
  def initialize(job_offer)
    @main_offer = job_offer
    @all_offers = []
  end

  def obtain
    []
  end

  def add(job_offers)
    job_offers.each { |job_offer| @all_offers.append(job_offer) }
  end
end
