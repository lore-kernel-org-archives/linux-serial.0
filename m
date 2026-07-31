Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074203A1B5
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506666; cv=none; b=C7q57sMR1Yl9Sqn6ef+6YHjqWORt/wL3Q66rmsgCrBLx1htc3P+XiUJtjTs2UhXGK5Yv1AgN+OPj8HLIvMeW3enp4L6JlrLVhNq0SzDU3TaGSb92QU4exYUDq3xP+1uyDpaQmS6QlIaevN6sNsBeqpoTJPqtiiClkjkaW/DjLyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506666; c=relaxed/simple;
	bh=CL6a3kKGMqX/G72gkjdWy54ME6pk+gvSa7r8f+O9bI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRUd+HyJNriMhbUIj7+LdZzBOP20HuUKrfK6B20qc/5Z0a66pyc6TVi1OXZF6tIIxtPkNbvDs2HwpGxExJXrGxzVui8aY9FMX/x1y5z7gLH6Qc918H+7sOqiljXb0y2DxwcTwPHcC0WXRbT3phduiG4Xx4vf6t3X/tyS7H/vBcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LtcE20ry; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LtcE20ry"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1f5208b38dso185944566b.0
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785506663; x=1786111463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SP1Qo5NZA0OKmxVoX1OJh2e5C6DfgXTb/m2D0IDgq70=;
        b=LtcE20ryi1ST0k9YRCI5AUiiUV4PNeN6WRLP5o4Tmxlej/7juGOAJeIkWU4e5rnRnw
         hCc39FveyFfKZx4bZzsPbjxD/wF1mrkNg41bcgJtFOrWxP7AgxQevmm4vUhRKX4un+RI
         1+5ZotrNPig7yFzmqW82Ln8ASrHfPCbrk7MZ4EpI0/fy+E39oZKvlya8ACcjZaLzKVHQ
         VH6j0gfpKTJtqK0Zj0w9Q1SXkU2ExF3Gz0myPUTSO5Dxt+dhdBFKuwuGQXGbqDMamTqL
         VzA/RxwFLO7XBRz2xkdXFcWm59fGdsBzFyoU0H8RUUUqpyXrCrNzCodKFlHb8yCo5TkF
         C8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785506663; x=1786111463;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SP1Qo5NZA0OKmxVoX1OJh2e5C6DfgXTb/m2D0IDgq70=;
        b=p9oE7MN0WzRLwCuhzQcr0Mg36x+by2BgSRJBpcOtuvnsXPqWBpGdtsnasOhc9PC/1p
         oCGbvAjITviiHtXJ6GM9PIBLrcicSXSo2I39xi5OWQ+zTfIBhWYDO/ZgwsRVEM9rnnq1
         K0c6TgxZ/btPiZ4S20WeOcpcBUM6AlsjtJLJPNsmJxOLCrXlnzHb9ybIBibysnL0p7Xn
         /lziZwqD9z/VIxl6Pp0f1xTmUvPt/5RSx9Wex5mtmKV5lr9jG5NK18io11nEhNnqA4LW
         yK/7ulK9IdXkE/tzNthU9zOLlT7Yxw1DZo8rw48LaOYHVG8fJ8Lqs+6TkAmQxzouTMz3
         ZK0w==
X-Forwarded-Encrypted: i=1; AHgh+RrHqlL+ZaH2h9aZYjTYOUIDhT2yFzpkN9wVN6P6TL3ft+0uZp8gAXTY1Nz1BC8rpJ6ndUAnk43/bM05stQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyv3vKENzAS0Lw48RV1PIJ5Q0Y6xp0LSdGmgP4q5mVgFnS3jVf
	w3CnDUQowNehawJVIe+Z/Vzv5UUI4NDSjPSboB7FgSf9FMYE5XQsDjM2n/aL731QcfE=
X-Gm-Gg: AR+sD13sJhHpR5wnsuohw2AUJGmt6IUr3GSyLeimpbKf1CXV+UegG5h2WLf6eeAu0Uo
	yo1Z/SRUxc2snQtna7NuYRHZuyQFpvqJzZMjup4LJoCoUM54GBX01BVMOHh8ApHyTV6//5wNczi
	WnEtZp35J7sTSnXv8v4YSNl1gaVdO13QOQLQqEXw9GH/j4ln/LfzUCyVCjUg9TGKkearOw62VEK
	DPhcf1LXWaCGod5Aa49O+jfFxN16aXui1WIs4YGi5ADPBUWpY8CeboSZqkGM+3OeTBACqcw8YU5
	Yk70266cHn0SDqXAhAmbhOz5Q+llA4DM0qxGf0tJUwb8ZnQoGCxkNkchUb2hsMXp3LR5Vngg/HA
	MltOoPHeMkxsIXowjCiDGc1RsOIkMAo+8qI1UoTYIsqimAGcVbgCqymlgej1vp4yU7x3xHWs47C
	s3QLhgOe369JwpIh4fuFgc9ff3wWdTZeBkTFzR+9yo9+BVAG5enhTMrKq0ryPY+zg=
