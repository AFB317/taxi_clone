enum ApiRequestStatus { initialized, loading, loaded, error, connectionError }

enum RouterPath { check, welcome, signIn, signUp, main, search }

enum ScreenState {
  initial,
  pending,
  search,
  canceled,
  isComing,
  isWaiting,
  isRiding,
  finished,
  rated,
}
