From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/9] serial: Add common rs485 device tree parsing function
Date: Thu, 22 Jun 2017 10:01:43 +0200
Message-ID: <20170622080143.waljtsziek2ciqmd@pengutronix.de>
References: <20170621102130.21024-1-u.kleine-koenig@pengutronix.de>
 <20170621102130.21024-2-u.kleine-koenig@pengutronix.de>
 <20170622061007.h76gk3hixp4ipyvr@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170622061007.h76gk3hixp4ipyvr-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jun 22, 2017 at 08:10:07AM +0200, Sascha Hauer wrote:
> On Wed, Jun 21, 2017 at 12:21:22PM +0200, Uwe Kleine-König wrote:
> > From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > 
> > Several drivers have the same device tree parsing code. Create
> > a common helper function for it.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >  drivers/tty/serial/Kconfig  |  4 ++++
> >  drivers/tty/serial/Makefile |  2 ++
> >  drivers/tty/serial/of.c     | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/serial_core.h | 12 ++++++++++++
> >  4 files changed, 63 insertions(+)
> >  create mode 100644 drivers/tty/serial/of.c
> > 
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index 5c8850f7a2a0..8baef5b95bed 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -14,6 +14,10 @@ config SERIAL_EARLYCON
> >  	  the console before standard serial driver is probed. The console is
> >  	  enabled when early_param is processed.
> >  
> > +config OF_SERIAL
> > +	depends on SERIAL_CORE
> > +	def_bool y
> 
> This probably also needs a dependency on some device tree option,
> CONFIG_OF maybe?

Without CONFIG_OF of_property_read_u32_array returns -ENOSYS and
of_property_read_bool returns false. So I think (but didn't test) there
is no problem not depending on more stuff.

But maybe do:

	if (!np)
		return 1;

in of_get_rs485_mode?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
