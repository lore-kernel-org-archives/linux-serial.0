From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] tty/serial: atmel: fix hardware handshake selection
Date: Fri, 15 Apr 2016 14:52:10 +0200
Message-ID: <5710E3FA.6040203@atmel.com>
References: <1460465500-25396-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460465500-25396-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>
List-Id: linux-serial@vger.kernel.org

Le 12/04/2016 14:51, Alexandre Belloni a =E9crit :
> Commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
> hardware handshake is enabled") actually allowed to enable hardware
> handshaking.
> Before, the CRTSCTS flags was silently ignored.
>=20
> As the DMA controller can't drive RTS (as explain in the commit messa=
ge).
> Ensure that hardware flow control stays disabled when DMA is used and=
 FIFOs
> are not available.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>

Yes, I agree with the fix:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

We can also add the following tags:

=46ixes: 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
hardware handshake is enabled")
Cc: stable <stable@vger.kernel.org> # v4.0+

Bye,

> ---
>  drivers/tty/serial/atmel_serial.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/a=
tmel_serial.c
> index d9439e6ab719..954941dd8124 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -274,6 +274,13 @@ static bool atmel_use_dma_rx(struct uart_port *p=
ort)
>  	return atmel_port->use_dma_rx;
>  }
> =20
> +static bool atmel_use_fifo(struct uart_port *port)
> +{
> +	struct atmel_uart_port *atmel_port =3D to_atmel_uart_port(port);
> +
> +	return atmel_port->fifo_size;
> +}
> +
>  static unsigned int atmel_get_lines_status(struct uart_port *port)
>  {
>  	struct atmel_uart_port *atmel_port =3D to_atmel_uart_port(port);
> @@ -2090,7 +2097,12 @@ static void atmel_set_termios(struct uart_port=
 *port, struct ktermios *termios,
>  		mode |=3D ATMEL_US_USMODE_RS485;
>  	} else if (termios->c_cflag & CRTSCTS) {
>  		/* RS232 with hardware handshake (RTS/CTS) */
> -		mode |=3D ATMEL_US_USMODE_HWHS;
> +		if (atmel_use_dma_rx(port) && !atmel_use_fifo(port)) {
> +			dev_info(port->dev, "not enabling hardware flow control because D=
MA is used");
> +			termios->c_cflag &=3D ~CRTSCTS;
> +		} else {
> +			mode |=3D ATMEL_US_USMODE_HWHS;
> +		}
>  	} else {
>  		/* RS232 without hadware handshake */
>  		mode |=3D ATMEL_US_USMODE_NORMAL;
>=20


--=20
Nicolas Ferre
