Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9435EC54EE9
	for <linux-serial@archiver.kernel.org>; Fri, 16 Sep 2022 11:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiIPLWX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Sep 2022 07:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiIPLWW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Sep 2022 07:22:22 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5614975FF9
        for <linux-serial@vger.kernel.org>; Fri, 16 Sep 2022 04:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663327341; x=1694863341;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hj9CVqoLaZslnWI/AuftHf/m/UxzYOZRQzTpBief3xU=;
  b=No3MUAyLtpn9RuyTpOJeO6H8NGSC/ofVknHdbswz6ol+LAazRRT4SgUs
   7DCbYvF+NU3pp60tEcPOqfLB7OjLHgHOORZVueTP53ZR6TV9Y1ejfnG07
   T094phc08OAsbQGAipKPirGlk4YRVhBQvE83jiaNfhPO+O3qnXyv9Mh+m
   kS6gELOiZthe8MrUgARfe5utaO0FfohA0zPuUjHptRxmVUvf6rTdiY/Fe
   0eUyk3+/lTLqjUa/W6L2lbd4aSX5gg5ZobG6pDxylWnvNoraLkuBatIv4
   vX4hNiNu8d7r+6mM76Kuh5mDMVoSN30vL9qgcdKzJVjAnit+EOAzoQCHB
   A==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654552800"; 
   d="scan'208";a="26225004"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 16 Sep 2022 13:22:19 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 16 Sep 2022 13:22:18 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 16 Sep 2022 13:22:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663327339; x=1694863339;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hj9CVqoLaZslnWI/AuftHf/m/UxzYOZRQzTpBief3xU=;
  b=Kalwn9b/kFXfm6Rzth0aBiwJM//xgtH5kThB7nR8u17BnwY52M4PPgmQ
   26/WfeOQ+lgwFYxjsy9hvYJm+NNicALvLDKU769Pl9zfCN402wQbmTNmv
   7IgmxzA3zgq7PtNG4XbQ1URTFcoH9WVPoudK3TNJk36jvRwT3TG7T/5cW
   m8gtKjFl2vlb7UGJxFQ7zWhM5C2ivmdLutg0+8xlkYSgGRposqJwhi84B
   CJ2QFmRICFxfwPe0XJ5M+NhzUWD6zNtj844oZfbAZc5fT2S9OjsqS+3sb
   AZ2JiNWMuQbkV1qoe+v/MRrVolK7CjsWap9NDGOmzugNOwi9znOaMLC9O
   A==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654552800"; 
   d="scan'208";a="26225003"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Sep 2022 13:22:19 +0200
