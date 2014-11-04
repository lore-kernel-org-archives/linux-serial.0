From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH] tty: cadence:: Add support for setting modem control
 signals
Date: Tue, 4 Nov 2014 09:08:00 -0800
Message-ID: <f3028a3fdbe44538a6b4721bc96d9302@BL2FFO11FD042.protection.gbl>
References: <1415098194-18992-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bn1on0074.outbound.protection.outlook.com ([157.56.110.74]:47280
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750796AbaKDRlF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Nov 2014 12:41:05 -0500
Content-Disposition: inline
In-Reply-To: <1415098194-18992-1-git-send-email-lars@metafoo.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org

Hi Lars,

On Tue, 2014-11-04 at 11:49AM +0100, Lars-Peter Clausen wrote:
> Add support for setting the state of the DTR and RTS signals.
>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/=
xilinx_uartps.c
> index 200c1af..fb1de12 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -133,6 +133,15 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255"=
);
>  #define CDNS_UART_IXR_BRK	0x80000000
> =20
>  /*
> + * Modem Control register:
> + * The read/write Modem Control register controls the interface with=
 the modem
> + * or data set, or a peripheral device emulating a modem.
> + */
> +#define CDNS_UART_MODEMCR_FCM	0x00000020 /* Automatic flow control m=
ode */
> +#define CDNS_UART_MODEMCR_RTS	0x00000002 /* Request to send output c=
ontrol */
> +#define CDNS_UART_MODEMCR_DTR	0x00000001 /* Data Terminal Ready */

I'd prefer using the BIT() macro, but I see that it doesn't really fit
the style of other #defines in the driver. So, probably ok this way.

> +
> +/*
>   * Channel Status Register:
>   * The channel status register (CSR) is provided to enable the contr=
ol logic
>   * to monitor the status of bits in the channel interrupt status reg=
ister,
> @@ -915,7 +924,18 @@ static unsigned int cdns_uart_get_mctrl(struct u=
art_port *port)
> =20
>  static void cdns_uart_set_mctrl(struct uart_port *port, unsigned int=
 mctrl)
>  {
> -	/* N/A */
> +	unsigned int val;

This should be u32.

I don't have a setup to actually test this, but it applies and doesn't
seem to break anything :)

Given that you fix the data type:
Acked-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

	Thanks,
	S=C3=B6ren
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
