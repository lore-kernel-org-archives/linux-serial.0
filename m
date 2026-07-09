Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D656237C93D;
	Thu,  9 Jul 2026 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783587753; cv=none; b=fFeJGgLfXbn6Eac7G+L8ITXrTMh0Trkf31W5uSJEB03YuybBDAZ9KAnOk3LWcH6q6TPwFPc0QMheREMz/JnPcfOzFD2cJxPBPIH2XijC5MwwwFVPBGsXbUTtriQVu9ig/RKvS10kXshU53iZytm24OAt94vHIoBRNwWdgYt20iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783587753; c=relaxed/simple;
	bh=sza15MUSuSXVu8kTcOWLvE/LJLLTF64g9tL/ubrh7a8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WhbEJPQJFRENVPfAdQvQ+eVn9lNSVHshhTNIjcv/a5VOlYNAX8d/+VK5xP/E2f6GbDYLlJUIoFiBan+xsrBsZ7BeJjT8wEkmph2lsspnESklwUUi60LwbyAIDR6CmS92CTl8I3kNktbYrxQT+WB9D1QIzp03bcHNT0Crr2C37AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vyrcTssg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7PeEjYvs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vyrcTssg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7PeEjYvs"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783587749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sFXYIbm/Hjr/hStCE1cyUKbLBfMtzQJll0dILXg2Qpg=;
	b=vyrcTssgl5LI37H4TnnJNqDzP6aXIjASuIuNsU1SCnHvCcsg+dGPy/Sp44nyNQVQZM2tl0
	Cy53BxDb9I2aIghEKUyk0EuvyubpjwkZCHXIFrb9yNGY2eX2MNutRRfRqK4tZo4l5dgPGN
	JjdM07BpRs7lP/rWWfbqkJb9nW0hh6x5O1DqwFLpLUFaGwa/LPjDu2SNVHFAVxzNOiqhHx
	Ne/cNvkJ4gSHbXYOup7IeXCcP/mpie75T1tbMNhuJsxfSNHIgEozTppUrT+qt0GHtQv5lF
	YAgzrZGfVyMPJa0ieqBDAHRw1+3zZz/aCZKPTTjiFGr0EvWkWGUSBBBW0w3UKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783587749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sFXYIbm/Hjr/hStCE1cyUKbLBfMtzQJll0dILXg2Qpg=;
	b=7PeEjYvsi6eUWPog7NnBd+b6sRbEQWY5BgmfEhlcLCG1IJfk4sDfonMV7qRWgndUa7HQBX
	Qg6GtER0qRhpucAw==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ilpo =?utf-8?Q?J?=
 =?utf-8?Q?=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Doug Anderson <dianders@chromium.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Marco Felsch
 <m.felsch@pengutronix.de>, Yunhui Cui <cuiyunhui@bytedance.com>
Subject: Re: [PATCH tty] serial: 8250: Ignore flow control on suspend/resume
 with no_console_suspend
In-Reply-To: <20260707141032.5074-1-john.ogness@linutronix.de>
References: <20260707141032.5074-1-john.ogness@linutronix.de>
Date: Thu, 09 Jul 2026 11:08:29 +0206
Message-ID: <87a4s0lemy.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-07-07, sashiko.dev wrote:
>> -	/* Wait up to 1s for flow control if necessary */
>> -	if (uart_console_hwflow_active(&up->port)) {
>> +	/*
>> +	 * Wait up to 1s for flow control if necessary.
>> +	 * When 'no_console_suspend' is active (in the window between
>> +	 * suspend() and resume()), flow control is temporarily ignored
>> +	 * because the canary workaround is not reliable in all situations,
>> +	 * leading to flow control timeouts for every character.
>> +	 */
>> +	if (uart_console_hwflow_active(&up->port) && !up->canary) {
>
> This isn't a bug introduced by this patch, but does this incomplete
> fix still allow flow control timeouts if the UART loses power during
> suspend?

Yes, and this is fine. More below...

> Looking at serial8250_console_write(), if power is lost, the canary is
> successfully matched, the UART is restored, and the canary is cleared
> to 0:
>
> serial8250_console_write() {
>     ...
>     if (up->canary && (up->canary != serial_port_in(port, UART_SCR))) {
>         serial8250_console_restore(up);
>         up->canary = 0;
>     }
>     ...
> }
>
> Since this happens before the actual characters are printed, won't
> subsequent calls to wait_for_xmitr() see !up->canary as true and
> re-enable the flow control wait loop for each character?

Yes, and that is correct behavior. When serial8250_console_restore() is
called (right before clearing @canary), hardware flow control is
correctly re-configured, thus hardware flow control will work correctly
and it is fine for wait_for_xmitr() to poll.

John
