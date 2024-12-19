class BluetoothDeviceEntity {
  final String rssid;
  final String name;
  final String address;
  final String? imageUrl;
  final int? charge;

  const BluetoothDeviceEntity(
      {required this.rssid,
      required this.name,
      required this.address,
      this.imageUrl,
      this.charge});
}
