Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C7B1F2B88;
	Tue, 25 Aug 2026 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666326; cv=none; b=Di5GB5w/73LSgclGjmKJnY8uaIWA+OaDZOZd9/ORRSLFqhmAsaFQlsmtJFlYS7SjDgsSKDbDwuS5UQmfLfw980KsLM6IwxZTGGn3kJ4sAk9QuO0vz2mu2T36jr/lKmUP5bIRW8bhV/rxhELk4oLsYjEeAtPhIFVPv9EwizILjAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666326; c=relaxed/simple;
	bh=+yqYdexVh/ewwGXf4CuHdE7ucuSjxbJaqm433cWulSw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ml92KQWbjeYo02RzWE2MOYLJ+ibQNVfoOf7605tnnP0+EOwCK6KjXgQe1k+NJ6sZYYJaqpY+o7ajKAbAKbpPiY7rUNMgc+OINqixUtJK1RhS0+dQIrLkCkdwOkO/UxINKHlezmdO9zgeo/WMDzh4tSpAC9105Mw9J+Rp0HbXmI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vZXj54yb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3nZTdCqI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vZXj54yb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3nZTdCqI"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787666322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JpxYfEw8Y3L2dt+1X3XZajsKGK7TK6rB0kNOBLoseK4=;
	b=vZXj54yb2z5cxzTCCNeUVBTfxSvToUm0nq8WXUjo/a5uXzS+cc+Rf/MIlE00bb33No3gZM
	CXZwBFKDqnY7oAXBXE81B5/QGgcuLGqs6NPs+Zr1WzcITMmAEF6cGvwWij7bKHK54eySZP
	AoTFiGkIFHCKPXlc4KbHlAEX2RDIcFWxC1onM7schhNJ+0fUng0Qq9fI9TSfL8BmAdaA7o
	Ckpro0HvYL0l5aqB/0cbSHzSqum4HcXFFreZEgEJss13VUXjasNIUwUsxmKOWBWl518u6R
	7RZP4e6ajTf3kkkY23rnmTwjq/0ezR5uYhhFMjpmzqyqSaUWhgCfsl/T9TL9Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787666322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JpxYfEw8Y3L2dt+1X3XZajsKGK7TK6rB0kNOBLoseK4=;
	b=3nZTdCqIcS2ybtn3UkRYyuQUl+mrlpOelTuOGa6aVyrgWTqKeulU7nJjrvqeM8eiQ0gHDM
	V35igiX0FLv/GcBg==
To: Jon Hunter <jonathanh@nvidia.com>, Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Kees Cook <kees@kernel.org>, Stepan Ionichev
 <sozdayvek@gmail.com>, Xin Zhao <jackzxcui1989@163.com>, Osama Abdelkader
 <osama.abdelkader@gmail.com>, Fushuai Wang <wangfushuai@baidu.com>, Marco
 Felsch <m.felsch@pengutronix.de>, linux-serial@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
In-Reply-To: <6b46866f-548f-4963-bc41-48ce15ae9012@nvidia.com>
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
Date: Tue, 25 Aug 2026 16:04:41 +0206
Message-ID: <877ble714e.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Jon,

On 2026-08-24, Jon Hunter <jonathanh@nvidia.com> wrote:
> With this I see a little more output on the console, but it still
> appears to hang later and never fully boots.
>
> Boot log here: https://pastebin.com/Xe1vmeUj

Thanks, this information is helpful. Below is another hack, to be used
on the unmodified linux-next. For whatever reason, I think the queuing
of irqwork is causing problems. Perhaps the irqwork is actually firing
even though interrupts are supposed to be disabled here.

The following hack will disable the queuing during the cpuidle. Please
give this a try:

===== BEGIN CPUIDLE HACK =====
diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index aca907a62bb5d..1dca9d6defbff 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -226,6 +226,7 @@ static int tegra_cpuidle_adjust_state_index(int index, unsigned int cpu)
 	return index;
 }
 
+extern bool console_irqwork_blocked;
 static __cpuidle int tegra_cpuidle_enter(struct cpuidle_device *dev,
 					 struct cpuidle_driver *drv,
 					 int index)
@@ -238,6 +239,8 @@ static __cpuidle int tegra_cpuidle_enter(struct cpuidle_device *dev,
 	if (dev->states_usage[index].disable)
 		return -1;
 
+	console_irqwork_blocked = true;
+
 	if (index == TEGRA_C1) {
 		if (do_rcu)
 			ct_cpuidle_enter();
@@ -256,6 +259,8 @@ static __cpuidle int tegra_cpuidle_enter(struct cpuidle_device *dev,
 		index = ret;
 	}
 
+	console_irqwork_blocked = false;
+
 	return index;
 }
===== END CPUIDLE HACK =====

John Ogness
