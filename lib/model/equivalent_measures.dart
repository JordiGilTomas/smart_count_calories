class EquivalentMeasures {
  static const double gramos = 1.0;
  static const double ml = 1.0;
  static const double tazaDesayuno = 250.0;
  static const double tazaTe = 150.0;
  static const double tazaCafe = 100.0;
  static const double cucharaSopera = 15.0;
  static const double cucharaPostre = 10.0;
  static const double cucharaCafe = 5.0;
  static const double vasoAgua = 250.0;
  static const double vasitoVino = 100.0;
  static const double vasitoLicor = 50.0;

  static Map<String, double> toMap() {
    return {
      "gramos": gramos,
      "ml": ml,
      "taza de desayuno": tazaDesayuno,
      "taza de té": tazaTe,
      "taza de café": tazaCafe,
      "cuchara sopera": cucharaSopera,
      "cuchara de postre": cucharaPostre,
      "cuchara de café": cucharaCafe,
      "vaso de agua": vasoAgua,
      "vasito de vino": vasitoVino,
      "vasito de licor": vasitoLicor,
    };
  }
}
