Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5D93BBFCA
	for <linux-serial@vger.kernel.org>; Thu, 23 Jul 2026 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804356; cv=none; b=OcUqisKehWH99bnI7ps6VPJDW19e3NJcaznBDGJ0LwZN3NtQQYkU8C4mOLWWYUNGFEk0M2IRiUTxskh/xJUSquAjylf90wt1aZowFJtgBJ9z0+XvXQbBU6kY9JFA47RvtxwHnGrhKFCuYVSvuu69QFKlK27kU4qkRqvezEzuHtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804356; c=relaxed/simple;
	bh=d5XEDx1ZlWhZosDsAVzATtdDuc/5GbRYUPILN0uYBK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0uWc/ABAMEbUrKi8kX1GMbTSc/JlBw7o8AEWXCE003SH0FjINbIuEGgnQawhqkrDNTB5dMfCevJheorEiB1AGCxEp+LInKgvRutBdaNv23ZJTCWcQ34lF//ldA6suGeDYZWQSEkB4guf/oHd/z3PN1BxsilKiw5Cs0KGwjhU/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bUtmzy30; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bUtmzy30"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49571fea44eso2967795e9.2
        for <linux-serial@vger.kernel.org>; Thu, 23 Jul 2026 03:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784804352; x=1785409152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d6QyTI/jMIesF5gbgMzngBGUAuRhntGFJAbuMMOaIa4=;
        b=bUtmzy30fpICgdWA3FN4FWnLJmd+hp/u96PFbQqU+luCIxWJsTTQHrt56eg3Y7yN6L
         PoORMf8tse4A8fdRIZXK2500npK6moEF6pgvB2KLd1Qn4C/yb6iOHxtMsIy2hYrUtJMr
         JVK5KoObetRt7ad8AGwQvX+Vu/snlF4Cr9Rixd5WwCKsMA4DmV18JyHBlyCDF9M5xCFz
         LLvrCjTsaS0gAFKf10Nk1BEx43VTpAA5JAgyM7ZGxk6RLK29W4gJXGRbHvO+i/sA+iTI
         VjVZJORlTPwnsvskceApN+N2wP/7y4Adki6aQ2KdTMG2A2de+TJbhCp34VGDA7cIHFyJ
         U23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784804352; x=1785409152;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d6QyTI/jMIesF5gbgMzngBGUAuRhntGFJAbuMMOaIa4=;
        b=Mbgcp8Y80X11rnWfJZTZl/aiRo2XLYhKsjTsA3utb47pSvlZwJqZangqYvHAMh/Uf/
         +pUlK03sFlVKjolhwNsGGCA+70HNo8aCgLMJ/ULaiZtXxn3GXcnECtr1cgnNE3ersz6k
         XTfE6tB3Ob0noXQxQ0YLTY9EFjHjwHqzI7R7GStN4+sPf7NXUdmc7HLPy1mdwTcIqbK/
         3io7Tyl8MFSsnli3+C6Gf9LnS8p7r8IhB7Nqv+ov/pq+UDVZkW2h08L+b2TBHLf7fcVL
         LKGsex2QS1whKLpesvCM2NflKC0rNHEKT10tD7zAr5FKbr2wyyvmV46Pl7YwHJabC7d9
         zznQ==
X-Forwarded-Encrypted: i=1; AHgh+RqjSmlQbLZMP+GDrw2o0GFanLYGywwebD6ldho9yY32mXikSiH4sKEhSt9uMyD//sol89yXpdoeGmITxZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvHltzdffU/Nt/s8LA4wVOZf1gOnZeSyClaBQN5RXPI4NRN++p
	w6o2dPM3ejCpqb8OOMXFyli09SY+x8P71xPGr/B9ij1zEfcc3q0b5jh1IJjbwSlmuxc=
X-Gm-Gg: AR+sD13EqjDbU9Juze5azV6+ykyjTWDLwBkdaDkUlc9jY7gSYgNDkaoKyoP1r3Segb4
	H1PqZ2xCnlykUim5sVX/5xwI4WOHPZ+mKRqUopPSR5ut+Ocmi/tD3viuLoCtBKwbAU1I9HaUyKY
	ImOylbqLeRUjbZLcnhfqI/g/6A5BAnKO/bLJfaeYSUhDY0yM+HK51ODGBvyZhAz16Q5FxQx1z5x
	BlMq4He64yo5QHgO+qtk8uxytxOL3Qz79zrMvJpoDqgWn61MjwqyaQVngAbg5RxMzkY1yMiS9Of
	TLChyXzFeUz/WoYVVbRXlIb0QUoyO8BuxBp1/TaNmDKgeizqbRMIky8uSsq38TeoT4pN8YQ/FMc
	aDFsA4oH+EXxBrLXteLfBYIaKiR8wJHdTwBctPIm0DSpPix+f/cAtn+yrbUp6jnZU2K71Q2Cy0X
	dMGv+GRHDhi2y/Vw0=
