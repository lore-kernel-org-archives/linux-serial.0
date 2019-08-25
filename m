From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty/serial: atmel: remove unneeded
 atmel_get_lines_status function
Date: Sun, 25 Aug 2019 10:45:51 +0200
Message-ID: <20190825084551.GA6458@kroah.com>
References: <20190823134109.12402-1-richard.genoud@gmail.com>
 <20190823143241.zixdsnwrtzhgkig7@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190823143241.zixdsnwrtzhgkig7@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Richard Genoud <richard.genoud@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 23, 2019 at 04:32:41PM +0200, Uwe Kleine-König wrote:
> On Fri, Aug 23, 2019 at 03:41:09PM +0200, Richard Genoud wrote:
> > Since commit ce59e48fdbad ("serial: mctrl_gpio: implement interrupt
> > handling"), the GPIOs interrupts are handled by mctrl_gpio_irq_handle().
> 
> Well no, since ce59e48fdbad the mctrl_gpio helper can do all that
> interrupt stuff. You want to reference
> 18dfef9c7f87b75bbb0fb66a634f7c13a45b9f8d here.

Richard, can you resend with this changed?

thanks

greg k-h
