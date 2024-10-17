Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F6579FD
	for <linux-serial@vger.kernel.org>; Thu, 17 Oct 2024 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729160706; cv=none; b=nXSPe+6Zerks8v9p7KxAAYsFBt+4hIQsbXYj2PfiSn+Xi52yzHV+BfkiLd0YiHoQ3sr1j0w+Rsug70PqPye2h+q2nPi5Br/KX8fRxZLpjbcAiDBkHTaeGwX7EiKkMIxqr2t3IDKq6sXSIjlZ7GP9qIVD+/lIOcP0bxvBOFCOCP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729160706; c=relaxed/simple;
	bh=wzQm9l7vk10B6Q3aRSfk9DGql9gEYft85E0xZ4Q5gIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+a6LhnuMDhFK2amfQAU2es6GgPnqt7tO7fIfdkiHcC0BvRZaw3p9g2p3qRQY/2R5vgqGbi9ztPcVlEzhPUlp9etOj3HvABGkBf5SoRO3HoU3CaMWfwR1ulfFogMYr0RZKvp6ZSsGio9YRTElyuKrEBWezmkNSX6tamOeo414pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FkQ5lZ0a; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FkQ5lZ0a"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d43a9bc03so487465f8f.2
        for <linux-serial@vger.kernel.org>; Thu, 17 Oct 2024 03:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729160700; x=1729765500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+fD2TvT8lfWKvBStb2U9gqk1F1YC7TzQtbsVRB7CDAc=;
        b=FkQ5lZ0aKrCDB5AccWl6EiZDBuxe1/2SlQ1+fEwfLEkhxAba6UMkY/d03gG0NKIfYO
         RlklTGxM4JJ//GGpGQXOevYM8HTP6XZW+4KJT8kghoJXR+Uhfl9B/kYCO/0Ryz+O5nIj
         B04fjcwo0JbeujnrVKs59zfa3IHoQTOXD8pPeBhNw8rtUN3ZGuJfjUrCeSG+0RneYxHU
         wl70e7lE2UVsYgYeSKAKrxnKBr9S9yOekmLngk5sWFwbtBMfAtbcZNWAiJCVQP/HEeUG
         wwQg+9tPY0yjfqBPEVo0IOHW5QaEFhedlY6ugzUOTHCD7E9ykbS4f/+MGmsBRWSdDjVv
         r6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729160700; x=1729765500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fD2TvT8lfWKvBStb2U9gqk1F1YC7TzQtbsVRB7CDAc=;
        b=B8mbsekJ/3R7FzgNQ2wYUuUYLq76BkaPr7KD30wPWC4xR9xw9klS+w9mUsjtNnZG9y
         RT4Rjj8QWcm69l0x1AKoKDcN6hVPpZb7nxNpnrRkRpx7/bzwB0mZsu/58nejn7XhL6n6
         kq9tndSGFQ8If0j4aRswPOGUjryosMV9KhqLgW2ATWbKfmlcIzHpaoRi3dLxuTRehokP
         BFj3b79Qgbvcm8lR8Fg8ViIqNDrEHuv+RpX5mL4cXMnBrv6n+IW4xFpuPfThKjKIhMZj
         +UfE3oMBTodIbzRwouJF3KCOV7T6IJdm+RClq2T76G78AgurIUuX49QxOeFL7cL9nhkr
         d+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIhcZLPObq8FHqOmDgNgeARNzp2fAtbVNUy25JcGviPyJDD8OvHQmLj5iau7XyhZXn0nvDvj4UexRD9LU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8EYTwa+36o37TvIRK87cNGEjMtpJUIVJDKHDDUAmphTO3F9ga
	fxcYtxMTAqkjo/z9InlXyH1aNjq7EN2bQ3FM821nzecs3u3r9PWShzYrznOAxq0=
