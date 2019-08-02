From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/3] serial: mctrl_gpio: Avoid probe failures in case
 of missing gpiolib
Date: Fri, 2 Aug 2019 10:24:41 +0200
Message-ID: <20190802082441.udsrc5ev4nwj7abz@pengutronix.de>
References: <20190801184505.17239-1-frieder.schrempf@kontron.de>
 <20190801203316.7ntlv6hequmddfxu@pengutronix.de>
 <011ac0ac-571e-b898-2b2d-89b9a771b0c1@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <011ac0ac-571e-b898-2b2d-89b9a771b0c1@kontron.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Schrempf Frieder <frieder.schrempf@kontron.de>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-imx@nxp.com" <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "festevam@gmail.com" <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hello,

On Fri, Aug 02, 2019 at 07:56:54AM +0000, Schrempf Frieder wrote:
> On 01.08.19 22:33, Uwe Kleine-König wrote:
> > On Thu, Aug 01, 2019 at 06:45:21PM +0000, Schrempf Frieder wrote:
> >> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
> >> index 2b400189be91..54c43e02e375 100644
> >> --- a/drivers/tty/serial/serial_mctrl_gpio.c
> >> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> >> @@ -61,6 +61,9 @@ EXPORT_SYMBOL_GPL(mctrl_gpio_set);
> >>   struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
> >>   				      enum mctrl_gpio_idx gidx)
> >>   {
> >> +	if (gpios == NULL)
> >> +		return NULL;
> >> +
> > 
> > I wonder why you need this. If GPIOLIB is off this code isn't active and
> > with GPIOLIB calling mctrl_gpio_to_gpiod with a gpios == NULL is a bug
> > that IMHO should not be silently ignored.
> > 
> > Am I missing something (again)?
> 
> No, you're right. My thoughts were, that if the mctrl_gpio functions are 
> allowed to be passed a NULL pointer in general, they all should have a 
> NULL check, even if in the current context (GPIOLIB disabled) this code 
> is not active. Apparently there are other cases when a NULL pointer is 
> passed, see [1]. So you can't really consider gpios == NULL to be a bug 
> as this seems to be allowed in general.

OK, then this is another separate commit, right? Preferably with a
comment pointing to drivers that use mctrl_gpio before being
initialized.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
