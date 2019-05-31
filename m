From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/6] serial: sa1100: add support for mctrl gpios
Date: Fri, 31 May 2019 14:23:40 +0100
Message-ID: <20190531132340.bco6xpyl3aatbryl@shell.armlinux.org.uk>
References: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
 <E1hWfTn-0003fP-Rl@rmk-PC.armlinux.org.uk>
 <20190531125013.3gkexhmbqjpdvrtf@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190531125013.3gkexhmbqjpdvrtf@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Fri, May 31, 2019 at 02:50:13PM +0200, Uwe Kleine-K=F6nig wrote:
> On Fri, May 31, 2019 at 12:13:47PM +0100, Russell King wrote:
> > Add support for the generic mctrl gpio helper.  This will allow us to
> > convert several board files to use the gpiod tables to assign GPIOs to
> > serial ports, rather than needing to have private function callbacks.
> > =

> > If the generic mctrl gpio helper fails, ignore the mctrl gpios rather
> > than preventing the (possibly console) serial port from being created.
> > =

> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/tty/serial/Kconfig  |  1 +
> >  drivers/tty/serial/sa1100.c | 42 +++++++++++++++++++++++++++++++++++++=
+----
> >  2 files changed, 39 insertions(+), 4 deletions(-)
> > =

> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index 72966bc0ac76..f4372ac1a774 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -511,6 +511,7 @@ config SERIAL_SA1100
> >  	bool "SA1100 serial port support"
> >  	depends on ARCH_SA1100
> >  	select SERIAL_CORE
> > +	select SERIAL_MCTRL_GPIO if GPIOLIB
> >  	help
> >  	  If you have a machine based on a SA1100/SA1110 StrongARM(R) CPU you
> >  	  can enable its onboard serial port by enabling this option.
> > diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
> > index a399772be3fc..97bdfeccbea9 100644
> > --- a/drivers/tty/serial/sa1100.c
> > +++ b/drivers/tty/serial/sa1100.c
> > @@ -28,6 +28,8 @@
> >  #include <mach/hardware.h>
> >  #include <mach/irqs.h>
> >  =

> > +#include "serial_mctrl_gpio.h"
> > +
> >  /* We've been assigned a range on the "Low-density serial ports" major=
 */
> >  #define SERIAL_SA1100_MAJOR	204
> >  #define MINOR_START		5
> > @@ -77,6 +79,7 @@ struct sa1100_port {
> >  	struct uart_port	port;
> >  	struct timer_list	timer;
> >  	unsigned int		old_status;
> > +	struct mctrl_gpios	*gpios;
> >  };
> >  =

> >  /*
> > @@ -174,6 +177,8 @@ static void sa1100_enable_ms(struct uart_port *port)
> >  		container_of(port, struct sa1100_port, port);
> >  =

> >  	mod_timer(&sport->timer, jiffies);
> > +
> > +	mctrl_gpio_enable_ms(sport->gpios);
> >  }
> >  =

> >  static void
> > @@ -322,11 +327,21 @@ static unsigned int sa1100_tx_empty(struct uart_p=
ort *port)
> >  =

> >  static unsigned int sa1100_get_mctrl(struct uart_port *port)
> >  {
> > -	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
> > +	struct sa1100_port *sport =3D
> > +		container_of(port, struct sa1100_port, port);
> > +	int ret =3D TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
> > +
> > +	mctrl_gpio_get(sport->gpios, &ret);
> > +
> > +	return ret;
> >  }
> >  =

> >  static void sa1100_set_mctrl(struct uart_port *port, unsigned int mctr=
l)
> >  {
> > +	struct sa1100_port *sport =3D
> > +		container_of(port, struct sa1100_port, port);
> > +
> > +	mctrl_gpio_set(sport->gpios, mctrl);
> >  }
> >  =

> >  /*
> > @@ -842,6 +857,27 @@ static int sa1100_serial_resume(struct platform_de=
vice *dev)
> >  	return 0;
> >  }
> >  =

> > +static int sa1100_serial_add_one_port(struct sa1100_port *sport, struc=
t platform_device *dev)
> > +{
> > +	sport->port.dev =3D &dev->dev;
> > +	sport->gpios =3D mctrl_gpio_init_noauto(sport->port.dev, 0);
> =

> the _noauto function was only introduced to ease a transition. I think
> the driver would benefit to use mctrl_gpio_init() instead.

In what way would the driver benefit?  mctrl_gpio_init() requires that
there are IRQs for each input GPIO.  This is not the case with most
SA11x0 platforms, where the GPIO controls are implemented using simple
latches, hence that interface is entirely unsuitable.

-- =

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps =
up
According to speedtest.net: 11.9Mbps down 500kbps up
