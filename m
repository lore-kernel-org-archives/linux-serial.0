Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35D135DA64
	for <linux-serial@vger.kernel.org>; Wed, 26 Aug 2026 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787729756; cv=none; b=jJuaHlTJRepDtjmAz3VTgrVcLQTgh/dmi8ENA+Xzw9eePbi7Wb8kZrUZcuym8NqFM/O/SIv/QxbWogeZo6aHhHE07wph38CZ+EOO5YCWdNBke28bVEF3talJ8mXyZlCjxKK6lsZve4jXBTf4zGLE5Y599CAhN666mvl+Z22htHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787729756; c=relaxed/simple;
	bh=lAlKIiHaY2We1Eg1pAGcjv+qVL9z4hMibmiKpOQKs2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmdkIz9d8rDjtUzKN7him2SOSFha8EwgZIXPfLcIhjM84hTCnMzUvEFsy/k/65NibQYdcdWTpsFJ3aRtLN1g9ulcv5oHh/aT75Guv1siLd3a/60GFZ7eVd72gsx5c2BQr3mm65p6XcXiSHqNH25v+3HLwVwVbNO96yGnax1wzpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DBaRqaQt; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DBaRqaQt"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a5ded53570so991680a12.3
        for <linux-serial@vger.kernel.org>; Wed, 26 Aug 2026 00:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787729752; x=1788334552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+o2OHs7EVw7RDxE23MpGrAyGtipLg/M6rWi6a9Pf3sE=;
        b=DBaRqaQtSIu/2KHO73pd6EH0+cfbfU32mvCqwa+FwnvGwv2IZD0Sezre8NNj6dtevK
         yBUkOmulGmkpNHWo+OOI/UjijZ5+fO2y42IEOVrH72HKmzuO8Pb3xcUWrKzf5hIe0GqC
         SEP5IS9Ep7rRvPsfzCXAfiOhao4V/KmG8KCWH2Cqq3kzTtZ3ArcZttxwcBqW/Yu012TP
         Ga48vaKh7SzLDcKmNg48QaTBEqa705ETizfe3+IO0y0aJUsQQv11Fn8KWEAOho96JphZ
         Rj+bNXOpVNERL031QTDij+cmcqzs3AKsmdy3S/BNUsbcfNxu0ZjSRdzjt5Y18ij6tt34
         EwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787729752; x=1788334552;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+o2OHs7EVw7RDxE23MpGrAyGtipLg/M6rWi6a9Pf3sE=;
        b=A4Dp3OT1LJ+RX/sBkAhxZXcldS1nf5uDLMdd0NOV2aRBMauUoaso7LLl5ohDEGLIcN
         pwmJwFNRYNoK7k5nzREQ6X+qKKJBiOIoQXbnE5ovCdq6LqzMwEl/pPXJiJTR48WeWs8z
         tjHYA4d3Fh40nm09ON8QPx8rou4tXM2V7BcaQPjn0hoNLgxsmyyZQKtal4uCask3BV7Y
         6dUAB9OmD5blwZoltLbZE6RjZK6VTM2oUoDOlv6GTGRqC3vH2FZ8fJVsQHQ1bKmSTWMx
         Cx7fORcp2xg5Sz9oFLgV5eDCXp538PqVnar1oNo0PQJz21On2ZVO8W/bb31B/Nx7uilh
         lPsQ==
X-Forwarded-Encrypted: i=1; AHgh+RqwmmFxQAgglMC/PcRu5vB4sjF/a+abp+3IVr/4m2gHhzcQ0bBAJr8OSght4CvjRLotY1w4+7prh/DIaYo=@vger.kernel.org
X-Gm-Message-State: AFuF++mVMvr9FcnrsHM8Vngsa3NOdMki56IIcghLCI5Zxz1t/GoEZJY2
	nST3lTo5IN3zweK035Rze+5FM+S9L+2Odl0r8wua+pqTJOqzS4E5RVJ1lxxdc4e6WWI=
X-Gm-Gg: AR+sD12BL+f+qrCd/fAafmMBwZtW49Q9NixaEnTOAp0AiBA8akfbBmyTiTdX2bcW4fe
	8mzXEELnVM4nq4/oTtnXydhn93oQoFVgGot+jMT2neXQ38wdYLFfKVYDaL/MOCzpqSeqrxKQi37
	CfFHoKCtt41yavSJQgusamGZIlDRXQKS53MCNDKePq7UcMCMp99c0Z5aigaUIQkat8KpqcCOIDd
	wZE/Zb756SSkonWKyyAyc2VIauZcEzal0lIww2Blw+b+NT6MuBbujps0lGo7XeC/DEl9S/FTyTD
	moBg7e5sIO66Jq+y/FUc2v/2OLGDLEM9UP6F3u2/PaR8eAdHBztOk4s3UV1e1l2UWU5WohrObFJ
	X9X/uL5YFAUYexIncTeQX90BLq6r0lzjWYFgc1GU8/USAS6L2yqRLTkYk6XeEFpaKv7X35Ri9ne
	tp2L28itaQELlJjivjwnesUxObAPhWR5pXKRQyaGO3yM/K7xodkFHQHGYdD1Z1Nw==
