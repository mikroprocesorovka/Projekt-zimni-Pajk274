#ifndef _MILIS_H_
#define _MILIS_H_ 1

#define MILIS_16BIT
//#define MILIS_32BIT
//#include "stm8s.h"
#include "stm8s_conf.h"
// configure PRESCALER and PERIOD according to your clock, to setup 1ms time base
#if F_CPU==16000000
// varianta pro 16MHz
#define PRESCALER TIM4_PRESCALER_128
#define PERIOD (125-1)
#elif F_CPU==2000000
// varianta pro 2MHz
#define PRESCALER TIM4_PRESCALER_16
#define PERIOD (125-1)
#else
#warning "milis timer parameters not defined for this clock !"
#endif

#if defined(MILIS_16BIT)

#define DELAY_MS_MAX_VALUE (0xffff-2) // nev�m jestli to m��e b�t pln�ch 0xffff tak rad�ji d�l�m rezervu - stejn� tak vysok� hodnoty nikdo rozumn� pou��vat nebude
uint16_t milis(void);
void delay_ms(uint16_t del);

#elif defined(MILIS_32BIT)

#define DELAY_MS_MAX_VALUE (0xffffffff-2) // nev�m jestli to m��e b�t pln�ch 0xffff tak rad�ji d�l�m rezervu - stejn� tak vysok� hodnoty nikdo rozumn� pou��vat nebude
uint32_t milis(void);
void delay_ms(uint32_t del);

#else
#error "Not defined MILIS_16BIT nor  MILIS_32BIT in milis.h !"
#endif


void init_milis(void);




#endif