#include <avr/io.h>
#include <util/delay.h>

int main() {
  DDRC |= 1;
  while (1) {
    PORTC &= ~1;
    _delay_ms(1000);

    PORTC |= 1;
    _delay_ms(1000);
  }
}