X-Received: by 2002:a05:600c:3b86:b0:494:6baa:ccef with SMTP id 5b1f17b1804b1-49573ccd0b5mr28565535e9.11.1784804351955;
        Thu, 23 Jul 2026 03:59:11 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653bfabesm244562405e9.10.2026.07.23.03.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 03:59:11 -0700 (PDT)
Date: Thu, 23 Jul 2026 12:59:08 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stepan Ionichev <sozdayvek@gmail.com>, Kees Cook <kees@kernel.org>,
	Xin Zhao <jackzxcui1989@163.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v8 1/2] serial: 8250: Switch to nbcon console, take 2
Message-ID: <amHz_PkZhHbsWEb8@pathway.suse.cz>
References: <20260722110925.74387-1-john.ogness@linutronix.de>
 <20260722110925.74387-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722110925.74387-2-john.ogness@linutronix.de>

On Wed 2026-07-22 13:15:18, John Ogness wrote:
> Implement the necessary callbacks to switch the 8250 console driver
> to perform as an nbcon console.
> 
> Add implementations for the nbcon console callbacks:
> 
>   ->write_atomic()
>   ->write_thread()
>   ->device_lock()
>   ->device_unlock()
> 
> and add CON_NBCON to the initial @flags.
> 
> All hardware access in the callbacks is within unsafe sections.
> The ->write_atomic() and ->write_thread() callbacks allow safe
> handover/takeover per byte and add a preceding newline if they
> take over from another context mid-line.
> 
> For the ->write_atomic() callback, a new irq_work is used to defer
> modem control since it may be called from a context that does not
> allow waking up tasks. During suspend/resume the irq_work is not
> used as this has been shown to cause suspend problems for some
> hardware. Upon resume, any pending modem control is performed.
> 
> Note: A new __serial8250_clear_IER() is introduced for direct
> clearing of UART_IER during console writing (which will not be
> holding the port lock for atomic printing or KDB/KGDB). This
> allows restoring a lockdep check to serial8250_clear_IER() in
> a follow-up commit.
> 
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -584,13 +609,19 @@ void serial8250_suspend_port(int line)
>  	struct uart_8250_port *up = &serial8250_ports[line];
>  	struct uart_port *port = &up->port;
>  
> -	if (!console_suspend_enabled && uart_console(port) &&
> -	    port->type != PORT_8250) {
> -		unsigned char canary = 0xa5;
> +	if (uart_console(port)) {
> +		/* No irq_work may be queued when suspending. */
> +		scoped_guard(uart_port_lock_irqsave, port)

Strictly speaking, it should be enough to call "uart_port_lock_irq"
instead of the "_irqsafe" variant.

This code must be called in a schedulable context. Otherwise,
we can't call irq_work_sync() below.

Honestly, I have been a bit lost in the maze of macros and callbacks.
And I wanted to be sure where this is called. So, I added WARN_ON(1)
and dumped all locks.

And it seems that we are on the safe side. This code is
called here:

[   78.676626] CPU: 7 UID: 0 PID: 1542 Comm: bash Kdump: loaded Not tainted 7.2.0-rc4-default+ #24 PREEMPT(full)  252cd4fa4cf2d3bc860af0a8bfee0a3e125ae7f8
[   78.676634] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-2-g4f253b9b-prebuilt.qemu.org 04/01/2014
[   78.676640] RIP: 0010:serial8250_suspend_port.cold+0x1f/0x1e4
[   78.676648] Code: dc e8 70 f6 02 00 e9 b3 28 df 00 53 48 c7 c7 d0 6d 0d 9f 48 83 ec 20 48 89 54 24 10 4c 89 4c 24 08 4c 89 04 24 e8 2c 1b fb ff <0f> 0b e8 d5 ee fa ff 48 8b 3c 24 e8 6c fa
 49 01 83 3d 79 0c 6b 02
[   78.676653] RSP: 0018:ffffd16d82743c10 EFLAGS: 00010246
[   78.676662] RAX: 0000000000000041 RBX: ffff8d8a00ab3800 RCX: 0000000000000001
[   78.676667] RDX: 0000000000000000 RSI: ffffffff9f1ae0d7 RDI: 00000000ffffffff
[   78.676672] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
[   78.676677] R10: 0000000000000007 R11: 0000000000000000 R12: ffffffff9f7f5a80
[   78.676681] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
[   78.676689] FS:  00007fadbce4e200(0000) GS:ffff8d8ada0a0000(0000) knlGS:0000000000000000
[   78.676695] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   78.676699] CR2: 000055b5982aea10 CR3: 000000010cb6b000 CR4: 0000000000750ef0
[   78.676707] PKRU: 55555554
[   78.676712] Call Trace:
[   78.676718]  <TASK>
[   78.676732]  serial_pnp_suspend+0x11/0x20
[   78.676745]  __pnp_bus_suspend+0x3d/0x100
[   78.676761]  ? __pfx_pnp_bus_freeze+0x10/0x10
[   78.676770]  dpm_run_callback+0x66/0x1f0
[   78.676790]  device_suspend+0x235/0x700
[   78.676798]  ? srso_alias_return_thunk+0x5/0xfbef5
[   78.676807]  ? __lock_release.isra.0+0x1c9/0x300
[   78.676825]  ? __pfx_dpm_watchdog_handler+0x10/0x10
[   78.676851]  ? __mutex_unlock_slowpath+0x1a9/0x410
[   78.676874]  dpm_suspend+0x18f/0x400
[   78.676888]  hibernation_snapshot+0xcb/0x1e0
[   78.676908]  hibernate.cold+0xfd/0x48b
[   78.676925]  state_store+0xc3/0xd0
[   78.676940]  kernfs_fop_write_iter+0x163/0x240
[   78.676960]  vfs_write+0x222/0x560
[   78.676997]  ksys_write+0x70/0xf0
[   78.677012]  do_syscall_64+0xb1/0x6d0
[   78.677021]  ? srso_alias_return_thunk+0x5/0xfbef5
[   78.677036]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   78.677043] RIP: 0033:0x7fadbc106af3

