#include <stdio.h>
#include <stdlib.h>

int main(void) {
  char *greeting = malloc(14);
  if (greeting == NULL) {
    return 1;
  }
  snprintf(greeting, 14, "Hello, world");
  puts(greeting);
  return 0;
}
