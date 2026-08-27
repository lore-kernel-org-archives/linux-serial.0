Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9863374A14;
	Thu, 27 Aug 2026 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835579; cv=none; b=pf8lrgeq6bLhekF9Za7EeCv2LAriuPbJru3GgFrqXWZs04hGIgWuzCEugxWaeWATtj8yUL90P6K8RxDOo3dMBQjPN7WzUdrPByiSUFBichbDZyF/EBG1v2QS1XG/3gFttl86vAQaomhZ/qRlDBAGIKA1sBgURgrWRDgLug0kXlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835579; c=relaxed/simple;
	bh=n4g67O2ahbEYQjmAR1A9xvd9Q4M5H24NCJnflkw+TVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z9nfw703RmupiFCj/oHKZLb/rWE1fFuRMzUgadFUTO1RzkRJCdtow4O6QISD3xoJkArza/QAmmOm8a4wnMunWI30uewuz6xT09ImsMI/AVnA24p1ShAnZZT8vmO4Qfw9KWdyhY1GmDYl9aFQufJX4yW1iaF731Tp7y+yNgPXT6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q6Np/Wdc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b+vOAjAR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q6Np/Wdc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b+vOAjAR"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787835566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ttq7Bkjlgdu0Zd+0ixn9ELU0etKIRWqFZqD1UHLmrgc=;
	b=Q6Np/WdcLDbTppRHdNIsZvsXbCV0VpGuqjeHIZskuxVG5gp/xViV56RHP/72Ps82a5j0/s
	1s/gEQAnxzZSsMq/La7yHyH0z5nn5tzI4yyhYP8P9VBkTA6gUAQ7WJHLsad/NvJhRSwVS6
	Jh4LrPZ/KRZxmetrSJgMJCPzgy8jD8leK/k3gLZm47eSFkIuvUnnUwjEw8SFbQP3Nw2wji
	8DXoij2zHhNE/ikjGIZAXN8N1NWvbSNGbp2I3OT7Kx2SmjNuilEvGqXZy1+ydlCudCLtJx
	+CufXmP+B6Q33F1mmis+AGQPGF4kjpikugaRN3E8utw/DYHK2V+x+K2QvuKh7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787835566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ttq7Bkjlgdu0Zd+0ixn9ELU0etKIRWqFZqD1UHLmrgc=;
	b=b+vOAjAR3tlzs71HRuvPRJL98R7RFTZxC81KnRjz15M3vLEBFLjfmN/ud4z7HbyHAXkWWH
	b0LhPwbuPhUw8CCA==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Petr Mladek
 <pmladek@suse.com>, Jon Hunter <jonathanh@nvidia.com>
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
In-Reply-To: <20260826075925.WTEVoXWi@linutronix.de>
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
Date: Thu, 27 Aug 2026 15:05:25 +0206
Message-ID: <875x0vpvma.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Jon,

On 2026-08-26, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> If that irq_work is the problem that making nbcon_irq_work LAZY should
> delay it, masking the problem.

Making nbcon_irq_work LAZY should work around this problem. And,
actually, it should be fine to make nbcon_irq_work LAZY in general since
it is only related to non-emergency messages, which are delayed anyway.

Jon, could you run your tests with only the following patch applied? If
this works for you, I will submit an official version of the patch.

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index a5921a84a80ed..ad79e30afd647 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1782,7 +1782,7 @@ bool nbcon_alloc(struct console *con)
 	}
 
 	rcuwait_init(&con->rcuwait);
-	init_irq_work(&con->irq_work, nbcon_irq_work);
+	con->irq_work = IRQ_WORK_INIT_LAZY(nbcon_irq_work);
 	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_prev_seq), -1UL);
 	nbcon_state_set(con, &state);
 
