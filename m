Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAED64A8D;
	Wed, 26 Aug 2026 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731170; cv=none; b=rdVd9Aww+d/iLR2SWJcSwEiQdxVKN7BrFLvkMHLvWn6iXdZLmoaDvUasp34G8YzP0/UzFVCcjGc1oaxv7Syag1GrMoRUD2TTlosi8sWdP6l6iRbIEnL5avPBV3d33WPXuUV+9VNaCigbe7uQYe06eBOFUi+cTMt/Ak9fm476pZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731170; c=relaxed/simple;
	bh=r/0+M4wdvjLRgs1k3O+I6W8cWObIePkDJOUd+tJSOJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUyjWbngCCu0hCvLAK8e+6a0J7ABWVZ0W95jMsGJthuTjyYMiZdSv3NwXTa5kKnE+EKQn8sMx3rr6w8+d5TOPHEaMOWvQe0+gdrhe3LsZQlpfd2nB+QLPABBYgBSILEURqCkXFOVH6N8X9G24nhO50IUpQTgHzZPTTgebOgszLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cBI3xtKk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dni4fe3n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cBI3xtKk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dni4fe3n"
Date: Wed, 26 Aug 2026 09:59:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787731166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vp8n5tXAE/0DxEjcH9DrU0RGbMnRQpKfp5sszJqLRLw=;
	b=cBI3xtKkRriqqSNOzSTcGsy1SxsD6TlAvNm7sQFQryV/k+6U/H1Igg6M7hQUcP/4YqZqy9
	sWJQtucnK10cfpcsrud54vF+A6O56Ehf49gVJug4AogMQYuz/kWelqmZ6zN9cFfeVQWOpL
	89NtwKnJiAUt9AHN9lh8VFGHmUwq4JDHdKg8kGbvxpQR2G11Y0kOnqvKMAQWOb/1ZaetcP
	aPm9KUMhdczDcehDroaCBUTjXi/uBELyq/iEUW4kQyI8WYIgGvs27WG60QZXCTRKj4bpwN
	6ifnRwd9LB3rkTpuuJZc24kqhGAUaZQ8C7NjTveWHBYqOGkump4pP2b/IqTjUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787731166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vp8n5tXAE/0DxEjcH9DrU0RGbMnRQpKfp5sszJqLRLw=;
	b=Dni4fe3nwRpDEJExlFlzK6UDjFQBL5SNh4WtCCif1/d9H/s0sywaOC/S5o9bBAWR3PCZGj
	Dzd6IQ8mB4RrIUBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Jon Hunter <jonathanh@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Kees Cook <kees@kernel.org>, Stepan Ionichev <sozdayvek@gmail.com>,
	Xin Zhao <jackzxcui1989@163.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	linux-serial@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
Message-ID: <20260826075925.WTEVoXWi@linutronix.de>
References: <aoR_9g7W0qyqWbOj@pathway.suse.cz>
 <fd1802c3-4b38-4127-b988-a9ff059bcebf@nvidia.com>
 <877bll9d91.fsf@jogness.linutronix.de>
 <eb0f2c8b-2c7b-4bfd-9144-6786999c4c31@nvidia.com>
 <875x139eqr.fsf@jogness.linutronix.de>
 <6b46866f-548f-4963-bc41-48ce15ae9012@nvidia.com>
 <877ble714e.fsf@jogness.linutronix.de>
 <d058012e-2be7-4e70-9c10-5e4c00a23b05@nvidia.com>
 <87pkz56epl.fsf@jogness.linutronix.de>
 <ao6XVfmvV6HjBiEv@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ao6XVfmvV6HjBiEv@pathway.suse.cz>

On 2026-08-26 09:35:49 [+0200], Petr Mladek wrote:
> > As for this 8250 "switch to nbcon" series, I am uncertain how to
> > proceed. Is it really printk's job (and, by extension, the console
> > driver's job) to decipher when it is allowed to queue irq_work?
> 
> I wonder how other architectures hanle this situation. I wonder
> if they just ignore the pending IRQs.

The interrupts should be disabled and the enqueued irq_work should be
delayed until after the interrupts are enabled again while entering
idle. An interrupt is probably what pulls the CPU out of idle.
Is it possible to get some kind of crash dump or anything else to figure
out the state of CPU while it hangs?
If that irq_work is the problem that making nbcon_irq_work LAZY should
delay it, masking the problem.

Either way, I don't see why raising irq_work should be a problem. That
interrupt has to trigger once interrupts are enabled again. However, if
this is missed then further irq_work enqueues won't trigger an
interrupt which might be a problem if something relies on it.

So the question what is doing while it makes no progress and does not
fully boot.

> Best Regards,
> Petr

Sebastian
