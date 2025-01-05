Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87424647;
	Sun,  5 Jan 2025 00:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736036771; cv=none; b=rozhTPsJKMYy+zSFZuMRCbOhXFMkgbWEqeGeLDK4qQh+Wqohe814D4FV+pjU6woLq0paYphIrx6ceDSDgsugkHNpzRdR1TIGU62m/umXU95bO2+bxecRHrt8IFvmnlaUAve4LOkjjon7x84/YLGlaNLCq978Q9X547TdruJI0YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736036771; c=relaxed/simple;
	bh=2+Y1rCVs4eO4ZyFtQWPQFkqL5hGE0PG7Yt+dpeENG2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h+Bn51/FR/m/gJEsYZ7UWdIhBdkRKDLV2124R2vfYskGJdAL7TU+M8USKCNGUMNzF9A090NxkEuQ7cAdxew1TuNK5/uOJsbVzN3ddvL9gRmFtjOAHb1tka68NJImwsMKB6dgR0+FxBAClTCXojNPGQwUS25JuEj7bBrYF80gk/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wQgBhZnq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M1cv+Y0F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wQgBhZnq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M1cv+Y0F"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736036761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2+Y1rCVs4eO4ZyFtQWPQFkqL5hGE0PG7Yt+dpeENG2M=;
	b=wQgBhZnqs+K+fV/HH3wGASh8EvPvFpRWkwkx7vKlvA1SZ1pr30rkvm2pLchxzOCe7PsBBR
	G4SHcFPW2XMtLd/4retDIu79i5xQfRBn6VNoJlTlF22521OBWQY3HIykPSQH+L0wcINurE
	VWDtyiiAeh29qpVksLZ4k8yjkkNkKYmdVmTDichrG7LMsWf6nd2F5tc7FS/rTyaWcbVMfW
	Z8aSx6BLFWagdk9rg1SZmfrMJZHFfQ/fiVWQ4wzt7qw0tkDn4NYLUbFKnNg4HzFIz3aTsN
	YziQb5HZZLkA6KWtFKI6UbnugQawdqWPk1b+gpQbYnS9Q2TJwL+CJ+KRs26Azw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736036761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2+Y1rCVs4eO4ZyFtQWPQFkqL5hGE0PG7Yt+dpeENG2M=;
	b=M1cv+Y0F11QMDB9kPRcs0+LRZSWSDFjf/e6s5ZSRUALOmkjk+/NQGh3kuHD78SbuO+IhDe
	RvATdDj64tfFDYDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner
 <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Florian
 Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Sunil
 V L <sunilvl@ventanamicro.com>, Matt Turner <mattst88@gmail.com>, Stefan
 Wahren <wahrenst@gmx.net>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>, Udit Kumar
 <u-kumar1@ti.com>, Griffin Kroah-Hartman <griffin@kroah.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH tty-next v4 4/6] serial: 8250: Provide flag for IER
 toggling for RS485
In-Reply-To: <Z3gCeP_P7VPpcOLA@pathway.suse.cz>
References: <20241227224523.28131-1-john.ogness@linutronix.de>
 <20241227224523.28131-5-john.ogness@linutronix.de>
 <Z3gCeP_P7VPpcOLA@pathway.suse.cz>
Date: Sun, 05 Jan 2025 01:32:00 +0106
Message-ID: <84jzbaxg13.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-01-03, Petr Mladek <pmladek@suse.com> wrote:
> My understanding is that the nested IER manipulation does not
> harm.

This statement implies that it is OK for UART_IER_RLSI|UART_IER_RDI bits
to be set in UART_IER even though the console will write to UART_TX,
because the _nesting_ contexts would set those bits rather than
restoring the original value of 0x0.

I ran some tests and leaving these bits set during Tx does not appear to
cause an issue, but it is difficult to say because the context
interrupted by a nesting context will only print at most 1
character. Also, it is writing under spin_lock_irqsave() so that might
be masking any effects. Perhaps UART_IER is temporarly cleared because
of other bits that would cause problems during Tx?

I would need to create a specific test to investigate this
further. Regardless, it still is a cosmetic ugliness that bits are not
being properly restored, even if it turns out these particular bits are
not problematic during Tx.

As was with your LSR_DR comment, you are good at triggering fundamental
investigations into the history of the 8250 driver. ;-)

> All in all, the patch looks good to me.
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks for the review. I interpret it to mean that I do not need to make
any changes to this patch for v5.

John
