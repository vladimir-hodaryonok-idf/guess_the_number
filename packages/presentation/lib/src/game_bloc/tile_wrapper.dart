class TileWrapper<D> {
  final bool isLoading;
  final D? data;

  TileWrapper({
    required this.isLoading,
    required this.data,
  });

  factory TileWrapper.init() => TileWrapper<D>(
        isLoading: true,
        data: null,
      );

  TileWrapper<D> copyWith({
    bool? isLoading,
    D? data,
  }) =>
      TileWrapper<D>(
        isLoading: isLoading ?? this.isLoading,
        data: data,
      );
}
