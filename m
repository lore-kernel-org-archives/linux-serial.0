Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F40466B58;
	Mon, 21 Sep 2026 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984911; cv=none; b=ZmVj5rth0ls+BTMWqo1RkFciz84JfGzKFw6Zf6FYtasbpsvBcPZ+Ny4x2rz8Vvv0PBzah+bH8sbTAQVHGYkuXIRgE4bxCG77WLuiDanOPZxwi5hwbEg78X6mZrEVc7lUSpxRSwLnBBidWT6G8hPjGaxCQNwJJXcP/IqiwjTTadA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984911; c=relaxed/simple;
	bh=5k9BkSvb1njXjOIy83C5tRV0gwALsOvJKkkv40UlMRE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DT8V6DlrWfpc71P7PQ6krBaXIBiNPOuwdmTN4/AhgHMOvVEqmyL1O8GPm0kBJh5PWbrUNlh3EbFtzk2+7nOKCiTqIYZeEvfLwiMEdJKZbojZPWCtZ9stHMnNG0q5Lpuv3x6odqMkxMDXv+NAbg/3KDG1r5yB61hDM1J3HEhJOfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bjBB7dPQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TUHc8Ejr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bjBB7dPQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TUHc8Ejr"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789984907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5k9BkSvb1njXjOIy83C5tRV0gwALsOvJKkkv40UlMRE=;
	b=bjBB7dPQfvFuSOScLb8dNZtkVqisPE5weO25prqfQXV4UTR4fkh3dUDbXUwlBM5D+mTBlK
	nESbhdmkHDeCSJZmGTY6w2e2Wd94U9797HFy8CRElwItZnQTTQF3fmzVZXJiUvwFAe0o2N
	wV3h/0nWpZuUPVK0vUc/I+Yrzeu5J/mmYHXFhgmwrDAzhvvFZaWJRn/pREpzYQYf+vQhqV
	lVhEG5PvNQkAXXEoI1KBSTsDHJ7Hxup6YPxhpPvcd6dkt6GSEJAprb2qw5t8jpn0PhKBzQ
	5Kcmn/U+WJ1djEg5GBH8S6WX/Vu16uotC+TBUl5L8Lc4/Sdu+JOC+ycjQTVURQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789984907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5k9BkSvb1njXjOIy83C5tRV0gwALsOvJKkkv40UlMRE=;
	b=TUHc8Ejrgq6zP9JT8hwlO3FkVXsVgx72qbu75aivokAq0TLIF5u121BWg5rmsdpRcOBnBu
	QxBAz87CLcuOJUDA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Petr Mladek
 <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jon
 Hunter <jonathanh@nvidia.com>, Thierry Reding <thierry.reding@kernel.org>,
 linux-kernel@vger.kernel.org, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Crescent Hsieh
 <crescentcy.hsieh@moxa.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH tty 0/1] Make 8250 deferred MSR handling LAZY
In-Reply-To: <20260828155811.270462-1-john.ogness@linutronix.de>
References: <20260828155811.270462-1-john.ogness@linutronix.de>
Date: Mon, 21 Sep 2026 12:07:46 +0206
Message-ID: <87ld8usz1x.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Greg, Jiri,

On 2026-08-28, John Ogness <john.ogness@linutronix.de> wrote:
> There was a report and follow-up discussion [0] about a problem
> using regular irq_work queuing on some platforms when entering
> cpuidle. To circumvent this problem, all irq_work for printk will
> become IRQ_WORK_LAZY [1].
>
> The 8250 console driver uses irq_work to defer MSR handling during
> atomic printing. This means it is vulnerable to the same problem if,
> for example, a WARN() is hit while entering cpuidle on one of the
> affected platforms.
>
> Avoid the problem for deferred MSR handling by changing
> console_msr_work to IRQ_WORK_LAZY.

Any chance of getting this into 7.3? A similar patch went into 7.3-rc3
for printk:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/printk?id=560f4deda32785e260056200f8bb911c475c5b88

Or do I need to send a v2 with an updated commit message? I could
rephrase it similar to the related printk commit. Something like this:

Change console_msr_work (defers MSR handling) to be IRQ_WORK_LAZY,
thus not raising an IRQ upon irq_work queuing. The irq_work is then
handled on the next kernel tick. This additional delay is acceptable
because the MSR handling also occurs in the an interrupt handler, if
mctrl is queried, and during console resume. Using IRQ_WORK_LAZY has
the benefit of not needing to raise an IRQ for each line of atomic
console printing when modem control is active.

On a side note, the Tegra20 and Tegra30 platforms can hang if an
irq_work IRQ is raised while entering cpuidle states. This problem
was reproducible by performing atomic printing while entering cpuidle.
So this change also provides a workaround for these platforms (as
long as they are not running tickless).

John Ogness
