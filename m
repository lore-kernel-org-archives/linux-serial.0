From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 1/1] drivers: introduce ARM SBSA generic UART driver
Date: Fri, 29 Aug 2014 20:59:31 +0200
Message-ID: <8453809.d9xRztN9Sq@wuerfel>
References: <1409328803-1953-1-git-send-email-andre.przywara@arm.com> <1409328803-1953-2-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:51942 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbaH2S7w (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Aug 2014 14:59:52 -0400
In-Reply-To: <1409328803-1953-2-git-send-email-andre.przywara@arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Andre Przywara <andre.przywara@arm.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Russell King <linux@arm.linux.org.uk>, linux@vger.kernel.org

On Friday 29 August 2014 17:13:23 Andre Przywara wrote:
> The ARM Server Base System Architecture (SBSA) describes a generic
> UART which all compliant level 1 systems should implement. This is
> actually a PL011 subset, so a full PL011 implementation will satisfy
> this requirement.
> However if a system does not have a PL011, a very stripped down
> implementation complying to the SBSA defined specification will
> suffice. The Linux PL011 driver is not guaranteed to drive this
> limited device (and indeed the fast model implentation hangs the
> kernel if driven by the PL011 driver).
> So introduce a new driver just implementing the part specified by the
> SBSA (which lacks DMA, the modem control signals and many of the
> registers including baud rate control). This driver has been derived
> by the actual PL011 one, removing all unnecessary code.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>


Hi Andre,

Thanks for getting this driver ready. There is one high-level comment
I have: As mentioned in the discussion in
https://lkml.org/lkml/2014/7/28/386 , I think this should really be
a tty driver using tty_port, not a serial driver using uart_port.

What is the reason you chose to do a uart_port driver?

A few more details below:

> +}
> +EARLYCON_DECLARE(pl011, sbsa_uart_early_console_setup);
> +OF_EARLYCON_DECLARE(pl011, "arm,sbsa-uart", sbsa_uart_early_console_setup);

Stray 'pl011' left from copying the code?

> +static struct uart_driver sbsa_uart_reg = {
> +	.owner			= THIS_MODULE,
> +	.driver_name		= "sbsa_uart",
> +	.dev_name		= "ttyAMA",
> +	.nr			= UART_NR,
> +	.cons			= SBSA_UART_CONSOLE,
> +};

I don't think we should overload the ttyAMA name.

> +#ifdef CONFIG_OF
> +
> +static int dt_probe_serial_alias(int index, struct device *dev)
> +{
> +	struct device_node *np;
> +	static bool seen_dev_with_alias;
> +	static bool seen_dev_without_alias;
> +	int ret = index;
> +
> +	if (!IS_ENABLED(CONFIG_OF))
> +		return ret;

The #ifdef should go away since you already have the if
(!IS_ENABLED(CONFIG_OF)) logic here.

	Arnd
