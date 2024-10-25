Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC8B38F97;
	Fri, 25 Oct 2024 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866310; cv=none; b=ofCAPqm47hnu6XoouKVPHkDGbo90N1BEI10adewiDDN2V4C/pHrvJj3KsvMVi/e7d6wQhFNY2M7SF5ELMp4qx8HCTI1NZ2JJTpHcKHGXNWKGm7ddWqb5qzXEr9fForYm+GNf6kRA39t7UObeDqOPUvM0UzfabAa97XZ8MvvoB40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866310; c=relaxed/simple;
	bh=itdUdyilJOpXHuFtqnevEly013GrPHaehmC4+D0Il8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GKgKLTIQD0Qroz5S/JGHtbQVc1tF99frOWVScEFHbrkzMrvvCQvzEq+tyeRvtDPGeZRhrZqOBN+QrQcBGsuGmtN14ecXJwP3qMtuuu+FQs/VyDQ6qQ81ao3/Nm41SbTZEnQDyBgmQvIcsTwXcP3yiVBWzoPKkXdLb2XKCaXZRCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qzz+CQfK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6Ztb4PK+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qzz+CQfK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6Ztb4PK+"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729866306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=itdUdyilJOpXHuFtqnevEly013GrPHaehmC4+D0Il8Y=;
	b=qzz+CQfKtotbVau0Y6+NhdZ4HmIqfEaYFXsRFsANieSq5A38Su3Cm8Ubh+rVbLujDPJqQd
	e1n8qT13oxrEXf/EPUvnU3LS0/RH8C/L3PGNFrgDjlugYl6moOLlCthh6WwxN+Kt0NBtGp
	Q7ShTaUSdSDEGDQBxkWsxgfp3CtEHjuar6LKajK8sjK79cTElZEwBE/KWTywTYXa6qCjBS
	92R/i3vb4DcB6ZOWFC28aONYkhqHA7JctnvWGvkgbpZDmvU8Bhp7Iintt62Uq1GnBWS0mJ
	cH2I0Svhn99JoLJy2UekKxlmfCjWXRf6s06gciEpBrGdFVnl7KHWahgv2hEd/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729866306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=itdUdyilJOpXHuFtqnevEly013GrPHaehmC4+D0Il8Y=;
	b=6Ztb4PK+2rZAZQ8Ud576zxXjCPq6h5nE37Q1xOVKczBp4u6HGX49CaKypX8Q8DVJCfq0Z+
	+jrRMGRjDn78/HCw==
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Stefan Wahren
 <wahrenst@gmx.net>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Kevin
 Hilman <khilman@baylibre.com>, Markus Schneider-Pargmann
 <msp@baylibre.com>, Ronald Wahl <ronald.wahl@raritan.com>, Udit Kumar
 <u-kumar1@ti.com>, Griffin Kroah-Hartman <griffin@kroah.com>, Rengarajan S
 <rengarajan.s@microchip.com>, Lino Sanfilippo <l.sanfilippo@kunbus.com>,
 Serge Semin <fancer.lancer@gmail.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH tty-next v3 4/6] serial: 8250: Specify console context
 for rs485_start/stop_tx
In-Reply-To: <ZxulYcgH1kTyx9Kr@smile.fi.intel.com>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-5-john.ogness@linutronix.de>
 <ZxulYcgH1kTyx9Kr@smile.fi.intel.com>
Date: Fri, 25 Oct 2024 16:31:05 +0206
Message-ID: <84v7xg2rb2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-10-25, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> Add an argument @in_con to the rs485_start/stop_tx() callbacks
>> to specify if they are being called from console write. If so,
>> the callbacks will not handle interrupt disabling/enabling.
>
> toggling ?
>
>> For all call sites other than console write, there is no
>> functional change.
>
> So, why not call the parameter better to emphasize that it's about IRQ
> toggling? bool toggle_irq ?

Currently there are only 2 users:

serial8250_em485_stop_tx()
bcm2835aux_rs485_stop_tx()

The first one toggles the IER bits, the second one does not. I figured
it would make more sense to specify the context rather than what needs
to be done and let the 8250-variant decide what it should do.

But I have no problems renaming it to toggle_irq. It is an 8250-specific
callback with few users. And really the IER bits is the only reason that
the argument even needs to exist.

John
