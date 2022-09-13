Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A14CC6FA82
	for <linux-serial@archiver.kernel.org>; Tue, 13 Sep 2022 08:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiIMIYL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Sep 2022 04:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiIMIYH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Sep 2022 04:24:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1645A11A14
        for <linux-serial@vger.kernel.org>; Tue, 13 Sep 2022 01:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663057446; x=1694593446;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ni8KI7h8Hdp/XuhmxTHPCHQ3f7jrQq9RePan4EjXrqY=;
  b=FTzN6fKc8yzZ4nfhScMq8oqTUnij1KZe/q9nK0uJlJBX01Df3Nyu3Q42
   jgccnoN70wRw6KCdFNVuPqKlP1qolk2jkgf3a5rUXhD/0RihOY3PQMwFK
   ZO2oVPFYlDbXajZzRy31mp/M65gEuRSHcGqG2cRsagpOGCasTE3OqIAUu
   Qy8LPAyYuI3hr0BGc0/XJJAbHKCW/I6BK3+QQtwOrROaq3atAAqhsL6oz
   xzeRXgxfihw5DFHuLrc3v8CFJvI+sE+314E9jVptZv3dOQ/9YtBGin4aZ
   3kgYuJvDPm2wcz+n9GGxrOnYKTP50eDqrMkHe8/4EPYXEylmMb8vk/bsG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="298876724"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="298876724"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 01:24:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="678465888"
