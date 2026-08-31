Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26CC3F54C6;
	Mon, 31 Aug 2026 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164433; cv=none; b=Eo58MoJoe+l+BEW5SSjAENJp0OZd5/E9975ofTnUxAFf6I8rdOLXb4VXMpGEUZlShhoI9TdCJHpgxn7klwUWXX92BS/tjEt08o5WHGYc+pbq4YtU8rOu8Cq9aS138DMnISBPgmGqDq3SqPM2utSfws2rvNWGpo/fPp9+sLSN+j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164433; c=relaxed/simple;
	bh=n5sSbVyGPMSD1h7wogTr4Jyv9m4lEOvM7bS8Os8AYpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4PPK1kTWODNcp2X7BVK15rvwO0I3+jjCpw+dDn4ocLfKuf464xm8OeZWJAEFdqNVx0H/AZfEeeIThgmFH0V5E3bb+1Ff1zv8P0O+KsvKNV9QS+WwsE+mdsD5aM28//LnUSSrO9o/cOEcNa86XB7ORDzeJ1gvOBVhcKLGxEs7pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YAUb57j/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uXgyf/Pk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YAUb57j/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uXgyf/Pk"
Date: Mon, 31 Aug 2026 10:20:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788164430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z8o4tLVzYA+qm3P6fK2UH+lUuHPW5Lc+HUZbnkk1Do4=;
	b=YAUb57j/HuQGn82FLCFlNnIYjxLUFfWNW/o+8OXsRHGZXHdAgskxL6lB8IhIQZvazEhaga
	BZpHEVRG9N4CrXzon301BntzT0qQcgMpIwhk9i80IqdiXDJ0fxO7i0uKQAcP1Jfs6i2bFI
	Lb7EpIfHl5XTh24o6rLjdwuRydVk41HfAj/VOyCbzEsY9sTABABWhnN70aS4SiU5OM3pbl
	oQhj1C6B8LBzTpkJygwAyZ3th0ye82j4hsEYcnoDYDf72LQk1CyYeeJW3g3BTQr88AvN+j
	K27yz1ZOobEidNNpvAqbgR/Upciwkjy2mff1nq7PNYwl7aZJuAf5g0lT/79XXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788164430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z8o4tLVzYA+qm3P6fK2UH+lUuHPW5Lc+HUZbnkk1Do4=;
	b=uXgyf/Pk7q7uA9UQASMLi6Q7jiQX3BrPFxD50anJKf8WSNm5cdZQ3HprxYFDqPpa1JSCt6
	5ESkjE+wBGHDJbCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH tty 1/1] serial: 8250: Change console_msr_work to
 IRQ_WORK_LAZY
Message-ID: <20260831082028.cCEc7BXU@linutronix.de>
References: <20260828155811.270462-1-john.ogness@linutronix.de>
 <20260828155811.270462-2-john.ogness@linutronix.de>
 <20260828160652.TQBsi8oO@linutronix.de>
 <0c2c424f-0372-4626-b14e-7697d98e6b20@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0c2c424f-0372-4626-b14e-7697d98e6b20@nvidia.com>

On 2026-08-28 18:06:50 [+0100], Jon Hunter wrote:
> 
> On 28/08/2026 17:06, Sebastian Andrzej Siewior wrote:
> > On 2026-08-28 18:04:08 [+0206], John Ogness wrote:
> > > For some platforms it is a problem to queue irq_work when entering
> > > cpuidle states. Since irq_work is used for deferred MSR handling,
> > > any atomic console printing when entering cpuidle states can lead
> > > to the affected hardware hanging. Tegra20 and Tegra30 are examples
> > > of such platforms. Avoiding raising the irq_work IRQ has shown to
> > > circumvent the problem.
> > 
> > I would argue that this is done for the benefit of less interrupts since
> > there no need to handle console_msr_work immediately. With the side
> > effect that it might fix a bug that was not yet reported on Tegra[23]0.
> > 
> > Ideally the Tegra folks should figure out what exactly is broken instead
> > of adding duct tape everywhere else.
> 
> Yes that would be ideal. Unfortunately these are old devices now and very
> much in maintenance mode so getting to the bottom of this now is unlikely.

So this is maintenance mode.

> You may say then why don't we completely deprecate these, but then you
> could argue the other way and say they have been working fine up until
> now.

So a couple of years ago this platform stalled printk development due
its irq_work usage. Now again. Imagine we would have a ext4 feature
which freezes just this platform on boot. What would happen here?

The current workaround is to use LAZY which in general defers the IRQ
work to the next tick and it works for you. If you enable NOHZ and the
CPU goes tickless even a scheduled LAZY irq-work will raise the irq-work
interrupt to ensure the CPU does not go idle and we do have a wake up.

This might bring the problem back at some point.

> Jon

Sebastian
