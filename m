Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A4D3A5E90;
	Fri,  9 Oct 2026 06:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791528718; cv=none; b=b/icbNWvYpyZsIqZG1WJjdD4GFDcs/blqiem+TUyZyMYLXECEfnuXpVQaxU67qJqQt8O4GdSkQWDQqwR6ddrtabBDkw8oTJql7jl+FzxYj67mDFHZgY0nsWRivJlI73TnQ/uFhbbF9o5Lvioar/lSU86kIEnhgCJ5KjRKWaPaVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791528718; c=relaxed/simple;
	bh=T7evhoAPnyLqu8AuSArXsuRV2uEGLdYrW+N9EDj4LWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urPYAnh39uMOeWALAdIWvlne/nqPlxk5ddIKiG7cy2Xj1TnsxHvfzNknDSQ2ijBLIwLPadqTmMteJY8FJfOsz60+QwLBne3/wPIdKR6psshamB0YXMtMBMoAL5xm2nsGqLGNBl1kNO/fI+DYvhTbDGuwAbrZ5xvddlPGYjMLRxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mWtzH9Rs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qvFQxV2n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mWtzH9Rs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qvFQxV2n"
Date: Fri, 9 Oct 2026 08:51:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791528713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y7MpN4X9qUy1mZN38rHT3JM/K99APJCe5a5mgYadF2c=;
	b=mWtzH9RsROtb6QZLbLoEHACoKG9zX/e9aAzj7YZP62XccdMptUhXyeGi1n+tpJa/kIteVb
	j2xnikHG4JR0ux0zg1PIS+Ln3VX+hJNOoqImPt7daF5IrNL6rsBmYFA3SD1tRVRhjMl8Ye
	sDxm8gCQPZc0l6RYN3Midv1mt9vrF1+6wRiAtlwNqJOMAC1boTHLcVmzE7ja2eHhZt5TWh
	hgl9Pd7eNaYjsyQrUSk/ZHqgg40XDASMnE/T9RavPIf8dRCh/i++MpSZyivrrWJ+stZhBu
	Q11FbQ6fHBEWHAZvNSiR/++apl6QQFFidxLl+RcZCjDR/jVxCzHrJGaM3JjAAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791528713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y7MpN4X9qUy1mZN38rHT3JM/K99APJCe5a5mgYadF2c=;
	b=qvFQxV2n409ugEDiKCQnPSZrbyPBRbeEKuElY1Ir4FbLaj7sZuJYqf7o/a9YzMwYW/NvDw
	Hvfbf3LQgsuy8nBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-serial@vger.kernel.org, oliver.sang@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbcon/reboot: Flush nbcon consoles synchronously on
 reboot
Message-ID: <20261009065152.udyfFRHx@linutronix.de>
References: <20261008150852.8286-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261008150852.8286-1-pmladek@suse.com>

On 2026-10-08 17:08:52 [+0200], Petr Mladek wrote:
> NBCON consoles emit messages in a dedicated kthreads when the system
> is working properly. printk() tries to flush them synchronously in
> explicitly marked emergency context and in panic().
> 
> Another situation where printk() could not rely on kthreads are the various
> reboot and halt code paths. They can be detected by the `system_state`
> variable.
> 
> Let's default to NBCON_PRIO_EMERGENCY for the post-running states.
> printk() will automatically try flushing the consoles synchronously.
> Also do not rely on printk() and explicitly flush the consoles
> after these states are set.

while this seems okay, didn't we have pr_flush() to flush the output on
shutdown/ reboot?

> Note that suspend code paths have already been handled, see
> console_suspend_all() and console_suspend().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/all/202608061008.48a1e76e-lkp@intel.com/
> Suggested-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Sebastian
