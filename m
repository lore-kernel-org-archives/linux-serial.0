Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3970DE7D0A4
	for <linux-serial@archiver.kernel.org>; Thu, 21 Sep 2023 18:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjIUSLB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Sep 2023 14:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjIUSKm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Sep 2023 14:10:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E47589D94
        for <linux-serial@vger.kernel.org>; Thu, 21 Sep 2023 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318732; x=1726854732;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Npmq64n2u2V5cBKZxzCKlrRuERBvFCCW/jjAK0sQbvk=;
  b=OvKE3Q3Z40APFVfjI8CRxhy2WCK/M4Ur3Do7k0/ShJN/ezcCXCAfBIXE
   0gSXRMnwKELjrsb8GgucVtCxk1q/XDBFnIconpvMwgeGi27YNeHSn+FaO
   Jb26Gx8cC16wVtZT3WDCOYy7CucuFcTGPhYPTIdEjH1xU3KHLu4R4US30
   FimexF5fW5vu0Yo4LUPxTRJb2XmldMcCBgU46Ufck9/8Amr8pLiRCM2Jb
   uFW1oxEQCVPNL6ES6FyvH483+4T46hNoLMCh1zpt38gygiVktYUXTAivF
   kf2yFjsVNiNuxMSQsBQdOBsGG3fmLoHMhgMQsPtvAJ6j1CVPh6jIjx4OO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="379428221"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="379428221"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 08:01:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="782212714"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="782212714"
Received: from rladysz-mobl2.ger.corp.intel.com ([10.252.52.175])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 08:01:43 -0700
Date:   Thu, 21 Sep 2023 18:01:41 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH tty-linus] serial: Reduce spinlocked portion of
 uart_rs485_config()
In-Reply-To: <f3a35967c28b32f3c6432d0aa5936e6a9908282d.1695307688.git.lukas@wunner.de>
Message-ID: <9888a15-d626-d262-203f-b5f49fa4494@linux.intel.com>
References: <f3a35967c28b32f3c6432d0aa5936e6a9908282d.1695307688.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 21 Sep 2023, Lukas Wunner wrote:

> Commit 44b27aec9d96 ("serial: core, 8250: set RS485 termination GPIO in
> serial core") enabled support for RS485 termination GPIOs behind i2c
> expanders by setting the GPIO outside of the critical section protected
> by the port spinlock.  Access to the i2c expander may sleep, which
> caused a splat with the port spinlock held.
> 
> Commit 7c7f9bc986e6 ("serial: Deassert Transmit Enable on probe in
> driver-specific way") erroneously regressed that by spinlocking the
> GPIO manipulation again.
> 
> Fix by moving uart_rs485_config() (the function manipulating the GPIO)
> outside of the spinlocked section and acquiring the spinlock inside of
> uart_rs485_config() for the invocation of ->rs485_config() only.
> 
> This gets us one step closer to pushing the spinlock down into the
> ->rs485_config() callbacks which actually need it.  (Some callbacks
> do not want to be spinlocked because they perform sleepable register
> accesses, see e.g. sc16is7xx_config_rs485().)
> 
> Stack trace for posterity:
> 
>  Voluntary context switch within RCU read-side critical section!
>  WARNING: CPU: 0 PID: 56 at kernel/rcu/tree_plugin.h:318 rcu_note_context_switch
>  Call trace:
>  rcu_note_context_switch
>  __schedule
>  schedule
>  schedule_timeout
>  wait_for_completion_timeout
>  bcm2835_i2c_xfer
>  __i2c_transfer
>  i2c_transfer
>  i2c_transfer_buffer_flags
>  regmap_i2c_write
>  _regmap_raw_write_impl
>  _regmap_bus_raw_write
>  _regmap_write
>  _regmap_update_bits
>  regmap_update_bits_base
>  pca953x_gpio_set_value
>  gpiod_set_raw_value_commit
>  gpiod_set_value_nocheck
>  gpiod_set_value_cansleep
>  uart_rs485_config
>  uart_add_one_port
>  pl011_register_port
>  pl011_probe
> 
> Fixes: 7c7f9bc986e6 ("serial: Deassert Transmit Enable on probe in driver-specific way")
> Suggested-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.1+
> ---
>  drivers/tty/serial/serial_core.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 7bdc21d5e13b..ca26a8aef2cb 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1404,12 +1404,18 @@ static void uart_set_rs485_termination(struct uart_port *port,
>  static int uart_rs485_config(struct uart_port *port)
>  {
>  	struct serial_rs485 *rs485 = &port->rs485;
> +	unsigned long flags;
>  	int ret;
>  
> +	if (!(rs485->flags & SER_RS485_ENABLED))
> +		return 0;
> +
>  	uart_sanitize_serial_rs485(port, rs485);

There's a subtle change in behavior here, uart_sanitize_serial_rs485() 
memset()s rs485 if RS485 is not enabled but the early return above does 
not.

Was that an oversight or intentional change? (I'm not sure it matters but 
it seems this fix doesn't realy depend on changing the zeroing behavior)

-- 
 i.

>  	uart_set_rs485_termination(port, rs485);
>  
> +	spin_lock_irqsave(&port->lock, flags);
>  	ret = port->rs485_config(port, NULL, rs485);
> +	spin_unlock_irqrestore(&port->lock, flags);
>  	if (ret)
>  		memset(rs485, 0, sizeof(*rs485));
>  
> @@ -2474,11 +2480,10 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
>  			if (ret == 0) {
>  				if (tty)
>  					uart_change_line_settings(tty, state, NULL);
> +				uart_rs485_config(uport);
>  				spin_lock_irq(&uport->lock);
>  				if (!(uport->rs485.flags & SER_RS485_ENABLED))
>  					ops->set_mctrl(uport, uport->mctrl);
> -				else
> -					uart_rs485_config(uport);
>  				ops->start_tx(uport);
>  				spin_unlock_irq(&uport->lock);
>  				tty_port_set_initialized(port, true);
> @@ -2587,10 +2592,10 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
>  		port->mctrl &= TIOCM_DTR;
>  		if (!(port->rs485.flags & SER_RS485_ENABLED))
>  			port->ops->set_mctrl(port, port->mctrl);
> -		else
> -			uart_rs485_config(port);
>  		spin_unlock_irqrestore(&port->lock, flags);
>  
> +		uart_rs485_config(port);
> +
>  		/*
>  		 * If this driver supports console, and it hasn't been
>  		 * successfully registered yet, try to re-register it.
> 
