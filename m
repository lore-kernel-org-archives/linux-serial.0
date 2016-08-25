From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 25 Aug 2016 11:40:07 -0500
Message-ID: <CAL_JsqJ_5+Em5SLSuqiJ3SnazhyEY2XaYh6N1AtR8_+MdcezMg@mail.gmail.com>
References: <20160818011445.22726-1-robh@kernel.org> <20160818102208.GA20476@kroah.com>
 <CAL_Jsq+Va2OF1pYTivH8YN1GKsiaT1eTOaSv607K_V+H+0Buvw@mail.gmail.com> <20160818160449.328b2eec@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160818160449.328b2eec-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 18, 2016 at 10:04 AM, One Thousand Gnomes
<gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org> wrote:
>> No, the code should be fast as it is so simple. I assume there is some
>> reason the tty buffering is more complex than just a circular buffer.
>
> I would suggest you read n_tty.c carefully and then it'll make a fair bit
> of sense. It has to interlock multiple reader/writes with discipline
> changes and flushes of pending data. At the same time a received
> character may cause output changes including bytes to be queued for
> transmit and the entire lot must not excessively recurse.
>
> It's fun and it took years to make work safely but basically you need to
> handle a simultaneous ldisc change, config change, read of data from the
> buffers, receive, transmit and the receive causing the transmit status to
> change and maybe other transmits, that might have to be sent with
> priority. It's fun 8)
>
> The good news is that nobody but n_tty and maybe n_irda cares on the rx
> side. Every other ldisc consumes the bytes immediately. IRDA hasn't worked
> for years anyway.
>
>> My best guess is because the tty layer has to buffer things for
>> userspace and userspace can be slow to read? Do line disciplines make
>> assumptions about the tty buffering? Is 4KB enough buffering?
>
> RTFS but to save you a bit of effort
>
> 1. 4K is not enough, 64K is not always sufficient, this is why we have
> all the functionality you appear to want to re-invent already in the tty
> buffer logic of the tty_port
> 2. Only n_tty actually uses the tty_port layer buffering
> 3. The ring buffer used for dumb uarts is entirely about latency limits
> on low end processors and only used by some uarts anyway.
>
>> Also, the current receive implementation has no concept of blocking or
>> timeout. Should the uart_dev_rx() function return when there's no more
>> data or wait (with timeout) until all requested data is received?
>> (Probably do all of them is my guess).
>
> Your rx routine needs to be able to run in IRQ context, not block and
> complete in very very short time scales because on some hardware you have
> exactly 9 bit times to recover the data byte and clear the IRQ done.
> Serial really stretches some of the low end embedded processors running
> at 56K/115200, and RS485 at 4Mbits even with 8 bytes of buffering is
> pretty tight. Thus you need very fast buffers for just about any use case.
> Dumb uarts you'll need to keep the existing ring buffer or similar
> (moving to a kfifo would slightly improve performance I think) and queue
> after.
>
>> >> - Convert a real driver/line discipline over to UART bus.
>> >
>> > That's going to be the real test, I recommend trying that as soon as
>> > possible as it will show where the real pain points are :)
>
> The locking. It's taken ten years to debug the current line discipline
> change locking. If you want to be able to switch stuff kernel side
> however it's somewhat easier.
>
> The change should be
>
> Add tty_port->rx(uint8_t *data,uint8_t *flags, unsigned int len)
>
> The semantics of tty_port->rx are
>
> - You may not assume a tty is bound to this port
> - You may be called in IRQ context, but are guaranteed not to get
>   parallel calls for the same port
> - When you return the bytes you passed are history
>
> At that point you can set tty_port->rx to point to the
> tty_flip_buffer_push() and everyone can use it. Slow ones will want to
> queue to a ring buffer then do tty_port->rx (where we do the flush_buffer
> now), fast ones will do the ->rx directly.

Other than doing DMA, I did not find any examples of UARTs doing
internal rx ring buffers. Most/all the non-DMA cases do
tty_insert_flip_char directly in the ISR. The flow is insert a series
of flags and characters as we process the receive status and then
trigger a flush of the buffer at the end. That doesn't match up with
what you are proposing for how tty_port->rx would work. That would
change the receive ISR processing in all the drivers quite a bit.
Either we'd have to call tty_port->rx a character at a time or
implement some temporary buffer. I don't think we want to call things
like BT receive code a byte at a time. This needs to be a layer
higher. flush_to_ldisc either needs to be duplicated to handle
tty_port->rx or generalized to call either tty_port->rx or ldisc
receive_buf. I'm not sure what to do about ldisc ref counting in the
latter case.

Rob
