Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF717322A;
	Fri,  6 Sep 2024 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640725; cv=none; b=kCoP8bTPOfsVOUAe+1mSVdjiV9bNTDd++r4zu9CmAtQl6H1hpPQ78TXRFBYQjxhHvasacVYmqdKgdAHJrOMCrEjv//uzpnnknx5f3HHb7lTF1lCk5oxCg8oYdYPDrfLmmk8qK9SAfTy9gzC7NOoa1HlhtvE0klIHRVUS9ozWMEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640725; c=relaxed/simple;
	bh=EVXGKS/uxt51tIPPDnBiy6DdU2jtxhk4BVroQW+5DYg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ejA3uQQBhwXZeWYzCifOoRFOJotOruqQQ4TeX8ba6W3OBnF223GYf31Ob2lzCepg/DrvMUroRsqFNLB1kEdGLgACSVUCECLKXtrGgqOHrhTcPuu1djVrCQnxLc0fieRd6rn+ut19k71TDqVO2L5glNxlTou/7exAmWCBcIvmEsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=igYUXDYw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WLS4Dywb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="igYUXDYw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WLS4Dywb"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725640721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGiT4D1DjJgDJ5qLla1WpeUu1+Lo0Y6C/CY5nSBo2fU=;
	b=igYUXDYw3SubawcwO3B/0i+ObngZKPllAsHDzG5hzd44EKAZF4PPr9QbbCgKo61MEFZHVo
	MjJnRkUimLXi1u7+utA6uS+snndQhro/Gt0dID/nO00k+HB4ckFrmAULNDUuRbBI1wANAl
	0gte0UJ14sCet7dy+5mvfaLgXx/C+eaneJ87VWuOXR+NDzwCrZ8J272Lb6xkbPHOc9hrb5
	mh7QOmK5aco6n9ejYkRW6d9QCPRsxREP920LmRCSzlyyhYr6QWy3iijhVQI844XbfG2/Ft
	C2+wnCyyM+zE/43+Tf9ISQ22V/hBTKOE2VtFmqQaZF880tw4yGfsuUYbot/pYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725640721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGiT4D1DjJgDJ5qLla1WpeUu1+Lo0Y6C/CY5nSBo2fU=;
	b=WLS4DywbGrmj+3BtmzxTp9eqLlv60IlDdIsZo0uBjVTj0ZVB5NrBi/1JH0McT28I12/KhM
	0g6BxowRDisnJaDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner
 <tglx@linutronix.de>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Tony Lindgren <tony@atomide.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Serge Semin <fancer.lancer@gmail.com>,
 Rengarajan S <rengarajan.s@microchip.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH next v1 1/2] serial: 8250: Switch to nbcon console
In-Reply-To: <87mskkdhwd.fsf@jogness.linutronix.de>
References: <20240905134719.142554-1-john.ogness@linutronix.de>
 <20240905134719.142554-2-john.ogness@linutronix.de>
 <Ztr3f8M2FaT2Rz1c@pathway.suse.cz> <87mskkdhwd.fsf@jogness.linutronix.de>
Date: Fri, 06 Sep 2024 18:44:41 +0206
Message-ID: <87jzfod9f2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-09-06, John Ogness <john.ogness@linutronix.de> wrote:
>> Wait! This makes the rs485 consoles much less usable for debugging.
>> They might have troubles to see the emergency and panic messages.
>>
>> Is this acceptable? Why?
>
> It is not acceptable. I am looking into making the atomic part work for
> RS485 as well.

So there are 2 things _not_ supported by the write_atomic() callback:

1. RS485 mode. This is due to the need to start up TX for the
write, which can lead to:

up->rs485_start_tx()
  serial8250_em485_start_tx()
    serial8250_stop_rx()
      serial8250_rpm_get()
        pm_runtime_get_sync()
          __pm_runtime_resume()
            spin_lock_irqsave()

Taking a spin lock is not safe from NMI and thus disqualifies this call
chain for write_atomic().

If UART_CAP_RPM is not set, the pm_runtime_get_sync() is avoided. So I
could only disable atomic RS485 if UART_CAP_RPM is set. But the OMAP
variant of the 8250 does set this capability.

2. Modem control. This is due to waiting for inputs, which can lead to:

serial8250_modem_status()
  wake_up_interruptible()

Performing wakes is not safe from scheduler or NMI and thus disqualifies
this call chain for write_atomic().

It would probably be acceptable to move serial8250_modem_status() into
an irq_work.

I would be grateful for any insights on how best to handle these 2
issues if we want full write_atomic() support for all 8250 variants.

John
