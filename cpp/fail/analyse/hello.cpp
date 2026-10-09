#include <iostream>
#include <string>
#include <utility>

int main() {
  std::string greeting = "Hello, world";
  std::string moved = std::move(greeting);
  std::cout << greeting << moved << "\n";
  return 0;
}