X-Received: by 2002:a17:907:9309:b0:c16:e3b:7d6 with SMTP id a640c23a62f3a-c1fd270255dmr134710266b.54.1785506663137;
        Fri, 31 Jul 2026 07:04:23 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458bf7csm5313078f8f.32.2026.07.31.07.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:04:22 -0700 (PDT)
Date: Fri, 31 Jul 2026 16:04:20 +0200
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
	Kees Cook <kees@kernel.org>, Stepan Ionichev <sozdayvek@gmail.com>,
	Xin Zhao <jackzxcui1989@163.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
Message-ID: <amyrZMGWys1-Nb7N@pathway.suse.cz>
References: <20260729120439.281252-1-john.ogness@linutronix.de>
 <20260729120439.281252-2-john.ogness@linutronix.de>
 <amtepien519U578B@pathway.suse.cz>
 <87ldarwqeb.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldarwqeb.fsf@jogness.linutronix.de>

On Fri 2026-07-31 09:54:44, John Ogness wrote:
> On 2026-07-30, Petr Mladek <pmladek@suse.com> wrote:
> >> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> >> index 8c241ec7f4f29..b9ea4f898474e 100644
> >> --- a/drivers/tty/serial/8250/8250_port.c
> >> +++ b/drivers/tty/serial/8250/8250_port.c
> >> @@ -3352,10 +3458,17 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
> >>  		 */
> >>  		!uart_console_hwflow_active(&up->port);
> >>  
> >> -	if (likely(use_fifo))
> >> -		serial8250_console_fifo_write(up, s, count);
> >> -	else
> >> -		uart_console_write(port, s, count, serial8250_console_wait_putchar);
> >> +	nbcon_exit_unsafe(wctxt);
> >> +
> >> +	__serial8250_console_write(up, wctxt, use_fifo);
> >> +
> >> +	/*
> >> +	 * Re-enter an unsafe section in order to perform final actions
> >> +	 * (such as re-enabling interrupts). If ownership was lost, this
> >> +	 * context must reacquire ownership.
> >> +	 */
> >> +	while (!nbcon_enter_unsafe(wctxt))
> >> +		nbcon_reacquire_nobuf(wctxt);
> >
> > If we are going to use this on more locations than I would add
> > a new API, e.g.
> 
> Agreed.
> 
> The 8250 has already played a significant role in influencing other
> NBCON implementations. I expect there will be a lot of copy/paste in the
> beginning. Once we start seeing which code is copied and how it is used
> in other drivers, we should be be able to do some general nbcon and
> serial_core consolidation.

Yup.

> > /**
> >  * nbcon_enter_unsafe_reacquire - Enter an unsafe region in the driver,
> >  *	reacquire when needed.
> >  * @wctxt:	The write context that was handed to the write function
> >  *
> >  *
> >  * The function is allowed to reacquire the console ownership to make
> >  * sure that the caller can enter an unsafe region in the driver.
> >  *
> >  * Warning: The caller must not longer access the text buffer. It is
> >  *	lost when the reacquire was needed. The function is intended
> >  *	for cleanup operations after emitting the message, for example,
> >  *	re-enabling interrupts on a used serial port.
> >  */
> > void nbcon_enter_unsafe_reacquire(struct nbcon_write_context *wctxt)
> > {
> > 	while (!nbcon_enter_unsafe(wctxt))
> > 		nbcon_reacquire_nobuf(wctxt);
> > }
> 
> I would name the function:
> 
> 	nbcon_enter_unsafe_reacquire_nobuf()

Yes, it looks better.

