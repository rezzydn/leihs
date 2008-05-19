module Backend::SearchHelper
  
  ACTION_DICTIONARY = { "add_line" => ["Add", "package_add"],
                        "swap_model_line" => ["Swap", "arrow_switch"],
                        "swap_user" => ["Swap", "arrow_switch"]}
  
  def get_action_text(action)
    ACTION_DICTIONARY[action][0]
  end

  def get_action_image(action)
    ACTION_DICTIONARY[action][1]
  end

    
end
