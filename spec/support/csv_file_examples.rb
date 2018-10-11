module CsvFileExamples
  def include_headers_options
    {
      includes_headers: true,
      date_column_name: "Date",
      description_column_name: "Transaction Details",
      funds_in_column_name: "Funds In",
      funds_out_column_name: "Funds Out",
      date_format: "%m/%d/%Y"
    }
  end

  def example
    <<~CSV_FILE
      Date, Transaction Details, Funds Out, Funds In
      05/01/2017,INTERNET BILL PAYMENT,91.00,
      05/02/2017,PROPERTY TAXES,400.00,
      05/02/2017,MUTUAL FUNDS,100.00,
      05/02/2017,CHEQUE #90,200.00,
      05/02/2017,CHEQUE IMAGE DEPOSIT,,200.00
      05/02/2017,CHEQUE IMAGE DEPOSIT,,200.00
      05/02/2017,CHEQUE IMAGE DEPOSIT,,150.00
      05/02/2017,CHEQUE IMAGE DEPOSIT,,150.00
    CSV_FILE
  end
end
