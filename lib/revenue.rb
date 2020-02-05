class Revenue
  def self.gross_revenue(date, contracts)
    # sum = 0
    # contracts.each do |contract|
    #   sum += contract.revenue_on(date)
    # end
    # sum
    contracts.sum { |c| c.revenue_on(date) }
  end
end
