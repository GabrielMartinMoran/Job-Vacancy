MAX_SUGGESTIONS = 3

class SuggestedOffers
  def initialize(job_offer)
    @job_offer_id = job_offer.id
    @main_offer_tags = job_offer.tags.split(',')
    @all_offers = Set.new
  end

  def obtain
    matches = obtain_matches
    inverted_matches = invert_hash(matches)
    generate_result(inverted_matches)
  end

  def add(job_offers)
    job_offers.each do |job_offer|
      @all_offers.add(job_offer) if @job_offer_id != job_offer.id && job_offer.is_active
    end
  end

  private

  def invert_hash(hash)
    inverted_hash = {}
    hash.each do |key, value|
      if inverted_hash.key?(value)
        inverted_hash[value] << key
      else
        inverted_hash[value] = [key]
      end
    end
    inverted_hash
  end

  def generate_result(inverted_matches)
    result = []
    unless inverted_matches.empty?
      tags = inverted_matches.keys.max
      (0..tags).reverse_each do |key|
        next if inverted_matches[key].nil?

        inverted_matches[key].each do |job_offer|
          result << job_offer
        end
      end
    end
    result.first(MAX_SUGGESTIONS)
  end

  def obtain_matches
    matches = {}
    @all_offers.each do |job_offer|
      job_offer_tags = job_offer.tags.split(',')
      job_offer_tags.each do |tag|
        if @main_offer_tags.include?(tag)
          if matches.key?(job_offer)
            matches[job_offer] += 1
          else
            matches[job_offer] = 1
          end
        end
      end
    end
    matches
  end
end
