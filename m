From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCHv2 2/3] tty/serial: at91: fix hardware handshake with GPIOs
Date: Thu, 22 Sep 2016 15:20:45 +0200
Message-ID: <20160922132045.tbrd5u56qasaf7gn@pengutronix.de>
References: <20160912094733.21501-1-richard.genoud@gmail.com>
 <20160912094733.21501-3-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160912094733.21501-3-richard.genoud@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-serial@vger.kernel.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Sep 12, 2016 at 11:47:32AM +0200, Richard Genoud wrote:
> Commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
> hardware handshake is enabled") broke the hardware handshake when GPIOs
> where used.

s/where/were/

> Hardware handshake with GPIOs used to work before this commit because
> the CRTSCTS flag (termios->c_cflag) was set, but not the
> ATMEL_US_USMODE_HWHS flag (controller register) ; so hardware handshake
> enabled, but not handled by the controller.
> =

> This commit restores this behaviour.
> =

> NB: -stable is not Cced because it doesn't cleanly apply on 4.1+
> and it will also need previous commit:
> "serial: mctrl_gpio: implement mctrl_gpio_use_rtscts"
> =

> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Fixes: 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when hard=
ware handshake is enabled")
> ---
>  drivers/tty/serial/atmel_serial.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> =

> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel=
_serial.c
> index 2eaa18ddef61..e9b4fbf88c2d 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2025,6 +2025,7 @@ static void atmel_serial_pm(struct uart_port *port,=
 unsigned int state,
>  static void atmel_set_termios(struct uart_port *port, struct ktermios *t=
ermios,
>  			      struct ktermios *old)
>  {
> +	struct atmel_uart_port *atmel_port =3D to_atmel_uart_port(port);
>  	unsigned long flags;
>  	unsigned int old_mode, mode, imr, quot, baud;
>  =

> @@ -2126,8 +2127,12 @@ static void atmel_set_termios(struct uart_port *po=
rt, struct ktermios *termios,
>  		atmel_uart_writel(port, ATMEL_US_TTGR,
>  				  port->rs485.delay_rts_after_send);
>  		mode |=3D ATMEL_US_USMODE_RS485;
> -	} else if (termios->c_cflag & CRTSCTS) {
> -		/* RS232 with hardware handshake (RTS/CTS) */
> +	} else if ((termios->c_cflag & CRTSCTS) &&
> +		   !mctrl_gpio_use_rtscts(atmel_port->gpios)) {

IMHO the behaviour of the hw controlled pins shouldn't change when
mctrl_gpio is in use (if possible). But I don't understand the issue so
I guess you need a better changelog.


> +		/*
> +		 * RS232 with hardware handshake (RTS/CTS)
> +		 * handled by the controller.
> +		 */
>  		if (atmel_use_dma_rx(port) && !atmel_use_fifo(port)) {
>  			dev_info(port->dev, "not enabling hardware flow control because DMA i=
s used");
>  			termios->c_cflag &=3D ~CRTSCTS;
> @@ -2135,7 +2140,7 @@ static void atmel_set_termios(struct uart_port *por=
t, struct ktermios *termios,
>  			mode |=3D ATMEL_US_USMODE_HWHS;
>  		}
>  	} else {
> -		/* RS232 without hadware handshake */
> +		/* RS232 without hadware handshake or controlled by GPIOs */

When touching this line, please also do s/hadware/hardware/.

>  		mode |=3D ATMEL_US_USMODE_NORMAL;
>  	}

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
