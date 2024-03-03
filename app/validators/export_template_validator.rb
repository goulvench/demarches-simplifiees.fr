class ExportTemplateValidator < ActiveModel::Validator
  def validate(record)
    validate_default_dossier_directory(record)
    validate_tiptap_attribute(record, :pdf_name)
    validate_pjs(record)
  end

  private

  def validate_default_dossier_directory(record)
    mention = attribute_content_mention(record, :default_dossier_directory)
    if mention&.fetch("id", nil) != "dossier_number"
      record.errors.add :default_dossier_directory, 'doit contenir le numéro de dossier'
    end
  end

  def validate_tiptap_attribute(record, attribute)
    if attribute_content_text(record, attribute).blank? && attribute_content_mention(record, attribute).blank?
      record.errors.add attribute, 'must not be blank'
    end
  end

  def attribute_content_text(record, attribute)
    attribute_content(record, attribute)&.find{|elem| elem["type"] == "text"}&.fetch("text", nil)
  end

  def attribute_content_mention(record, attribute)
    attribute_content(record, attribute)&.find{|elem| elem["type"] == "mention"}&.fetch("attrs", nil)
  end

  def attribute_content(record, attribute)
    record.content[attribute.to_s]&.fetch("content", nil)&.first&.fetch("content", nil)
  end

  def validate_pjs(record)
    record.content["pjs"]&.each do |pj|
      pj_sym = pj.symbolize_keys
      validate_content(record, pj_sym[:path], "pj_#{pj_sym[:stable_id]}".to_sym)
    end
  end

  def validate_content(record, attribute_content, attribute)
    if attribute_content.nil? || attribute_content["content"].nil? ||
        attribute_content["content"].first.nil? ||
        attribute_content["content"].first["content"].nil? ||
        (attribute_content["content"].first["content"].find{|elem| elem["text"].blank? } && attribute_content["content"].first["content"].find{|elem| elem["type"] == "mention"}["attrs"].blank?)
      record.errors.add attribute, 'must not be blank'
    end
  end
end
