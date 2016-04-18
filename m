From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 1/5] doc: DT: Add Generic Serial Device Tree Bindings
Date: Mon, 18 Apr 2016 16:05:24 +0200
Message-ID: <10322130.q5nmK1X286@wuerfel>
References: <1460636003-3011-1-git-send-email-geert+renesas@glider.be> <5792073.qsBJ1LK659@wuerfel> <CAMuHMdWmHUhhwbYDcmNXuxBRC6n+tp=oX03dBaK2VgL4OA72MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdWmHUhhwbYDcmNXuxBRC6n+tp=oX03dBaK2VgL4OA72MQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Barry Song <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Monday 18 April 2016 14:34:12 Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> CC Richard (serial-mctrl-gpio)
> CC Grant (ePAPR successor) and Frank
> 
> On Sat, Apr 16, 2016 at 6:30 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> > On Thursday 14 April 2016 14:13:19 Geert Uytterhoeven wrote:
> >> Document a set of generic properties for describing UARTs in a
> >> device tree:
> >>   1. The GPIO modem control properties are currently duplicated across
> >>      hardware-specific binding documentation,
> >>   2. The property for dedicated RTS/CTS hardware flow control lines is
> >>      already supported by several drivers, albeit with a vendor-specific
> >>      prefix, hence make it generic.
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> >
> > Originally the ISA 8250 uart binding (from ieee) was used as the
> > template for other uart bindings. How about documenting the parts that
> > are used in 8250-of today (current-speed, clock-frequency,
> > reg-offset, reg-shift, fifo-size, reg-io-width, auto-flow-control)
> > in the same file?
> 
> I don't think we have the habit of documenting (duplicating) bindings for ePAPR
> under Documentation/devicetree/bindings/. Perhaps we should?
> 
> Apart from that, most of the properties you mention look legacy or overly
> broad too me.
> 
>   - current-speed: This is configuration, not a property of the hardware.
>     For the console, this has been deprecated by appending the serial config
>     to chosen/stdout-path (e.g. "serial0:115200n8").
>     For non-consoles, its use is debatable, IMHO.
>     It's users are mostly legacy powerpc and early adaptors of DT on ARM.
>   - clock-frequency: Legacy predating the Common Clock Framework.
>     Any modern SoC uses clock specifiers with clock handles pointing to clock
>     providers.

I think both are still used by IBM Firmware, which does not use the clock
binding or the linux syntax for passing the speed.

>   - reg-offset, reg-shift, reg-io-width: These are much broader than serial,
>     and IMHO thus don't belong in
>     Documentation/devicetree/bindings/serial/serial.txt.

The exact meaning can be explained elsewhere, but I think the binding
can mention that they are allowed.

>   - auto-flow-control: Looks a bit like a vague version of "uart-has-rtscts".
>     Documentation/devicetree/bindings/serial/8250.txt doesn't make it clear
>     whether this is about hardware capabilities or software configuration.
>     Even the driver doesn't make it clear:
>     #define UART_CAP_AFE    (1 << 11)       /* MCR-based hw flow control */
>     "MCR" could mean RTS/CTS, DSR/DTR, ...
>   - fifo-size: This one could be generic. atmel-usart uses a vendor-specific
>     version "atmel,fifo-size".
> 
> I suggest we move forward with my initial set, as I have patches that depend on
> them? We can always add more properties later.

Sounds ok to me.

> >>  - out1-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
> >>    used as the UART's OUT1 line.
> >>  - out2-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
> >>    used as the UART's OUT2 line.
> >
> > I had to look up what OUT1 and OUT2 are, but I still don't see how you'd
> > implement them using a GPIO line: From all I can tell, these are usually
> > internal registers in a hardware uart but they are not assigned to an
> > external line on the standard db9 or even the old db25 connectors. Should
> > we drop these instead?
> 
> They're indeed fairly exotic, and they're burried deeply in the ns16550
> datasheet. We do have TIOCM_OUT1 and TIOCM_LOOP in asm-generic/termios.h,
> probably for obscure historical reasons.
> 
> If we drop them, I guess they should be removed from the helper code in
> drivers/tty/serial/serial_mctrl_gpio.c, too? There don't seem to be any
> current users.

I think it makes sense for user space to toggle at least TIOCM_OUT1
through the ioctl and for drivers to implement it correctly. Apparently
the "Hayes SmartModem" used this for resetting the modem from its
integrated uart.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
