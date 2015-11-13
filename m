From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: Re: [PATCH v2 3/3] tty: Add software emulated RS485 support for 8250
Date: Fri, 13 Nov 2015 11:35:01 +0300
Message-ID: <CAJs94EZqA=kjGuuRe57o20DKEv9nqDLi2MLu8ZUjEa=xodz7zQ@mail.gmail.com>
References: <1446890976-1817-1-git-send-email-matwey@sai.msu.ru>
 <1446890976-1817-3-git-send-email-matwey@sai.msu.ru> <56421759.8070103@hurleysoftware.com>
 <CAJs94EZnJi+s-pkLGFZNg9rV5v-Ky6veWk4vYFN2mTi7f12pVA@mail.gmail.com> <56449596.5020109@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56449596.5020109@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

2015-11-12 16:35 GMT+03:00 Peter Hurley <peter@hurleysoftware.com>:
> On 11/12/2015 07:34 AM, Matwey V. Kornilov wrote:
>> 2015-11-10 19:12 GMT+03:00 Peter Hurley <peter@hurleysoftware.com>:
>>> On 11/07/2015 05:09 AM, Matwey V. Kornilov wrote:
>>>> Implementation of software emulation of RS485 direction handling is based
>>>> on omap-serial driver.  It is acts as the following. At transmission start,
>>>> RTS is set (if required) and receiver is off (if required). At transmission
>>>> stop, RTS is set (if required) and fifo is flushed.
>>>>
>>>> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
>>>> ---
>>>>  drivers/tty/serial/8250/8250_port.c | 32 ++++++++++++++++++++++++++++++++
>>>>  1 file changed, 32 insertions(+)
>>>>
>>>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>>>> index 52d82d2..a9291f7 100644
>>>> --- a/drivers/tty/serial/8250/8250_port.c
>>>> +++ b/drivers/tty/serial/8250/8250_port.c
>>>> @@ -559,7 +559,37 @@ static void serial8250_rpm_put_tx(struct uart_8250_port *p)
>>>>       pm_runtime_mark_last_busy(p->port.dev);
>>>>       pm_runtime_put_autosuspend(p->port.dev);
>>>>  }
>>>> +static void serial8250_stop_rx(struct uart_port *port);
>>>> +static void serial8250_rs485_start_tx(struct uart_8250_port *p)
>>>> +{
>>>> +     if (p->capabilities & UART_CAP_HW485 || !(p->port.rs485.flags & SER_RS485_ENABLED))
>>>> +             return;
>>>> +
>>>> +     if (p->port.rs485.flags & SER_RS485_RTS_ON_SEND) {
>>>> +             serial_port_out(&p->port, UART_MCR, UART_MCR_RTS);
>>>
>>> The SER_RS485_RTS_ON_SEND bit is supposed to be the logic level of RTS,
>>> so RTS should be driven to either 0 or 1 here (not just to 1).
>>
>> By the way, I've found that p->mcr caches MCR inconsistently. Is it
>> supposed to be so? Or p->mcr is not for caching?
>
> Not for caching; it's for modal settings (eg., AFE) that the 8250 port
> driver needs to merge in when changing mctrl bits (DTR/RTS/etc).
>
> The serial core caches the mctrl bits in uart_port->mctrl, but IMO
> it would be simpler to always set/clear RTS here (rather than like
> the omap-serial driver where it checks the gpio value first).
>
> Is the assumption that userspace will not perform conflicting
> operations, such as ioctl(TIOCMSET) or ioctl(TCSETSx), with RS485 enabled?

I've sent v3 series and put all RTS related stuff into separate
functions. Could you please continue this discussion in "v3 5/5"?
TIOCMGET should work correctly now, because it reads register. I am
not sure that TIOCMSET should be limited somehow, user knows better
what he wants.

> Regards,
> Peter Hurley
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119991, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
