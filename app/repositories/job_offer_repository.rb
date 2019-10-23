class JobOfferRepository < BaseRepository
  self.table_name = :job_offers
  self.model_class = 'JobOffer'

  def all_active
    load_collection dataset.where(is_active: true)
  end

  def find_by_owner(user)
    load_collection dataset.where(user_id: user.id)
  end

  def deactivate_old_offers
    all_active.each do |offer|
      if offer.old_offer?
        offer.deactivate
        update(offer)
      end
    end
  end

  def search_by_tags(tags)
    tags_array = tags.split(',')
    return [] if tags_array.empty?

    seq = Sequel.like(:tags, "%#{tags_array[0]}%")
    if tags_array.size > 1
      (1..(tags_array.size - 1)).each do |index|
        seq |= Sequel.like(:tags, "%#{tags_array[index]}%")
      end
    end
    load_collection dataset.where(seq)
  end

  def search_by_title(title)
    load_collection dataset.where(Sequel.like(:title, "%#{title}%"))
  end

  protected

  def load_object(a_record)
    job_offer = super
    # TODO: Eager load user to avoid N+1 queries
    user = UserRepository.new.find(job_offer.user_id)
    job_offer.owner = user
    job_offer
  end

  def changeset(offer)
    {
      title: offer.title,
      location: offer.location,
      description: offer.description,
      tags: offer.tags,
      is_active: offer.is_active,
      user_id: offer.owner&.id || offer.user_id
    }
  end
end
