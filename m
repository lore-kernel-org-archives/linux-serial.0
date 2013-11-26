From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2] serial: 8250_dw: Improve unwritable LCR workaround
Date: Tue, 26 Nov 2013 15:36:00 -0300
Message-ID: <20131126183559.GA18570@localhost>
References: <1380647888-32473-1-git-send-email-tim.kryger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:54664 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757696Ab3KZSgK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Nov 2013 13:36:10 -0500
Content-Disposition: inline
In-Reply-To: <1380647888-32473-1-git-send-email-tim.kryger@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tim Kryger <tim.kryger@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, patches@linaro.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org

Hello,

On Tue, Oct 01, 2013 at 10:18:08AM -0700, Tim Kryger wrote:
> When configured with UART_16550_COMPATIBLE=3DNO or in versions prior =
to
> the introduction of this option, the Designware UART will ignore writ=
es
> to the LCR if the UART is busy.  The current workaround saves a copy =
of
> the last written LCR and re-writes it in the ISR for a special interr=
upt
> that is raised when a write was ignored.
>=20
> Unfortunately, interrupts are typically disabled prior to performing =
a
> sequence of register writes that include the LCR so the point at whic=
h
> the retry occurs is too late.  An example is serial8250_do_set_termio=
s()
> where an ignored LCR write results in the baud divisor not being set =
and
> instead a garbage character is sent out the transmitter.
>=20
> Furthermore, since serial_port_out() offers no way to indicate failur=
e,
> a serious effort must be made to ensure that the LCR is actually upda=
ted
> before returning back to the caller.  This is difficult, however, as =
a
> UART that was busy during the first attempt is likely to still be bus=
y
> when a subsequent attempt is made unless some extra action is taken.
>=20
> This updated workaround reads back the LCR after each write to confir=
m
> that the new value was accepted by the hardware.  Should the hardware
> ignore a write, the TX/RX FIFOs are cleared and the receive buffer re=
ad
> before attempting to rewrite the LCR out of the hope that doing so wi=
ll
> force the UART into an idle state.  While this may seem unnecessarily
> aggressive, writes to the LCR are used to change the baud rate, parit=
y,
> stop bit, or data length so the data that may be lost is likely not
> important.  Admittedly, this is far from ideal but it seems to be the
> best that can be done given the hardware limitations.
>=20
> Lastly, the revised workaround doesn't touch the LCR in the ISR, so i=
t
> avoids the possibility of a "serial8250: too much work for irq" lock =
up.
> This problem is rare in real situations but can be reproduced easily =
by
> wiring up two UARTs and running the following commands.
>=20
>   # stty -F /dev/ttyS1 echo
>   # stty -F /dev/ttyS2 echo
>   # cat /dev/ttyS1 &
>   [1] 375
>   # echo asdf > /dev/ttyS1
>   asdf
>=20
>   [   27.700000] serial8250: too much work for irq96
>   [   27.700000] serial8250: too much work for irq96
>   [   27.710000] serial8250: too much work for irq96
>   [   27.710000] serial8250: too much work for irq96
>   [   27.720000] serial8250: too much work for irq96
>   [   27.720000] serial8250: too much work for irq96
>   [   27.730000] serial8250: too much work for irq96
>   [   27.730000] serial8250: too much work for irq96
>   [   27.740000] serial8250: too much work for irq96
>=20
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> ---
>=20
> Changes in v2:
>   - Rebased on tty-next
>   - Updated commit messsage to mention UART_16550_COMPATIBLE
>   - Removed potentially unnecessary read of LSR and MSR
>   - Only attempt workaround when LCR write is ignored
>=20
>  drivers/tty/serial/8250/8250_dw.c | 41 +++++++++++++++++++++++++++++=
+---------
>  1 file changed, 32 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8=
250/8250_dw.c
> index d04a037..4658e3e 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -57,7 +57,6 @@
> =20
>  struct dw8250_data {
>  	u8			usr_reg;
> -	int			last_lcr;
>  	int			last_mcr;
>  	int			line;
>  	struct clk		*clk;
> @@ -77,17 +76,33 @@ static inline int dw8250_modify_msr(struct uart_p=
ort *p, int offset, int value)
>  	return value;
>  }
> =20
> +static void dw8250_force_idle(struct uart_port *p)
> +{
> +	serial8250_clear_and_reinit_fifos(container_of
> +					  (p, struct uart_8250_port, port));
> +	(void)p->serial_in(p, UART_RX);
> +}
> +
>  static void dw8250_serial_out(struct uart_port *p, int offset, int v=
alue)
>  {
>  	struct dw8250_data *d =3D p->private_data;
> =20
> -	if (offset =3D=3D UART_LCR)
> -		d->last_lcr =3D value;
> -
>  	if (offset =3D=3D UART_MCR)
>  		d->last_mcr =3D value;
> =20
>  	writeb(value, p->membase + (offset << p->regshift));
> +
> +	/* Make sure LCR write wasn't ignored */
> +	if (offset =3D=3D UART_LCR) {
> +		int tries =3D 1000;
> +		while (tries--) {
> +			if (value =3D=3D p->serial_in(p, UART_LCR))
> +				return;
> +			dw8250_force_idle(p);
> +			writeb(value, p->membase + (UART_LCR << p->regshift));
> +		}
> +		dev_err(p->dev, "Couldn't set LCR to %d\n", value);
> +	}
>  }
> =20
>  static unsigned int dw8250_serial_in(struct uart_port *p, int offset=
)
> @@ -108,13 +123,22 @@ static void dw8250_serial_out32(struct uart_por=
t *p, int offset, int value)
>  {
>  	struct dw8250_data *d =3D p->private_data;
> =20
> -	if (offset =3D=3D UART_LCR)
> -		d->last_lcr =3D value;
> -
>  	if (offset =3D=3D UART_MCR)
>  		d->last_mcr =3D value;
> =20
>  	writel(value, p->membase + (offset << p->regshift));
> +
> +	/* Make sure LCR write wasn't ignored */
> +	if (offset =3D=3D UART_LCR) {
> +		int tries =3D 1000;
> +		while (tries--) {
> +			if (value =3D=3D p->serial_in(p, UART_LCR))
> +				return;
> +			dw8250_force_idle(p);
> +			writel(value, p->membase + (UART_LCR << p->regshift));
> +		}
> +		dev_err(p->dev, "Couldn't set LCR to %d\n", value);
> +	}
>  }
> =20
>  static unsigned int dw8250_serial_in32(struct uart_port *p, int offs=
et)
> @@ -132,9 +156,8 @@ static int dw8250_handle_irq(struct uart_port *p)
>  	if (serial8250_handle_irq(p, iir)) {
>  		return 1;
>  	} else if ((iir & UART_IIR_BUSY) =3D=3D UART_IIR_BUSY) {
> -		/* Clear the USR and write the LCR again. */
> +		/* Clear the USR */
>  		(void)p->serial_in(p, d->usr_reg);
> -		p->serial_out(p, UART_LCR, d->last_lcr);
> =20
>  		return 1;
>  	}

Since v3.13-rc1, this commit seems to have introduced some oddities on
some of our boards. See this log snippet:

Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDR=EF=BF=BDconsole [ttyS0] enabled
console [ttyS0] enabled
bootconsole [earlycon0] disabled
bootconsole [earlycon0] disabled
dw-apb-uart d0012100.serial: Couldn't set LCR to 191
dw-apb-uart d0012100.serial: Couldn't set LCR to 191
dw-apb-uart d0012100.serial: Couldn't set LCR to 224
dw-apb-uart d0012100.serial: Couldn't set LCR to 224
d0012100.serial: ttyS1 at MMIO 0xd0012100 (irq =3D 18, base_baud =3D 15=
625000) is a 16550A

This behavior appear in at least Armada 370 and Armada XP boxes.

I confirm reverting this commit fixes the issue and things get back to =
normal.
Here's the complete kernel log: sprunge.us/gMdL

Ideas?
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
