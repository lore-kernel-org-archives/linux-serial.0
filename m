From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v6 2/3] tty: Add software emulated RS485 support for 8250
Date: Fri, 15 Jan 2016 13:54:06 -0800
Message-ID: <56996A7E.9070003@hurleysoftware.com>
References: <1450722379-13438-1-git-send-email-matwey@sai.msu.ru>
 <1450722379-13438-3-git-send-email-matwey@sai.msu.ru>
 <56991AE5.50503@hurleysoftware.com>
 <CAJs94Ea3MfLOniYEe39MisTdV=0pZ2CsRR5PBnCbanLU5ng5GQ@mail.gmail.com>
 <56994C4F.7040008@hurleysoftware.com>
 <CAJs94EZ670AZRukTa=n9sOLgTw30EaSs58PJ+z49P7H7jCTPYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJs94EZ670AZRukTa=n9sOLgTw30EaSs58PJ+z49P7H7jCTPYQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 01/15/2016 12:20 PM, Matwey V. Kornilov wrote:
> 2016-01-15 22:45 GMT+03:00 Peter Hurley <peter@hurleysoftware.com>:
>> On 01/15/2016 10:42 AM, Matwey V. Kornilov wrote:
>>> 2016-01-15 19:14 GMT+03:00 Peter Hurley <peter@hurleysoftware.com>:
>>>> On 12/21/2015 10:26 AM, Matwey V. Kornilov wrote:
>>>>> Implementation of software emulation of RS485 direction handling is based
>>>>> on omap_serial driver.
>>>>> Before and after transmission RTS is set to the appropriate value.
>>>>>
>>>>> Note that before calling serial8250_em485_init the caller has to
>>>>> ensure that UART will interrupt when shift register empty. Otherwise,
>>>>> emultaion cannot be used.
>>>>>
>>>>> Both serial8250_em485_init and serial8250_em485_destroy are
>>>>> idempotent functions.
>>>>
>>>> Apologies for the long delay; comments below.
>>>>
>>>>> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
>>>>> ---
>>>>>  drivers/tty/serial/8250/8250.h      |   6 ++
>>>>>  drivers/tty/serial/8250/8250_port.c | 161 +++++++++++++++++++++++++++++++++++-
>>>>>  include/linux/serial_8250.h         |   7 ++
>>>>>  3 files changed, 170 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
>>>>> index d54dcd8..0189cb3 100644
>>>>> --- a/drivers/tty/serial/8250/8250.h
>>>>> +++ b/drivers/tty/serial/8250/8250.h
>>>>> @@ -117,6 +117,12 @@ static inline void serial_dl_write(struct uart_8250_port *up, int value)
>>>>>  struct uart_8250_port *serial8250_get_port(int line);
>>>>>  void serial8250_rpm_get(struct uart_8250_port *p);
>>>>>  void serial8250_rpm_put(struct uart_8250_port *p);
>>>>> +int serial8250_em485_init(struct uart_8250_port *p);
>>>>> +void serial8250_em485_destroy(struct uart_8250_port *p);
>>>>> +static inline bool serial8250_em485_enabled(struct uart_8250_port *p)
>>>>> +{
>>>>> +     return p->em485 && (p->port.rs485.flags & SER_RS485_ENABLED);
>>>>
>>>> Under what circumstances is p->em485 != NULL but
>>>> (p->port.rs485.flags & SER_RS485_ENABLED) is true?
>>>>
>>>> ISTM, p->em485 is necessary and sufficient to determine if em485 is enabled.
>>>>
>>>> In which case, this function can be eliminated and callers can be reduced to
>>>>
>>>>         if (p->em485)
>>>>                 ....
>>>>
>>>>> +}
>>>>>
>>>>>  #if defined(__alpha__) && !defined(CONFIG_PCI)
>>>>>  /*
>>>>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>>>>> index 8ad0b2d..d67a848 100644
>>>>> --- a/drivers/tty/serial/8250/8250_port.c
>>>>> +++ b/drivers/tty/serial/8250/8250_port.c
>>>>> @@ -37,6 +37,7 @@
>>>>>  #include <linux/slab.h>
>>>>>  #include <linux/uaccess.h>
>>>>>  #include <linux/pm_runtime.h>
>>>>> +#include <linux/timer.h>
>>>>>
>>>>>  #include <asm/io.h>
>>>>>  #include <asm/irq.h>
>>>>> @@ -504,6 +505,31 @@ static void serial8250_clear_fifos(struct uart_8250_port *p)
>>>>>       }
>>>>>  }
>>>>>
>>>>> +static inline void serial8250_em485_rts_on_send(struct uart_8250_port *p)
>>>>
>>>> Only one call site, so please drop inline.
>>>>
>>>>
>>>>> +{
>>>>> +     unsigned char mcr = serial_in(p, UART_MCR);
>>>>> +
>>>>> +     if (p->port.rs485.flags & SER_RS485_RTS_ON_SEND)
>>>>> +             mcr |= UART_MCR_RTS;
>>>>> +     else
>>>>> +             mcr &= ~UART_MCR_RTS;
>>>>> +     serial_out(p, UART_MCR, mcr);
>>>>> +}
>>>>> +
>>>>> +static inline void serial8250_em485_rts_after_send(struct uart_8250_port *p)
>>>>
>>>> Doesn't really need to be inline.
>>>>
>>>>
>>>>> +{
>>>>> +     unsigned char mcr = serial_in(p, UART_MCR);
>>>>> +
>>>>> +     if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
>>>>> +             mcr |= UART_MCR_RTS;
>>>>> +     else
>>>>> +             mcr &= ~UART_MCR_RTS;
>>>>> +     serial_out(p, UART_MCR, mcr);
>>>>> +}
>>>>> +
>>>>> +static void serial8250_em485_handle_start_tx(unsigned long arg);
>>>>> +static void serial8250_em485_handle_stop_tx(unsigned long arg);
>>>>> +
>>>>>  void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p)
>>>>>  {
>>>>>       serial8250_clear_fifos(p);
>>>>> @@ -528,6 +554,42 @@ void serial8250_rpm_put(struct uart_8250_port *p)
>>>>>  }
>>>>>  EXPORT_SYMBOL_GPL(serial8250_rpm_put);
>>>>>
>>>>> +int serial8250_em485_init(struct uart_8250_port *p)
>>>>> +{
>>>>> +     if (p->em485 != NULL)
>>>>> +             return 0;
>>>>> +
>>>>> +     p->em485 = kmalloc(sizeof(struct uart_8250_em485), GFP_KERNEL);
>>>>> +     if (p->em485 == NULL)
>>>>> +             return -ENOMEM;
>>>>> +
>>>>> +     init_timer(&p->em485->stop_tx_timer);
>>>>> +     p->em485->stop_tx_timer.function = serial8250_em485_handle_stop_tx;
>>>>> +     p->em485->stop_tx_timer.data = (unsigned long)p;
>>>>> +     p->em485->stop_tx_timer.flags |= TIMER_IRQSAFE;
>>>>
>>>> Not sure this is going to fly; this would be the only user of TIMER_IRQSAFE
>>>> (which was specifically introduced to workaround workqueue issues and not
>>>> meant for general use).
>>>
>>> This is required to call del_timer_sync(&p->em485->start_tx_timer);
>>> from __stop_tx_rs485
>>
>> I know; that doesn't mean it's ok.
>>
>>
>>>>> +     init_timer(&p->em485->start_tx_timer);
>>>>> +     p->em485->start_tx_timer.function = serial8250_em485_handle_start_tx;
>>>>> +     p->em485->start_tx_timer.data = (unsigned long)p;
>>>>> +     p->em485->start_tx_timer.flags |= TIMER_IRQSAFE;
>>>>> +
>>>>> +     serial8250_em485_rts_after_send(p);
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(serial8250_em485_init);
>>>>
>>>> Newline.
>>>>
>>>>> +void serial8250_em485_destroy(struct uart_8250_port *p)
>>>>> +{
>>>>> +     if (p->em485 == NULL)
>>>>> +             return;
>>>>> +
>>>>> +     del_timer_sync(&p->em485->start_tx_timer);
>>>>> +     del_timer_sync(&p->em485->stop_tx_timer);
>>>>
>>>> What keeps start_tx() from restarting a new timer right here?
>>>
>>> Both start_tx and rs485_config (which calls destroy) are wrapped with
>>> port->lock in serial_core.c
>>
>> Ahh, missed that.
>>
>> Maybe it would be better simply to implement the config_rs485()
>> generically, and just call it from the omap_8250 config_rs485().
>>
>> And put a note about the locking in a function comment header
>>
>> /**
>>  *      serial8250_config_em485()       -       rs485 config helper
>>  *
>>  *      ....
>>  */
>>
> 
> I would like to provide init and destroy and left the rest for user.
> The reason is simple.
> When serial8250_em485_init is called a driver has to enable interrupt
> on empty shift register and probably disable it after
> serial8250_em485_destroy.
> And I believe that the driver knows better how to do it
> transactionally and correctly.