Received: from calabres-mobl.ger.corp.intel.com ([10.252.47.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 01:24:03 -0700
Date:   Tue, 13 Sep 2022 11:24:01 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marex@denx.de>, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH] serial: stm32: Deassert Transmit Enable on
 ->rs485_config()
In-Reply-To: <6059eab35dba394468335ef640df8b0050fd9dbd.1662886616.git.lukas@wunner.de>
Message-ID: <774e5f24-c673-bbd2-08e-403987b63d1b@linux.intel.com>
References: <6059eab35dba394468335ef640df8b0050fd9dbd.1662886616.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1479841264-1663057445=:16933"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1479841264-1663057445=:16933
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sun, 11 Sep 2022, Lukas Wunner wrote:

> The STM32 USART can control RS-485 Transmit Enable in hardware.  Since
> commit 7df5081cbf5e ("serial: stm32: Add RS485 RTS GPIO control"),
> it can alternatively be controlled in software.  That was done to allow
> RS-485 even if the RTS pin is unavailable because it's pinmuxed to a
> different function.
> 
> However the commit neglected to deassert Transmit Enable upon invocation
> of the ->rs485_config() callback.  Fix it.
> 
> Avoid forward declarations by moving stm32_usart_tx_empty(),
> stm32_usart_rs485_rts_enable() and stm32_usart_rs485_rts_disable()
> further up in the driver.
> 
> Fixes: 7df5081cbf5e ("serial: stm32: Add RS485 RTS GPIO control")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v5.9+
> Cc: Marek Vasut <marex@denx.de>

I'd prefer to have those plain function moves to be in a separate patch. 
Other than that,

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.


> ---
>  drivers/tty/serial/stm32-usart.c | 100 ++++++++++++++++---------------
>  1 file changed, 53 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index 0b18615b2ca4..c48f225eba86 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -131,6 +131,53 @@ static void stm32_usart_clr_bits(struct uart_port *port, u32 reg, u32 bits)
>  	writel_relaxed(val, port->membase + reg);
>  }
>  
> +static unsigned int stm32_usart_tx_empty(struct uart_port *port)
> +{
> +	struct stm32_port *stm32_port = to_stm32_port(port);
> +	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
> +
> +	if (readl_relaxed(port->membase + ofs->isr) & USART_SR_TC)
> +		return TIOCSER_TEMT;
> +
> +	return 0;
> +}
> +
> +static void stm32_usart_rs485_rts_enable(struct uart_port *port)
> +{
> +	struct stm32_port *stm32_port = to_stm32_port(port);
> +	struct serial_rs485 *rs485conf = &port->rs485;
> +
> +	if (stm32_port->hw_flow_control ||
> +	    !(rs485conf->flags & SER_RS485_ENABLED))
> +		return;
> +
> +	if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
> +		mctrl_gpio_set(stm32_port->gpios,
> +			       stm32_port->port.mctrl | TIOCM_RTS);
> +	} else {
> +		mctrl_gpio_set(stm32_port->gpios,
> +			       stm32_port->port.mctrl & ~TIOCM_RTS);
> +	}
> +}
> +
> +static void stm32_usart_rs485_rts_disable(struct uart_port *port)
> +{
> +	struct stm32_port *stm32_port = to_stm32_port(port);
> +	struct serial_rs485 *rs485conf = &port->rs485;
> +
> +	if (stm32_port->hw_flow_control ||
> +	    !(rs485conf->flags & SER_RS485_ENABLED))
> +		return;
> +
> +	if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
> +		mctrl_gpio_set(stm32_port->gpios,
> +			       stm32_port->port.mctrl & ~TIOCM_RTS);
> +	} else {
> +		mctrl_gpio_set(stm32_port->gpios,
> +			       stm32_port->port.mctrl | TIOCM_RTS);
> +	}
> +}
> +
>  static void stm32_usart_config_reg_rs485(u32 *cr1, u32 *cr3, u32 delay_ADE,
>  					 u32 delay_DDE, u32 baud)
>  {
> @@ -214,6 +261,12 @@ static int stm32_usart_config_rs485(struct uart_port *port, struct ktermios *ter
>  
>  	stm32_usart_set_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
>  
> +	/* Adjust RTS polarity in case it's driven in software */
> +	if (stm32_usart_tx_empty(port))
> +		stm32_usart_rs485_rts_disable(port);
> +	else
> +		stm32_usart_rs485_rts_enable(port);
> +
>  	return 0;
>  }
>  
> @@ -529,42 +582,6 @@ static void stm32_usart_tc_interrupt_disable(struct uart_port *port)
>  	stm32_usart_clr_bits(port, ofs->cr1, USART_CR1_TCIE);
>  }
>  
> -static void stm32_usart_rs485_rts_enable(struct uart_port *port)
> -{
> -	struct stm32_port *stm32_port = to_stm32_port(port);
> -	struct serial_rs485 *rs485conf = &port->rs485;
> -
> -	if (stm32_port->hw_flow_control ||
> -	    !(rs485conf->flags & SER_RS485_ENABLED))
> -		return;
> -
> -	if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
> -		mctrl_gpio_set(stm32_port->gpios,
> -			       stm32_port->port.mctrl | TIOCM_RTS);
> -	} else {
> -		mctrl_gpio_set(stm32_port->gpios,
> -			       stm32_port->port.mctrl & ~TIOCM_RTS);
> -	}
> -}
> -
> -static void stm32_usart_rs485_rts_disable(struct uart_port *port)
> -{
> -	struct stm32_port *stm32_port = to_stm32_port(port);
> -	struct serial_rs485 *rs485conf = &port->rs485;
> -
> -	if (stm32_port->hw_flow_control ||
> -	    !(rs485conf->flags & SER_RS485_ENABLED))
> -		return;
> -
> -	if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
> -		mctrl_gpio_set(stm32_port->gpios,
> -			       stm32_port->port.mctrl & ~TIOCM_RTS);
> -	} else {
> -		mctrl_gpio_set(stm32_port->gpios,
> -			       stm32_port->port.mctrl | TIOCM_RTS);
> -	}
> -}
> -
>  static void stm32_usart_transmit_chars_pio(struct uart_port *port)
>  {
>  	struct stm32_port *stm32_port = to_stm32_port(port);
> @@ -807,17 +824,6 @@ static irqreturn_t stm32_usart_threaded_interrupt(int irq, void *ptr)
>  	return IRQ_HANDLED;
>  }
>  
> -static unsigned int stm32_usart_tx_empty(struct uart_port *port)
> -{
> -	struct stm32_port *stm32_port = to_stm32_port(port);
> -	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
> -
> -	if (readl_relaxed(port->membase + ofs->isr) & USART_SR_TC)
> -		return TIOCSER_TEMT;
> -
> -	return 0;
> -}
> -
>  static void stm32_usart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  {
>  	struct stm32_port *stm32_port = to_stm32_port(port);
> 
--8323329-1479841264-1663057445=:16933--
