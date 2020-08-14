Return-Path: <SRS0=xWBg=BY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6469C433E1
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 14:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 744B320866
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 14:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTVjZ5Gk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgHNOJw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHNOJu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Aug 2020 10:09:50 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E65C061384;
        Fri, 14 Aug 2020 07:09:49 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so4609747pgf.0;
        Fri, 14 Aug 2020 07:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ef5LJ2yNYl4zwywECTQBptoCdcYzbdTtvUSNV41zWDg=;
        b=iTVjZ5GkBLeIKvJ9aan7yTGC1RFIXnvbgiim6Rnc09bpm8Mu49zksTCXZ5j5ZlAfaH
         qHsQ2oGnMZgNCs2QnbaTLvVSBCgto0z9ZwFKaU1D1OMXgPCBL3SeHMJTj6ai7DbeT1tc
         y2rT24azx4IfhOv2FR51qiLvdaQ5fycLAeFzt+BQc1SRMdfG9ySM4fyw75Ri8a9mLfwG
         kcM8ysqqy7b8Y+5oJVPN+Te2XMZMbgl6QeE7eOkTyTgPIX9OrQrKcQ1xlWvHRbHJc/R2
         D0+UpCXQOtGQ9baQ0T/QdYNyTDSuN1O7JR2+bZ46sDC8CCUi0Hak3G5GATmdCT1AGZA9
         uddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ef5LJ2yNYl4zwywECTQBptoCdcYzbdTtvUSNV41zWDg=;
        b=IfV0m5UeTB6acikaeGm3I8sIuY4up7GPt8PEth9OYHg6ZumtCPCax9BoUYYuaebTU9
         B0vi3IX8Vy5nMuTCI83tX4CQwZ4sDa+dUKPzcLiqNm70kZlb1bNwo8P7ZgEk/6qiqOuz
         aDheEfPIjGdfom7EIvO4/BmpzLv5mDIhCNV/vufZCrnyv/UiDOputs3SQgXg+fCmyAnr
         KjQyLVWG32kAkOqwzKUWUtpFigb0Imv3X1/ljT+uAfXzn9zGBKnJQpRjurleGMmV+gki
         iihixpr8WbTDpE3GxvQeVICJ651mG9H2/Tj01Qb6ZcobDYCCFgPsn2aySWB0WxvrVo5K
         994A==
X-Gm-Message-State: AOAM532NrerB1tLA2WufPnRJVLIPed8PkkwVuNkUjlPj1F685Wg5xwF0
        p5Ukz3vdlB6d5nG7GY/hTExJPslaFhQ=
X-Google-Smtp-Source: ABdhPJx9COCqR8k9CYEjomMXGZgEDYHFObHlhzaWKkgk04Ra8+p0EiNF3yNwQO3vYHuh1N5xki6q1A==
X-Received: by 2002:a62:f904:: with SMTP id o4mr2072547pfh.14.1597414189025;
        Fri, 14 Aug 2020 07:09:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f63sm8627038pjk.53.2020.08.14.07.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 07:09:45 -0700 (PDT)
Subject: Re: [PATCH] uart:8250: change lock order in serial8250_do_startup()
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Raul Rangel <rrangel@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
References: <20200814013802.357412-1-sergey.senozhatsky@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <2a70c05e-4a0a-40f7-bc8b-29cd75be6d06@roeck-us.net>
Date:   Fri, 14 Aug 2020 07:09:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814013802.357412-1-sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 8/13/20 6:38 PM, Sergey Senozhatsky wrote:
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

Tested-by: Guenter Roeck <linux@roeck-us.net>

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
> 

