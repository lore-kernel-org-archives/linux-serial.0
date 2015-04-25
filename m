From: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: 8250-based SoC serial ports and features
Date: Sat, 25 Apr 2015 16:33:18 +0200
Message-ID: <CAGhQ9VyrnPrgzqtkTN5V7zpSQQ6QhmQdpQi5Sc1eTkcQnxKZXw@mail.gmail.com>
References: <CAGhQ9Vw5hJKX+wrhV91mGmB00eUJKaR8Astns8rpk465BQnv1Q@mail.gmail.com>
	<9563845.vZY1xECvNe@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9563845.vZY1xECvNe@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 24 April 2015 at 14:06, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Friday 24 April 2015 13:48:57 Joachim Eastwood wrote:
>> Hi,
>>
>> I am working on a DT supported SoC which has a 8250-based USART block
>> with some additional features:
>>  - Two clocks (baud and reg)
>>  - DMA support (DMA engine)
>>  - RS485
>>
>> Should support for these things be put into a 8250_<soc uart>.c file
>> or should of_serial.c be extended?
>> I am leaning towards creating a 8250_<soc uart>.c since the RS485
>> support can't be made generic here.
>
> Yes, that seems fine. If you need a separate file, don't put it
> into of_serial.c
>
>> On a related note: How should quirks be handeled?
>> Example: arch/arm/mach-lpc32xx/serial.c does applies a lot of errata
>> workarounds. (This UART also requires two clocks)
>> Should this be moved into a 8250_lpc32xx_uart.c file or it's there a
>> better place to do this?
>
> That code probably needs to be rewritten before it can be put into
> drivers/tty/serial/, but I think that's where it should go if anyone
> finds the time, and can convert lpc32xx to use common-clk first.

One other question: What is the preferred way of describing different
UART SoC features in DT?
16550a is used as base on most NXP Cortex-M devices, but each UART can
have different features like; IRDA, Smart card, RS485, sync mode
(USART), DMA, hardware RTS/CTS pins and full modem pins.
Features also differ between UARTs on the same device.

I am thinking about either using different comp strings or some kind
of feature flags in DT. (Freescale UART already uses feature flags
like: "fsl,irda-mode" and "fsl,uart-has-rtscts")

All UARTs on LPC1850 have RS485 and DMA support. In additional you have:
UART0,2,3: sync mode and smart card.
UART3: IRDA
UART1: full modem control pin set.

Comp strings could be something like:
"nxp,lpc1850-usart" <- sync+smart card
"nxp,lpc1850-usart-irda" <- sync+smart card+irda
"nxp,lpc1850-uart-modem" <- modem-pins

or feature flags like:
nxp,sync-mode;
nxp,rs485-mode;
nxp,smart-card;
nxp,irda-mode;
nxp,full-modem;

regards,
Joachim Eastwood
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
