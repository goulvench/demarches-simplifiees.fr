class Champs::RepetitionChamp < Champ
  has_many :champs, -> { ordered }, foreign_key: :parent_id, dependent: :destroy

  accepts_nested_attributes_for :champs, allow_destroy: true

  def rows
    champs.group_by(&:row).values
  end

  def search_terms
    # The user cannot enter any information here so it doesn’t make much sense to search
  end
end