Ok.

> The 8250_omap doesn't do that just because it enables the interrupt
> normally on start and always keep it enabled.

Which would be another good note to add to the serial8250_em485_init()
function comment. I know it, and you know it, but someone a while from
now might not. I realize you documented that requirement in __stop_tx()
but someone might not bother to look too closely at the implementation.

Regards,
Peter Hurley


>>>>> +     kfree(p->em485);
>>>>> +     p->em485 = NULL;
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(serial8250_em485_destroy);
>>>>> +
>>>>>  /*
>>>>>   * These two wrappers ensure that enable_runtime_pm_tx() can be called more than
>>>>>   * once and disable_runtime_pm_tx() will still disable RPM because the fifo is
>>>>> @@ -1293,7 +1355,61 @@ static void serial8250_stop_rx(struct uart_port *port)
>>>>>       serial8250_rpm_put(up);
>>>>>  }
>>>>>
>>>>> -static inline void __stop_tx(struct uart_8250_port *p)
>>>>> +static __u32 __start_tx_rs485(struct uart_8250_port *p)
>>>>           ^^^^^
>>>> No need to preserve the userspace type here.
>>>>
>>>> The double underline leader in an identifier is typically used to distinguish
>>>> an unlocked version from a locked version. I don't think it's necessary here
>>>> or any of the other newly-introduced functions.
>>>
>>> I use double __ for consistency with __start_tx. Now I have:
>>>
>>>         if (up->em485)
>>>                 __start_tx_rs485(port);
>>>         else
>>>                 __start_tx(port);
>>
>> But __start_tx() is labelled that way to differentiate it from being identified
>> as the start_tx() handler (which is serial8250_start_tx()). IOW, contributors
>> unfamiliar with the 8250 driver itself won't become confused when grepping
>> for start_tx (or at least the idea is to minimize that confusion).
>>
>> start_tx_rs485() doesn't need differentiation, so doesn't require the
>> double __ leader.
>>
>> FWIW, this is consistent and typical elsewhere in the kernel.
>>
>>
>>>>> +{
>>>>> +     if (!serial8250_em485_enabled(p))
>>>>> +             return 0;
>>>>
>>>> Already checked that em485 was enabled in lone caller.
>>>>
>>>>
>>>>> +     if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX))
>>>>> +             serial8250_stop_rx(&p->port);
>>>>> +
>>>>> +     del_timer_sync(&p->em485->stop_tx_timer);
>>>>> +
>>>>> +     if (!!(p->port.rs485.flags & SER_RS485_RTS_ON_SEND) != !!(serial_in(p, UART_MCR) & UART_MCR_RTS)) {
>>>>
>>>> Line too long. And just one negation is sufficient, ie.
>>>>
>>>>         if (!(....) !=
>>>>             !(....)) {
>>>>
>>>
>>> I would like to keep the double negation, in my opinion it is more
>>> clear to the reader and I believe that the compiler is able to
>>> optimize it.
>>>
>>>>> +             serial8250_em485_rts_on_send(p);
>>>>> +             return p->port.rs485.delay_rts_before_send;
>>>>> +     }
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static inline void __do_stop_tx_rs485(struct uart_8250_port *p)
>>>>
>>>> Does this really need to be inline?
>>>>
>>>
>>> Why not?
>>
>> The expected yardstick for inline is some demonstrable speed improvement;
>> otherwise, size is favored.
>>
>> And __stop_tx() is already inlined in 3 places, which really doesn't
>> need inlining either -- a call/ret is nothing compared to device i/o.
>>
>>
>> Regards,
>> Peter Hurley
>>
>>>>> +{
>>>>> +     if (!serial8250_em485_enabled(p))
>>>>> +             return;
>>>>> +
>>>>> +     serial8250_em485_rts_after_send(p);
>>>>> +     /*
>>>>> +     * Empty the RX FIFO, we are not interested in anything
>>>>> +     * received during the half-duplex transmission.
>>>>> +     */
>>>>
>>>> Malformed block comment.
>>>>
>>>>         /*
>>>>          *
>>>>          *
>>>>          */
>>>>
>>>>> +     if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX))
>>>>> +             serial8250_clear_fifos(p);
>>>>> +}
>>>>> +
>>>>> +static void serial8250_em485_handle_stop_tx(unsigned long arg)
>>>>> +{
>>>>> +     struct uart_8250_port *p = (struct uart_8250_port *)arg;
>>>>> +
>>>>> +     __do_stop_tx_rs485(p);
>>>>> +}
>>>>> +
>>>>> +static inline void __stop_tx_rs485(struct uart_8250_port *p)
>>>>
>>>> Single caller so drop inline.
>>>>
>>>>> +{
>>>>> +     if (!serial8250_em485_enabled(p))
>>>>> +             return;
>>>>> +
>>>>> +     del_timer_sync(&p->em485->start_tx_timer);
>>>>> +
>>>>> +     /* __do_stop_tx_rs485 is going to set RTS according to config AND flush RX FIFO if required */
>>>>
>>>> Block comment.
>>>>
>>>>> +     if (p->port.rs485.delay_rts_after_send > 0) {
>>>>> +             mod_timer(&p->em485->stop_tx_timer, jiffies + p->port.rs485.delay_rts_after_send * HZ / 1000);
>>>>
>>>> Line too long; please re-format.
>>>> This is one problem with overly long identifiers.
>>>>
>>>>> +     } else {
>>>>> +             __do_stop_tx_rs485(p);
>>>>> +     }
>>>>> +}
>>>>> +
>>>>> +static inline void __do_stop_tx(struct uart_8250_port *p)
>>>>>  {
>>>>>       if (p->ier & UART_IER_THRI) {
>>>>>               p->ier &= ~UART_IER_THRI;
>>>>> @@ -1302,6 +1418,21 @@ static inline void __stop_tx(struct uart_8250_port *p)
>>>>>       }
>>>>>  }
>>>>>
>>>>> +static inline void __stop_tx(struct uart_8250_port *p)
>>>>> +{
>>>>> +     if (serial8250_em485_enabled(p)) {
>>>>> +             unsigned char lsr = serial_in(p, UART_LSR);
>>>>> +     /* To provide required timeing and allow FIFO transfer,
>>>>> +      * __stop_tx_rs485 must be called only when both FIFO and shift register
>>>>> +      * are empty. It is for device driver to enable interrupt on TEMT.
>>>>> +      */
>>>>
>>>> Block indent.
>>>>
>>>> This code path should cancel start timer also.
>>>>
>>>>> +             if (!((lsr & UART_LSR_TEMT) && (lsr & UART_LSR_THRE)))
>>>>
>>>>                 if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
>>>>
>>>>> +                     return;
>>>>> +     }
>>>>> +     __do_stop_tx(p);
>>>>> +     __stop_tx_rs485(p);
>>>>> +}
>>>>> +
>>>>>  static void serial8250_stop_tx(struct uart_port *port)
>>>>>  {
>>>>>       struct uart_8250_port *up = up_to_u8250p(port);
>>>>> @@ -1319,12 +1450,10 @@ static void serial8250_stop_tx(struct uart_port *port)
>>>>>       serial8250_rpm_put(up);
>>>>>  }
>>>>>
>>>>> -static void serial8250_start_tx(struct uart_port *port)
>>>>> +static inline void __start_tx(struct uart_port *port)
>>>>>  {
>>>>>       struct uart_8250_port *up = up_to_u8250p(port);
>>>>>
>>>>> -     serial8250_rpm_get_tx(up);
>>>>> -
>>>>>       if (up->dma && !up->dma->tx_dma(up))
>>>>>               return;
>>>>>
>>>>> @@ -1350,6 +1479,30 @@ static void serial8250_start_tx(struct uart_port *port)
>>>>>       }
>>>>>  }
>>>>>
>>>>> +static void serial8250_em485_handle_start_tx(unsigned long arg)
>>>>> +{
>>>>> +     struct uart_8250_port *p = (struct uart_8250_port *)arg;
>>>>> +
>>>>> +     __start_tx(&p->port);
>>>>> +}
>>>>> +
>>>>> +static void serial8250_start_tx(struct uart_port *port)
>>>>> +{
>>>>> +     struct uart_8250_port *up = up_to_u8250p(port);
>>>>> +     __u32 delay;
>>>>
>>>>         int delay;
>>>>
>>>>> +
>>>>> +     serial8250_rpm_get_tx(up);
>>>>> +
>>>>> +     if (up->em485 && timer_pending(&up->em485->start_tx_timer))
>>>>> +             return;
>>>>> +
>>>>> +     if (up->em485 && (delay = __start_tx_rs485(up))) {
>>>>
>>>> No assignment in conditional please.
>>>>
>>>>> +             mod_timer(&up->em485->start_tx_timer, jiffies + delay * HZ / 1000);
>>>>> +     } else {
>>>>> +             __start_tx(port);
>>>>> +     }
>>>>
>>>> Generally, braces aren't used for single statement if..else.
>>>> That probably won't apply here after removing the assignment-in-conditional,
>>>> but I thought it worth mentioning just so you know.
>>>>
>>>> Regards,
>>>> Peter Hurley
>>>>
>>>>> +}
>>>>> +
>>>>>  static void serial8250_throttle(struct uart_port *port)
>>>>>  {
>>>>>       port->throttle(port);
>>>>> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
>>>>> index faa0e03..71516ec 100644
>>>>> --- a/include/linux/serial_8250.h
>>>>> +++ b/include/linux/serial_8250.h
>>>>> @@ -76,6 +76,11 @@ struct uart_8250_ops {
>>>>>       void            (*release_irq)(struct uart_8250_port *);
>>>>>  };
>>>>>
>>>>> +struct uart_8250_em485 {
>>>>> +     struct timer_list       start_tx_timer; /* "rs485 start tx" timer */
>>>>> +     struct timer_list       stop_tx_timer; /* "rs485 stop tx" timer */
>>>>> +};
>>>>> +
>>>>>  /*
>>>>>   * This should be used by drivers which want to register
>>>>>   * their own 8250 ports without registering their own
>>>>> @@ -122,6 +127,8 @@ struct uart_8250_port {
>>>>>       /* 8250 specific callbacks */
>>>>>       int                     (*dl_read)(struct uart_8250_port *);
>>>>>       void                    (*dl_write)(struct uart_8250_port *, int);
>>>>> +
>>>>> +     struct uart_8250_em485 *em485;
>>>>>  };
>>>>>
>>>>>  static inline struct uart_8250_port *up_to_u8250p(struct uart_port *up)
>>>>>
>>>>
>>>
>>>
>>>
>>
> 
> 
> 
