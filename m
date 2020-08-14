Return-Path: <SRS0=xWBg=BY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6602DC433E1
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 01:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3708420771
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 01:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewpTS6mv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHNBy1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Aug 2020 21:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgHNBy1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Aug 2020 21:54:27 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAA7C061757;
        Thu, 13 Aug 2020 18:54:27 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so3477926plr.7;
        Thu, 13 Aug 2020 18:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JoMZTg2rQH5X7Un5bSU0CwmEe/eR3O98Jy/+xzlp9iE=;
        b=ewpTS6mvUm57qdops8FwS5zQ47ZOhIarQlWHSvjJwn1hmvx+XiqhkoJisx/ShXjvfb
         QD6iG7XghFMmFrNFXemhP4SmeD8Hm5S58Anee93A0qXBT4/kXPyWrL09H1/85O6BHWL6
         eq1gmlmXGVWRLS7klEjdj1XY31T/Ou3MZ4qgbpiGWEfeeplehRYUs6AFOcTCWYI3q+jC
         n0Z5VIYMLUHsPmxwk8RVfJj1E3T1Vt4an4HbuR8QnjeN8ajVSF8vXEfBdNOmdmUPPAwE
         EvwUsu41//ZzSetxIbOs64GFzVpIBNlFbMXpjQLZKq3KdTlgdaC4BhyCgNhKnQtTg/R7
         t2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JoMZTg2rQH5X7Un5bSU0CwmEe/eR3O98Jy/+xzlp9iE=;
        b=Y7XgAvwqe6t+wGv+qqa1hEb4mlIdUov10wNnSCIW4I1IS3VHRvcNf2E+QDyJGMBYBA
         CZFIVg5OlY4ibXxwDulNuLbTU+q69ha0oKQmEGBGe5pf9Po/eXpHrAXq5Ks5tSz/IgXx
         cG3U9EEW/BIy0MvwXggkDAgkYCJ3Adoq2/20APX6xb4QftMiqaIt9TD/N1BTRxUcAqec
         WPBAWTlxPaqC5W08yMI4XIFiZ42MOx59sawXR/OJDsIg4M5bSPFkSa8uxwqPXso9idXg
         1jBAZ1ddtzAMX45GpReHn+9csla9IJmI8NmtVTF6WwGJXBKZqeTnLQOGgtL7T1/Gf3tz
         eL9Q==
X-Gm-Message-State: AOAM533XO0xz2EpAm725ATIW7PrOvCbBnZ4C+L/poHXaYq7qOFrifi5B
        /v58NR13Dr+Tl3wtkJGcXAxRI/aY
X-Google-Smtp-Source: ABdhPJyH+lenXjex692PnKeGimQpml2RBBnI/Z2KeY5iViWT1pv54cEf9gd8HZKJKSF0szXgYl+07Q==
X-Received: by 2002:a17:90b:1093:: with SMTP id gj19mr395914pjb.149.1597370066785;
        Thu, 13 Aug 2020 18:54:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j13sm7108455pfn.166.2020.08.13.18.54.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Aug 2020 18:54:26 -0700 (PDT)
