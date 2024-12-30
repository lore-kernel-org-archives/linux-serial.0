Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB01195;
	Mon, 30 Dec 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735572600; cv=none; b=k6h0mK1AOtG1EV8vqxRQigbCmIP86Bm9anrVsYhm+YPUsDXTVlOKg4Iw68nJ46mCsiflCSMRBqZgzzVop1YOxGmdv2nUAPTAsPmC/j9iHIUNX4xUVk6iTQbxMwp5oWbwyhql9k3o8aM01YSKBfgNMOihKcPikpL0OMpIBG73oFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735572600; c=relaxed/simple;
	bh=qBfK8zirRpmxO2hcBEGwyKcO9OUtgdt7JXEDD9A/ASU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EfrDBSpU4OGj9wZt68Yfw2n32fYoQfzDLEAfZizwknrtYYHX0eHCNSLwJNxBhi1wJVCSnxpz2/o4H99IRWMzJkUuOQi2RVXCzZg3oPePwAgQhKwENgl21BMgRvTCf7TtkxcqaQZtOdVsKozq7WoCFbYskX50qfIqNdWj/HqR8PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zV3N9C2w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rZH7+Zd0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zV3N9C2w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rZH7+Zd0"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735572596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H0Ta0DJsbzn2ZLhVqlv8dv42niwU17XW21qLA074XCI=;
	b=zV3N9C2wqQ1woRKwb0m1EnKxApoAQkr4JyzEwDQ/wJngmn5IVx5IDLb5pswfRUflrz8Ld1
	Yrm82tMfbsi/Pez1o32LrPTaVjnS51mLcifOLysFYPU/x+xBq/fdWJPbnuaDtnBKgMdEGT
	L7AC0ANI7LTpNtZkO1q+dYjMHnwhPTEgP108wrQWxjAA3JvC3vZoeirwkPtoBOufAfbiOr
	5AjD6YxA+SfAIqN1bGFSlucpYZc6SQ8U46TJIEurxHa83xuPW1Of/WvamlcbSt1UhOztw0
	pCv3aeJhod6tz0/mPqwAtqAHEAzChVY0AeTeumrNZk4nXzeZIdsmEHuELMSA0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735572596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H0Ta0DJsbzn2ZLhVqlv8dv42niwU17XW21qLA074XCI=;
	b=rZH7+Zd0GKA7jczUq6tkXw5b34YBrxr3lAIPf9uYRC6eZ5S91ZjzC3JRJ+bIZGxr8nswI0
	0W/EQcccnUbL+SAQ==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Esben
 Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Rengarajan S <rengarajan.s@microchip.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Serge Semin <fancer.lancer@gmail.com>, Wander
 Lairson Costa <wander@redhat.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott
 Branden <sbranden@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Sunil V L
 <sunilvl@ventanamicro.com>, Matt Turner <mattst88@gmail.com>, Stefan
 Wahren <wahrenst@gmx.net>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>, Udit Kumar
 <u-kumar1@ti.com>, Griffin Kroah-Hartman <griffin@kroah.com>,
 linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH tty-next v4 0/6] convert 8250 to nbcon
In-Reply-To: <20241227224523.28131-1-john.ogness@linutronix.de>
References: <20241227224523.28131-1-john.ogness@linutronix.de>
Date: Mon, 30 Dec 2024 16:35:55 +0106
Message-ID: <84y0zxp4ss.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-12-27, John Ogness <john.ogness@linutronix.de> wrote:
> The changes since v3:
>
> - For serial8250_console_fifo_write() and
>   serial8250_console_byte_write(), use nbcon_can_proceed()
>   rather than repeatedly enter/exit unsafe regions.

I will revert this particular change for v5. It is necessary to
exit/enter unsafe regions per character so that handovers can occur
mid-line. Using nbcon_can_proceed() only allows the hostile takeover
case to perform mid-line interruptions.

John
