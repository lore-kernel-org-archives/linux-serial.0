Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BECA1F4FB9;
	Mon, 21 Oct 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519885; cv=none; b=qFwE+CZXv5zjsyD4ewEy+TGRxwyeOhhtC9Vz1qjhARaBQHcXzu3uZOI874g9805ruBKYCOgWtDNKcUU5KoyVmGWyAnpRrwiWKxu2Uxr+heYqlIq9SVIi54n/fr63jdjtHA+r6c0QymuFlyoBA/vrqpIswXSJoBx1i9jVySy6h1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519885; c=relaxed/simple;
	bh=b/cW38UmE3Pv76IHe4RPgR096CPrB/Pvt0IRGOkpP/U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jgSsN9HKfXo2ldB6ujay6H2XpHNROud+ROpOo4E2m15jYVMIclr963nB8HJmHzYEd0unNNAaVTcpzBlw8h0sv51YxNtNOf+9Dnnj/OVFbJ6s1uNSlSBDLA2UMp0gPUhcZ18eRTSSGb1bKJyH2i43WgStczU9vY36mZVmBKbB4DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wxpfwnjX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dv0Ajaei; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wxpfwnjX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dv0Ajaei"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729519881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uX3cYUCg0C3YKx6EmlFEipnB4MzYOAQ48LbD1o4kUOs=;
	b=wxpfwnjXqTMfV9S2UECFbZ7QBnCB8nOxPdiMmaIGKniEmliHqLsndr4NxVwDJ2/O5sHQG8
	AQbH0Z3K/dbvv+Ng4c6nM5/ljqDUivc0STxOT/IX1v+0xwv0roFXAuUetD7puY20QH5o7/
	nNIR95PfOuHz8anb1DEBUADi5n4cekNY8VJQtTcGpqHQ1mMq57erlcXUJ72HZAHEwGzlrp
	XqlFQ/W2znK53SE2bl9qB6wPRVKON8Jw7cJMC8J2DKztey/+VVO4bkqNxDgvSh/7rf0A6X
	4UeJXMP8Hy3BB2TVKhftXpqqBufc0ZVHLY4TaNVkmdFCCwDDY7VWD9me1ENP9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729519881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uX3cYUCg0C3YKx6EmlFEipnB4MzYOAQ48LbD1o4kUOs=;
	b=dv0Ajaeim9j8QL4yXE0A+Wmil/cwevlLfy0I5GBbsismvMz9aq3bbC4KB58qgfGPIQkFOp
	PzfpLHKqaNT+HpAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: Introduce LOUD_CON flag
In-Reply-To: <ZxZYKe0t7jWX-_1K@pathway.suse.cz>
References: <20241016-printk-loud-con-v1-0-065e4dad6632@suse.com>
 <20241016-printk-loud-con-v1-1-065e4dad6632@suse.com>
 <84plnz29zv.fsf@jogness.linutronix.de> <ZxDl-VcVAI8DGM40@pathway.suse.cz>
 <847ca5rigk.fsf@jogness.linutronix.de> <ZxZYKe0t7jWX-_1K@pathway.suse.cz>
Date: Mon, 21 Oct 2024 16:17:20 +0206
Message-ID: <8434kpfsvr.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-10-21, Petr Mladek <pmladek@suse.com> wrote:
>> That will not work because migrate_enable() can only be called from
>> can_sleep context. Instead, the migrate_disable()/enable() should be at
>> the few (one?) call sites where printk_loud_console_enter()/exit() is
>> used from task context.
>
> Hmm, if I get it correctly, we could not use migrate_disable() in
> __handle_sysrq() because it can be called also in atomic context,

I am talking about callers of __handle_sysrq() and/or their callers.

For example write_sysrq_trigger() could do:

	migrate_disable();
	__handle_sysrq(c, false);
	migrate_enable();

Or a new wrapper could be introduced for this purpose:

static inline void wrapper handle_sysrq_task(u8 key, bool check_mask)
{
	migrate_disable();
	__handle_sysrq(key, check_mask);
	migrate_enable();
}

A quick grep shows about 25 call sites to check.

> I do not see any easy way how to distinguish whether it was called in
> an atomic context or not.

There is no clean way to do that. If this information is needed, it must
be tracked by the call chain.

> So, I see three possibilities:
>
>   1. Explicitly call preempt_disable() in __handle_sysrq().
>
>      It would be just around the the single line or the help. But still,
>      I do not like it much.

Not acceptable for PREEMPT_RT since sysrq is exposed to external inputs.

>   2. Avoid the per-CPU variable. Force adding the LOUD_CON/FORCE_CON
>      flag using a global variable, e.g. printk_force_console.
>
>      The problem is that it might affect also messages printed by
>      other CPUs. And there might be many.
>
>      Well, console_loglevel is a global variable. The original code
>      had a similar problem.

If disabling migration is not an option for you, this would be my second
choice. I assume tagging too many messages is better than not tagging
enough. And, as you say, this is effectively what the current code is
trying to do.

>   3. Add the LOUD_CON/FLUSH_CON flag via a parameter. For example,
>      by a special LOGLEVEL_FORCE_CON, similar to LOGLEVEL_SCHED.
>
>      I might work well for __handle_sysrq() which calls the affected
>      printk() directly.
>
>      But it won't work, for example, for kdb_show_stack(). It wants
>      to show messages printed by a nested functions.

Right, this has limited usefulness and might miss the important things,
which tend to be within helper functions.

John
