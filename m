Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378F3377A83;
	Fri, 28 Aug 2026 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933216; cv=none; b=mBvShi9m/SpnVZ8T1yFgHZ+fpBpgakwBeUe157N8SSlS3F2a2BZvg+CFv/OaPH7f/kT9DyduMzk3wr/0DEmczbVsjnv6NdgExBjvDIxxi+/Jpd07WQXewc7mS4GaEkzFtuk9bAK1IboUN+6CFhDlkdToBSAcufMZfux1NYrVXkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933216; c=relaxed/simple;
	bh=KUdVNzS7J08gZEG5L1JNnrXe3a6ABvrWF4v/HYz5wDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+TJn5OVgBYxq11+Hg4IUxJGFUW97ntWAwoZkHnLJnyr77yziZ88Kxk6CDRZ5zKJZYQut6yXaTYvkhyHNHRD5cgugPH5P2Xj9eos40IouqYN1lRRE7ODVJoivBQTXXIaVXD0DCnty2Y0jvooaoHGiv5hPHLBxX9D5BU5qYmsQaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3hMR7+qI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RjrJiDqk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3hMR7+qI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RjrJiDqk"
Date: Fri, 28 Aug 2026 18:06:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787933213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4jEUr6IeQK/dhrUiysofDNbqn21YATEcvFeZZvaTgAQ=;
	b=3hMR7+qIanoOHq5DwT+KUAT3VfUtJ7l+uCgRdXRD37R4ujFLhuz8ls8wDrf7AkfQqlT/9y
	MTn7u66ZHyyIMZhHGAAGiey7mwl9PXT2mjLtn71iedmyFW/IbquWX2Jl7pNfqtChyzmDQH
	ZtKWZ7Y+cLnSEzPIFHx4flHCMeyO07SOw5F0pnrcp3dBbrXXoT+wwS6PRPoKq7r58gzIVw
	KfJ+YlvYVutGeIm1Pii1A8FIdTjEeTOXHK9USd5v1ZaQ0y0Z5gWGvJKV/jgLb7Z7WES2SJ
	R9fy8zISYc4/iM6LOGUk0wzIzKjNCnVCfCqvkPKeUeYcS4uYx/eN64DYDJiktA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787933213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4jEUr6IeQK/dhrUiysofDNbqn21YATEcvFeZZvaTgAQ=;
	b=RjrJiDqkflbPfGpEk/2axBeTJxp44cxuQ4fStPCBhPsprVp4RgIqgZXewIkQD/VMKKg1O4
	J6SgkAgQlzAZ/2Aw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>, Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH tty 1/1] serial: 8250: Change console_msr_work to
 IRQ_WORK_LAZY
Message-ID: <20260828160652.TQBsi8oO@linutronix.de>
References: <20260828155811.270462-1-john.ogness@linutronix.de>
 <20260828155811.270462-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260828155811.270462-2-john.ogness@linutronix.de>

On 2026-08-28 18:04:08 [+0206], John Ogness wrote:
> For some platforms it is a problem to queue irq_work when entering
> cpuidle states. Since irq_work is used for deferred MSR handling,
> any atomic console printing when entering cpuidle states can lead
> to the affected hardware hanging. Tegra20 and Tegra30 are examples
> of such platforms. Avoiding raising the irq_work IRQ has shown to
> circumvent the problem.

I would argue that this is done for the benefit of less interrupts since
there no need to handle console_msr_work immediately. With the side
effect that it might fix a bug that was not yet reported on Tegra[23]0. 

Ideally the Tegra folks should figure out what exactly is broken instead
of adding duct tape everywhere else.

> Change the console_msr_work to be IRQ_WORK_LAZY, thus not raising
> an IRQ upon irq_work queuing. The irq_work is then handled on the
> next interrupt (worst case, kernel tick).

Not on the next interrupt, on the next jiffies tick. Should you run
tickless and should the CPU have the tick switch off then it will raise
the irq-work interrupt anyway.

side-note: Wasn't there another tegra workaround in v5/take1?

Sebastian
