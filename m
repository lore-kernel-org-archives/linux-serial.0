Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC16E41836E
	for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345418; cv=none; b=m2ve8FmzZ9Nq1y7U1sniugjSS7k3xkN6b9/bSu+zIl+l3p/zmxRRMyiZKjHM8Tnw8W8fGq5e+1PJbRJ8AH/dh1byjGSbxQmDf6PFTN3uZNv3I8cW9/YoqIwm6pmVnbZk7giSpeMhlY0dodermeBS/yhtcgpiEISzOIxgIdn/lb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345418; c=relaxed/simple;
	bh=BS8deKBe8YylbXCiat/0G6yEZV3rWMqa9pDpmgUJ+6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/buVErKmM6SO0RVjNFl5F8/j2Un5dEcwE1v6icf3Gibj4yfhZZwSmlsce9mgSN7041IRcldtLmwz5Vhw2pnUjU784ZMCi42+wAa9MrbPsX8+A99cvc0sVvgCah/JJOlyK+Gz6dWq2QkEIi7TtkOWRlOTULJKDgr3bhdS7ISKl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IuPkftOV; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IuPkftOV"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48877902c99so789351f8f.2
        for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 07:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790345415; x=1790950215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5EozD17rD10z9YERFiVN6ETD514MdqE8+77HcfpzGcs=;
        b=IuPkftOVLungDwHy63VfdOl/+QgRNiZJBAT0QJjK9vv9xcle2AZeE0glQHkd7/u+fd
         gBPGZ/4otVBG6KicOGJVcYgozqmd8rn+Le72ZKo4khW6Tp7P6CATbJ3hCgBRXmsVt7YX
         9UNmmo335e1vm13xnDRgeEOhLPYPMR4mj2ilG2lhmKpm+E9RuCNwM+xU2NFhRM9KnPbU
         CtMM1ZUrIvYaOfyJg0Yd+7829TDc9IqMc5cr8tN+PtMRb1ScbZgd1qG0Vl1ssjlZ639M
         ry2hbjRvXsYbwQFO4lPShAD42BEI/HA79qiIF6WApZ2cVYyIkqdrwKjeDkas/ZuAnAhv
         so3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790345415; x=1790950215;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5EozD17rD10z9YERFiVN6ETD514MdqE8+77HcfpzGcs=;
        b=ZPBd+kroy76WWylivHDppLDIFzKgN/mSgxgcDPyAceZa6pPVaGCFx8G85Lp6axd6CG
         m99ikJq3qKZRdhDeWpIk/VX/xKS+cEj0MqtEoTxkljbL2uQ3ogyBd2Luvyn7N9vr9Qqa
         XYKCWG1L5JTrAqv3egKq+/DspSRIuDWSiNEwh1yUvn3TMUDRvYwq2vBNKFVdzfjIgMEp
         elFV9g8kgk0J6J6e/N5ezP5OeeIUL3ok3Olz2XDyWcZ6tKs4OLSccekKkqpwD0jm7myW
         OWrR2VOEqvodwiI6OqOnGl1A+jwJiiubrSDqd03RUP9YJwDYkC4jzFGAvMhc6t4ob7xP
         /WkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwNWv7dx1MxTcxt5lQgMGOECu/wnmlHCEI7QSG/CMDpzpO7co1sGCALlhYAqcNxQELKwUar3mo8H6LhoGE=@vger.kernel.org
X-Gm-Message-State: AFuF++nt/mnNHTV3UG6IRqcZU7DiQrRsnjiHJIX2M9rkKETrQ9Yr13mE
	G2J/ag4Skx0k7ozc2sjusxGSR59xqmHL5kM4/jb/adKQ2JdLCae8C87o5MtkdXgrKIA=
X-Gm-Gg: AYBFou13mq/FL/t6YOWGpaTbZ4ja2GKCEEOnKIawaVcCdagjLfbM9LXroMoQ3zpUjQp
	ClMkWsE0Dbkf4EH5ATGJlLUs8W1pihL3ap/gb0XxmKcty9RJgNQTI6mSX6hBp4m43G+kOWlo+cU
	3AtIFyHg1bWLxOn4e/XexSxG+cbqiMHyzoDVoIVilZKT/7Ec+Xk7+3NLeC5/8uHFMfehsxOQZG0
	VNqhhvbzMmd2NqSAqQP4lJ8UhSPNXDS9dAei/cvG/S/5A2ycP0kj7MdEn4YHzUkBHY5kQHlR0zY
	+CBXTD8UVoykPZcY8BBY2PK3xdGCaW79ewLjmlEC2gsdUxPObw+K3S7NQHZC3zmQKt8VibfOqgV
	oC2SkAI2DneG/xRR2dB1bXzQwhQ3ZqM/MHRGLM2JkZzDS4EdVT9vhzV3bsI77wh7LX/QbbbunP4
	XfrUf1pNDJCEHlk6JMkXGGfmtGHAKPA16QcnnXuvx+UUuFpBCoICkSywuOPyIVRbt3ee7VJOin
