From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH RESEND 5/5] tty/serial: at91: add interrupts for modem
 control lines
Date: Mon, 1 Sep 2014 11:26:59 +0200
Message-ID: <CACQ1gAguMJM3iBSh9RN9Sbq8c-DfQUhzFPOXav2CASVHA6Rxdw@mail.gmail.com>
References: <1400005245-11943-1-git-send-email-richard.genoud@gmail.com>
 <1400005245-11943-6-git-send-email-richard.genoud@gmail.com> <53E7C8F8.1080507@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:45989 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbaIAJ1V (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Sep 2014 05:27:21 -0400
Received: by mail-la0-f43.google.com with SMTP id ty20so5709129lab.2
        for <linux-serial@vger.kernel.org>; Mon, 01 Sep 2014 02:27:19 -0700 (PDT)
In-Reply-To: <53E7C8F8.1080507@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yegor Yefremov <yegor_sub1@visionsystems.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

2014-08-10 21:33 GMT+02:00 Peter Hurley <peter@hurleysoftware.com>:
> Hi Richard,

Hi !
Sorry for the delay !

> On 05/13/2014 02:20 PM, Richard Genoud wrote:
>> Handle CTS/DSR/RI/DCD GPIO interrupts in atmel_serial.
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>  drivers/tty/serial/atmel_serial.c |  125 ++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 122 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
>> index 43ca659..3fceae0 100644
>> --- a/drivers/tty/serial/atmel_serial.c
>> +++ b/drivers/tty/serial/atmel_serial.c
>> @@ -45,6 +45,7 @@
>>  #include <linux/gpio.h>
>>  #include <linux/gpio/consumer.h>
>>  #include <linux/err.h>
>> +#include <linux/irq.h>
>>
>>  #include <asm/io.h>
>>  #include <asm/ioctls.h>
>> @@ -167,7 +168,9 @@ struct atmel_uart_port {
>>
>>       struct serial_rs485     rs485;          /* rs485 settings */
>>       struct mctrl_gpios      *gpios;
>> +     int                     gpio_irq[UART_GPIO_MAX];
>>       unsigned int            tx_done_mask;
>> +     bool                    ms_irq_enabled;
>>       bool                    is_usart;       /* usart or uart */
>>       struct timer_list       uart_timer;     /* uart timer */
>>       int (*prepare_rx)(struct uart_port *port);
>> @@ -489,8 +492,38 @@ static void atmel_stop_rx(struct uart_port *port)
>>   */
>>  static void atmel_enable_ms(struct uart_port *port)
>>  {
>> -     UART_PUT_IER(port, ATMEL_US_RIIC | ATMEL_US_DSRIC
>> -                     | ATMEL_US_DCDIC | ATMEL_US_CTSIC);
>> +     struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>> +     uint32_t ier = 0;
>> +
>> +     /*
>> +      * Interrupt should not be enabled twice
>> +      */
>> +     if (atmel_port->ms_irq_enabled)
>> +             return;
>> +
>> +     atmel_port->ms_irq_enabled = true;
>> +
>> +     if (atmel_port->gpio_irq[UART_GPIO_CTS] >= 0)
>> +             enable_irq(atmel_port->gpio_irq[UART_GPIO_CTS]);
>> +     else
>> +             ier |= ATMEL_US_CTSIC;
>> +
>> +     if (atmel_port->gpio_irq[UART_GPIO_DSR] >= 0)
>> +             enable_irq(atmel_port->gpio_irq[UART_GPIO_DSR]);
>> +     else
>> +             ier |= ATMEL_US_DSRIC;
>> +
>> +     if (atmel_port->gpio_irq[UART_GPIO_RI] >= 0)
>> +             enable_irq(atmel_port->gpio_irq[UART_GPIO_RI]);
>> +     else
>> +             ier |= ATMEL_US_RIIC;
>> +
>> +     if (atmel_port->gpio_irq[UART_GPIO_DCD] >= 0)
>> +             enable_irq(atmel_port->gpio_irq[UART_GPIO_DCD]);
>> +     else
>> +             ier |= ATMEL_US_DCDIC;
>
> Where are these gpio irqs disabled if !UART_ENABLE_MS()?
They are disabled in atmel_shutdown()/atmel_free_gpio_irq().
Like the doc says in Documentation/serial/driver
  enable_ms(port)
    Enable the modem status interrupts.

    This method may be called multiple times.  Modem status
    interrupts should be disabled when the shutdown method is
    called.

Regards,
Richard.
