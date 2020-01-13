class Total {
  String id,
      branches,
      cash,
      categories,
      clients,
      companies,
      credit,
      debit,
      deposit,
      employees,
      products,
      reports,
      transactions,
      withdraw;

  Total(
      {this.id,
      this.branches,
      this.cash,
      this.categories,
      this.clients,
      this.companies,
      this.credit,
      this.debit,
      this.deposit,
      this.employees,
      this.products,
      this.reports,
      this.transactions,
      this.withdraw});

  Total.fromMap(Map snapshot, String id)
      : id = id ?? "",
        branches = snapshot['branches'] ?? '',
        cash = snapshot['cash'] ?? '',
        categories = snapshot['categories'] ?? '',
        clients = snapshot['clients'] ?? '',
        companies = snapshot['companies'] ?? '',
        credit = snapshot['credit'] ?? '',
        debit = snapshot['debit'] ?? '',
        deposit = snapshot['deposit'] ?? '',
        employees = snapshot['employees'] ?? '',
        products = snapshot['products'] ?? '',
        reports = snapshot['reports'] ?? '',
        transactions = snapshot['transactions'] ?? '',
        withdraw = snapshot['withdraw'] ?? '';

  toJson() {
    return {
      'branches': branches,
      'cash': cash,
      'categories': categories,
      'clients': clients,
      'companies': companies,
      'credit': credit,
      'debit': debit,
      'deposit': deposit,
      'employees': employees,
      'products': products,
      'reports': reports,
      'transactions': transactions,
      'withdraw': withdraw,
    };
  }
}
