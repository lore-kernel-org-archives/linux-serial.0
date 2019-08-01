From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/3] serial: mctrl_gpio: Avoid probe failures in case
 of missing gpiolib
Date: Thu, 1 Aug 2019 22:33:16 +0200
Message-ID: <20190801203316.7ntlv6hequmddfxu@pengutronix.de>
References: <20190801184505.17239-1-frieder.schrempf@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190801184505.17239-1-frieder.schrempf@kontron.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Schrempf Frieder <frieder.schrempf@kontron.de>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-imx@nxp.com" <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "festevam@gmail.com" <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 01, 2019 at 06:45:21PM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> =

> If CONFIG_GPIOLIB is not enabled, mctrl_gpio_init() and
> mctrl_gpio_init_noauto() will currently return an error pointer with
> -ENOSYS. As the mctrl GPIOs are usually optional, drivers need to
> check for this condition to allow continue probing.
> =

> To avoid the need for this check in each driver, we return NULL
> instead, as all the mctrl_gpio_*() functions are skipped anyway.
> We also adapt mctrl_gpio_to_gpiod() to be in line with this change.
> =

> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

nitpick: put your S-o-b last.

> ---
> Changes in v2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> * Move the sh_sci changes to a separate patch
> * Add a patch for the 8250 driver
> * Add Fabio's R-b tag
> ---
>  drivers/tty/serial/serial_mctrl_gpio.c | 3 +++
>  drivers/tty/serial/serial_mctrl_gpio.h | 6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
> =

> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/=
serial_mctrl_gpio.c
> index 2b400189be91..54c43e02e375 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.c
> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> @@ -61,6 +61,9 @@ EXPORT_SYMBOL_GPL(mctrl_gpio_set);
>  struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
>  				      enum mctrl_gpio_idx gidx)
>  {
> +	if (gpios =3D=3D NULL)
> +		return NULL;
> +

I wonder why you need this. If GPIOLIB is off this code isn't active and
with GPIOLIB calling mctrl_gpio_to_gpiod with a gpios =3D=3D NULL is a bug
that IMHO should not be silently ignored.

Am I missing something (again)?

>  	return gpios->gpio[gidx];
>  }

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