X-Received: by 2002:a17:906:fe4a:b0:c25:5d2:acf0 with SMTP id a640c23a62f3a-c250bb53e86mr564960866b.8.1787729752072;
        Wed, 26 Aug 2026 00:35:52 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a88aa0asm399790766b.35.2026.08.26.00.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 00:35:51 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:35:49 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
Message-ID: <ao6XVfmvV6HjBiEv@pathway.suse.cz>
References: <861247ca-dfd4-40c6-a094-0fbe389f3b67@nvidia.com>
 <aoR_9g7W0qyqWbOj@pathway.suse.cz>
 <fd1802c3-4b38-4127-b988-a9ff059bcebf@nvidia.com>
 <877bll9d91.fsf@jogness.linutronix.de>
 <eb0f2c8b-2c7b-4bfd-9144-6786999c4c31@nvidia.com>
 <875x139eqr.fsf@jogness.linutronix.de>
 <6b46866f-548f-4963-bc41-48ce15ae9012@nvidia.com>
 <877ble714e.fsf@jogness.linutronix.de>
 <d058012e-2be7-4e70-9c10-5e4c00a23b05@nvidia.com>
 <87pkz56epl.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pkz56epl.fsf@jogness.linutronix.de>

On Wed 2026-08-26 00:08:46, John Ogness wrote:
> On 2026-08-25, Jon Hunter <jonathanh@nvidia.com> wrote:
> >>> With this I see a little more output on the console, but it still
> >>> appears to hang later and never fully boots.
> >>>
> >>> Boot log here: https://pastebin.com/Xe1vmeUj
> >> 
> >> Thanks, this information is helpful. Below is another hack, to be used
> >> on the unmodified linux-next. For whatever reason, I think the queuing
> >> of irqwork is causing problems. Perhaps the irqwork is actually firing
> >> even though interrupts are supposed to be disabled here.
> >> 
> >> The following hack will disable the queuing during the cpuidle. Please
> >> give this a try:
> >> 
> >> ===== BEGIN CPUIDLE HACK =====
> >> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
> >> index aca907a62bb5d..1dca9d6defbff 100644
> >> --- a/drivers/cpuidle/cpuidle-tegra.c
> >> +++ b/drivers/cpuidle/cpuidle-tegra.c
> >> @@ -226,6 +226,7 @@ static int tegra_cpuidle_adjust_state_index(int index, unsigned int cpu)
> >>   	return index;
> >>   }
> >>   
> >> +extern bool console_irqwork_blocked;
> >>   static __cpuidle int tegra_cpuidle_enter(struct cpuidle_device *dev,
> >>   					 struct cpuidle_driver *drv,
> >>   					 int index)
> >> @@ -238,6 +239,8 @@ static __cpuidle int tegra_cpuidle_enter(struct cpuidle_device *dev,
> >>   	if (dev->states_usage[index].disable)
> >>   		return -1;
> >>   
> >> +	console_irqwork_blocked = true;
> >> +
> >>   	if (index == TEGRA_C1) {
> >>   		if (do_rcu)
> >>   			ct_cpuidle_enter();
> >> @@ -256,6 +259,8 @@ static __cpuidle int tegra_cpuidle_enter(struct cpuidle_device *dev,
> >>   		index = ret;
> >>   	}
> >>   
> >> +	console_irqwork_blocked = false;
> >> +
> >>   	return index;
> >>   }
> >> ===== END CPUIDLE HACK =====
> >
> > Yes that does boot.
> 
> Your results surprise me a bit because in previous attempts it seemed
> you were also getting hangs related to printk's not produced within
> cpuidle. This would lead me to believe that cpuidle is entered while
> irq_work from a directly preceeding printk (from outside cpuidle) was
> pending and caused a problem.
> 
> Does this hack really work reliably, without using keep_bootcon or any
> other patches?
> 
> Also, although this hack will avoid queuing irq_work from within
> cpuidle, it does not prevent the 8250 console driver from queuing
> irq_work for MSR handling during atomic printing. There is no generic
> console callback to deal with that (other than suspending the console).
> 
> I suspect it is a general irq_work problem on tegra regarding
> suspend/cpuidle. Really the problem should be fixed there. But I would
> need hardware to investigate the issue.
> 
> As for this 8250 "switch to nbcon" series, I am uncertain how to
> proceed. Is it really printk's job (and, by extension, the console
> driver's job) to decipher when it is allowed to queue irq_work?

I wonder how other architectures hanle this situation. I wonder
if they just ignore the pending IRQs.

Best Regards,
Petr
