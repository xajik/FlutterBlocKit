class DataSnapshot<T> {
  final T? data;
  final bool loading;
  final String? errorMessage;
  final bool loaded;

  const DataSnapshot({
    required this.data,
    required this.loading,
    required this.errorMessage,
    required this.loaded,
  });

  bool hasData() => data != null; 

  bool get failed => errorMessage != null && data == null;

  DataSnapshot<T> copyWith({
    T? data,
    bool? loading,
    String? errorMessage,
    bool? loaded,
  }) {
    return DataSnapshot(
      data: data ?? this.data,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
      loaded: loaded ?? this.loaded,
    );
  }

  DataSnapshot.data(
    T? snapshot, {
    this.loading = false,
    this.loaded = false,
  })  : data = snapshot,
        errorMessage = null;

  DataSnapshot.loading()
      : loading = true,
        data = null,
        errorMessage = null,
        loaded = false;

  DataSnapshot.error(String error)
      : loading = false,
        data = null,
        errorMessage = error,
        loaded = true;
}