And the locks are:

[   78.677780] 7 locks held by bash/1542:
[   78.677784]  #0: ffff8d8a038a4470 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x70/0xf0
[   78.677820]  #1: ffff8d8a08f44288 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x105/0x240
[   78.677849]  #2: ffff8d8a00d9a230 (kn->active#105){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x11a/0x240
[   78.677878]  #3: ffffffff9f48c0a8 (system_transition_mutex){+.+.}-{4:4}, at: lock_system_sleep+0x2b/0x40
[   78.677904]  #4: ffffffff9f804968 (device_hotplug_lock){+.+.}-{4:4}, at: hibernate.cold+0xac/0x48b
[   78.677930]  #5: ffff8d8a00ab3938 (&dev->mutex){....}-{4:4}, at: device_suspend+0x1ff/0x700
[   78.677955]  #6: ffffffff9f5ab1a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire.constprop.0+0x7/0x30

, where the rcu_read_lock() is from debug_show_all_locks() itself.

The function serial8250_suspend_port() is called under dev->mutex
so we are on the safe side.


> +			up->console_msr_work_allow = false;
> +		irq_work_sync(&up->console_msr_work);
>  
> -		serial_out(up, UART_SCR, canary);
> -		if (serial_in(up, UART_SCR) == canary)
> -			up->canary = canary;
> +		if (!console_suspend_enabled && port->type != PORT_8250) {
> +			unsigned char canary = 0xa5;
> +
> +			serial_out(up, UART_SCR, canary);
> +			if (serial_in(up, UART_SCR) == canary)
> +				up->canary = canary;
> +		}
>  	}
>  
>  	uart_suspend_port(&serial8250_reg, port);
> @@ -620,6 +651,18 @@ void serial8250_resume_port(int line)
>  		port->uartclk = 921600*16;
>  	}
>  	uart_resume_port(&serial8250_reg, port);
> +
> +	if (uart_console(port)) {
> +
> +		guard(uart_port_lock_irqsave)(port);

This should be symetrical -> s/irqsave/irq

> +		/* irq_work allowed again. */
> +		up->console_msr_work_allow = true;
> +
> +		/* Handle any pending MSR changes. */
> +		if (up->msr_saved_flags)
> +			serial8250_modem_status(up);
> +	}
>  }
>  EXPORT_SYMBOL(serial8250_resume_port);


Plus the problem reported by Sashiko.

Otherwise, it looks good to me.

Best Regards,
Petr
