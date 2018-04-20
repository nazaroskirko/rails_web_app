module ApplicationHelper
  def full_title(page_title = '')
    base_title = "Patient Notes"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def get_tag_type_type stripe_missing_item
    if stripe_missing_item == "legal_entity.type"
      select_tag stripe_missing_item.to_sym, options_for_select(["Individual", "Company"]), prompt:"Select One..."
    elsif stripe_missing_item == "legal_entity.dob.month" || stripe_missing_item == "legal_entity.dob.year" || stripe_missing_item == "tos_acceptance.ip"
      return ""
    elsif stripe_missing_item == "legal_entity.dob.day"
      date_field_tag stripe_missing_item.to_sym 
    elsif stripe_missing_item == "tos_acceptance.date"
      check_box_tag stripe_missing_item.to_sym
    elsif stripe_missing_item == "legal_entity.address.state"
      select_tag stripe_missing_item.to_sym, options_for_select(Address::STATES), prompt:"Select State..."
    else
      text_field_tag stripe_missing_item.to_sym, nil, class:"form-control"
    end
  end

  def get_label_tag field
  field_dictionary = {"legal_entity.type": "Entity Type",
  "legal_entity.dob.day": "Birthday of Business Owner",
  "legal_entity.dob.month": "",
  "legal_entity.dob.year": "",
  "legal_entity.first_name": "Business Owner First Name",
  "legal_entity.last_name": "Business Owner Last Name",
  "tos_acceptance.date": "Accept Terms of Service",
  "tos_acceptance.ip": "",
  "legal_entity.address.city": "City",
  "legal_entity.address.line1": "Address",
  "legal_entity.address.postal_code": "Zip Code",
  "legal_entity.address.state": "State",
  "legal_entity.ssn_last_4": "Confirm Last 4 of Business Owner's SSN",
  "legal_entity.personal_id_number": "Social Security Number",
  "legal_entity.business_name": "Business Name",
  "legal_entity.business_tax_id": "Business Tax ID",
  "legal_entity.verification.document": "Picture of Business owner Passport or License"}
  unless field_dictionary[field.to_sym].empty?
    label_tag field.to_sym, field_dictionary[field.to_sym]
  else
    return ""
  end
end
end
