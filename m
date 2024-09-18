Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C94C1BF304;
	Wed, 18 Sep 2024 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726670837; cv=none; b=oxwPv+4ejqOCXjXPZ0iwQnkoFQjmf0G3ciOYDM8FD2d9fJ2M5AdI7/1MT8T7b8Z93o8JwHn6feK0m2mZ5p2a7adJveV/6l/sBtwuUkck+SK7Ijxw4g1FTobEF7Oo++qZz39itjPVW5JNPkDVi+AT1B+hiGtVjf+4BI4GGaxI6NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726670837; c=relaxed/simple;
	bh=mrCSN/5slYGBSDKXEIP8r1qzpyFQ4Ye6LoTtQVredz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QYuYKKAdSgkr5tJxw5ElWgz/MBwBWXUHWZZ8PmkbQ2rXDtzNOUOWK1CnYvY1pP08MlaKhLkp23XAOpP702HbMixvvdpVEJSSIKduqv93rBjl7EUJmjHwq45Ng77ixEmAag3X7K1I7WWzvVcAb1uRXu75G1rPV8KV1Oy0M3WVbs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NiAzZ67Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ksUDclSH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NiAzZ67Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ksUDclSH"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726670833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mE03GBXmWAksElzFDVw/gDDmYxh5FSKWUbown+C5kDI=;
	b=NiAzZ67YWyq7cqRtj9DvH67c/czw30NM1m6J3w/d1xnZQt7j/MhL7sgeXxzBCi7KFamyoU
	ypgWianA4F0e3yS1CxYGW1WkOCQAHp62NdW1d6u0SgbfsDlBM2PA1Qp+9U+XGisK/PfXir
	PVwwvusSRfZtlMuiyjQAeUzGtV1lE+Xmqm9hSfRlZ90GpOjQZFz/wGBoD2Na6OU2MZbU1F
	iKKQxmqasi8YbKaaO2/P0uApiOnZAk6bA44arEDhuK8v4lunisyr6l1ltQF3usr8J+RABz
	I+rnsPEz88WmtlU9aUtFyscydaY341H2Rl5X26gEXiu7zKO/ak2/KPdpun2Qaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726670833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mE03GBXmWAksElzFDVw/gDDmYxh5FSKWUbown+C5kDI=;
	b=ksUDclSHn1+aq75DdoxvxInIOyYqX1c5KZdlvkkUMiDzSSuovHYOpJ9PXPqRqBMjQbm779
	3yNRvOKtWs0vhOCg==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Esben
 Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Tony Lindgren <tony@atomide.com>,
 Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Serge Semin
 <fancer.lancer@gmail.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Lino Sanfilippo
 <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH next v2 3/4] serial: 8250: Switch to nbcon console
In-Reply-To: <20240913140538.221708-4-john.ogness@linutronix.de>
References: <20240913140538.221708-1-john.ogness@linutronix.de>
 <20240913140538.221708-4-john.ogness@linutronix.de>
Date: Wed, 18 Sep 2024 16:53:12 +0206
Message-ID: <84o74lrpcf.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-09-13, John Ogness <john.ogness@linutronix.de> wrote:
> +/*
> + * irq_work handler to perform modem control. Only triggered via
> + * write_atomic() callback because it may be in a scheduler or NMI
> + * context, unable to wake tasks.
> + */
> +static void modem_status_handler(struct irq_work *iwp)
> +{
> +	struct uart_8250_port *up = container_of(iwp, struct uart_8250_port, modem_status_work);
> +	struct uart_port *port = &up->port;
> +
> +	uart_port_lock(port);
> +	serial8250_modem_status(up);
> +	uart_port_unlock(port);
> +}

As reported [0] by the kernel test robot, I need to move
modem_status_handler() down into the "#ifdef CONFIG_SERIAL_8250_CONSOLE"
block.

John Ogness

[0] https://lore.kernel.org/oe-kbuild-all/202409140437.EP0Ryw3u-lkp@intel.com
