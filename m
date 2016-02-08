From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] serial: 8250: fix building Ingenic with SERIAL_8250=m
Date: Mon, 08 Feb 2016 22:45:07 +0100
Message-ID: <2444356.TvhDejDUJL@wuerfel>
References: <1454935947-2743255-1-git-send-email-arnd@arndb.de> <1454935947-2743255-2-git-send-email-arnd@arndb.de> <20160208164543.GY23093@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160208164543.GY23093@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, Eddie Huang <eddie.huang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Matt Redfearn <matt.redfearn@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Monday 08 February 2016 11:45:44 Paul Gortmaker wrote:
> [[PATCH 2/2] serial: 8250: fix building Ingenic with SERIAL_8250=m] On 08/02/2016 (Mon 13:51) Arnd Bergmann wrote:
> 
> > The Ingenic 8250 driver has a 'bool' Kconfig symbol, but that
> > breaks when SERIAL_8250 is a loadable module:
> > 
> > drivers/tty/built-in.o: In function `ingenic_uart_probe':
> > 8250_ingenic.c:(.text+0x1c1a0): undefined reference to `serial8250_register_8250_port'
> > 
> > This changes the symbol to a 'tristate', plus a dependency on
> 
> Note that Greg just queued a patch yesterday (but sent in 2015) that
> removed what was the dead modular code.
> 
> It could also depend on SERIAL_8250=y to resolve the build issue you
> found, if nobody cares about having modular SOC console UART drivers.

All other UART drivers can be modules, no need for this to be an
exception I think. Having it depend on SERIAL_8250=y would make the
driver disabled on 'allmodconfig', which is a bit counterproductive for
the purpose of allmodconfig. I don't think anyone actually cares about
the driver being runtime loaded on real hardware.

> Either way, I don't have issue with it being tristate vs bool, but if
> you do go with tristate, then my patch will have to be dropped/reverted.

Fine with me too.

I also now saw in the randconfig builds that the driver is missing an #include
<linux/module.h>, which I guess is going to be there after reverting your
patch.

I'll send a new series.

	Arnd
