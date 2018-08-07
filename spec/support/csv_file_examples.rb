module CsvFileExamples
  def transaction_csv_with_header_and_non_iso_dates()
    <<~CSV_FILE
      Date, Transaction Details, Funds Out, Funds In 
      05/01/2017,INTERNET BILL PAYMENT CABLE,91.00,
      05/02/2017,CHEQUE IMAGE DEPOSIT,,200.00
    CSV_FILE
  end

  def example()
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
