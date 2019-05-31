From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] serial: sa1100: add note about modem control signals
Date: Fri, 31 May 2019 23:27:02 +0200
Message-ID: <20190531212702.cmqbaqwdybgkb3ug@pengutronix.de>
References: <20190531155700.crrawgf3iot2sm2t@shell.armlinux.org.uk>
 <E1hWjyQ-0008Ni-8V@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <E1hWjyQ-0008Ni-8V@rmk-PC.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Hello Russell,

On Fri, May 31, 2019 at 05:01:42PM +0100, Russell King wrote:
> As suggested by Uwe, add a note indicating that the modem control
> signals do not support interrupts, which precludes the driver from
> using mctrl_gpio_init().
> =

> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/tty/serial/sa1100.c | 4 ++++
>  1 file changed, 4 insertions(+)
> =

> diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
> index 97bdfeccbea9..8e618129e65c 100644
> --- a/drivers/tty/serial/sa1100.c
> +++ b/drivers/tty/serial/sa1100.c
> @@ -860,6 +860,10 @@ static int sa1100_serial_resume(struct platform_devi=
ce *dev)
>  static int sa1100_serial_add_one_port(struct sa1100_port *sport, struct =
platform_device *dev)
>  {
>  	sport->port.dev =3D &dev->dev;
> +
> +	// mctrl_gpio_init() requires that the GPIO driver supports interrupts,
> +	// but we need to support GPIO drivers for hardware that has no such
> +	// interrupts.  Use mctrl_gpio_init_noauto() instead.

I hope it's not an impostor who claimed to be Linus to spread deviance
from K&R :-)

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

If you want to, squash this in the commit that introduced
mctrl_gpio_init_noauto while keeping my Ack on the resulting patch.

Best regards
Uwe

>  	sport->gpios =3D mctrl_gpio_init_noauto(sport->port.dev, 0);
>  	if (IS_ERR(sport->gpios)) {
>  		int err =3D PTR_ERR(sport->gpios);
> -- =

> 2.7.4
> =

> =


-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
