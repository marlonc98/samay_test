enum Flavor {
  dev,
  fake,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return '[DEV] Samay';
      case Flavor.fake:
        return '[FAKE] Samay';
      case Flavor.prod:
        return 'Samay';
      default:
        return 'title';
    }
  }

}
