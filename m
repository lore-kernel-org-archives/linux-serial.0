From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RESEND 3/5] tty/serial: Add GPIOLIB helpers for
 controlling modem lines
Date: Wed, 28 May 2014 12:47:21 -0700
Message-ID: <20140528194721.GA12869@kroah.com>
References: <1400005245-11943-1-git-send-email-richard.genoud@gmail.com>
 <1400005245-11943-4-git-send-email-richard.genoud@gmail.com>
 <20140528194550.GA12735@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:39813 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841AbaE1Tnq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 May 2014 15:43:46 -0400
Content-Disposition: inline
In-Reply-To: <20140528194550.GA12735@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Yegor Yefremov <yegor_sub1@visionsystems.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, May 28, 2014 at 12:45:50PM -0700, Greg Kroah-Hartman wrote:
> On Tue, May 13, 2014 at 08:20:43PM +0200, Richard Genoud wrote:
> > This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
> > GPIO.
> > This will be useful for many boards which have a serial controller that
> > only handle CTS/RTS pins (or even just RX/TX).
> > 
> > Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> > Tested-by: Yegor Yefremov <yegorslists@googlemail.com>
> > ---
> >  Documentation/serial/driver            |   25 ++++++
> >  drivers/tty/serial/Kconfig             |    3 +
> >  drivers/tty/serial/Makefile            |    3 +
> >  drivers/tty/serial/serial_mctrl_gpio.c |  143 ++++++++++++++++++++++++++++++++
> >  drivers/tty/serial/serial_mctrl_gpio.h |  110 ++++++++++++++++++++++++
> >  5 files changed, 284 insertions(+)
> >  create mode 100644 drivers/tty/serial/serial_mctrl_gpio.c
> >  create mode 100644 drivers/tty/serial/serial_mctrl_gpio.h
> > 
> > diff --git a/Documentation/serial/driver b/Documentation/serial/driver
> > index c3a7689..3bba1ae 100644
> > --- a/Documentation/serial/driver
> > +++ b/Documentation/serial/driver
> > @@ -429,3 +429,28 @@ thus:
> >  		struct uart_port	port;
> >  		int			my_stuff;
> >  	};
> > +
> > +Modem control lines via GPIO
> > +----------------------------
> > +
> > +Some helpers are provided in order to set/get modem control lines via GPIO.
> > +
> > +mctrl_gpio_init(dev, idx):
> > +	This will get the {cts,rts,...}-gpios from device tree if they are
> > +	present and request them, set direction etc, and return an
> > +	allocated structure. devm_* functions are used, so there's no need
> > +	to call mctrl_gpio_free().
> > +
> > +mctrl_gpio_free(dev, gpios):
> > +	This will free the requested gpios in mctrl_gpio_init().
> > +	As devm_* function are used, there's generally no need to call
> > +	this function.
> > +
> > +mctrl_gpio_to_gpiod(gpios, gidx)
> > +	This returns the gpio structure associated to the modem line index.
> > +
> > +mctrl_gpio_set(gpios, mctrl):
> > +	This will sets the gpios according to the mctrl state.
> > +
> > +mctrl_gpio_get(gpios, mctrl):
> > +	This will update mctrl with the gpios values.
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index 5d9b01a..95afd31 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -1510,4 +1510,7 @@ config SERIAL_ST_ASC_CONSOLE
> >  
> >  endmenu
> >  
> > +config SERIAL_MCTRL_GPIO
> > +	tristate
> 
> Why is this added here?  Who is going to use it?

Ah, the next patch does, nevermind...

