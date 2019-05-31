From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: sa1100: add note about modem control signals
Date: Fri, 31 May 2019 17:31:35 +0200
Message-ID: <20190531153135.sboekptwx4jxlpeg@pengutronix.de>
References: <20190531151032.tfrl7yqph6wsg5pl@pengutronix.de>
 <E1hWjO0-00087g-7y@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <E1hWjO0-00087g-7y@rmk-PC.armlinux.org.uk>
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

On Fri, May 31, 2019 at 04:24:04PM +0100, Russell King wrote:
> As suggested by Uwe, add a note indicating that the modem control
> signals do not support interrupts, which precludes the driver from
> using mctrl_gpio_init().
> =

> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> =

> Uwe, something like this?
> =

>  drivers/tty/serial/sa1100.c | 3 +++
>  1 file changed, 3 insertions(+)
> =

> diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
> index a6b4309b62fc..d7dbf0576be8 100644
> --- a/drivers/tty/serial/sa1100.c
> +++ b/drivers/tty/serial/sa1100.c
> @@ -949,6 +949,9 @@ static int sa1100_serial_resume(struct platform_devic=
e *dev)
>  static int sa1100_serial_add_one_port(struct sa1100_port *sport, struct =
platform_device *dev)
>  {
>  	sport->port.dev =3D &dev->dev;
> +
> +	// GPIO driver does not support interrupts for these modem
> +	// control signals, so the serial driver polls them.
>  	sport->gpios =3D mctrl_gpio_init_noauto(sport->port.dev, 0);
>  	if (IS_ERR(sport->gpios)) {
>  		int err =3D PTR_ERR(sport->gpios);

I would mention that because of this mctrl_gpio_init cannot be used.
(And I would have expected C-like comments).

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
