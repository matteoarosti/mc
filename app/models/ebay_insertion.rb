class EbayInsertion < ActiveRecord::Base
  
  has_many :ebay_insertion_timelines
  
  def save_to_timeline
    n = self.ebay_insertion_timelines.new
      n.tm_num_impressions = self.num_impressions      
      n.tm_num_visits      = self.num_visits
      n.tm_num_solded      = self.num_solded
      n.tm_num_questions   = self.num_questions
      n.tm_num_follows     = self.num_follows 
    n.save!
  end
  
end
