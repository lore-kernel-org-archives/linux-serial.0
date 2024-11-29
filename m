Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1DF13D520;
	Fri, 29 Nov 2024 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732902313; cv=none; b=I62eULZ9X98cQJhRoKGus1zL9Ry1ywyEB/aLsj0P3KuZtPipoqNgmsHnlUArpflKw74rZl4biyzN6Qvnv5GOXHVZjXgwHvgiekeTCjJWgHHsTfBJzuNXPpRRs0SGEwHf72+EIwVbNo/u6vbEs0iKZqVqSJokhtOl8yraYqkmAi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732902313; c=relaxed/simple;
	bh=TnmoU5TP+FLl7Ofb9grKV8LgLXGcc1efbm5QIQsFSMo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=mz8OjA7s3LB1nTOw1ysO3fqf8wbHhwMDLJkAPefn9BEA9MS/rIfjhctathbwyDDFkTYX5oIsDsu5lqqqRHLv1wg11D6jjqI3YqoHT7rJDlmkJajayURl3ihDsWIbHwyj9KBMi2WORKe0KzrBHICGR6zZuRcBI+3dnRhWzAzPht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R6SXnReS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0MfM48tm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R6SXnReS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0MfM48tm"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732902309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=TnmoU5TP+FLl7Ofb9grKV8LgLXGcc1efbm5QIQsFSMo=;
	b=R6SXnReSrE00cNIZqinb9hlhkaFAFNBbAY6yh/dAegTFNVE0pL5eQbQ2B4o3fAgiQXwmLj
	zgiUawZ0+OZevVoDPmH8jHUjjdfnVZ+mJMlureG1pyDeEf690m8gh5YRDm7yeGBoZmJftS
	ealh//fmdxdo/ujPuSkdu2OmuLr2pyO7G+l+SSnBid3mNax/Ip35Rx0Rema56X9WT1owuP
	pmfcpCxHkGLIYH6LMJR06AkqXM7W39LG0LnKlSk3LIC1Z4U2LJuYoBQyvlnaUIo2DNtozq
	LXeiConGjuzppjpCKHkgvqAJobrvpM5TTbXy4hCRfH03zbLd7aIdNrbInIs+rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732902309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=TnmoU5TP+FLl7Ofb9grKV8LgLXGcc1efbm5QIQsFSMo=;
	b=0MfM48tmlBjwXmDOX2EM6p7s4VVa3Ae0g+yn+nDsey53GY5bLZUZM54/w3a3dah9dd0VYU
	jODWcyT3qTV2iiBA==
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner
 <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Stefan Wahren
 <wahrenst@gmx.net>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>, Ronald Wahl
 <ronald.wahl@raritan.com>, Udit Kumar <u-kumar1@ti.com>, Griffin
 Kroah-Hartman <griffin@kroah.com>, Rengarajan S
 <rengarajan.s@microchip.com>, Lino Sanfilippo <l.sanfilippo@kunbus.com>,
 Serge Semin <fancer.lancer@gmail.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH tty-next v3 4/6] serial: 8250: Specify console context
 for rs485_start/stop_tx
In-Reply-To: <ZyuOX4VVbfAFhMfV@pathway.suse.cz>
Date: Fri, 29 Nov 2024 18:51:08 +0106
Message-ID: <84ed2url23.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-11-06, Petr Mladek <pmladek@suse.com> wrote:
>> For RS485 mode, if SER_RS485_RX_DURING_TX is not available, the
>> console write callback needs to enable/disable TX. It does this
>> by calling the rs485_start/stop_tx() callbacks. However, these
>> callbacks will disable/enable interrupts, which is a problem
>> for console write, as it must be responsible for
>> disabling/enabling interrupts.
>
> It is not clear to me what exactly is the problem.

serial8250_em485_stop_tx() blindly sets the RX interrupt bits in IER,
because it assumes they were cleared in serial8250_stop_rx(). This is
fine for the driver in general, but it is wrong for the console
->write(), which restores those bits on its own later.

> Is the main problem calling pm_runtime*() API because it uses extra
> locks and can cause deadlocks? Or is it more complicated?

pm_runtime*() is a second issue. In the v1 feeback we talked about
it. tglx summarized it well here:

https://lore.kernel.org/lkml/8734mbdwrf.ffs@tglx/

as well as explaining the need to split off the console-write code from
the generic driver code.

> IMHO, it would deserve some explanation.

This commit message only talks about the first issue, which is enough to
justify the patch. I will add that the callbacks are also not
appropriate because they call into the PM code, which is not needed by
console ->write() and is even unsafe in some contexts.

> IMHO, one thing which makes things comlicated is that
> serial8250_em485_start_tx() and serial8250_em485_stop_tx()
> are not completely reversible operations. Especially,
> the change done by __serial8250_stop_rx_mask_dr() is
> not reverted in serial8250_em485_stop_tx(). It makes
> things look tricky. But I think that it is beyond the scope
> of this patchset to do anything about it.

I agree that it is strange that the driver does not unmask DR later. I
have now run tests and it seems the use of @read_status_mask is
partially broken. I did some historical digging on it...

For Linux 1.1.60 [0] the @read_status_mask usage was extended to support
"stop listening to incoming characters" (text from the changelog
[1]). Looking at that version, it is clear why and how it was used.

For Linux 2.1.8 [2], the async handling was reworked, basically
reverting the change from 1.1.60. However, that revert forgot the piece
that clears the UART_LSR_DR bit in serial8250_stop_rx() (back then
called rs_close()).

And indeed, if you track the @read_status_mask value today, that bit
remains cleared until serial8250_do_set_termios() happens to be
called. But it didn't matter that the bit was not set again because that
bit was not being evaluated at any call sites.

For 4.6, RS485 support was added, but with a bug about re-enabling
interrupts. When that bug was fixed [3], the fix did not set the
UART_LSR_DR bit in @read_status_mask. Still that was not a problem
because at that time, that bit still had no users.

For 5.7, support was added to avoid reading characters when
throttling. This re-introduced a user of the UART_LSR_DR bit in
@read_status_mask. And thus now there _is_ a bug that the bit is not set
when starting RX in __do_stop_tx_rs485(). Interestingly enough, the OMAP
variant of the 8250 _did_ implement setting the bit when unthrottling
[5] (also from the same series).

So in summary, I will add a patch to my series that fixes [3] (or is it
fixing [4]?) by setting the bit in __do_stop_tx_rs485() when re-enabling
the RX interrupts.

John

[0] https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/diff/drivers/char/serial.c?id=ba97e35a1a8b45ff87ed37a58fca3ecf39c1c893
[1] https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/diff/drivers/char/ChangeLog?id=ba97e35a1a8b45ff87ed37a58fca3ecf39c1c893
[2] https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/diff/drivers/char/serial.c?id=0f9cac5b27076f801b29a0867868e1bce7310e00
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=0c66940d584d1aac92f6a78460dc0ba2efd3b7ba
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=f19c3f6c8109b8bab000afd35580929958e087a9
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=f4b042a050062b2dec456adfced13d61341939e2
