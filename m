Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B28273805
	for <linux-serial@vger.kernel.org>; Mon, 29 Sep 2025 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135217; cv=none; b=rGuHpjqgbX/Q7T6s439dQxyh0biN/sKGgyr54xvYFIpeCjZ54xQ2PYeZOLQrYnzzUMRcASG/VA+Lcyd6e9CbmCpAHPOGxSXNPGv/EdHaeNZdVbd4A2sNxLYhsHWyy2ZyKv+pgpxDkJ1A3kY6/KaorcpRNVm72jOYz8CuenZvexw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135217; c=relaxed/simple;
	bh=/vU3axIjTRmEvmNvhaARoMrLo54CT8EBIvYVAdhrkBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVhIEV1IRqj94KIQoZbVsqAgHDQ0Ue8uEvv+idxK8ArLf7UG123yvR15H1+qUZ3FrQE6k2ckeD9CzRGNXYND45yUSMweQty0NgicCsegyL8WG4qkzF3056Bvgb+N/X9Cm5j0HcDcEWcSfnreCVmIDkNzH4vO9icXiFTMvv0RpbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=WprTBntY; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="WprTBntY"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-91179e3fe34so164418239f.1
        for <linux-serial@vger.kernel.org>; Mon, 29 Sep 2025 01:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1759135214; x=1759740014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PCYyCdPY4pLZwGknO/yFiSab1vr2MfF6oEDxyAFa5wA=;
        b=WprTBntYxtgNHUg1ugc/NyyA148H9eAp5WWnyW4LfeC5bp69VGfjneRT9tNzC2CuHb
         QWl1ZJMsrPEyaOM40wTKhTwY9G9cPbBnJZVYSBKbM3uOA0PKkYTu/6kY6EH8X5cqxjUb
         jk4fQBbPYi8ZSbZoNBE7OaOeeAaHMZkvC5055yBfVeP883D2B9M/vV/YLxZnM7ePj9Bv
         qwJe6+RkSy10gsCbb7liq86qk5sfahcU7raIBoG2dO6ihPQtCHxI32rR75k3rryLeZ1s
         Y9AxZBGNQf92znRO8DuYkofy3Jkq+gk0uuWLWWHVgOJyA5UhYrjC3ib85EKHU3GN0T6x
         iQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759135214; x=1759740014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCYyCdPY4pLZwGknO/yFiSab1vr2MfF6oEDxyAFa5wA=;
        b=QnV6X/pjxjMfSOQFEsOuZiwetOG8WB39EZREFu+FP7nFlLI30ok38o7fdZR9HObKeP
         +x70liNSLIfwjHZxvDVsUF+HSB1z24p/mAkAc2S54lQj6PRD+eG9eNBZlR59Hl2Sqn0o
         B7QQQbi4hqDJ6inbsLMFcHW0MDadu022KAQ2FK9QFeT0DgoJiJnWb2K7AG8ycEvfLgci
         CTiWILADQuSVt/PNWE49a0PLMLEokdJZ8i+emWwxytdkb1XHXFbHn0yOcWDtVNpbqbOV
         TSGHAcdiyVPxq6Fm/WEBVZtQKJ4P09L2ss2F7jDYELw4Z1ubq6WFfPDcBZwlL8xC+E/W
         rJuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT3oylVXSHZCKMVzCK7JY90Q9q7x4HwtO/iqj9ZCk9QY1WKOSHxQAWTpp2lcMS7D0kPCKKCumyJiznEaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2n0Y5LovPUGbml77fnjfpYBJqYwDpgN9HoVmRexQxz8Jw3MGF
	OJeUSiM2jIkrixNSQOAIAY6X+Y8xxR3oKkJN1UFhvCmcjHBn+GRji+9AmtyHA5a3GriQqQOgOBc
	F4ktOE3rjpCgOX4EIsaGeJWqtxZf58NEUfYOK9A0oIA==
X-Gm-Gg: ASbGnct+G8mjU2QHjceHCG745loWKS3LD6qgC5CZ8z95J5UgUwlsoC1aszeFDYMyVlT
	qTmpgeDS6oG5tJVnA/cSPUH8o5A5Z1HoOLXTtmEtYCShAfpP10MYLngrNSszCqTdt+U17bvRs43
	giy3m7pNjb2YDl/hRfvJFN/IPSDQCyu50LYbqSdhKgR/7X0wkbELif+qRzyI1icwEzCtbytgU8w
	M+85w3qZxIrXP7k6xG+VXF2T2882eVsAQE6KOkk
X-Google-Smtp-Source: AGHT+IHQtcDvH2C7e4+MP2jPAJbNMI89b/DTmyExpG5QhdiDmz9e0af/TgeRnMwKo6Uav5ZTT8Ovwftn+mQhkWt370A=
X-Received: by 2002:a05:6e02:16c5:b0:422:a9aa:7ff4 with SMTP id
 e9e14a558f8ab-425c2a27af1mr188988605ab.11.1759135214127; Mon, 29 Sep 2025
 01:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926124912.243464-1-pmladek@suse.com> <20250926124912.243464-2-pmladek@suse.com>