Date:   Thu, 13 Aug 2020 18:54:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Raul Rangel <rrangel@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] uart:8250: change lock order in serial8250_do_startup()
Message-ID: <20200814015424.GA38268@roeck-us.net>
References: <20200814013802.357412-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814013802.357412-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 14, 2020 at 10:38:02AM +0900, Sergey Senozhatsky wrote:
> We have a number of "uart.port->desc.lock vs desc.lock->uart.port"
> lockdep reports coming from 8250 driver; this causes a bit of trouble
> to people, so let's fix it.
> 
> The problem is reverse lock order in two different call paths:
> 
> chain #1:
> 
>  serial8250_do_startup()
>   spin_lock_irqsave(&port->lock);
>    disable_irq_nosync(port->irq);
>     raw_spin_lock_irqsave(&desc->lock)
> 
> chain #2:
> 
>   __report_bad_irq()
>    raw_spin_lock_irqsave(&desc->lock)
>     for_each_action_of_desc()
>      printk()
>       spin_lock_irqsave(&port->lock);
> 
> Fix this by changing the order of locks in serial8250_do_startup():
>  do disable_irq_nosync() first, which grabs desc->lock, and grab
>  uart->port after that, so that chain #1 and chain #2 have same lock
>  order.
> 
> Full lockdep splat:
> 
>  ======================================================
>  WARNING: possible circular locking dependency detected
>  5.4.39 #55 Not tainted
>  ------------------------------------------------------
>  swapper/0/0 is trying to acquire lock:
>  ffffffffab65b6c0 (console_owner){-...}, at: console_lock_spinning_enable+0x31/0x57
> 
>  but task is already holding lock:
>  ffff88810a8e34c0 (&irq_desc_lock_class){-.-.}, at: __report_bad_irq+0x5b/0xba
> 
>  which lock already depends on the new lock.
> 
>  the existing dependency chain (in reverse order) is:
> 
>  -> #2 (&irq_desc_lock_class){-.-.}:
>         _raw_spin_lock_irqsave+0x61/0x8d
>         __irq_get_desc_lock+0x65/0x89
>         __disable_irq_nosync+0x3b/0x93
>         serial8250_do_startup+0x451/0x75c
>         uart_startup+0x1b4/0x2ff
>         uart_port_activate+0x73/0xa0
>         tty_port_open+0xae/0x10a
>         uart_open+0x1b/0x26
>         tty_open+0x24d/0x3a0
>         chrdev_open+0xd5/0x1cc
>         do_dentry_open+0x299/0x3c8
>         path_openat+0x434/0x1100
>         do_filp_open+0x9b/0x10a
>         do_sys_open+0x15f/0x3d7
>         kernel_init_freeable+0x157/0x1dd
>         kernel_init+0xe/0x105
>         ret_from_fork+0x27/0x50
> 
>  -> #1 (&port_lock_key){-.-.}:
>         _raw_spin_lock_irqsave+0x61/0x8d
>         serial8250_console_write+0xa7/0x2a0
>         console_unlock+0x3b7/0x528
>         vprintk_emit+0x111/0x17f
>         printk+0x59/0x73
>         register_console+0x336/0x3a4
>         uart_add_one_port+0x51b/0x5be
>         serial8250_register_8250_port+0x454/0x55e
>         dw8250_probe+0x4dc/0x5b9
>         platform_drv_probe+0x67/0x8b
>         really_probe+0x14a/0x422
>         driver_probe_device+0x66/0x130
>         device_driver_attach+0x42/0x5b
>         __driver_attach+0xca/0x139
>         bus_for_each_dev+0x97/0xc9
>         bus_add_driver+0x12b/0x228
>         driver_register+0x64/0xed
>         do_one_initcall+0x20c/0x4a6
>         do_initcall_level+0xb5/0xc5
>         do_basic_setup+0x4c/0x58
>         kernel_init_freeable+0x13f/0x1dd
>         kernel_init+0xe/0x105
>         ret_from_fork+0x27/0x50
> 
>  -> #0 (console_owner){-...}:
>         __lock_acquire+0x118d/0x2714
>         lock_acquire+0x203/0x258
>         console_lock_spinning_enable+0x51/0x57
>         console_unlock+0x25d/0x528
>         vprintk_emit+0x111/0x17f
>         printk+0x59/0x73
>         __report_bad_irq+0xa3/0xba
>         note_interrupt+0x19a/0x1d6
>         handle_irq_event_percpu+0x57/0x79
>         handle_irq_event+0x36/0x55
>         handle_fasteoi_irq+0xc2/0x18a
>         do_IRQ+0xb3/0x157
>         ret_from_intr+0x0/0x1d
>         cpuidle_enter_state+0x12f/0x1fd
>         cpuidle_enter+0x2e/0x3d
>         do_idle+0x1ce/0x2ce
>         cpu_startup_entry+0x1d/0x1f
>         start_kernel+0x406/0x46a
>         secondary_startup_64+0xa4/0xb0
> 
>  other info that might help us debug this:
> 
>  Chain exists of:
>    console_owner --> &port_lock_key --> &irq_desc_lock_class
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&irq_desc_lock_class);
>                                 lock(&port_lock_key);
>                                 lock(&irq_desc_lock_class);
>    lock(console_owner);
> 
>   *** DEADLOCK ***
> 
>  2 locks held by swapper/0/0:
>   #0: ffff88810a8e34c0 (&irq_desc_lock_class){-.-.}, at: __report_bad_irq+0x5b/0xba
>   #1: ffffffffab65b5c0 (console_lock){+.+.}, at: console_trylock_spinning+0x20/0x181
> 
>  stack backtrace:
>  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.39 #55
>  Hardware name: XXXXXX
>  Call Trace:
>   <IRQ>
>   dump_stack+0xbf/0x133
>   ? print_circular_bug+0xd6/0xe9
>   check_noncircular+0x1b9/0x1c3
>   __lock_acquire+0x118d/0x2714
>   lock_acquire+0x203/0x258
>   ? console_lock_spinning_enable+0x31/0x57
>   console_lock_spinning_enable+0x51/0x57
>   ? console_lock_spinning_enable+0x31/0x57
>   console_unlock+0x25d/0x528
>   ? console_trylock+0x18/0x4e
>   vprintk_emit+0x111/0x17f
>   ? lock_acquire+0x203/0x258
>   printk+0x59/0x73
>   __report_bad_irq+0xa3/0xba
>   note_interrupt+0x19a/0x1d6
>   handle_irq_event_percpu+0x57/0x79
>   handle_irq_event+0x36/0x55
>   handle_fasteoi_irq+0xc2/0x18a
>   do_IRQ+0xb3/0x157
>   common_interrupt+0xf/0xf
>   </IRQ>
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

