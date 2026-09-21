Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC00D489FD2;
	Mon, 21 Sep 2026 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992967; cv=none; b=ob6CPVCyNpOfdnhsZZQFmzod6H+Bh68BZyyKTs/6pFRY+hecahuKHbF4DqiBBmyoQSg44+C8/6u5bE42jkGLxhOn79YKdReQcTQHlRRo6QLwOJIu2rbEcfAg29il7bHrGfff1N2UX5AEZ4EpnqkjpMYpyAwuvAblFJmp7UR5ko8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992967; c=relaxed/simple;
	bh=Oq+fJ2yTUAgHBfgWNUdgNQ6nPa2ReAQw4cPU9wmXCmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsXA1O4OOPn5N3DU/718x2+uNP27uC3vosDPRn7dKVr9Lrf1Rx3SDQPRvwZo6hHECyC3BG3xv0Wn3irkK2nkJB6JvUzRUkmfreYTFrN85L1aUiiN/Xs6ULLsHtb+W1Gpby/B2GVdUT5K1CuhvIBXxClwhAotGthXEfxW42el63M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mi3tUiDJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mi3tUiDJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994DA1F000FF;
	Mon, 21 Sep 2026 12:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789992965;
	bh=gkdhwQJypqCwU0qXuaTIExx64fio9MAL9upHipbfc1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mi3tUiDJalT3fepDX/6sdyIi2NEQE6NFBD9iEpvexTVCMvxJdqQo+UgURL+yNL/+z
	 xZ4Gejfcayka7U91QCYbhnAkcFpAJBXgO9EAkK7ZLC1qkCjq45mRLko+6iyRdDUoY4
	 i82wOEPRzTQQZqBhZn2JCfgjiQjS4787BKnq2HHM=
Date: Mon, 21 Sep 2026 14:15:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH tty 0/1] Make 8250 deferred MSR handling LAZY
Message-ID: <2026092133-runt-sharper-445c@gregkh>
References: <20260828155811.270462-1-john.ogness@linutronix.de>
 <87ld8usz1x.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ld8usz1x.fsf@jogness.linutronix.de>

On Mon, Sep 21, 2026 at 12:07:46PM +0206, John Ogness wrote:
> Hi Greg, Jiri,
> 
> On 2026-08-28, John Ogness <john.ogness@linutronix.de> wrote:
> > There was a report and follow-up discussion [0] about a problem
> > using regular irq_work queuing on some platforms when entering
> > cpuidle. To circumvent this problem, all irq_work for printk will
> > become IRQ_WORK_LAZY [1].
> >
> > The 8250 console driver uses irq_work to defer MSR handling during
> > atomic printing. This means it is vulnerable to the same problem if,
> > for example, a WARN() is hit while entering cpuidle on one of the
> > affected platforms.
> >
> > Avoid the problem for deferred MSR handling by changing
> > console_msr_work to IRQ_WORK_LAZY.
> 
> Any chance of getting this into 7.3? A similar patch went into 7.3-rc3
> for printk:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/printk?id=560f4deda32785e260056200f8bb911c475c5b88
> 
> Or do I need to send a v2 with an updated commit message? I could
> rephrase it similar to the related printk commit. Something like this:
> 
> Change console_msr_work (defers MSR handling) to be IRQ_WORK_LAZY,
> thus not raising an IRQ upon irq_work queuing. The irq_work is then
> handled on the next kernel tick. This additional delay is acceptable
> because the MSR handling also occurs in the an interrupt handler, if
> mctrl is queried, and during console resume. Using IRQ_WORK_LAZY has
> the benefit of not needing to raise an IRQ for each line of atomic
> console printing when modem control is active.
> 
> On a side note, the Tegra20 and Tegra30 platforms can hang if an
> irq_work IRQ is raised while entering cpuidle states. This problem
> was reproducible by performing atomic printing while entering cpuidle.
> So this change also provides a workaround for these platforms (as
> long as they are not running tickless).

An updated changelog would be great, then I can take it for 7.3-final
easier.

thanks,

greg k-h
