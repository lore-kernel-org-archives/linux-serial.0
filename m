From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH v6] serial: 8250_uniphier: add UniPhier serial driver
Date: Tue, 26 May 2015 15:28:38 +0100
Message-ID: <1432650518.13900.72.camel@linux.intel.com>
References: <1432525477-14051-1-git-send-email-yamada.masahiro@socionext.com>
	 <1432545245.8736.5.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432545245.8736.5.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Cc: "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>, "manabian@gmail.com" <manabian@gmail.com>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>, "ricardo.ribalda@gmail.com" <ricardo.ribalda@gmail.com>, "blogic@openwrt.org" <blogic@openwrt.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "peter@hurleysoftware.com" <peter@hurleysoftware.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

> > +
> > +#define UNIPHIER_UART_CHAR_FCR	3	/* Character / FIFO Control Register */
> > +#define UNIPHIER_UART_LCR_MCR	4	/* Line/Modem Control Register */
> > +#define   UNIPHIER_UART_LCR_SHIFT	8
> 
> Indentation problem, needs to be fixed.

If you are going to review a patch set at least look at the previous
reviews - the indentation was already discussed and is done that way to
show (as many drivers do) which are fields for which registers

> > +static unsigned int uniphier_serial_in(struct uart_port *p, int offset)
> > +{
> > +	int valshift = 0;
> 
> Perhaps unsigned int?

Why ? even if it mattered gcc is already realising that the value can
only be 0 or 8 and will be generating whatever works best for that.


Alan
