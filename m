Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB544166F1B;
	Sat,  7 Sep 2024 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725741550; cv=none; b=OgVFz7VK7IUj5e42dYd6tUqq0u5dzN1s6VsfSwTKT8oc2bQL0pYffeGNY6w8imhsbDhQKBSr90e7oPhCm9vEyvd0VLF7YXiebh+jDm9lTBV8e27TKS24RJjCzq6vL0L1ksBqQ/lx9rSb/qviIIoFK6VkQiFUI0qrVeipxUpmgs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725741550; c=relaxed/simple;
	bh=+N1+FUrRZa71sZafK5gbpc6Aa+Nz4p1MbssVaSaRgRY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=cHKKwgT4pu/g1X15onuQ1IGlrgy1X/2TtCuH0ckZFrWbcFvSpMI+E5Gi0zCfJ3K60bCsDEqBUatKTQmp0XW9+c5swh0jVLzuU8umTOYAe3TKCbJlTno+S3eSkjLKurd8WoOcg3e7Efon25teQa2+Q7jkTkSQD2SWxySAb/tYj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DM7r0k9x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EREHzoYV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DM7r0k9x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EREHzoYV"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725741540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Jxh1drwwzS4C1cbz9nF6aHf3luVAOBDNpQwoAG7I7c4=;
	b=DM7r0k9x3tf8lSySlNhpsR7Z20SstxJQvsA1I8ztyyCtayKhwMpMVle3mfpx34vbk6l3I4
	/pWMQq4EmfvZKkhePbDgxX//71JqjkelFgWX7SwUTqn0yCGm+h4Azj691o3VXgNYYq5Ftg
	d8Nv3lU02j5B+tqvqbMABPIXT/ycgxdpZrPytglXSPgSa6R5TRbRYJFwDhf+n+T6GAT3ZO
	T3hyQ7H4WQxPVv3mpBeSVgOajr0eCOrFfvFmMTyunOXFU4wVh4e4lIWjTWKtnBuHkYD28A
	Axz2+9jdtwsmqmDf+qBlXts0m5NsnicmuiK/lj5jBi5bItw2a4EtZ5Kayk7/8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725741540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Jxh1drwwzS4C1cbz9nF6aHf3luVAOBDNpQwoAG7I7c4=;
	b=EREHzoYVqrp07ut5+fQlDAXm2PTjZqXGWlzV0fWSP9LrtqJDuJ23b3xeYt6XrT587jPMgM
	r400dpNZj9YIHzAg==
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Tony Lindgren <tony@atomide.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Serge Semin <fancer.lancer@gmail.com>,
 Rengarajan S <rengarajan.s@microchip.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH next v1 1/2] serial: 8250: Switch to nbcon console
In-Reply-To: <87jzfod9f2.fsf@jogness.linutronix.de>
Date: Sat, 07 Sep 2024 22:39:00 +0200
Message-ID: <8734mbdwrf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 06 2024 at 18:44, John Ogness wrote:
> So there are 2 things _not_ supported by the write_atomic() callback:
>
> 1. RS485 mode. This is due to the need to start up TX for the
> write, which can lead to:
>
> up->rs485_start_tx()
>   serial8250_em485_start_tx()
>     serial8250_stop_rx()
>       serial8250_rpm_get()
>         pm_runtime_get_sync()
>           __pm_runtime_resume()
>             spin_lock_irqsave()
>
> Taking a spin lock is not safe from NMI and thus disqualifies this call
> chain for write_atomic().

Correct. __pm_runtime_resume() can sleep as well :)

> If UART_CAP_RPM is not set, the pm_runtime_get_sync() is avoided. So I
> could only disable atomic RS485 if UART_CAP_RPM is set. But the OMAP
> variant of the 8250 does set this capability.

Sure, but none of this makes sense. What's so special about that em485
muck that serial8250_stop_rx() needs to do that PM dance?

It writes the IER register, which serial8250_console_write() just wrote
to in serial8250_clear_IER() without doing this PM dance. So for the
console write path this stop part is not required at all.  That said,
serial8250_em485_stop_tx() doesn't have this PM dance either.

I'm 100% that this is just a problem of blindly sharing this with the
regular uart code and not because there is a requirement. See what
serial8250_console_setup() does at the end:

        if (port->dev)
                pm_runtime_get_sync(port->dev);

The corresponding put() is in serial8250_console_exit(). So there is
absolutely zero reason for power management in the console write
functions. It's the usual voodoo programming which nobody noticed
because it did not immediately blow up in their face.

There is another minor issue in that em485 muck. One code path arms a
hrtimer, which does not work from NMI like contexts, but that is only
taken when the transmitter is not empty, so probably a non-issue
because the console write code waits for it to be drained.

There are also a few lockdep_assert_held_once(port->lock) in that code
which will trigger when called from the nbcon write functions. They are
already broken today when oops_in_progress is set and the trylock of
port::lock fails...

So splitting this up into a clean and lean set for the console write
functions will make all these horrors just go away. The current sharing
is just fragile as hell and makes no sense at all.

> 2. Modem control. This is due to waiting for inputs, which can lead to:
>
> serial8250_modem_status()
>   wake_up_interruptible()
>
> Performing wakes is not safe from scheduler or NMI and thus disqualifies
> this call chain for write_atomic().
>
> It would probably be acceptable to move serial8250_modem_status() into
> an irq_work.

Yes, but serial8250_modem_status() has more problems than that:

See uart_handle_dcd_change() and uart_handle_cts_change(). They call
into the tty layer and do their own wakeups.

So no, serial8250_modem_status() cannot be invoked there at all.

You have to defer this whole status dance to irq work and this really
needs to be done inside the write_atomic() callback. Otherwise a status
change could get lost, which is bad in non-panic situations.

That needs a bit of thought vs. port->msr_saved_flags, because in a
hostile takeover situation that needs to take into account that the
interrupted context might be fiddling with msr_saved_flags too, which
might on resume overwrite the write_atomic() modifications due to RMW.
Shouldn't be hard.

That brings me to that USE_SERIAL_8250_LEGACY_CONSOLE #ifdeffery, which
started this conversation.

The nbcon conversion does not make things worse than they are today. Any
problem which happens in the atomic_write() callback has existed before
already. So just get rid of the legacy code and be done with it.

At some point you have to bite the bullet and deal with the fallout when
it's reported. Remember, perfect is the enemy of good and you will never
reach perfect.

Thanks,

        tglx
