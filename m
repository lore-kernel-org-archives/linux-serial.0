Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665E187FE8;
	Fri, 18 Oct 2024 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235664; cv=none; b=bi6cNk6Hq1Ec3EhrW8qJ8PS+hRD3EDUIf4f8oBLxSZXnw+LNoxvmw1oBCuuZCyhMVvgdU+NamG5rs8p4onezgAutdZb2ZBuFynSC7dpfRss6DiJqKhPPPg8mIxsnXqkjAFcQW24YA9J5Sg8BMxuk9DxKhSp75XVpPOnkgRZRIBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235664; c=relaxed/simple;
	bh=xCAUbdnqvgNV/V6oAIWT+m3/O2zlkGatZfSoz/Xnnhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mOMkwAUKf9ljlq5La0wL7KjMli7DIvcD0+RrhPDBgllyRe+JjLdW3uxQvTXKp5DxXJDiC0pufkqsOKnrDUOcJRIWINHdD9tZvMPgQwOUBFUa3emX5cLXOoReZmusUeHMb1wDmLVDak/mp2q8VDl9YUwbK75Z5D0qwVgdGWAJNSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DDelpabA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xMTGE46Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DDelpabA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xMTGE46Q"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729235660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Z7JsCpFB189JSy0DnbwO4yluBbFguCW7D+UFmq9dhg=;
	b=DDelpabAhrUyYlZ+yz56Bu79pNAk8o0gShQvPSD3iTU8mVHPXnzUfDGayY68bkEu+SGdkQ
	et9yQKTQU23jITDkDcCs1JTsp4br0TWd3hVK0HTbU+ioQnkjnckWxpvrfXw7i/I5bXwvce
	Haf/XfWcTY+4HAr1jYQa1IQ0rTdzqdcFgrcejXQgufKlM18Ir52WVGmrrvdMgVt3McQs4n
	j8914B9WSK1oa+t9/KyYEq9QSPr51ACF3TpR+vde6juplG91qFQiJve60TL2giEu0Gmwxe
	LsGSMvvbjv9qyo+wIThRcZlFBUOVc6l9bFM0CPcFFiezR25G6Pt5d78JMNXu6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729235660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Z7JsCpFB189JSy0DnbwO4yluBbFguCW7D+UFmq9dhg=;
	b=xMTGE46Qxq+mCNBb8Hto5m3Hf/zdqhBW1SlINfm80YgGairf7jg9J4MD+6qSPmXx+Ohf+/
	7NMIrI3HPl5upzAQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: Introduce LOUD_CON flag
In-Reply-To: <ZxDl-VcVAI8DGM40@pathway.suse.cz>
References: <20241016-printk-loud-con-v1-0-065e4dad6632@suse.com>
 <20241016-printk-loud-con-v1-1-065e4dad6632@suse.com>
 <84plnz29zv.fsf@jogness.linutronix.de> <ZxDl-VcVAI8DGM40@pathway.suse.cz>
Date: Fri, 18 Oct 2024 09:20:19 +0206
Message-ID: <847ca5rigk.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-10-17, Petr Mladek <pmladek@suse.com> wrote:
> # echo h >/proc/sysrq-trigger
>
> produced:
>
> [   53.669907] BUG: assuming non migratable context at kernel/printk/printk_safe.c:23
> [   53.669920] in_atomic(): 0, irqs_disabled(): 0, migration_disabled() 0 pid: 1637, name: bash
> [   53.669931] 2 locks held by bash/1637:
> [   53.669936]  #0: ffff8ae680a384a8 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x6e/0xf0
> [   53.669968]  #1: ffffffff83f226e0 (rcu_read_lock){....}-{1:3}, at: __handle_sysrq+0x3d/0x120
> [   53.670002] CPU: 2 UID: 0 PID: 1637 Comm: bash Not tainted 6.12.0-rc3-default+ #67
> [   53.670011] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-2-gc13ff2cd-prebuilt.qemu.org 04/01/2014
> [   53.670020] Call Trace:
> [   53.670026]  <TASK>
> [   53.670045]  dump_stack_lvl+0x6c/0xa0
> [   53.670064]  __cant_migrate.cold+0x7c/0x89
> [   53.670080]  printk_loud_console_enter+0x15/0x30
> [   53.670088]  __handle_sysrq+0x60/0x120
> [   53.670104]  write_sysrq_trigger+0x6a/0xa0
> [   53.670120]  proc_reg_write+0x5f/0xb0
> [   53.670132]  vfs_write+0xf9/0x540
> [   53.670147]  ? __lock_release.isra.0+0x1a6/0x2c0
> [   53.670172]  ? do_user_addr_fault+0x38c/0x720
> [   53.670197]  ksys_write+0x6e/0xf0
> [   53.670220]  do_syscall_64+0x79/0x190
> [   53.670238]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> IMHO, the best solution would be to call migrate_disable()/enable()
> in printk_loud_console_enter()/exit().

That will not work because migrate_enable() can only be called from
can_sleep context. Instead, the migrate_disable()/enable() should be at
the few (one?) call sites where printk_loud_console_enter()/exit() is
used from task context.

This is also how printk_deferred_enter()/exit() works, relying on the
caller to disable migration if necessary.

John
