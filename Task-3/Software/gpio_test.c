#include <stdint.h>
#include "io.h"

#define IO_GPIO       32
#define GPIO_DATA     (IO_GPIO + 0x00)
#define GPIO_DIR      (IO_GPIO + 0x04)
#define GPIO_READ     (IO_GPIO + 0x08)

int main(void) {
    uint32_t write_value = 0x12345678;
    uint32_t read_value;

    printf("GPIO TASK-3 TEST START\n");

    /* Configure all GPIO pins as outputs */
    IO_OUT(GPIO_DIR, 0xFFFFFFFF);

    /* Write output data */
    IO_OUT(GPIO_DATA, write_value);

    /* Read current GPIO pin state */
    read_value = IO_IN(GPIO_READ);

    printf("GPIO DATA WRITE = %x\n", write_value);
    printf("GPIO READ       = %x\n", read_value);

    if (read_value == write_value) {
        printf("GPIO TASK-3 TEST PASSED\n");
    } else {
        printf("GPIO TASK-3 TEST FAILED\n");
    }

    return 0;
}