In-Reply-To: <20250926124912.243464-2-pmladek@suse.com>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Mon, 29 Sep 2025 09:40:03 +0100
X-Gm-Features: AS18NWCff_9PhMTvCu-j89Lfkx-I2AQxTzbVUdJaLNdrn0zjHo0LmnaiAIS2LGE
Message-ID: <CALqELGzia2BObxPuDPiH-3HSDAf+r6HWmpD+iFAr+v22QGwoTw@mail.gmail.com>
Subject: Re: [PATCH 1/3] printk/nbcon: Block printk kthreads when any CPU is
 in an emergency context
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Tony Lindgren <tony@atomide.com>, Niklas Schnelle <schnelle@linux.ibm.com>, 
	Serge Semin <fancer.lancer@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Sept 2025 at 13:50, Petr Mladek <pmladek@suse.com> wrote:
>
> In emergency contexts, printk() tries to flush messages directly even
> on nbcon consoles. And it is allowed to takeover the console ownership
> and interrupt the printk kthread in the middle of a message.
>
> Only one takeover and one repeated message should be enough in most
> situations. The first emergency message flushes the backlog and printk
> kthreads get to sleep. Next emergency messages are flushed directly
> and printk() does not wake up the kthreads.
>
> However, the one takeover is not guaranteed. Any printk() in normal
> context on another CPU could wake up the kthreads. Or a new emergency
> message might be added before the kthreads get to sleep. Note that
> the interrupted .write_kthread() callbacks usually have to call
> nbcon_reacquire_nobuf() and restore the original device setting
> before checking for pending messages.
>
> The risk of the repeated takeovers will be even bigger because
> __nbcon_atomic_flush_pending_con is going to release the console
> ownership after each emitted record. It will be needed to prevent
> hardlockup reports on other CPUs which are busy waiting for
> the context ownership, for example, by nbcon_reacquire_nobuf() or
> __uart_port_nbcon_acquire().
>
> The repeated takeovers break the output, for example:
>
>     [ 5042.650211][ T2220] Call Trace:
>     [ 5042.6511
>     ** replaying previous printk message **
>     [ 5042.651192][ T2220]  <TASK>
>     [ 5042.652160][ T2220]  kunit_run_
>     ** replaying previous printk message **
>     [ 5042.652160][ T2220]  kunit_run_tests+0x72/0x90
>     [ 5042.653340][ T22
>     ** replaying previous printk message **
>     [ 5042.653340][ T2220]  ? srso_alias_return_thunk+0x5/0xfbef5
>     [ 5042.654628][ T2220]  ? stack_trace_save+0x4d/0x70
>     [ 5042.6553
>     ** replaying previous printk message **
>     [ 5042.655394][ T2220]  ? srso_alias_return_thunk+0x5/0xfbef5
>     [ 5042.656713][ T2220]  ? save_trace+0x5b/0x180
>
> A more robust solution is to block the printk kthread entirely whenever
> *any* CPU enters an emergency context. This ensures that critical messages
> can be flushed without contention from the normal, non-atomic printing
> path.
>
> Link: https://lore.kernel.org/all/aNQO-zl3k1l4ENfy@pathway.suse.cz
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/printk/nbcon.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index d5d8c8c657e0..08b196e898cd 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -117,6 +117,9 @@
>   * from scratch.
>   */
>
> +/* Counter of active nbcon emergency contexts. */
> +atomic_t nbcon_cpu_emergency_cnt;
> +
>  /**
>   * nbcon_state_set - Helper function to set the console state
>   * @con:       Console to update
> @@ -1168,6 +1171,16 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
>         if (kthread_should_stop())
>                 return true;
>
> +       /*
> +        * Block the kthread when the system is in an emergency or panic mode.
> +        * It increases the chance that these contexts would be able to show
> +        * the messages directly. And it reduces the risk of interrupted writes
> +        * where the context with a higher priority takes over the nbcon console
> +        * ownership in the middle of a message.
> +        */
> +       if (unlikely(atomic_read(&nbcon_cpu_emergency_cnt)))
> +               return false;
> +
>         cookie = console_srcu_read_lock();
>
>         flags = console_srcu_read_flags(con);
> @@ -1219,6 +1232,13 @@ static int nbcon_kthread_func(void *__console)
>                 if (kthread_should_stop())
>                         return 0;
>
> +               /*
> +                * Block the kthread when the system is in an emergency or panic
> +                * mode. See nbcon_kthread_should_wakeup() for more details.
> +                */
> +               if (unlikely(atomic_read(&nbcon_cpu_emergency_cnt)))
> +                       goto wait_for_event;
> +
>                 backlog = false;
>
>                 /*
> @@ -1660,6 +1680,8 @@ void nbcon_cpu_emergency_enter(void)
>
>         preempt_disable();
>
> +       atomic_inc(&nbcon_cpu_emergency_cnt);
> +
>         cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
>         (*cpu_emergency_nesting)++;
>  }
> @@ -1674,10 +1696,18 @@ void nbcon_cpu_emergency_exit(void)
>         unsigned int *cpu_emergency_nesting;
>
>         cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
> -
>         if (!WARN_ON_ONCE(*cpu_emergency_nesting == 0))
>                 (*cpu_emergency_nesting)--;
>
> +       /*
> +        * Wake up kthreads because there might be some pending messages
> +        * added by other CPUs with normal priority since the last flush
> +        * in the emergency context.
> +        */
> +       if (!WARN_ON_ONCE(atomic_read(&nbcon_cpu_emergency_cnt) == 0))
> +               if (atomic_dec_return(&nbcon_cpu_emergency_cnt) == 0)
> +                       nbcon_kthreads_wake();
> +
>         preempt_enable();
>  }
>
> --
> 2.51.0
>

Reviewed-by: Andrew Murray <amurray@thegoodpenguin.co.uk>

Thanks,

Andrew Murray
