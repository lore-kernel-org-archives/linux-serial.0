From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3] serial: 8250_uniphier: add UniPhier serial driver
Date: Tue, 19 May 2015 13:31:21 +0200
Message-ID: <CABuKBeJ=5QrGikYbOctUKfE6Y54w5BpjpCxVvFiFrp4mThZ0Jg@mail.gmail.com>
References: <1431997900-18390-1-git-send-email-yamada.masahiro@socionext.com>
	<CABuKBeJwOp3Km=Vw+xn8cRtH8DC-TNB_m7s8WSdPxzKHdzrdcw@mail.gmail.com>
	<CAK7LNARrjkCcMsVJwe5hdB71QsEQAf51sNf4xYVMkNazdbdxKA@mail.gmail.com>
	<20150519104800.5ebd3518@lxorguk.ukuu.org.uk>
	<CAK7LNARG6F97s9gTY_YZi0srKUBebFd1uBJhbVjzj_dAn9+nsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNARG6F97s9gTY_YZi0srKUBebFd1uBJhbVjzj_dAn9+nsg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>, John Crispin <blogic@openwrt.org>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joachim Eastwood <manabian@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "linux-arm-kernel@lists.infradead.org\" <linux-arm-kernel@lists.infradead.org>"@lxorguk.ukuu.org.uk
List-Id: linux-serial@vger.kernel.org

2015-05-19 13:18 GMT+02:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Hi Alan,
>
>
> 2015-05-19 18:48 GMT+09:00 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>:
>>> I intentionally use deeper indentation for *_SHIFT
>>> because I want to clearly show  UNIPHIER_UART_LCR_SHIFT
>>> belongs to UNIPHIER_UART_LCR_MCR register.
>>
>> Seems sensible to do it that way to me and a lot of other bits of the
>> kernel do.
>>
>> The only other question I have is about the unipher_serial_out. If I am
>> writing a "special" register then the sequence becomes
>>
>> - read 32bits
>> - modify
>> - write 32bits
>>
>> That means that it's no longer atomic safe as the kernel expects.
>> Checking the users FCR seems safe, LCR is probably safe and MCR likewise
>> so I don't see a problem but I think it's worth noting in case anyone
>> else does.
>
> Uh, I missed this.
> I am a bit afraid what if LCR and MCR are updated at the same time.
>
> Is it better to add mutex for writing special case registers?
>
>     if (normal) {
>             writel(value, p->membase + offset);
>     } else {
>             /* special case: two registers share the same address. */
>             u32 tmp = readl(p->membase + offset);
>             struct uniphier8250_priv *priv = p->private_data;
>
>             mutex_lock(&priv->atomic_write_lock);
>             tmp &= ~(0xff << valshift);
>             tmp |= value << valshift;
>             writel(tmp, p->membase + offset);
>             mutex_unlock(&priv->atomic_write_lock);
>     }
>
>
> If it is OK, I can fix it in v4.
>
>
>
>
>> Finally can you add a comment in serial_in and serial_out where one
>> switch case drops through into the next so its obvious to anyone looking
>> at Coverity and other analyser output that this drop through was
>> intentional ?
>
> I thought about it, too.
>
> My previous version was as follows:
>
>
> +#define UNIPHIER_UART_CHAR_FCR 3
> +#define     UNIPHIER_UART_CHAR_SHIFT   8       /* Character Register */
> +#define     UNIPHIER_UART_FCR_SHIFT    0       /* FIFO Control Register */
> +#define UNIPHIER_UART_LCR_MCR  4
> +#define     UNIPHIER_UART_LCR_SHIFT    8       /* Line Control Register */
> +#define     UNIPHIER_UART_MCR_SHIFT    0       /* Modem Control Register */
> +#define UNIPHIER_UART_DLR      9               /* Divisor Latch Register */
>
> [snip]
>
> +static void uniphier_serial_out(struct uart_port *p, int offset, int value)
> +{
> +       int valshift = 0;
> +       bool normal = false;
> +
> +       switch (offset) {
> +       case UART_FCR:
> +               offset = UNIPHIER_UART_CHAR_FCR;
> +               valshift = UNIPHIER_UART_FCR_SHIFT;
> +               break;
> +       case UART_LCR:
> +               offset = UNIPHIER_UART_LCR_MCR;
> +               valshift = UNIPHIER_UART_LCR_SHIFT;
> +               /* Divisor latch access bit does not exist. */
> +               value &= ~(UART_LCR_DLAB << valshift);
> +               break;
> +       case UART_MCR:
> +               offset = UNIPHIER_UART_LCR_MCR;
> +               valshift = UNIPHIER_UART_MCR_SHIFT;
> +               break;
> +       default:
> +               normal = true;
> +               break;
> +       }
>
>
>
> I thought it was clear to anyone although it was a bit redundant and
> Matthias was opposed to it.
>
> I personally prefer clear code to tricky code that requires comments.

Me too :)
What I wanted to say was, that in the case statement you don't need to
set valshift to zero as this is the default value when entering
uniphier_serial_out. This way you can get rid of
UNIPHIER_UART_MCR_SHIFT and UNIPHIER_UART_FCR_SHIFT.

Sorry, I didn't explained myself.

Cheers,
Matthias
-- 
motzblog.wordpress.com
