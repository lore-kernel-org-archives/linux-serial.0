Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2D61F76C1
	for <linux-serial@vger.kernel.org>; Mon, 21 Oct 2024 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517615; cv=none; b=PxT1wsXv1uI5JObB+uazX8KcWT8x1bt/AQYutOmvn/xw7vTxhW2oYtl9/YccX2seYgA4iF1Qx++lg7c1/qCq6GpwmWeVCliBU0layVQdslejS7hyDh9GnvpiRAm2P0LxsIRfjQvvzQVBK2kXHKa44hdhN6qPo7CttA/nlTvFjk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517615; c=relaxed/simple;
	bh=Xz7FfdVN7zd3+jJtg9M19VBDU7kqZSw49biDmvDmB0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8f48bakfdSEQ1mC7R4gfDaFiW5gciNYpNI3NOWn45XHwtyr+yQo5ADf/LqQX80k+AR1wua50R+P7EoXI3vcaSMDQD+ldpTZ8KUwlERqUwBvhgZmXt2qhbcddpufKVW+nyPDxoNZ0iDcZcVYQ3UbaUb/ixDBXW0dSmTre/hT3x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UlNBehwf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UlNBehwf"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so46078305e9.1
        for <linux-serial@vger.kernel.org>; Mon, 21 Oct 2024 06:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729517611; x=1730122411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bmMrC2OzRPqpFSTohNG2UKX+gtED3pFdgQ93RqnjCxA=;
        b=UlNBehwfqu3XQ2jJZEePtexeGYnSItLCc+cGxeqA2D3J+gytQ3vf0mE/y3NwMKnGHF
         aTLuaBMzEyhn63Ev4jroLc1vhAhngqMtOIU715r0g1/LX9ynEIESTeFECm1qrbbZmlsF
         97r8DO+a26loZcsyQg/4t77HvHUU5XocwzSVUmXwZrgItEpWTJiJ/J15tpWWuHFWCvNN
         JrCeuAJ83e+AGiIeK2fxnaV6Lsx/qS93sdFXisIm1ubNqut8aUHcoijQ62VsAdp+uBtz
         LFEPlHXbkchUp1szBgA+PFeVH8F8tdHyF+fEGO22Y0WGhI97EMcskPEj33TQ59Y2RzkX
         u+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517611; x=1730122411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmMrC2OzRPqpFSTohNG2UKX+gtED3pFdgQ93RqnjCxA=;
        b=geec4dUIt46+nR9NGAuvMHSjTWruUgNpgM6lswmYdyMIAqYv8/JGMiija6IGmT9B8r
         6wMp+UFJ9RI8QxEMP4onlHK6WqUrf8GNJOzzBCfwSPz/3So5XmKEIVH3bxR/bF4IexoY
         90q9wvqa0WKdsEf1xwWo1MD1h0GzWxdRyBt3o/xWfUGtGVo5IYlRa31r9Tu21ioOaso/
         XwqygDrV0SDyVq3USmphBTccFJYLdhn2EXitc/4sgEtd5pyMiqBEdU0L7ct6T+4MESfl
         zzs+07i8HDmncnsHWxX1yWxv6ZEaZJA56uULrQKz0oTky5QLvYTxJmUE1xg9Mzv3nGSv
         mGPg==
X-Forwarded-Encrypted: i=1; AJvYcCXIZuCkFCptMocSIdJmROChizCVTb9Q0Q2eDoBcN9+SLyTmXuPlU8QodIXyhZak0o7Ebeh9j7ieUlCNKqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMdWx68x948bmih/iIPt5bFtUxlhpsovy7hbxHq7CwjJ7Fs6R9
	oODffcxE4lY6qmqypxsokqQl0uhd/MkFp8AIE4MgR4timtxNqZ1J1UPaAafjXtIr4Qr0V6D3Csz
	x
X-Google-Smtp-Source: AGHT+IEfW+CIBn8UHEt/2gvUUws+y1TH4gv5C41keK7p1Je1zfNoB3sebbL4+7gAW8SjEaUa8T3WZg==
X-Received: by 2002:a05:600c:1e26:b0:431:51a9:e956 with SMTP id 5b1f17b1804b1-4317b8d64femr85275e9.1.1729517611196;
        Mon, 21 Oct 2024 06:33:31 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c2b46sm57705055e9.36.2024.10.21.06.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:33:30 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:33:29 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: Introduce LOUD_CON flag
