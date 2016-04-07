module ApplicationHelper

  # 02/04/2016 tutorials: returns the full page title
  def full_title(page_title = '')
    base_title = "Workchoice"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
end
