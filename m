Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC93471410;
	Tue,  1 Sep 2026 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249020; cv=none; b=QU7ZnW/wO08PDpxbzuu7n5dw30e0oto1MLjHNc56fUadrLVy2mMlaz08LXmipmmRxiq2HMQYkSXh7FhvdOKuMF7rA7e+aMalDZ5s9m6E0VNSWR5JMiqG47/jZoX+nP+/hkcBSgr5WwgNrpTEsK6F6hbdTaNhAbv69yxQ6jkw8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249020; c=relaxed/simple;
	bh=JjFpQL6i7zqo6rZPziQwY0L3iKdrklhUD4YeCOg6ZVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIVp0C8s3dVaX7b5FDB714o5jZsap9LLfrZozP6qxmp6l/52u2GWWTN2l7qGp3fW6ZYWtXNsBUqplD27GSWTCpq7F3kZiO1eiIGDFtd53uwO6UQ68b1qg+rF8WywGi0kOFSnulhGquzbju2dc3uSjW7nMNeloO5sm/zbhfgedto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YD9YQ1KL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JmZmx3l8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YD9YQ1KL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JmZmx3l8"
Date: Tue, 1 Sep 2026 09:50:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788249016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iUBH692Z36aZg03LvKjB9jPXVfhm0cBeh/zOB1KfNos=;
	b=YD9YQ1KL0WOd8TMtZexCsr2KJHmzfhslZ6YoFjT6aZ00SWEQokufCJgr6rIgxq66g8FxyW
	oA56rBXLdJL+SPtm6W1OIxF8wJHgqPX81ZwAKc9KOgGT5KGqT/y95sjNKRw7jufKDP1JTD
	aeTNtH9cOI21YNCbqOHDCbt0H1q3IwNFQhseu+MuiuRCe8SbKYmSxEVdHDlqig7rCdHvey
	Q8IhxgKrPi3wKbKpizAj3ZMJRLAMCHcQTYSjrGPkOsV9aBaNM2OQWnFm4HB1N+qqjNhwjG
	qk8Fom8a+Ynea+VouNRZz4Mup8Mk9P8Kdw9+pIwebEOtzt8fPGmdQm8cugiP8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788249016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iUBH692Z36aZg03LvKjB9jPXVfhm0cBeh/zOB1KfNos=;
	b=JmZmx3l8bhg77IcWwiZ0FVpqnovlzDqLRoN1oXDjaWZ7VgUIkAapUF9T5aZ01x2ECp+FoW
	WnoGUdgenXgnc7DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH tty 1/1] serial: 8250: Change console_msr_work to
 IRQ_WORK_LAZY
Message-ID: <20260901075015.BBNf1HZ5@linutronix.de>
References: <20260828155811.270462-1-john.ogness@linutronix.de>
 <20260828155811.270462-2-john.ogness@linutronix.de>
 <20260828160652.TQBsi8oO@linutronix.de>
 <apWcikIof_6CRNNU@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <apWcikIof_6CRNNU@pathway.suse.cz>

On 2026-08-31 17:23:54 [+0200], Petr Mladek wrote:
> On Fri 2026-08-28 18:06:52, Sebastian Andrzej Siewior wrote:
> > On 2026-08-28 18:04:08 [+0206], John Ogness wrote:
> > > For some platforms it is a problem to queue irq_work when entering
> > > cpuidle states. Since irq_work is used for deferred MSR handling,
> > > any atomic console printing when entering cpuidle states can lead
> > > to the affected hardware hanging. Tegra20 and Tegra30 are examples
> > > of such platforms. Avoiding raising the irq_work IRQ has shown to
> > > circumvent the problem.
> > 
> > > Change the console_msr_work to be IRQ_WORK_LAZY, thus not raising
> > > an IRQ upon irq_work queuing. The irq_work is then handled on the
> > > next interrupt (worst case, kernel tick).
> >
> > Not on the next interrupt, on the next jiffies tick. Should you run
> > tickless and should the CPU have the tick switch off then it will raise
> > the irq-work interrupt anyway.
> 
> This seems to be more precise. There is one more scenario. It would
> run in a dedicated kthread with PREEMPT_RT.

That is an implementation detail same as the tickless thingy.

> I hope that nobody would run tickless system on the old
> Tegra hardware. So, this change should be good enough in reality.
> 
> Anyway, I would prefer to get this "workaround" in for 7.3.
> In each case, I would not want to revert the uart 8250 conversion
> to nbcon because it did break the Tegra hardware.

I would see this as an improvement and not a workaround. It has the
side effect that it works now on Tegra which has apparently a broken low
idle implementation.

*If* this LAZY mode couldn't be used for some reason, I would suggest to
disable the offending low idle mode
	https://lore.kernel.org/all/791131d7-cf8d-4572-8eec-df5fff1783a9@nvidia.com/

rather than reverting 8250-nbcon for everyone.


> Best Regards,
> Petr

Sebastian
