From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] tty/serial: atmel: remove unneeded
 atmel_get_lines_status function
Date: Fri, 23 Aug 2019 16:32:41 +0200
Message-ID: <20190823143241.zixdsnwrtzhgkig7@pengutronix.de>
References: <20190823134109.12402-1-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190823134109.12402-1-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 23, 2019 at 03:41:09PM +0200, Richard Genoud wrote:
> Since commit ce59e48fdbad ("serial: mctrl_gpio: implement interrupt
> handling"), the GPIOs interrupts are handled by mctrl_gpio_irq_handle().

Well no, since ce59e48fdbad the mctrl_gpio helper can do all that
interrupt stuff. You want to reference
18dfef9c7f87b75bbb0fb66a634f7c13a45b9f8d here.

> So, atmel_get_lines_status() can be completely killed and replaced by :
> atmel_uart_readl(port, ATMEL_US_CSR);
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