X-Google-Smtp-Source: AGHT+IFrCdkSXRKaos50WfAoTk2LPE39hHwuPO774kwuQO6uDHVKYah63t3uLjq6t164YONxlJZcvg==
X-Received: by 2002:a05:6000:d42:b0:37c:d02a:7e41 with SMTP id ffacd0b85a97d-37d5feab452mr12476044f8f.15.1729160699817;
        Thu, 17 Oct 2024 03:24:59 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc41a15sm6784622f8f.110.2024.10.17.03.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 03:24:59 -0700 (PDT)
Date: Thu, 17 Oct 2024 12:24:57 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: Introduce LOUD_CON flag
Message-ID: <ZxDl-VcVAI8DGM40@pathway.suse.cz>
References: <20241016-printk-loud-con-v1-0-065e4dad6632@suse.com>
 <20241016-printk-loud-con-v1-1-065e4dad6632@suse.com>
 <84plnz29zv.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84plnz29zv.fsf@jogness.linutronix.de>

On Wed 2024-10-16 20:17:48, John Ogness wrote:
> Hi Marcus,
> 
> On 2024-10-16, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> > Introduce LOUD_CON flag to printk.
> 
> Generally speaking, I do not like the name "LOUD_CON". The flag is
> related to records, not consoles. Something like "NO_SUPPRESS" or
> "FORCE_PRINT" might be more appropriate. Note that naming is not my
> strength.

I see. I would prefer to avoid names with double negatives.
So I prefer the "FORCE_PRINT" variant.

That said, I think that "FORCE_CON" might also be good.
Aka, the message forces consoles to show it.

> > The new flag will make it possible to
> > create a context where printk messages will never be suppressed. This
> > new context information will be stored in the already existing
> > printk_context per-CPU variable. This variable was changed from 'int' to
> > 'unsigned int' to avoid issues with automatic casting.
> >
> > This mechanism will be used in the next patch to create a loud_console
> > context on sysrq handling, removing an existing workaround on the
> > loglevel global variable. The workaround existed to make sure that sysrq
> > header messages were sent to all consoles.
> 
> IMO the more interesting aspect is that the "loud" flag is stored in the
> ringbuffer so that the message is not suppressed, even if printed later
> (for example because it was deferred). This actually even fixes a bug
> since the current workaround will not perform as expected if the sysrq
> records are deferred (for example due to threaded printing or consoles
> that are registered later).

Yeah. I think that the fix of this race is the main motivation for
the change. We should make it more clear in the commit message.

> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index beb808f4c367..b893825fe21d 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -1321,6 +1321,7 @@ static void boot_delay_msec(int level)
> >  	unsigned long timeout;
> >  
> >  	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
> > +		|| is_printk_console_loud()
> >  		|| suppress_message_printing(level)) {
> 
> I do not think "loud" should be a reason to skip the delays. The delays
> are there to slow down printing. I would think that for "loud" messages,
> this is even more important. I suppose this function (as well as
> printk_delay()) would need a new boolean parameter whether it is a
> "loud" message. Then:
> 
> 	|| (!loud_con && suppress_message_printing(level))

Yes, this makes more sense.

> > @@ -2273,6 +2274,9 @@ int vprintk_store(int facility, int level,
> >  	if (dev_info)
> >  		flags |= LOG_NEWLINE;
> >  
> > +	if (is_printk_console_loud())
> > +		flags |= LOG_LOUD_CON;
> > +
> >  	if (flags & LOG_CONT) {
> >  		prb_rec_init_wr(&r, reserve_size);
> >  		if (prb_reserve_in_last(&e, prb, &r, caller_id, PRINTKRB_RECORD_MAX)) {
> 
> I guess LOG_LOUD_CON should also be set in the LOG_CONT case (like
> LOG_NEWLINE does).

Great catch! Yes, it would make sense to set it even in the re-opened record.

> > diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
> > index 2b35a9d3919d..4618988baeea 100644
> > --- a/kernel/printk/printk_safe.c
> > +++ b/kernel/printk/printk_safe.c
> > @@ -12,7 +12,30 @@
> >  
> >  #include "internal.h"
> >  
> > -static DEFINE_PER_CPU(int, printk_context);
> > +static DEFINE_PER_CPU(unsigned int, printk_context);
> > +
> > +#define PRINTK_SAFE_CONTEXT_MASK		0x0000ffffU
> > +#define PRINTK_LOUD_CONSOLE_CONTEXT_MASK	0xffff0000U
> > +#define PRINTK_LOUD_CONSOLE_CONTEXT_OFFSET	0x00010000U
> > +
> > +void noinstr printk_loud_console_enter(void)
> > +{
> > +	cant_migrate();
> > +	this_cpu_add(printk_context, PRINTK_LOUD_CONSOLE_CONTEXT_OFFSET);
> > +}
> 
> Have you tested this with lockdep? AFAICT, the write_sysrq_trigger()
> path can migrate since it is only using rcu_read_lock() in
> __handle_sysrq().

Interesting. I have always had connected rcu_read_lock() with
preempt_disable(). But I see that there actually exists preemptive
variant with CONFIG_PREEMPT_RCU. And I guess that preemptive RCU
read lock is a must-to-have on RT.

And indeed:

# echo h >/proc/sysrq-trigger

produced:

[   53.669907] BUG: assuming non migratable context at kernel/printk/printk_safe.c:23
[   53.669920] in_atomic(): 0, irqs_disabled(): 0, migration_disabled() 0 pid: 1637, name: bash
[   53.669931] 2 locks held by bash/1637:
[   53.669936]  #0: ffff8ae680a384a8 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x6e/0xf0
[   53.669968]  #1: ffffffff83f226e0 (rcu_read_lock){....}-{1:3}, at: __handle_sysrq+0x3d/0x120
[   53.670002] CPU: 2 UID: 0 PID: 1637 Comm: bash Not tainted 6.12.0-rc3-default+ #67
[   53.670011] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-2-gc13ff2cd-prebuilt.qemu.org 04/01/2014
[   53.670020] Call Trace:
[   53.670026]  <TASK>
[   53.670045]  dump_stack_lvl+0x6c/0xa0
[   53.670064]  __cant_migrate.cold+0x7c/0x89
[   53.670080]  printk_loud_console_enter+0x15/0x30
[   53.670088]  __handle_sysrq+0x60/0x120
[   53.670104]  write_sysrq_trigger+0x6a/0xa0
[   53.670120]  proc_reg_write+0x5f/0xb0
[   53.670132]  vfs_write+0xf9/0x540
[   53.670147]  ? __lock_release.isra.0+0x1a6/0x2c0
[   53.670172]  ? do_user_addr_fault+0x38c/0x720
[   53.670197]  ksys_write+0x6e/0xf0
[   53.670220]  do_syscall_64+0x79/0x190
[   53.670238]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   53.670252] RIP: 0033:0x7fa4247d9b13
[   53.670269] Code: 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 f3 c3 0f 1f 00 41 54 55 49 89 d4 53 48 89
[   53.670275] RSP: 002b:00007ffe62690f38 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   53.670282] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fa4247d9b13
[   53.670288] RDX: 0000000000000002 RSI: 00005557ac516ec0 RDI: 0000000000000001
[   53.670291] RBP: 00005557ac516ec0 R08: 000000000000000a R09: 0000000000000000
[   53.670295] R10: 00007fa4246da468 R11: 0000000000000246 R12: 00007fa424abd500
[   53.670298] R13: 0000000000000002 R14: 00007fa424ac2c00 R15: 0000000000000002
[   53.670350]  </TASK>
[   53.670358] sysrq: HELP : loglevel(0-9) reboot(b) crash(c) show-all-locks(d) terminate-all-tasks(e) memory-full-oom-kill(f) kill-all-tasks(i) thaw-filesystems(j) sak(k) show-backtrace-all-active-cpus(l) show-memory-usage(m) nice-all-RT-tasks(n) poweroff(o) show-registers(p) show-all-timers(q) unraw(r) sync(s) show-task-states(t) unmount(u) show-blocked-tasks(w) dump-ftrace-buffer(z) replay-kernel-logs(R) 


IMHO, the best solution would be to call migrate_disable()/enable()
in printk_loud_console_enter()/exit().

We should not disable preemption because the output could
be long.

Best Regards,
Petr
