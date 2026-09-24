Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0A5481669
	for <linux-serial@vger.kernel.org>; Thu, 24 Sep 2026 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255457; cv=none; b=q683CQBqxhbHKXLU8cF0+aRJt6ftoRN01ocI1N+BLlo9NEwk0NziF6BDLr6lkVwYYp8euBQvYzJk0d9REvDdPa0YLrJBrGW2tEpIRo5/4nQtLJkqd26nWcPkm8P/bxzaIQn2oowTmbirZsLDM2+eJc4lS7jC9Krx7YSr+uYoprQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255457; c=relaxed/simple;
	bh=gcfeWoiFumGnwZk5oFpcY1/uEIGM3eRC5jcO2JGn5qA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WcNYjA6tngTW+KfZNqwUQPo3AN+/LAF2DFXhuL9qc/299P6TR0NyKxGkd1zBrtQBozZfwXGbHJ9rChzwT+2+2kFQzx7bGmry4dEN0tCt0O6iIVBr6aveUYclN2PC8AGUpOUyQnECQT/ewNxjmsKNvjWN8Jn20ktguMeAcPQvHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EXLbNego; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8xUZhWDf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EXLbNego";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8xUZhWDf"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790255452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LiKz17vAIdlOfYQvk8/f7uZ7etlql30qRiSSyHC6Ljk=;
	b=EXLbNegoUgxByyJwIkTuDEyqv0eAtUVKIWN0/OmVk/D6ax7fG+/FVEDOggFDZxQrun8xCX
	deb2dOVt1Xyjdx2z1bxrWhsG95zX6iroe14+gx4tNqZURxzV80gVXXKyFggN6plpWKur6j
	AVcHTkmnpdQeneJK8DvZ/O3eS9Z0imK8GuFw7BYwlK8R4gqG+UhFQR3czC3R+dCIiYZxhL
	WiyFcgQjQf7gN5OYPlUDVHKHJS5szx8SdK8QHL5i+Pnhf9HVKOPX1LmtSUMJNf6uYmFMIN
	g+rpryqH1/3q3gzUAcBloeuey+Vn5Ow+VrQQUWq/C0Vgd2vunm6+mPf7lK0N8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790255452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LiKz17vAIdlOfYQvk8/f7uZ7etlql30qRiSSyHC6Ljk=;
	b=8xUZhWDfY7A477ahokQeXmbTEMGoIg09C4bus0wz8C2qgKdSydq2QkabYH0rMagFVfDfLI
	Sgq2qvaO/kAgVZAg==
To: Petr Mladek <pmladek@suse.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-serial@vger.kernel.org, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [linux-next:master] [serial]  d353934702:
 BUG:kernel_reboot-without-warning_in_test_stage
In-Reply-To: <87bj9o0yir.fsf@jogness.linutronix.de>
References: <202608061008.48a1e76e-lkp@intel.com>
 <87ecek1c8d.fsf@jogness.linutronix.de> <arPQwKbl7wM6IM3x@pathway.suse.cz>
 <87bj9o0yir.fsf@jogness.linutronix.de>
Date: Thu, 24 Sep 2026 15:16:51 +0206
Message-ID: <87pky2u750.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Petr,

On 2026-09-23, John Ogness <john.ogness@linutronix.de> wrote:
>> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
>> index d17704fe93ae..48446926dc50 100644
>> --- a/kernel/printk/nbcon.c
>> +++ b/kernel/printk/nbcon.c
>> @@ -1446,6 +1446,10 @@ enum nbcon_prio nbcon_get_default_prio(void)
>>  	if (panic_on_this_cpu())
>>  		return NBCON_PRIO_PANIC;
>>  
>> +	/* Do not rely on kthreads when the system is going down. */
>> +	if (system_state > SYSTEM_RUNNING)
>> +		return NBCON_PRIO_EMERGENCY;
>> +
>>  	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
>>  	if (*cpu_emergency_nesting)
>>  		return NBCON_PRIO_EMERGENCY;
>> diff --git a/kernel/reboot.c b/kernel/reboot.c
>> index d177d89fcc33..776784a82499 100644
>> --- a/kernel/reboot.c
>> +++ b/kernel/reboot.c
>> @@ -8,6 +8,7 @@
>>  #define pr_fmt(fmt)	"reboot: " fmt
>>  
>>  #include <linux/atomic.h>
>> +#include <linux/console.h>
>>  #include <linux/ctype.h>
>>  #include <linux/export.h>
>>  #include <linux/kexec.h>
>> @@ -94,6 +95,7 @@ void emergency_restart(void)
>>  {
>>  	kmsg_dump(KMSG_DUMP_EMERG);
>>  	system_state = SYSTEM_RESTART;
>> +	printk_trigger_flush();
>>  	machine_emergency_restart();
>>  }
>>  EXPORT_SYMBOL_GPL(emergency_restart);
>> @@ -102,6 +104,7 @@ void kernel_restart_prepare(char *cmd)
>>  {
>>  	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
>>  	system_state = SYSTEM_RESTART;
>> +	printk_trigger_flush();
>>  	usermodehelper_disable();
>>  	device_shutdown();
>>  }
>> @@ -305,6 +308,7 @@ static void kernel_shutdown_prepare(enum system_states state)
>>  	blocking_notifier_call_chain(&reboot_notifier_list,
>>  		(state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
>>  	system_state = state;
>> +	printk_trigger_flush();
>>  	usermodehelper_disable();
>>  	device_shutdown();
>>  }
>
> I am OK with this change.

If you want to roll this into an official patch:

Reviewed-by: John Ogness <john.ogness@linutronix.de>
