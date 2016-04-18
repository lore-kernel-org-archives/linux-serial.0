From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/5] doc: DT: Add Generic Serial Device Tree Bindings
Date: Mon, 18 Apr 2016 10:02:55 -0700
Message-ID: <5715133F.2040103@hurleysoftware.com>
References: <1460636003-3011-1-git-send-email-geert+renesas@glider.be>
 <1460636003-3011-2-git-send-email-geert+renesas@glider.be>
 <5792073.qsBJ1LK659@wuerfel>
 <CAMuHMdWmHUhhwbYDcmNXuxBRC6n+tp=oX03dBaK2VgL4OA72MQ@mail.gmail.com>
 <CACQ1gAhnEuCZbzpyiAcCx_kRhzCBvWAVVaecUdUhvu4vDD0REw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACQ1gAhnEuCZbzpyiAcCx_kRhzCBvWAVVaecUdUhvu4vDD0REw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Barry Song <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On 04/18/2016 08:43 AM, Richard Genoud wrote:
> 2016-04-18 14:34 GMT+02:00 Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>:
>> Hi Arnd,
>>
>> CC Richard (serial-mctrl-gpio)
>> CC Grant (ePAPR successor) and Frank
>>
>> On Sat, Apr 16, 2016 at 6:30 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
>>> On Thursday 14 April 2016 14:13:19 Geert Uytterhoeven wrote:

[...]

>>>>  - out1-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
>>>>    used as the UART's OUT1 line.
>>>>  - out2-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
>>>>    used as the UART's OUT2 line.
>>>
>>> I had to look up what OUT1 and OUT2 are, but I still don't see how you'd
>>> implement them using a GPIO line: From all I can tell, these are usually
>>> internal registers in a hardware uart but they are not assigned to an
>>> external line on the standard db9 or even the old db25 connectors. Should
>>> we drop these instead?

Yeah, not sure how those snuck in for gpios.

The original 8250/16550 uarts had OUT1 and OUT2 pins, and OUT1 could be used
like gpio. That was 3 decades ago though so maybe we don't need to try to
recreate that tech again :)


>> They're indeed fairly exotic, and they're burried deeply in the ns16550
>> datasheet. We do have TIOCM_OUT1 and TIOCM_LOOP in asm-generic/termios.h,
>> probably for obscure historical reasons.

Please leave the bit defs alone.


>> If we drop them, I guess they should be removed from the helper code in
>> drivers/tty/serial/serial_mctrl_gpio.c, too? There don't seem to be any
>> current users.
> I must confess that I don't really know what TIOCM_OUT1&2 are for.
> (I implemented them for completeness)
> But it seems that OUT2 is used in some drivers:
> drivers/tty/serial/omap-serial.c:
>         /*
>          * Most PC uarts need OUT2 raised to enable interrupts.
>          */
>         up->port.mctrl |= TIOCM_OUT2;

There's no need for OUT1 and OUT2 gpios; let's fix that.

Regards,
Peter Hurley

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
