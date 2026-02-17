Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B531A238C;
	Tue, 17 Feb 2026 02:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771294472; cv=none; b=I5Ln3LlzfixQnGR+1rOs6vMDqzYrfgeC/gaGWdKK+nzY95OnLZkdbDOUI6EkO7VADUNUiQJyR+DAs7ZckHhwMFYDfFtU5N1suCdiKSzhJb+9Inrs4jKfnatppEWPXneh0UybCRCeM3DsSem5RsYt3QSuz+VcWPKEuRBnWUQpgJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771294472; c=relaxed/simple;
	bh=WuNo0hyEI/y/3r2N2k5bIroJMhjaGh7DQxU3V52yWLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NqJzBPA89vlJ9GWpmohCDvXU4MNOvrM791u4LkxkuaUXWFc72p4QYi5KzHmuRhUNfhuFf2D26T67HG5MiPXT6TBMXhdRS0iNrh3nFXkrwAng7p9AbbvrKUIjRZ87VFmA1vhBS/qL6GgB9W9BtUhCIS6IrkwpRjqQtxlot7at28U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GQtiPvJJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NoY6/D6k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GQtiPvJJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NoY6/D6k"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771294464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=TvU4/TcpH+A/DNluEe92TPtsDcT+c9aV1pmx/XjYkaA=;
	b=GQtiPvJJgQjrSYNfWp5pgGwGXHTYfBvUprvFhNebifhiFva6ckvzTxokou2jah9Y01UdZ4
	iOs+KrhuJuzX+6Cj76IM3Ixfud66rZLmOS1mqg2vN0bV03dYJeF5ZTze+4p9t63oSZfkbw
	ptGYClJPTPvFhH37GW4IZz6ogaNhjMXqeLXIVnNUyEtOoEE2lPSxAg7g4eiokDt+TpD/tW
	hW1YUuDg/C+b/aYMq3ZghUi1JybsAPSfaZFP2C9DmVuzVY5DsE+F9BYXBqnAADGSKslcmU
	It4ZBFlM3kI1caPzZtw2GRygsJ0u9o6FRAQx2BHx9i5nfPgifp0Sdj3K4hvnIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771294464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=TvU4/TcpH+A/DNluEe92TPtsDcT+c9aV1pmx/XjYkaA=;
	b=NoY6/D6kiyoiFPBYYzdLCpy/3HjOGFjiYS/GpHEdHkNFJOBcxZeSoyS1qt6Z0LlXsEbEO3
	pkXnXh7EMbh80tDw==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Nicolas Pitre <npitre@baylibre.com>, Calixte
 Pernot <calixte.pernot@grenoble-inp.org>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: printk, vt: sleep from invalid context bug
Date: Tue, 17 Feb 2026 09:14:12 +0700
Message-ID: <87v7fwdsln.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Since commit 1bc9a28f076f ("printk: Use console_flush_one_record for
legacy printer kthread"), I see this warning:

BUG: sleeping function called from invalid context at kernel/printk/printk.c:3431
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 14, name: pr/legacy
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
4 locks held by pr/legacy/14:
 #0: ffffffff807dcdf0 (console_lock){+.+.}-{0:0}, at: legacy_kthread_func+0x40/0x114
 #1: ffffffff807dce30 (console_srcu){....}-{0:0}, at: console_flush_one_record+0x0/0x3c8
 #2: ffffffff8083af88 (printing_lock){+.+.}-{3:3}, at: vt_console_print+0x48/0x330
 #3: ffffffff807df2e8 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x24/0x138
CPU: 0 UID: 0 PID: 14 Comm: pr/legacy Not tainted 6.19.0-rvvm-09292-g7449f86bafcd #79 PREEMPT_RT 
Hardware name: RVVM v0.7-git-g8c45ccf (DT)
Call Trace:
    walk_stackframe+0x0/0x80
    dump_stack_lvl+0x4e/0x74
    rt_spin_trylock+0x9e/0x138
    __might_resched+0x19e/0x1e0
    fbcon_redraw+0x74/0x1a0
    fbcon_scroll+0xf2/0x13c
    con_scroll+0x122/0x188
    lf+0x6a/0x74
    vt_console_print+0x2ac/0x330
    console_flush_one_record+0x208/0x3c8
    console_flush_one_record+0x3c4/0x3c8
    kthread+0xc6/0x100
    legacy_kthread_func+0x4c/0x114
    prio_changed_stop+0xc/0x10
    kthread+0xc6/0x100
    ret_from_fork_kernel_asm+0x12/0x18
    ret_from_fork_kernel+0xe/0x3fc
    rt_spin_unlock+0x56/0x128
    kthread_affine_node+0x88/0x8c
    ret_from_fork_kernel_asm+0x12/0x18

If I understand it correctly, vt_console_print() grabs the spin lock
"printing_lock", and then calls fbcon_redraw() which does
console_conditional_schedule(), triggering the warning.

Nam
