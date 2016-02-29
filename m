From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1] serial: mctrl_gpio: Add missing module license
Date: Mon, 29 Feb 2016 09:49:40 +0100
Message-ID: <20160229084940.GF2613@pengutronix.de>
References: <1456239294-28342-1-git-send-email-romain.izard.pro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456239294-28342-1-git-send-email-romain.izard.pro@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello Romain,

On Tue, Feb 23, 2016 at 03:54:54PM +0100, Romain Izard wrote:
> As the mctrl_gpio driver can be built as a module, it needs to have i=
ts
> license specified with MODULE_LICENSE. Otherwise, it cannot access
> required symbols exported through EXPORT_SYMBOL_GPL.
>=20
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> ---
>  drivers/tty/serial/serial_mctrl_gpio.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/ser=
ial/serial_mctrl_gpio.c
> index 226ad23b136c..02147361eaa9 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.c
> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> @@ -20,6 +20,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/termios.h>
>  #include <linux/serial_core.h>
> +#include <linux/module.h>
> =20
>  #include "serial_mctrl_gpio.h"
> =20
> @@ -249,3 +250,5 @@ void mctrl_gpio_disable_ms(struct mctrl_gpios *gp=
ios)
>  	}
>  }
>  EXPORT_SYMBOL_GPL(mctrl_gpio_disable_ms);
> +
> +MODULE_LICENSE("GPL");

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
