From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] serial: 8250_uniphier: add UniPhier serial driver
Date: Mon, 18 May 2015 12:24:19 +0900
Message-ID: <CAK7LNAT6AEog7u9C3kAyMJc3OqP5WOcZVe=30PXN1+dGQiSfmA@mail.gmail.com>
References: <1431692764-17576-1-git-send-email-yamada.masahiro@socionext.com>
	<CABuKBeJnMcyH7TGtYcUToRhLnu_qcxHtwEedS2JgGjX8EiX1Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABuKBeJnMcyH7TGtYcUToRhLnu_qcxHtwEedS2JgGjX8EiX1Gw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, John Crispin <blogic@openwrt.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Hi Matthias,


2015-05-16 18:17 GMT+09:00 Matthias Brugger <matthias.bgg@gmail.com>:

>> +/*
>> + * The register map is slightly different from that of 8250.
>> + * IO callbacks must be overridden for correct access to FCR, LCR, and MCR.
>> + */
>> +static unsigned int uniphier_serial_in(struct uart_port *p, int offset)
>> +{
>> +       int valshift = 0;
>> +
>> +       switch (offset) {
>> +       case UART_LCR:
>> +               valshift = 8;
>
> Please use a define for the value. Something like UNIPHIER_UART_LCR_SHIFT maybe.
>


Will do in v2.

Thank you!


-- 
Best Regards
Masahiro Yamada
