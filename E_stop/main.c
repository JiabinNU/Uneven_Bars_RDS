

/**
 * main.c
 * single GPIO-level channel is HIGH when e-stop is OFF and LOW when ON
 * line routed to the enable inputs of motor controllers and to GPIO pin on TIVA
 *
 * behavior is as follows:
 *      clearing to LOW triggers hardware interrupt on TIVA with highest possible priority
 *      e-stop ISR produces a signal detected by other ISRs and main routine
 *      main routine and other ISRs prevented from changing state of this flag
 *
 * main loop polls e-stop state and turns on red channel when e-stop event occurs
 *
 * timer interrupt fires at 100Hz and turns on blue channel when e-top event occurs
 *
 * when e-stop line is manually asserted (pulled LOW), LED glows purple
 */

#include <stdint.h>
#include <stdbool.h>
#include "inc/tm4c123gh6pm.h"
#include "utils/uartstdio.h"
#include "driverlib/uart.h"
#include "driverlib/gpio.h"
#include "driverlib/sysctl.h"
#include "driverlib/pin_map.h"
#include "inc/hw_memmap.h"
#include "driverlib/rom.h"
#include "driverlib/rom_map.h"
#include "driverlib/timer.h"
#include "driverlib/interrupt.h"

uint8_t state;

void ESTOP(void){  //should this have the priority and sub-priority levels?...IPL6SRS
    GPIOIntClear(GPIO_PORTF_BASE, GPIO_INT_PIN_4);  //portF pin4 is the left button on the TIVA
    state = 1;
    //uint8_t valueRED = GPIOPinRead(GPIO_PORTF_BASE, GPIO_PIN_1);
    //uint8)t valueBLUE = GPIOPinRead(GPIO_PORTF_BASE, GPIO_PIN_2);

    /*
    while(state == 0)   //while GPIO pin is low
    {
        GPIO_PORTF_DATA_R |= 0x02; //turn on Red LED on PF1
    }
    GPIO_PORTF_DATA_R &= ~(0x02);   //turn off Red LED when GPIO pin goes high again
    */
    /*if(state == 0)  //if GPIO pin is low, turn on blue LED, pole "state" in main function
    {
        GPIO_PORTF_DATA_R |= 0x02; //turn on Blue LED on PF2
    }
    else
    {
        GPIO_PORTF_DATA_R &= ~(0x02);   //turn off Blue LED
    }
    */

}

void TIMER0ISR(void) //want interrupt to run at 100Hz
{
    TimerIntClear(TIMER0_BASE, TIMER_TIMA_TIMEOUT); //clear timer interrupt

    //if(state == 0)  //if GPIO pin is low, turn on blue LED, pole "state" in main function
    if (state == 1)
    {
        GPIO_PORTF_DATA_R |= 0x04; //turn on Blue LED on PF2
    }
    else
    {
        GPIO_PORTF_DATA_R &= ~(0x04);   //turn off Blue LED
    }
}

void initGPIO(void)
{
    SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOF);    //LEDS
    //SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOB);    //use PORTB for interrupt

    //do I need this...? GPIOPinConfigure(uint32_t ui32PinConfig)...

    /*
    void GPIOPinTypeGPIOInput(uint32_t ui32Port, uint8_t ui8Pins)
    Parameters:
    ui32Port is the base address of the GPIO port.
    ui8Pins is the bit-packed representation of the pin(s).
     */
    GPIOPinTypeGPIOOutput(GPIO_PORTF_BASE, GPIO_PIN_1 | GPIO_PIN_2);  //PF1 RED LED, PF2 BLUE LED, not totally sure what the OR means here?
    GPIOPinTypeGPIOInput(GPIO_PORTF_BASE, GPIO_PIN_4);

    GPIOPadConfigSet(GPIO_PORTF_BASE, GPIO_PIN_4, GPIO_STRENGTH_2MA, GPIO_PIN_TYPE_STD_WPU);  // Enable weak pullup resistor for PF4

    GPIOIntDisable(GPIO_PORTF_BASE, GPIO_PIN_4);        // Disable interrupt for PF4 (in case it was enabled)
    GPIOIntClear(GPIO_PORTF_BASE, GPIO_PIN_4);      // Clear pending interrupts for PF4

    //GPIOIntTypeSet(GPIO_PORTB_BASE, GPIO_PIN_0, GPIO_LOW_LEVEL);    //sets interrupt detection to low level
    GPIOIntTypeSet(GPIO_PORTF_BASE, GPIO_PIN_4, GPIO_FALLING_EDGE);

    GPIOIntRegister(GPIO_PORTF_BASE, ESTOP);

    GPIOIntEnable(GPIO_PORTF_BASE, GPIO_INT_PIN_4);

    /*
    GPIOIntEnable(GPIO_PORTB_BASE, GPIO_INT_PIN_0);
    IntPrioritySet(INT_GPIOB, 6);
    IntRegister(INT_GPIOB, ESTOP);  //name of ISR
    IntEnable(INT_GPIOB);
    IntMasterEnable();
     */

    IntMasterEnable();


}

void initTimer(void)
{
    SysCtlPeripheralEnable(SYSCTL_PERIPH_TIMER0);
    TimerConfigure(TIMER0_BASE, TIMER_CFG_PERIODIC);    //32 bit timer, configure timer operation as periodic
    TimerLoadSet(TIMER0_BASE, TIMER_A, 1200000);    //120,000,000 / 1,200,000 = 100Hz
    TimerIntRegister(TIMER0_BASE, TIMER_A, TIMER0ISR);  //TIMER0ISR is the name of the ISR
    IntEnable(INT_TIMER0A);
    TimerIntEnable(TIMER0_BASE, TIMER_TIMA_TIMEOUT); //timer interrupts when timeout
    TimerEnable(TIMER0_BASE, TIMER_A);  //start timer

    //ROM_IntMasterEnable();  //do i need this line?  example has it as second line of function after peripheral enable

}

/*
 * example resource: https://gist.github.com/EddyJMB/73a907524c3fbe8f6c0ee9ecefc0c52d
 */

/*
 * confused whether GPIO Pin generates interrupt or timer because instructions say
 * "timer interrupt fires at 100Hz...?
 *
 * this tutorial seems to do it one way then convert to the other way while keeping the same function
 *
 * https://www.youtube.com/watch?v=bQ50pzqFA5Q
 *
 * should have two ISR: 1 with the timer and 1 with the GPIO
 *
 * digitalWrite(RED_LED, digitalRead(RED_LED) ^ 1);              // toggle LED pin
 *  is "^" equivalent to "!"?
 *  https://gist.github.com/robertinant/10398194
 *
 * https://henryforceblog.wordpress.com/2015/05/02/blink-example-using-timer-on-a-tiva-launchpad/
 *
 */

int main(void)      // main loop polls e-stop state
{
    initGPIO();
    initTimer();
    while(1)
    {
        //SysCtlDelay(3);
        //state = GPIOPinRead(GPIO_PORTF_BASE, GPIO_PIN_4);   //checks the state of the GPIO pin
        /*
         * /SysCtlDelay(3);
         * state = 1;
         */

        if (state ==1)
        {
            GPIO_PORTF_DATA_R |= 0x02;
        }
    }

    return 0;
}