X-Received: by 2002:a05:6000:2486:b0:487:27f9:829 with SMTP id ffacd0b85a97d-488716f6ec2mr11119206f8f.30.1790345414609;
        Fri, 25 Sep 2026 07:10:14 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a746c57sm6908032f8f.35.2026.09.25.07.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:10:14 -0700 (PDT)
Date: Fri, 25 Sep 2026 16:10:06 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Fushuai Wang <wangfushuai@baidu.com>, Kees Cook <kees@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>, linux-serial@vger.kernel.org,
	Manuel Lauss <manuel.lauss@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] braille: nbcon: Allow using a serial driver
 converted to nbcon API as a Braille console
Message-ID: <araAvkIB5XatHPNk@pathway.suse.cz>
References: <20260922072558.98854-1-pmladek@suse.com>
 <87ik3tiim7.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ik3tiim7.fsf@jogness.linutronix.de>

On Fri 2026-09-25 15:14:16, John Ogness wrote:
> On 2026-09-22, Petr Mladek <pmladek@suse.com> wrote:
> > I have been working on v5 [1] of the patchset cleaning console registration
> > code and I found that the system did not boot when I selected a Braille
> > on the command line, for example:
> >
> >      console=brl,ttyS0,115200 console=tty0
> >
> > Bisection went down to the commit d3539347022a ("serial: 8250: Switch to
> > nbcon console, take 2"). I found that the Braille console driver called
> > braille_co->write() internally where braille_co pointed to the uart
> > 8250 driver.
> 
> The Braille console blindly calling (struct console).write() is
> obviously bad. This needs to be fixed. And not just because of the
> 8250. Other NBCON drivers already exist mainline and have this same
> issue.
> 
> > I added the support for the nbcon console API similar way as we did
> > for kdb [2].
> 
> kdb does not need to care about latencies. The Braille consoles do. I
> will comment more on this in the related patch.
> 
> > Note 1: I believe that we have a bug in the kdb patch because we call
> >         con->write() atomic callback after entering the unsafe mode.
> >         But we should do so in the default "safe" mode.
> 
> Why do you believe this? kdb operates within an unsafe section so that
> other CPUs cannot take ownership. (BTW: For kdb the other CPUs are
> supposed to be quiesced, so there should not be any ownership attempts
> anyway. The unsafe section is just an extra precaution.)

It is safe from the kdb context POV. But it is not right from the API
POV. The API does not suport nested unsafe section, so the following
happens:

  kdb_msg_write()

	nbcon_kdb_try_acquire(c, &wctxt);
	// on success: nbcon acquired, entered unsafe context
	c->write_atomic(c, &wctxt);

		serial8250_console_write()
			nbcon_enter_unsafe()
			// nested unsafe context
			nbcon_exit_unsafe(wctxt);
			// the nbcon context is marked as safe
			return;

	// the nbcon context is marked as save even though
	// kdb_msg_write() did not call nbcon_exit_unsafe()
	// which might lead to bugs

As you say, it is not a real problem here in the kdb code
because other CPUs are stopped. But it is an error prone pattern.
IMHO, we have already talked about adding warnings to catch nested
nbcon_enter_unsafe()/nbcon_exit_unsafe() calls.


> > Note 2: I am not completely sure about the locking. It might be better
> >         to use NBCON_PRIO_PANIC in panic().
> 
> Why does it matter? printk() is not trying to do any Braille printing
> during panic, so it will not attempt to acquire the Braille console.

The Braille console show exactly what the graphical console show.
It shows printk() messages when ttyX is registered as a console.

> >       Also I thought about using con->write_thread(). But I think
> > 	that we have to use the atomic variant because the Braille
> > 	console can be called from printk() via the VT code, aka
> > 	graphical console.
> 
> How can it be called from printk()? Even printk() writing to VT is only
> if it is registered as a console. Braille consoles are not registered.
> Please explain.

I have added WARN_ON() into braille_write() and got this:

[    0.069344] WARNING: drivers/accessibility/braille/braille_console.c:115 at braille_write+0x231/0x300, CPU#0: swapper/0/0
[    0.069352] Modules linked in:
[    0.069355] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.2.0-rc5-default+ #139 PREEMPT(full)  db5f4527e6a3b5c4863452c3023f648284afb38d
[    0.069358] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-2-g4f253b9b-prebuilt.qemu.org 04/01/2014
[    0.069359] RIP: 0010:braille_write+0x231/0x300
[    0.069362] Code: 71 02 41 83 c8 40 44 88 06 48 8d 56 02 c6 46 01 02 41 f6 42 49 01 0f 84 98 00 00 00 49 83 ba 80 00 00 00 00 0f 84 b0 00 00 00 <0f> 0b 48 8d 74 24 5a 48 8d 7c 24 08 29 f2
 e8 2c d2 08 ff 48 8b 3d
[    0.069363] RSP: 0000:ffffffffaf603b78 EFLAGS: 00010086
[    0.069365] RAX: ffffffffb15c2e70 RBX: ffffffffb15c2e20 RCX: ffffffffaf603bfb
[    0.069366] RDX: ffffffffaf603bfe RSI: ffffffffaf603bfc RDI: 0000000000000020
[    0.069367] RBP: 00000000ffffffff R08: 0000000000000045 R09: ffffffffb15c2e70
[    0.069367] R10: ffffffffaf9f5a20 R11: 0000000000000000 R12: 0000000000000000
[    0.069368] R13: 0000000000000003 R14: ffffffffaf603ce8 R15: ffffffffafa33930
[    0.069371] FS:  0000000000000000(0000) GS:ffff8d04287a1000(0000) knlGS:0000000000000000
[    0.069372] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.069373] CR2: ffff8d03fffff000 CR3: 000000000b656000 CR4: 00000000000100b0
[    0.069376] Call Trace:
[    0.069377]  <TASK>
[    0.069378]  ? check_prev_add+0xf2/0xe40
[    0.069392]  ? lock_acquire.part.0+0xc5/0x230
[    0.069394]  ? atomic_notifier_call_chain+0x2a/0x110
[    0.069398]  vt_notifier_call+0x183/0x380
[    0.069402]  ? rcu_is_watching+0x11/0x50
[    0.069405]  ? __pfx_vt_notifier_call+0x10/0x10
[    0.069406]  notifier_call_chain+0x5d/0x170
[    0.069413]  atomic_notifier_call_chain+0x5f/0x110
[    0.069417]  vt_console_print+0x22e/0x4c0
[    0.069424]  ? console_emit_next_record+0x23a/0x2c0
[    0.069428]  console_emit_next_record+0x264/0x2c0
[    0.069430]  ? console_emit_next_record+0x23a/0x2c0
[    0.069439]  console_flush_one_record+0x210/0x340
[    0.069446]  console_unlock+0x6f/0x130
[    0.069447]  ? vprintk_emit+0x187/0x250
[    0.069451]  vprintk_emit+0x1fe/0x250
[    0.069457]  _printk+0x5b/0x80
[    0.069463]  ? __pfx_univ8250_console_init+0x10/0x10
[    0.069470]  lockdep_init+0x10/0xc0
[    0.069474]  start_kernel+0x5f2/0x720
[    0.069481]  x86_64_start_reservations+0x24/0x30
[    0.069484]  x86_64_start_kernel+0xd5/0xe0
[    0.069487]  common_startup_64+0x13e/0x151
[    0.069501]  </TASK>
[    0.069502] irq event stamp: 324
[    0.069502] hardirqs last  enabled at (323): [<ffffffffad43d623>] __down_trylock_console_sem+0x93/0xa0
[    0.069506] hardirqs last disabled at (324): [<ffffffffad44072e>] console_emit_next_record+0x21e/0x2c0
[    0.069507] softirqs last  enabled at (0): [<0000000000000000>] 0x0
[    0.069510] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.069511] ---[ end trace 0000000000000000 ]---

This shows that braille_write() is called form printk() even when
braille_co is not in console_list. It is called via vt_console_print()
because the graphical console driver (ttyX) is registered.

Best Regards,
Petr
