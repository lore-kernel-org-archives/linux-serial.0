From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2 3/3] tty: Add software emulated RS485 support for 8250
Date: Tue, 10 Nov 2015 11:52:40 -0500
Message-ID: <564220D8.20005@hurleysoftware.com>
References: <1446890976-1817-1-git-send-email-matwey@sai.msu.ru>
 <1446890976-1817-3-git-send-email-matwey@sai.msu.ru>
 <56421759.8070103@hurleysoftware.com>
 <CAJs94EZW0rRO6qtKBTbfL3RVVZvxQjthriV_rVo2+Hq3S=oQ9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJs94EZW0rRO6qtKBTbfL3RVVZvxQjthriV_rVo2+Hq3S=oQ9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 11/10/2015 11:25 AM, Matwey V. Kornilov wrote:
> 2015-11-10 19:12 GMT+03:00 Peter Hurley <peter@hurleysoftware.com>:
>> Hi Matwey,
>>
>> I noticed 3 other issues here; see below.
>>
>> On 11/07/2015 05:09 AM, Matwey V. Kornilov wrote:
>>> Implementation of software emulation of RS485 direction handling is based
>>> on omap-serial driver.  It is acts as the following. At transmission start,
>>> RTS is set (if required) and receiver is off (if required). At transmission
>>> stop, RTS is set (if required) and fifo is flushed.
>>>
>>> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
>>> ---
>>>  drivers/tty/serial/8250/8250_port.c | 32 ++++++++++++++++++++++++++++++++
>>>  1 file changed, 32 insertions(+)
>>>
>>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>>> index 52d82d2..a9291f7 100644
>>> --- a/drivers/tty/serial/8250/8250_port.c
>>> +++ b/drivers/tty/serial/8250/8250_port.c
>>> @@ -559,7 +559,37 @@ static void serial8250_rpm_put_tx(struct uart_8250_port *p)
>>>       pm_runtime_mark_last_busy(p->port.dev);
>>>       pm_runtime_put_autosuspend(p->port.dev);
>>>  }
>>> +static void serial8250_stop_rx(struct uart_port *port);
>>> +static void serial8250_rs485_start_tx(struct uart_8250_port *p)
>>> +{
>>> +     if (p->capabilities & UART_CAP_HW485 || !(p->port.rs485.flags & SER_RS485_ENABLED))
>>> +             return;
>>> +
>>> +     if (p->port.rs485.flags & SER_RS485_RTS_ON_SEND) {
>>> +             serial_port_out(&p->port, UART_MCR, UART_MCR_RTS);
>>
>> The SER_RS485_RTS_ON_SEND bit is supposed to be the logic level of RTS,
>> so RTS should be driven to either 0 or 1 here (not just to 1).
>>
>>> +             if (p->port.rs485.delay_rts_before_send > 0)
>>> +                     mdelay(p->port.rs485.delay_rts_before_send);
>>> +     }
>>> +     if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX))
>>> +             serial8250_stop_rx(&p->port);
>>> +}
>>> +static void serial8250_rs485_stop_tx(struct uart_8250_port *p)
>>> +{
>>> +     if (p->capabilities & UART_CAP_HW485 || !(p->port.rs485.flags & SER_RS485_ENABLED))
>>> +             return;
>>
>> Unlike omap-serial, the 8250 stop_tx() will trigger _before_ the transmitter
>> is drained. Some mechanism is required to defer until the transmitter
>> is empty.
>>
> 
> In serial8250_stop_tx() I see the following:
> 
>         if (port->type == PORT_16C950) {
>                 up->acr |= UART_ACR_TXDIS;
>                 serial_icr_write(up, UART_ACR, up->acr);
>         }
> 
> AFAIU this will disable transmission unconditionally, or not?

Yes, the transmitter will be stopped.

> What will happen here with data in FIFO?

It is preserved in the transmitter and restarted if/when start_tx() is called.
The 950 fifo is 128 bytes, so waiting for it to drain when the serial core has
commanded stop is not ok. Some of the other chips have even larger fifos but
I don't have that hardware so can't really test disabling their transmitters
also.

Note this is why there is a distinction between
a. __stop_tx(), which is an internal helper for disabling the THRE interrupt
   when all the tx data has been written to the fifo, and
b. serial8250_stop_tx(), which is the stop() method for the 8250 driver.
   The serial core calls the stop_tx() method when,
   1. tty core stops the tty (software flow control, ioctl(TCXONC, TCOOFF), etc)
   2. system pm suspend
   3. sw-assisted CTS flow control (ie., CRTSCTS)

When the serial core calls the stop_tx(), the driver is expected to stop
promptly, not drain i/o.

Regards,
Peter Hurley

> I think that parts of my rs485 stuff have to be moved to
> serial8250_tx_chars where It will be simpler to handle things without
> involving mdelays.
> 
>>> +     if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND) {
>>> +             if (p->port.rs485.delay_rts_after_send > 0)
>>> +                     mdelay(p->port.rs485.delay_rts_after_send);
>>> +             serial_port_out(&p->port, UART_MCR, UART_MCR_RTS);
>>
>> As with the SER_RS485_RTS_ON_SEND, RTS should be driven to either 0 or 1 here
>> as well (not just to 1).
>>
>> Regards,
>> Peter Hurley
>>
>>> +     }
>>> +     /*
>>> +     * Empty the RX FIFO, we are not interested in anything
>>> +     * received during the half-duplex transmission.
>>> +     */
>>> +     if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX))
>>> +             serial8250_clear_fifos(p);
>>> +}
>>>  /*
>>>   * IER sleep support.  UARTs which have EFRs need the "extended
>>>   * capability" bit enabled.  Note that on XR16C850s, we need to
>>> @@ -1309,6 +1339,7 @@ static void serial8250_stop_tx(struct uart_port *port)
>>>               up->acr |= UART_ACR_TXDIS;
>>>               serial_icr_write(up, UART_ACR, up->acr);
>>>       }
>>> +     serial8250_rs485_stop_tx(up);
>>>       serial8250_rpm_put(up);
>>>  }
>>>
>>> @@ -1317,6 +1348,7 @@ static void serial8250_start_tx(struct uart_port *port)
>>>       struct uart_8250_port *up = up_to_u8250p(port);
>>>
>>>       serial8250_rpm_get_tx(up);
>>> +     serial8250_rs485_start_tx(up);
>>>
>>>       if (up->dma && !up->dma->tx_dma(up))
>>>               return;
>>>
>>
> 
> 
> 
