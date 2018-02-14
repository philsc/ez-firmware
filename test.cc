constexpr int factorial(int n) {
  if (n < 2) {
    return 1;
  }
  return n * factorial(n - 1);
}

int main() {
  static_assert(factorial(4) == 24);
  return factorial(4);
}