Received: from schifferm-ubuntu (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id DB163280056;
        Fri, 16 Sep 2022 13:22:17 +0200 (CEST)
Message-ID: <f9cde9dbb9a080c34a77e60d6bf901e71e29b7ce.camel@ew.tq-group.com>
Subject: Re: [PATCH] serial: Deassert RS485 Transmit Enable on probe in
 driver-specific way
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Maarten Brock <m.brock@vanmierlo.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Su Bao Cheng <baocheng.su@siemens.com>, baocheng_su@163.com,
        Chao Zeng <chao.zeng@siemens.com>,
        Peter Hung <hpeter+linux_kernel@gmail.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        "<Codrin.Ciubotariu@microchip.com>" <Codrin.Ciubotariu@microchip.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Dario Binacchi <dariobin@libero.it>,
        Bich Hemon <bich.hemon@st.com>, Marek Vasut <marex@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roosen Henri <Henri.Roosen@ginzinger.com>,
        linux-serial@vger.kernel.org
Date:   Fri, 16 Sep 2022 13:22:15 +0200
In-Reply-To: <b17842d9792762948f75d74205596d36bdd27f22.1663310999.git.lukas@wunner.de>
References: <b17842d9792762948f75d74205596d36bdd27f22.1663310999.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 2022-09-16 at 09:04 +0200, Lukas Wunner wrote:
> When a UART port is newly registered, uart_configure_port() seeks to
> deassert RS485 Transmit Enable by setting the RTS bit in port->mctrl.
> However a number of UART drivers interpret a set RTS bit as *assertion*
> instead of deassertion:  Affected drivers include those using
> serial8250_em485_config() (except 8250_bcm2835aux.c) and some using
> mctrl_gpio (e.g. imx.c).
> 
> Since the interpretation of the RTS bit is driver-specific, it is not
> suitable as a means to centrally deassert Transmit Enable in the serial
> core.  Instead, the serial core must call on drivers to deassert it in
> their driver-specific way.  One way to achieve that is to call
> ->rs485_config().  It implicitly deasserts Transmit Enable.
> 
> So amend uart_configure_port() and uart_resume_port() to invoke
> uart_rs485_config().  That allows removing calls to uart_rs485_config()
> from drivers' ->probe() hooks and declaring the function static.
> 
> Skip any invocation of ->set_mctrl() if RS485 is enabled.  RS485 has no
> hardware flow control, so the modem control lines are irrelevant and
> need not be touched.  When leaving RS485 mode, reset the modem control
> lines to the state stored in port->mctrl.  That way, UARTs which are
> muxed between RS485 and RS232 transceivers drive the lines correctly
> when switched to RS232.  (serial8250_do_startup() historically raises
> the OUT1 modem signal because otherwise interrupts are not signaled on
> ancient PC UARTs, but I believe that no longer applies to modern,
> RS485-capable UARTs and is thus safe to be skipped.)
> 
> imx.c modifies port->mctrl whenever Transmit Enable is asserted and
> deasserted.  Stop it from doing that so port->mctrl reflects the RS232
> line state.
> 
> 8250_omap.c deasserts Transmit Enable on ->runtime_resume() by calling
> ->set_mctrl().  Because that is now a no-op in RS485 mode, amend the
> function to call serial8250_em485_stop_tx().
> 
> fsl_lpuart.c retrieves and applies the RS485 device tree properties
> after registering the UART port.  Because applying now happens on
> registration in uart_configure_port(), move retrieval of the properties
> ahead of uart_add_one_port().
> 
> Fixes: d3b3404df318 ("serial: Fix incorrect rs485 polarity on uart open")
> Reported-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Link: https://lore.kernel.org/all/20220329085050.311408-1-matthias.schiffer@ew.tq-group.com/
> Reported-by: Roosen Henri <Henri.Roosen@ginzinger.com>
> Link: https://lore.kernel.org/all/8f538a8903795f22f9acc94a9a31b03c9c4ccacb.camel@ginzinger.com/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.14+


I had to add one more fix to make RS485 work at all with 8250_omap on
Linux 6.0-rc5+ (submitted a few minutes ago, "serial: 8250: omap: Use
serial8250_em485_supported"), but the RTS polarity is correct now, so:

Tested-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Thanks!


> ---
>  Based on v6.0-rc3 + this dependency:
>  https://lore.kernel.org/linux-serial/72fb646c1b0b11c989850c55f52f9ff343d1b2fa.1662884345.git.lukas@wunner.de/
> 
>  drivers/tty/serial/8250/8250_omap.c |  3 +++
>  drivers/tty/serial/8250/8250_pci.c  |  9 +--------
>  drivers/tty/serial/8250/8250_port.c | 10 ++++++----
>  drivers/tty/serial/fsl_lpuart.c     | 10 ++++------
>  drivers/tty/serial/imx.c            |  8 ++------
>  drivers/tty/serial/serial_core.c    | 36 ++++++++++++++++++++----------------
>  include/linux/serial_core.h         |  1 -
>  7 files changed, 36 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index b43894e..2e67754 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -342,6 +342,9 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
>  	omap8250_update_mdr1(up, priv);
>  
>  	up->port.ops->set_mctrl(&up->port, up->port.mctrl);
> +
> +	if (up->port.rs485.flags & SER_RS485_ENABLED)
> +		serial8250_em485_stop_tx(up);
>  }
>  
>  /*
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 6f66dc2..b260c55 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1627,7 +1627,6 @@ static int pci_fintek_init(struct pci_dev *dev)
>  	resource_size_t bar_data[3];
>  	u8 config_base;
>  	struct serial_private *priv = pci_get_drvdata(dev);
> -	struct uart_8250_port *port;
>  
>  	if (!(pci_resource_flags(dev, 5) & IORESOURCE_IO) ||
>  			!(pci_resource_flags(dev, 4) & IORESOURCE_IO) ||
> @@ -1674,13 +1673,7 @@ static int pci_fintek_init(struct pci_dev *dev)
>  
>  		pci_write_config_byte(dev, config_base + 0x06, dev->irq);
>  
> -		if (priv) {
> -			/* re-apply RS232/485 mode when
> -			 * pciserial_resume_ports()
> -			 */
> -			port = serial8250_get_port(priv->line[i]);
> -			uart_rs485_config(&port->port);
> -		} else {
> +		if (!priv) {
>  			/* First init without port data
>  			 * force init to RS232 Mode
>  			 */
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 907c5ff..a6f03b1 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -600,7 +600,7 @@ void serial8250_rpm_put(struct uart_8250_port *p)
>  static int serial8250_em485_init(struct uart_8250_port *p)
>  {
>  	if (p->em485)
> -		return 0;
> +		goto deassert_rts;
>  
>  	p->em485 = kmalloc(sizeof(struct uart_8250_em485), GFP_ATOMIC);
>  	if (!p->em485)
> @@ -616,6 +616,7 @@ static int serial8250_em485_init(struct uart_8250_port *p)
>  	p->em485->active_timer = NULL;
>  	p->em485->tx_stopped = true;
>  
> +deassert_rts:
>  	p->rs485_stop_tx(p);
>  
>  	return 0;
> @@ -2047,6 +2048,10 @@ void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  
>  static void serial8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  {
> +
> +	if (port->rs485.flags & SER_RS485_ENABLED)
> +		return;
> +
>  	if (port->set_mctrl)
>  		port->set_mctrl(port, mctrl);
>  	else
> @@ -3189,9 +3194,6 @@ static void serial8250_config_port(struct uart_port *port, int flags)
>  	if (flags & UART_CONFIG_TYPE)
>  		autoconfig(up);
>  
> -	if (port->rs485.flags & SER_RS485_ENABLED)
> -		uart_rs485_config(port);
> -
>  	/* if access method is AU, it is a 16550 with a quirk */
>  	if (port->type == PORT_16550A && port->iotype == UPIO_AU)
>  		up->bugs |= UART_BUG_NOMSR;
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index e9d5b48..dfc73fe 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -2724,15 +2724,13 @@ static int lpuart_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto failed_reset;
>  
> -	ret = uart_add_one_port(&lpuart_reg, &sport->port);
> -	if (ret)
> -		goto failed_attach_port;
> -
>  	ret = uart_get_rs485_mode(&sport->port);
>  	if (ret)
>  		goto failed_get_rs485;
>  
> -	uart_rs485_config(&sport->port);
> +	ret = uart_add_one_port(&lpuart_reg, &sport->port);
> +	if (ret)
> +		goto failed_attach_port;
>  
>  	ret = devm_request_irq(&pdev->dev, sport->port.irq, handler, 0,
>  				DRIVER_NAME, sport);
> @@ -2742,9 +2740,9 @@ static int lpuart_probe(struct platform_device *pdev)
>  	return 0;
>  
>  failed_irq_request:
> -failed_get_rs485:
>  	uart_remove_one_port(&lpuart_reg, &sport->port);
>  failed_attach_port:
> +failed_get_rs485:
>  failed_reset:
>  	lpuart_disable_clks(sport);
>  	return ret;
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 5875ee6..05b432d 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -380,8 +380,7 @@ static void imx_uart_rts_active(struct imx_port *sport, u32 *ucr2)
>  {
>  	*ucr2 &= ~(UCR2_CTSC | UCR2_CTS);
>  
> -	sport->port.mctrl |= TIOCM_RTS;
> -	mctrl_gpio_set(sport->gpios, sport->port.mctrl);
> +	mctrl_gpio_set(sport->gpios, sport->port.mctrl | TIOCM_RTS);
>  }
>  
>  /* called with port.lock taken and irqs caller dependent */
> @@ -390,8 +389,7 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
>  	*ucr2 &= ~UCR2_CTSC;
>  	*ucr2 |= UCR2_CTS;
>  
> -	sport->port.mctrl &= ~TIOCM_RTS;
> -	mctrl_gpio_set(sport->gpios, sport->port.mctrl);
> +	mctrl_gpio_set(sport->gpios, sport->port.mctrl & ~TIOCM_RTS);
>  }
>  
>  static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
> @@ -2347,8 +2345,6 @@ static int imx_uart_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev,
>  			"low-active RTS not possible when receiver is off, enabling receiver\n");
>  
> -	uart_rs485_config(&sport->port);
> -
>  	/* Disable interrupts before requesting them */
>  	ucr1 = imx_uart_readl(sport, UCR1);
>  	ucr1 &= ~(UCR1_ADEN | UCR1_TRDYEN | UCR1_IDEN | UCR1_RRDYEN | UCR1_RTSDEN);
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index c711318..179ee19 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -158,15 +158,10 @@ static void uart_start(struct tty_struct *tty)
>  	unsigned long flags;
>  	unsigned int old;
>  
> -	if (port->rs485.flags & SER_RS485_ENABLED) {
> -		set &= ~TIOCM_RTS;
> -		clear &= ~TIOCM_RTS;
> -	}
> -
>  	spin_lock_irqsave(&port->lock, flags);
>  	old = port->mctrl;
>  	port->mctrl = (old & ~clear) | set;
> -	if (old != port->mctrl)
> +	if (old != port->mctrl && !(port->rs485.flags & SER_RS485_ENABLED))
>  		port->ops->set_mctrl(port, port->mctrl);
>  	spin_unlock_irqrestore(&port->lock, flags);
>  }
> @@ -1391,7 +1386,7 @@ static void uart_set_rs485_termination(struct uart_port *port,
>  				 !!(rs485->flags & SER_RS485_TERMINATE_BUS));
>  }
>  
> -int uart_rs485_config(struct uart_port *port)
> +static int uart_rs485_config(struct uart_port *port)
>  {
>  	struct serial_rs485 *rs485 = &port->rs485;
>  	int ret;
> @@ -1405,7 +1400,6 @@ int uart_rs485_config(struct uart_port *port)
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(uart_rs485_config);
>  
>  static int uart_get_rs485_config(struct uart_port *port,
>  			 struct serial_rs485 __user *rs485)
> @@ -1444,8 +1438,13 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
>  
>  	spin_lock_irqsave(&port->lock, flags);
>  	ret = port->rs485_config(port, &tty->termios, &rs485);
> -	if (!ret)
> +	if (!ret) {
>  		port->rs485 = rs485;
> +
> +		/* Reset RTS and other mctrl lines when disabling RS485 */
> +		if (!(rs485.flags & SER_RS485_ENABLED))
> +			port->ops->set_mctrl(port, port->mctrl);
> +	}
>  	spin_unlock_irqrestore(&port->lock, flags);
>  	if (ret)
>  		return ret;
> @@ -2352,7 +2351,8 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
>  
>  		spin_lock_irq(&uport->lock);
>  		ops->stop_tx(uport);
> -		ops->set_mctrl(uport, 0);
> +		if (!(uport->rs485.flags & SER_RS485_ENABLED))
> +			ops->set_mctrl(uport, 0);
>  		/* save mctrl so it can be restored on resume */
>  		mctrl = uport->mctrl;
>  		uport->mctrl = 0;
> @@ -2440,7 +2440,8 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
>  
>  		uart_change_pm(state, UART_PM_STATE_ON);
>  		spin_lock_irq(&uport->lock);
> -		ops->set_mctrl(uport, 0);
> +		if (!(uport->rs485.flags & SER_RS485_ENABLED))
> +			ops->set_mctrl(uport, 0);
>  		spin_unlock_irq(&uport->lock);
>  		if (console_suspend_enabled || !uart_console(uport)) {
>  			/* Protected by port mutex for now */
> @@ -2451,7 +2452,10 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
>  				if (tty)
>  					uart_change_speed(tty, state, NULL);
>  				spin_lock_irq(&uport->lock);
> -				ops->set_mctrl(uport, uport->mctrl);
> +				if (!(uport->rs485.flags & SER_RS485_ENABLED))
> +					ops->set_mctrl(uport, uport->mctrl);
> +				else
> +					uart_rs485_config(uport);
>  				ops->start_tx(uport);
>  				spin_unlock_irq(&uport->lock);
>  				tty_port_set_initialized(port, 1);
> @@ -2558,10 +2562,10 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
>  		 */
>  		spin_lock_irqsave(&port->lock, flags);
>  		port->mctrl &= TIOCM_DTR;
> -		if (port->rs485.flags & SER_RS485_ENABLED &&
> -		    !(port->rs485.flags & SER_RS485_RTS_AFTER_SEND))
> -			port->mctrl |= TIOCM_RTS;
> -		port->ops->set_mctrl(port, port->mctrl);
> +		if (!(port->rs485.flags & SER_RS485_ENABLED))
> +			port->ops->set_mctrl(port, port->mctrl);
> +		else
> +			uart_rs485_config(port);
>  		spin_unlock_irqrestore(&port->lock, flags);
>  
>  		/*
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 02a4299..0354369 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -933,5 +933,4 @@ static inline int uart_handle_break(struct uart_port *port)
>  					 !((cflag) & CLOCAL))
>  
>  int uart_get_rs485_mode(struct uart_port *port);
> -int uart_rs485_config(struct uart_port *port);
>  #endif /* LINUX_SERIAL_CORE_H */

