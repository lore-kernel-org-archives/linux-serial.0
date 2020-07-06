Return-Path: <SRS0=r/Py=AR=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B41C433DF
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jul 2020 16:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D72206DF
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jul 2020 16:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594053419;
	bh=k2QTWzbMB6APqphVWK4zFEzNUlT95fuHmff9QWbaTSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gmdKx+oIzXGDIAmSwA29oy+4id5LATE93idT2A8pbbaRwBzzDeyOlHi8bmbr9rkN9
	 n3CRXxUTEJOx62/QMCGJXWFZZ/Aaio4SHUEn8UGl8kcUnz56pnJMNDBnMwBW8shD/0
	 5/WPKZTnUjqbonY4PdZBZRO0gQCzsbOeyZ7eWdqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgGFQg7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729551AbgGFQg7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Jul 2020 12:36:59 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 570D1206CD;
        Mon,  6 Jul 2020 16:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594053418;
        bh=k2QTWzbMB6APqphVWK4zFEzNUlT95fuHmff9QWbaTSU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R2r5StX+V3B+npBW3ROfxhQf8cLMzKyuo5om8oJiNKRPOA0FbpxvxW+THocSo7qe5
         t4BT1piRU2BWG0nouW4WEab2fHL0eKSauKuxQL2V5At3SmPCYYHwaKWvy9kw2qOra3
         BoqDQKgsnI27uZYM1DEcyZvTUqLA8FNv9RuFCJZs=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jsU6y-009Vjc-Sl; Mon, 06 Jul 2020 17:36:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 06 Jul 2020 17:36:56 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Anatoly Pugachev <matorola@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] serial: core: Initialise spin lock before use in
 uart_configure_port()
In-Reply-To: <20200706143548.63985-1-andriy.shevchenko@linux.intel.com>
References: <20200706143548.63985-1-andriy.shevchenko@linux.intel.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <bfa0f8b35fe5b1864338376fa34b0db1@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com, linux@roeck-us.net, matorola@gmail.com, tony@atomide.com, geert@linux-m68k.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2020-07-06 15:35, Andy Shevchenko wrote:
> The comment near to uart_port_spin_lock_init() says:
> 
>   Ensure that the serial console lock is initialised early.
>   If this port is a console, then the spinlock is already initialised.
> 
> and there is nothing about enabled or disabled consoles. The commit
> a3cb39d258ef ("serial: core: Allow detach and attach serial device
> for console") made a change, which follows the comment, and also to
> prevent reinitialisation of the lock in use, when user detaches and
> attaches back the same console device. But this change discovers
> another issue, that uart_add_one_port() tries to access a spin lock
> that now may be uninitialised. This happens when a driver expects
> the serial core to register a console on its behalf. In this case
> we must initialise a spin lock before use.
> 
> Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial
> device for console")
> Reported-by: Marc Zyngier <maz@kernel.org>
> Reported-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: my bad to send the version with one typo, now squashed and resent
> 
> I hope this is now properly root caused. To the people in Reported-by 
> list, can
> you revert the corresponding change you either reported or submitted to 
> the
> certain serial driver and apply this patch and retest?
> 
> Tony, can you also test that this doesn't change anything for the PM 
> case for
> OMAP?
> 
> Geert, I tried to explain above why the change had been made in the 
> first place.
> 
>  drivers/tty/serial/serial_core.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c 
> b/drivers/tty/serial/serial_core.c
> index 3cc183acf7ba..55f9615f0b50 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1915,6 +1915,12 @@ static inline bool uart_console_enabled(struct
> uart_port *port)
>  	return uart_console(port) && (port->cons->flags & CON_ENABLED);
>  }
> 
> +static inline void uart_any_port_spin_lock_init(struct uart_port 
> *port)

nit: __uart_port_spin_lock_init() looks like a better name to me
(as a primitive of uart_port_spin_lock_init). You can also drop
the inline which doesn't mean much these days (and this isn't
a hot path).

> +{
> +	spin_lock_init(&port->lock);
> +	lockdep_set_class(&port->lock, &port_lock_key);
> +}
> +
>  /*
>   * Ensure that the serial console lock is initialised early.
>   * If this port is a console, then the spinlock is already 
> initialised.
> @@ -1924,8 +1930,7 @@ static inline void
> uart_port_spin_lock_init(struct uart_port *port)
>  	if (uart_console(port))
>  		return;
> 
> -	spin_lock_init(&port->lock);
> -	lockdep_set_class(&port->lock, &port_lock_key);
> +	uart_any_port_spin_lock_init(port);
>  }
> 
>  #if defined(CONFIG_SERIAL_CORE_CONSOLE) || 
> defined(CONFIG_CONSOLE_POLL)
> @@ -2371,6 +2376,13 @@ uart_configure_port(struct uart_driver *drv,
> struct uart_state *state,
>  		/* Power up port for set_mctrl() */
>  		uart_change_pm(state, UART_PM_STATE_ON);
> 
> +		/*
> +		 * If this driver supports console, and it hasn't been
> +		 * successfully registered yet, initialise spin lock for it.
> +		 */
> +		if (port->cons && !(port->cons->flags & CON_ENABLED))
> +			uart_any_port_spin_lock_init(port);
> +
>  		/*
>  		 * Ensure that the modem control lines are de-activated.
>  		 * keep the DTR setting that is set in uart_set_options()

Otherwise looks OK to me (having tested an earlier version).
With the above addressed:

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
