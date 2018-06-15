module TransactionImport
  class TransactionToImport
    attr_accessor :date, :funds_in, :funds_out, :description

    def new(date:, funds_in:, funds_out:, description:)
      @date = date
      @funds_in = funds_in
      @funds_out = funds_out
      @description = description
    end
  end
end
