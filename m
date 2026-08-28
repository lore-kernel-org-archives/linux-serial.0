Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECDA373BE7;
	Fri, 28 Aug 2026 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787935291; cv=none; b=C2UA1R+YEp5p1LFaCxlLFrf5016uCpXGVfISk0mZirTlh++L4IkQ/rJt9LI84IMytHq+arMsTH1FP/+BuUF8lu/QhTRs64mAVrYphGd2JfNnSKOrI1wkb6lRC4ktj6H/irdZJ2tzuuq48hgZtYiaQdGlthkvoEFPnJQrRY62PO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787935291; c=relaxed/simple;
	bh=gWKGi/ksL7f+lF3W/0vP5VhdGa7zQtCz+nDzrSBNoCU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gbnMp3e0R6d/FGmw2G4KeSk9RiJlaMuIQaEmnzFS0BanQpmRCxTrYDjSCrbho8AfRbImoEZ4FR1lVGRgp8W+pFiFI+Qd6kQ7TvSu05FcSI89bJrBMtbL27V6yK0ZPuvLbfr32oZ4hD70P8qCtqf8QJJDWoYNCz3sDucxXJkWijs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NkCaA14f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T/8mEenm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NkCaA14f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T/8mEenm"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787935288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gWKGi/ksL7f+lF3W/0vP5VhdGa7zQtCz+nDzrSBNoCU=;
	b=NkCaA14fYboXfr1kc6lHQzoJwbjkNkO/o8lFyoov6KVcKROfG1uAW1MhG/yXAow8h/1sIK
	7w1jyiX0LU6GOtg+impGPczAfBmwTmizDkU3ehsbnQ7Y4BCrwBAcMirm+y2UNuWWyRNWXw
	dDQ9UNFnC0uUm5O29B6WcMZxXMFXItqp77Vjk93JAS2LqWno3NhWtbZhd5U2w3qL7VBLEs
	2uPPxzVyYgG8UhnVToKqK5PGTGx++E9d2kpGjPJToRq9OaeLFh7v3w5yC9Ho+aocD7tqKp
	N8gwYABYgNKWA2GxDoxSgAa6/l9kVV4OKnHJ2/tkUdkdRvnrfaICRbu2JqqbPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787935288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gWKGi/ksL7f+lF3W/0vP5VhdGa7zQtCz+nDzrSBNoCU=;
	b=T/8mEenm+hbkgI7TE/d0nysMtekLKzAzcAD4pPjZn4XXUXtilAQAX1+UzCpRNMnxCimwTW
	auia8e3Fds3WZkDA==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Petr
 Mladek <pmladek@suse.com>, Jon Hunter <jonathanh@nvidia.com>, Thierry
 Reding <thierry.reding@kernel.org>, linux-kernel@vger.kernel.org, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Crescent Hsieh
 <crescentcy.hsieh@moxa.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH tty 1/1] serial: 8250: Change console_msr_work to
 IRQ_WORK_LAZY
In-Reply-To: <20260828160652.TQBsi8oO@linutronix.de>
References: <20260828155811.270462-1-john.ogness@linutronix.de>
 <20260828155811.270462-2-john.ogness@linutronix.de>
 <20260828160652.TQBsi8oO@linutronix.de>
Date: Fri, 28 Aug 2026 18:47:27 +0206
Message-ID: <87ik4uxknc.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-08-28, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> On 2026-08-28 18:04:08 [+0206], John Ogness wrote:
>> For some platforms it is a problem to queue irq_work when entering
>> cpuidle states. Since irq_work is used for deferred MSR handling,
>> any atomic console printing when entering cpuidle states can lead
>> to the affected hardware hanging. Tegra20 and Tegra30 are examples
>> of such platforms. Avoiding raising the irq_work IRQ has shown to
>> circumvent the problem.
>
> I would argue that this is done for the benefit of less interrupts since
> there no need to handle console_msr_work immediately.

Indeed that is a better argument, but strictly speaking, it isn't the
motivation. I think it is important to clarify that _currently_ there is
a problem that the explicit lazy is working around.

I expect most irq_work users could be changed to lazy with the argument
of reducing interrupts.

> side-note: Wasn't there another tegra workaround in v5/take1?

Yes, related to suspend/resume, implemented at the printk level [0]. Now
that we better understand the problem, that could be reverted. However,
it also provided a side-effect benefit: switching to atomic mode on
suspend when no_console_suspend is specified. I suppose at some point
(once the nbcon churn settles down) we will clean those changes so that
the naming and semantics really focus on "switching to atomic" rather
than "block irqwork".

John

[0] https://lore.kernel.org/lkml/20251113160351.113031-3-john.ogness@linutronix.de