> to make it clear that the buffer will be lost on a reacquire.
> 
> >> @@ -3365,10 +3478,21 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
> >>  
> >>  	if (em485) {
> >>  		mdelay(port->rs485.delay_rts_after_send);
> >> +
> >> +		/* Toggle unsafe after possibly long delay */
> >> +		nbcon_exit_unsafe(wctxt);
> >> +		while (!nbcon_enter_unsafe(wctxt))
> >> +			nbcon_reacquire_nobuf(wctxt);
> >
> > The comment describes what the code does but it does not explain why.
> 
> Well, the _why_ is the same for all the toggling that we do throughout
> the console code.

Yes, a good place to document it would be a comment above a helper
function.

> > My first idea was that it would allow to takeover the ownership
> > as soon as possible in an emergency context.
> 
> Yes. That is one of the purposes. Even takeovers in panic will patiently
> wait up to 2ms before becoming hostile.
> 
> > But the motivation seems to be to reduce the race with a possible
> > unsafe takeover in the final panic flush, see
> > https://lore.kernel.org/all/87ecgntf01.fsf@jogness.linutronix.de/
> 
> Yes, this is also valid, but for all other toggle situations as
> well. The driver should avoid touching the hardware if it is no longer
> the owner.
> 
> > I think about entering unsafe only when really needed.
> > Instead of releasing it and taking again immediately.
> >
> > Something like:
> >
> > 	/*
> > 	 * Re-enter an unsafe section in order to perform final actions
> > 	 * (such as re-enabling interrupts). If ownership was lost, this
> > 	 * context must reacquire ownership.
> > 	 */
> > 	nbcon_enter_unsafe_reacquire(wctxt);
> >
> > 	/*
> > 	 *	Finally, wait for transmitter to become empty
> > 	 *	and restore the IER
> > 	 */
> > 	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
> >
> > 	/*
> > 	 * Exit unsafe section after a potentially long wait. It allows
> > 	 * a safe takeover before another potentially long way. Also
> > 	 * it reduces the race window when a possible unsafe takeover
> > 	 * happened unnoticed.
> > 	 */
> > 	nbcon_exit_unsafe()
> >
> > 	if (em485) {
> > 		u32 delay;
> >
> > 		nbcon_enter_unsafe_reacquire(wctxt);
> > 		delay = port->rs485.delay_rts_after_send;
> > 		nbcon_exit_unsafe(wctxt);
> 
> This unsafe enter/exit is unnecessary. This value does not change.

I have added the locking because of:

 + uart_ioctl()
   + uart_set_rs485_config()
     + uart_sanitize_serial_rs485()
       + uart_sanitize_serial_rs485_delays()

which does

	} else if (rs485->delay_rts_after_send > RS485_MAX_RTS_DELAY) {
		rs485->delay_rts_after_send = RS485_MAX_RTS_DELAY;

But I guess that this is is a rather theoretical race.

> > 		mdelay(port->rs485.delay_rts_after_send);
> >
> > 		nbcon_enter_unsafe_reacquire(wctxt);
> > 		if (em485->tx_stopped)
> > 			up->rs485_stop_tx(up, false);
> > 		nbcon_exit_unsafe(wctxt);
> > 	}
> >
> > 	nbcon_enter_unsafe_reacquire(wctxt);
> >
> > 	serial_port_out(port, UART_IER, ier);
> >
> > 	/*
> > 	 *	The receive handling will happen properly because the
> > 	 *	receive ready bit will still be set; it is not cleared
> > 	 *	on read.  However, modem control will not, we must
> > 	 *	call it if we have saved something in the saved flags
> > 	 *	while processing with interrupts off.
> > 	 */
> > 	if (up->msr_saved_flags) {
> > 		if (is_atomic) {
> > 			/*
> > 			 * For atomic, MSR handling must be deferred to
> > 			 * irq_work because this may be a context that does
> > 			 * not permit waking up tasks.
> > 			 *
> > 			 * But no irq_work may be queued when suspending.
> > 			 * In that case, the MSR handling will occur during
> > 			 * resume in serial8250_resume_port().
> > 			 */
> > 			if (up->console_msr_work_allow)
> > 				irq_work_queue(&up->console_msr_work);
> > 		} else {
> > 			serial8250_modem_status(up);
> > 		}
> > 	}
> >
> > 	nbcon_exit_unsafe(wctxt);
> > }
> >
> > But I have to say that both approaches are quite hairy. I am not sure
> > if it is worth it.
> 
> I would just move the unsafe_exit before the mdelay(). I think that is
> sufficient here.

Fair enough.

> > Otherwise, I do not see any real problems in the code.
> 
> Thanks Petr for taking a detailed look at this!
> 
> I think v11 is OK for mainline (Greg has it in tty-testing now.) If
> anything else comes up and I need to touch the code again, I will
> relocate the unsafe_exit to before the mdelay().

I agree that v11 looks good for the mainline.
We could always improve/clean up the code later.

Best Regards,
Petr
