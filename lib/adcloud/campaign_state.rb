class CampaignState
  STATES = {
    :inactive => 0,
    :online => 1,
    :offer => 2,
    :rejected => 3,
    :accepted => 4,
    :awaiting_approval => 5,
    :paused => 6,
    :ended => 7,
    :billed => 9,
    :paid => 10,
    :approved => 11,
    :canceled => 12,
    :approval_rejected => 13,
  }

  def id_to_string(id)
    STATES.find { |_, value| value.to_s == id.to_s }
  end

  def string_to_id(string)
    STATES[string.to_sym]
  end
end