Message-ID: <ZxZYKe0t7jWX-_1K@pathway.suse.cz>
References: <20241016-printk-loud-con-v1-0-065e4dad6632@suse.com>
 <20241016-printk-loud-con-v1-1-065e4dad6632@suse.com>
 <84plnz29zv.fsf@jogness.linutronix.de>
 <ZxDl-VcVAI8DGM40@pathway.suse.cz>
 <847ca5rigk.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <847ca5rigk.fsf@jogness.linutronix.de>

On Fri 2024-10-18 09:20:19, John Ogness wrote:
> On 2024-10-17, Petr Mladek <pmladek@suse.com> wrote:
> > # echo h >/proc/sysrq-trigger
> >
> > produced:
> >
> > [   53.669907] BUG: assuming non migratable context at kernel/printk/printk_safe.c:23
> > [   53.669920] in_atomic(): 0, irqs_disabled(): 0, migration_disabled() 0 pid: 1637, name: bash
> > [   53.669931] 2 locks held by bash/1637:
> > [   53.669936]  #0: ffff8ae680a384a8 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x6e/0xf0
> > [   53.669968]  #1: ffffffff83f226e0 (rcu_read_lock){....}-{1:3}, at: __handle_sysrq+0x3d/0x120
> > [   53.670002] CPU: 2 UID: 0 PID: 1637 Comm: bash Not tainted 6.12.0-rc3-default+ #67
> > [   53.670011] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-2-gc13ff2cd-prebuilt.qemu.org 04/01/2014
> > [   53.670020] Call Trace:
> > [   53.670026]  <TASK>
> > [   53.670045]  dump_stack_lvl+0x6c/0xa0
> > [   53.670064]  __cant_migrate.cold+0x7c/0x89
> > [   53.670080]  printk_loud_console_enter+0x15/0x30
> > [   53.670088]  __handle_sysrq+0x60/0x120
> > [   53.670104]  write_sysrq_trigger+0x6a/0xa0
> > [   53.670120]  proc_reg_write+0x5f/0xb0
> > [   53.670132]  vfs_write+0xf9/0x540
> > [   53.670147]  ? __lock_release.isra.0+0x1a6/0x2c0
> > [   53.670172]  ? do_user_addr_fault+0x38c/0x720
> > [   53.670197]  ksys_write+0x6e/0xf0
> > [   53.670220]  do_syscall_64+0x79/0x190
> > [   53.670238]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > IMHO, the best solution would be to call migrate_disable()/enable()
> > in printk_loud_console_enter()/exit().
> 
> That will not work because migrate_enable() can only be called from
> can_sleep context. Instead, the migrate_disable()/enable() should be at
> the few (one?) call sites where printk_loud_console_enter()/exit() is
> used from task context.

Hmm, if I get it correctly, we could not use migrate_disable() in
__handle_sysrq() because it can be called also in atomic context,
for example:

  + pl010_int()
    + pl010_rx_chars()
      + uart_handle_sysrq_char()
	+ handle_sysrq()
	  + __handle_sysrq()

I do not see any easy way how to distinguish whether it was called in
an atomic context or not.

So, I see three possibilities:

  1. Explicitly call preempt_disable() in __handle_sysrq().

     It would be just around the the single line or the help. But still,
     I do not like it much.


  2. Avoid the per-CPU variable. Force adding the LOUD_CON/FORCE_CON
     flag using a global variable, e.g. printk_force_console.

     The problem is that it might affect also messages printed by
     other CPUs. And there might be many.

     Well, console_loglevel is a global variable. The original code
     had a similar problem.


  3. Add the LOUD_CON/FLUSH_CON flag via a parameter. For example,
     by a special LOGLEVEL_FORCE_CON, similar to LOGLEVEL_SCHED.

     I might work well for __handle_sysrq() which calls the affected
     printk() directly.

     But it won't work, for example, for kdb_show_stack(). It wants
     to show messages printed by a nested functions.


I personally prefer the 2nd variant. It fixes the problem and it
should not make things worse.

Best Regards,
Petr
