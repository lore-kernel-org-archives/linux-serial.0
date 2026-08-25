Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0F83CD8C9;
	Tue, 25 Aug 2026 22:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695372; cv=none; b=pSfVt/WjELyXjCfEvO3O2YTTKjDMlYSV1WQF6c85icn0YvWZ4z164NGSEz4WdRFVf1dGoLAaLUP/zPbAn0RdsAGVOL4fH/Vu5/xcwsClwVxhtxsellcEPy56wyHLSf8FfUx5BEHbI0vmTEnWIee4ogOICDi5l/4FkWrbbdAFKKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695372; c=relaxed/simple;
	bh=+ayHrEc/kIzEPpVNi0TkNcAu2bRYPEIUCPrglKGPYRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NpEnCRu7iEi8L6Z1B0bFI824YMfAyOUQ/wcgrm/y0YBlTU+LUa6lLktKsHPCpM0DXkgYBtvfhBxPn9U3Xca+ajQs97FUL7vzHJCSDbyeo8oQOguejct3KnQJJ9AgxJwz8obmisv8n4wziau4oO3IaBAkGbxDpZoPPe2lRYCIrfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cJbIQPDz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FuqUMn9V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cJbIQPDz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FuqUMn9V"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787695367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/L5LZqIh4c+AjMrtMse+OATPvq98V5QVhKi4uxTFP7A=;
	b=cJbIQPDzse65ByeShd32nDanDszyGY5E4VMbWtKF3cJtblRdJPvwEeiD01Iaev+CrMundR
	ElxddU59GAUEiNP7eyQKaXPDxtmbwYjgxWKPmfx3XmXovOJGG1KkbFl1moZX6NfgVJcbRb
	GhH1o/M7zQoE/OAdUGdra/0RGbiVxc4tdTd61isq1ynw5DIWux1HFRNpoAeSvrTR9cBkj5
	z5f6U1ozV8Qr2A8oAXWXXpLYGo3azAgSAqepU+DZlpTGMhKHPgu57Nd5CJAj7WYIO+p/vj
	9ixGk0oA4s/fq1niDiPtFxvQBOOhb/xkySF+QudG7pWzX1lFf8KYNBs1HIZC/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787695367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/L5LZqIh4c+AjMrtMse+OATPvq98V5QVhKi4uxTFP7A=;
	b=FuqUMn9VKT1U/6quGk3fWZTUSLC0ue2mt9lzhfvogl7TwY2ifGFHs/R7mdnh6R4h0/iwQv
	fHytGnV4KcNxoIAw==
To: Jon Hunter <jonathanh@nvidia.com>, Petr Mladek <pmladek@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Kees Cook <kees@kernel.org>, Stepan Ionichev
 <sozdayvek@gmail.com>, Xin Zhao <jackzxcui1989@163.com>, Osama Abdelkader
 <osama.abdelkader@gmail.com>, Fushuai Wang <wangfushuai@baidu.com>, Marco
 Felsch <m.felsch@pengutronix.de>, linux-serial@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
In-Reply-To: <d058012e-2be7-4e70-9c10-5e4c00a23b05@nvidia.com>
References: <20260729120439.281252-1-john.ogness@linutronix.de>
 <20260729120439.281252-2-john.ogness@linutronix.de>
 <f3757a75-0ba1-4558-bf57-f19ab7e59a4c@nvidia.com>
 <aoQPFC7d8mSuNZMh@pathway.suse.cz>
 <861247ca-dfd4-40c6-a094-0fbe389f3b67@nvidia.com>
 <aoR_9g7W0qyqWbOj@pathway.suse.cz>
 <fd1802c3-4b38-4127-b988-a9ff059bcebf@nvidia.com>
 <877bll9d91.fsf@jogness.linutronix.de>
 <eb0f2c8b-2c7b-4bfd-9144-6786999c4c31@nvidia.com>
 <875x139eqr.fsf@jogness.linutronix.de>
 <6b46866f-548f-4963-bc41-48ce15ae9012@nvidia.com>
 <877ble714e.fsf@jogness.linutronix.de>
 <d058012e-2be7-4e70-9c10-5e4c00a23b05@nvidia.com>
Date: Wed, 26 Aug 2026 00:08:46 +0206
Message-ID: <87pkz56epl.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-08-25, Jon Hunter <jonathanh@nvidia.com> wrote:
>>> With this I see a little more output on the console, but it still
>>> appears to hang later and never fully boots.
>>>
>>> Boot log here: https://pastebin.com/Xe1vmeUj
>> 
>> Thanks, this information is helpful. Below is another hack, to be used
>> on the unmodified linux-next. For whatever reason, I think the queuing
>> of irqwork is causing problems. Perhaps the irqwork is actually firing
>> even though interrupts are supposed to be disabled here.
>> 
>> The following hack will disable the queuing during the cpuidle. Please
>> give this a try:
>> 
>> ===== BEGIN CPUIDLE HACK =====
>> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
>> index aca907a62bb5d..1dca9d6defbff 100644
>> --- a/drivers/cpuidle/cpuidle-tegra.c
>> +++ b/drivers/cpuidle/cpuidle-tegra.c
>> @@ -226,6 +226,7 @@ static int tegra_cpuidle_adjust_state_index(int index, unsigned int cpu)
>>   	return index;
>>   }
>>   
>> +extern bool console_irqwork_blocked;
>>   static __cpuidle int tegra_cpuidle_enter(struct cpuidle_device *dev,
>>   					 struct cpuidle_driver *drv,
>>   					 int index)
>> @@ -238,6 +239,8 @@ static __cpuidle int tegra_cpuidle_enter(struct cpuidle_device *dev,
>>   	if (dev->states_usage[index].disable)
>>   		return -1;
>>   
>> +	console_irqwork_blocked = true;
>> +
>>   	if (index == TEGRA_C1) {
>>   		if (do_rcu)
>>   			ct_cpuidle_enter();
>> @@ -256,6 +259,8 @@ static __cpuidle int tegra_cpuidle_enter(struct cpuidle_device *dev,
>>   		index = ret;
>>   	}
>>   
>> +	console_irqwork_blocked = false;
>> +
>>   	return index;
>>   }
>> ===== END CPUIDLE HACK =====
>
> Yes that does boot.

Your results surprise me a bit because in previous attempts it seemed
you were also getting hangs related to printk's not produced within
cpuidle. This would lead me to believe that cpuidle is entered while
irq_work from a directly preceeding printk (from outside cpuidle) was
pending and caused a problem.

Does this hack really work reliably, without using keep_bootcon or any
other patches?

Also, although this hack will avoid queuing irq_work from within
cpuidle, it does not prevent the 8250 console driver from queuing
irq_work for MSR handling during atomic printing. There is no generic
console callback to deal with that (other than suspending the console).

I suspect it is a general irq_work problem on tegra regarding
suspend/cpuidle. Really the problem should be fixed there. But I would
need hardware to investigate the issue.

As for this 8250 "switch to nbcon" series, I am uncertain how to
proceed. Is it really printk's job (and, by extension, the console
driver's job) to decipher when it is allowed to queue irq_work?

John