For the time being:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

I triggered complete set of test runs on chromeos-{4.4,4.14,4.19,5.4}.
I'll send an update, hopefully by tomorrow morning, with results.

Thanks,
Guenter

> ---
>  drivers/tty/serial/8250/8250_port.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 09475695effd..67f1a4f31093 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2275,6 +2275,11 @@ int serial8250_do_startup(struct uart_port *port)
>  
>  	if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
>  		unsigned char iir1;
> +		bool irq_shared = up->port.irqflags & IRQF_SHARED;
> +
> +		if (irq_shared)
> +			disable_irq_nosync(port->irq);
> +
>  		/*
>  		 * Test for UARTs that do not reassert THRE when the
>  		 * transmitter is idle and the interrupt has already
> @@ -2284,8 +2289,6 @@ int serial8250_do_startup(struct uart_port *port)
>  		 * allow register changes to become visible.
>  		 */
>  		spin_lock_irqsave(&port->lock, flags);
> -		if (up->port.irqflags & IRQF_SHARED)
> -			disable_irq_nosync(port->irq);
>  
>  		wait_for_xmitr(up, UART_LSR_THRE);
>  		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
> @@ -2297,9 +2300,9 @@ int serial8250_do_startup(struct uart_port *port)
>  		iir = serial_port_in(port, UART_IIR);
>  		serial_port_out(port, UART_IER, 0);
>  
> -		if (port->irqflags & IRQF_SHARED)
> -			enable_irq(port->irq);
>  		spin_unlock_irqrestore(&port->lock, flags);
> +		if (irq_shared)
> +			enable_irq(port->irq);
>  
>  		/*
>  		 * If the interrupt is not reasserted, or we otherwise
> -- 
> 2.28.0
> 
