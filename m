From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v4] serial/efm32: add new driver
Date: Wed, 25 Jan 2012 00:25:59 -0800
Message-ID: <1327479959.21686.8.camel@joe2Laptop>
References: <20120124220522.GA10590@kroah.com>
	 <1327478704-4233-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:44630 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752768Ab2AYI0O (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Jan 2012 03:26:14 -0500
In-Reply-To: <1327478704-4233-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org

On Wed, 2012-01-25 at 09:05 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

trivial comments below:

> diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm=
32-uart.c
[]
> @@ -0,0 +1,830 @@
> +#if defined(CONFIG_SERIAL_EFM32_UART_CONSOLE) && defined(CONFIG_MAGI=
C_SYSRQ)
> +#define SUPPORT_SYSRQ
> +#endif

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

> +static void efm32_uart_rx_chars(struct efm32_uart_port *efm_port,
> +		struct tty_struct *tty)
> +{
[]
> +		if ((rxdata & UARTn_RXDATAX_FERR) &&
> +				!(rxdata & UARTn_RXDATAX_RXDATA__MASK)) {

Perhaps better as:

		if ((rxdata & UARTn_RXDATAX_FERR) &&
		    !(rxdata & UARTn_RXDATAX_RXDATA__MASK)) {

and RXDATA__MASK with 2 underscores?  perhaps just one _?

> +static int efm32_uart_console_setup(struct console *co, char *option=
s)
[]
> +		for (i =3D 0; i < ARRAY_SIZE(efm32_uart_ports); ++i) {
> +			if (efm32_uart_ports[i]) {
> +				pr_warn("efm32-console: fall back to console index %u (from %hhi=
)\n",
> +						i, co->index);

				pr_warn("fall back to ..."
[]
> +	efm_port =3D efm32_uart_ports[co->index];
> +	if (!efm_port) {
> +		pr_warn("efm32-console: No port at %d\n", co->index);

		pr_warn("No port at..."


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
