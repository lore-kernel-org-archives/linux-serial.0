Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06982202F70;
	Thu, 27 Aug 2026 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845730; cv=none; b=hmuWPP0SJ96mUZhpCZseRem+MZc3F3o5b46yN3IyvbrYjNjeUw98HJYnnzYBMQRx+F9gq6QUe9TdfzeQ0Eha4c5Ze75AuuaURftZqVmXDEvAdFAjy6DccIwKgfptTt3GlU+T0IFm1vQM0+Y5Md19Iw8Ft6Is2d3MXnZ6t1GoHR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845730; c=relaxed/simple;
	bh=N7lL1W32Y2EORCPYqVVvxsbDQKXWMGA6B3ZOZGWJO/E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Og7uQoFo/3jDSi3zRu0AouCI4a3UjIi9DShqMyLNxn3buYGBD+ZiLHpPTboEaSaYZo4toAdHZrNT4T/VhfDibYgjW8pmvniVxroOqZcWGrHHjvj8SPaI+Xus+d7ntBf+HEExTtJUADWooxnBncGLP/4d1rCPJmkNgTTgsEUUlWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zoASgelX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vAbLg8Ie; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zoASgelX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vAbLg8Ie"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787845726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gqfl1YSZejsOeooCm+JfAFANwhQXYm9K8eFA9dVn5Ss=;
	b=zoASgelXX5pWQh4lpVPvjUAxXYDAVJ/8hL6UM0B/gkU4CwLMz8gwavTLUnYxQqWF02uq43
	zURocTY1x7g3oBlVQKdLOgkwGWc4aQlIlZOkhwLLAqPC41im7rJdDhre8yBtxQ4/pM/Mnh
	ZaBSGltJnGlua+eS9u8Fwzvfy0guYLBBTjjauUyYU8kPJl/AECKInBPvd7tr+TIfPoaBGu
	6HaD/Bx6gsTH5PrHRQzY/a1uoht7BSJvApivJ/vRV6EiEBy64yN+6a0YJVVagb0miCWODz
	8sMM0hnAtTn6uk+c43yUu9v5uYYO95R8QRdoVIHHSneYZj4r6v5IQDZFsZNCkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787845726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gqfl1YSZejsOeooCm+JfAFANwhQXYm9K8eFA9dVn5Ss=;
	b=vAbLg8IeO8tHG129Ynr0UtU0RpmosIvKpqXyYT+yvxXO/MAhzNk0bybGEHeM1k+sD0gWEH
	71CzHyRUdcmnb7Dg==
To: Jon Hunter <jonathanh@nvidia.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 linux-kernel@vger.kernel.org, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Kees Cook <kees@kernel.org>, Stepan Ionichev
 <sozdayvek@gmail.com>, Xin Zhao <jackzxcui1989@163.com>, Osama Abdelkader
 <osama.abdelkader@gmail.com>, Fushuai Wang <wangfushuai@baidu.com>, Marco
 Felsch <m.felsch@pengutronix.de>, linux-serial@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
In-Reply-To: <95ab37fe-2e21-4b6e-b8ef-39bccd2e7d75@nvidia.com>
References: <aoR_9g7W0qyqWbOj@pathway.suse.cz>
 <fd1802c3-4b38-4127-b988-a9ff059bcebf@nvidia.com>
 <877bll9d91.fsf@jogness.linutronix.de>
 <eb0f2c8b-2c7b-4bfd-9144-6786999c4c31@nvidia.com>
 <875x139eqr.fsf@jogness.linutronix.de>
 <6b46866f-548f-4963-bc41-48ce15ae9012@nvidia.com>
 <877ble714e.fsf@jogness.linutronix.de>
 <d058012e-2be7-4e70-9c10-5e4c00a23b05@nvidia.com>
 <87pkz56epl.fsf@jogness.linutronix.de> <ao6XVfmvV6HjBiEv@pathway.suse.cz>
 <20260826075925.WTEVoXWi@linutronix.de>
 <875x0vpvma.fsf@jogness.linutronix.de>
 <95ab37fe-2e21-4b6e-b8ef-39bccd2e7d75@nvidia.com>
Date: Thu, 27 Aug 2026 17:54:45 +0206
Message-ID: <87wltbo97m.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Jon,

On 2026-08-27, Jon Hunter <jonathanh@nvidia.com> wrote:
>> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
>> index a5921a84a80ed..ad79e30afd647 100644
>> --- a/kernel/printk/nbcon.c
>> +++ b/kernel/printk/nbcon.c
>> @@ -1782,7 +1782,7 @@ bool nbcon_alloc(struct console *con)
>>   	}
>>   
>>   	rcuwait_init(&con->rcuwait);
>> -	init_irq_work(&con->irq_work, nbcon_irq_work);
>> +	con->irq_work = IRQ_WORK_INIT_LAZY(nbcon_irq_work);
>>   	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_prev_seq), -1UL);
>>   	nbcon_state_set(con, &state);
>>   
>
> I gave this a quick try on Tegra20 and Tegra30 and I can confirm that
> this does work.

OK, great. I will prepare an official patch for mainline to change
nbcon_irq_work to LAZY.

Back with v5 you reported [0] similar issues due to suspend/resume. For
that we implemented the @console_irqwork_blocked workaround. We probably
do not need that anymore. You could verify that with the following hack
(and booting with no_console_suspend). Note that you also need the LAZY
change above.

===== BEGIN SUSPEND HACK =====
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6d3d18a50da74..73c85f6de2c9e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2796,7 +2796,6 @@ void console_suspend_all(void)
 	 * any klogd waiters are not triggered.
 	 */
 	pr_flush(1000, true);
-	console_irqwork_blocked = true;
 
 	if (!console_suspend_enabled)
 		return;
===== END SUSPEND HACK =====

However, this workaround did allow the consoles to switch to atomic mode
on suspend when no_console_suspend is specified at boot. So the
workaround might be interesting for that reason alone. But we should no
longer need it for the reasons mentioned in commit 26873e3e7f0c
("printk: Avoid scheduling irq_work on suspend")

John

[0] https://lore.kernel.org/lkml/80b020fc-c18a-4da4-b222-16da1cab2f4c@nvidia.com
