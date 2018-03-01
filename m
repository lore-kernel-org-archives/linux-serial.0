From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] earlycon: Allow specifying a uartclk in options
Date: Thu, 1 Mar 2018 20:46:34 +0200
Message-ID: <CAHp75VcZSkQHFgfAgePQsfsYOZOZxsgz3-+W7X42Gw2hrxODEg@mail.gmail.com>
References: <20180301182028.237856-1-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180301182028.237856-1-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: adurbin@chromium.org, Brian Norris <briannorris@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 1, 2018 at 8:20 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> Currently when an earlycon is registered, the uartclk is assumed to be
> BASE_BAUD * 16 = 1843200.  If a baud rate is specified in the earlycon
> options, then 8250_early's init_port will program the UART clock divider
> registers based on this assumed uartclk.
>
> However, not all uarts have a UART clock of 1843200.  For example, the
> 8250_dw uart in AMD's CZ/ST uses a fixed 48 MHz clock (as specified in
> cz_uart_desc in acpi_apd.c).  Thus, specifying a baud when using earlycon
> on such a device will result in incorrect divider values and a wrong UART
> clock.
>
> Fix this by extending the earlycon options parameter to allow specification
> of a uartclk, like so:
>
>  earlycon=uart,mmio32,0xfedc6000,115200,48000000
>
> If none is specified, fall-back to prior behavior - 1843200.

It needs to be discussed.

First of all, if you are going to do this you need to add a parse of
human readable formats (IIRC kernel has helpers), i.e. "48M", "38.4M"
and so on.

Next, I was under impression that purpose of earlycon (in difference
to earlyprintk) is to re-use existing drivers as fully as possible.

So, what exactly happens in your case? Are your driver lacks of
properly set clock? Or earlycon does simple not utilizing this
information?

-- 
With Best Regards,
Andy Shevchenko
