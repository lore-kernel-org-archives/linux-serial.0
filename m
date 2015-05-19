From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v3] serial: 8250_uniphier: add UniPhier serial driver
Date: Tue, 19 May 2015 10:48:00 +0100
Message-ID: <20150519104800.5ebd3518@lxorguk.ukuu.org.uk>
References: <1431997900-18390-1-git-send-email-yamada.masahiro@socionext.com>
	<CABuKBeJwOp3Km=Vw+xn8cRtH8DC-TNB_m7s8WSdPxzKHdzrdcw@mail.gmail.com>
	<CAK7LNARrjkCcMsVJwe5hdB71QsEQAf51sNf4xYVMkNazdbdxKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNARrjkCcMsVJwe5hdB71QsEQAf51sNf4xYVMkNazdbdxKA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Peter Hurley <peter@hurleysoftware.com>, John Crispin <blogic@openwrt.org>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joachim Eastwood <manabian@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "linux-arm-kernel@lists.infradead.org\" <linux-arm-kernel@lists.infradead.org>"@lxorguk.ukuu.org.uk
List-Id: linux-serial@vger.kernel.org

> I intentionally use deeper indentation for *_SHIFT
> because I want to clearly show  UNIPHIER_UART_LCR_SHIFT
> belongs to UNIPHIER_UART_LCR_MCR register.

Seems sensible to do it that way to me and a lot of other bits of the
kernel do.

The only other question I have is about the unipher_serial_out. If I am
writing a "special" register then the sequence becomes

- read 32bits
- modify
- write 32bits

That means that it's no longer atomic safe as the kernel expects.
Checking the users FCR seems safe, LCR is probably safe and MCR likewise
so I don't see a problem but I think it's worth noting in case anyone
else does.

Finally can you add a comment in serial_in and serial_out where one
switch case drops through into the next so its obvious to anyone looking
at Coverity and other analyser output that this drop through was
intentional ?

Alan
