Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C51E3597B;
	Thu,  3 Apr 2025 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743681482; cv=none; b=H6I6rqLrZfJSz0mSpW7xZ2NY63SnhZ/jhkPtsFYeZMn737ljqWMU28NnF5kQTdWyx4emZQ5/ZTl0tPfYKJayxVcOZzb8GoduTXRpruFP76cPhLsPOJKfNP0ZWU/dJ0/Bl6As+K8vGxXDHyZeuVZ2k7z6OUULO+fdbzOmg79zGA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743681482; c=relaxed/simple;
	bh=nOXdSC/76SoEpTSftrnfQcrp9fghhEGma2SbAc4rv7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VVR5d7b1oI0QFozn3T/j+oXdpu/9PSxnDcrLORmypIaytLQTc8ubsGl40Z36oY5CaouXTKTaXzXXH0tiedPBAu7C6Jytjhi2u2tQQHEssFhKxzFIZZWytTi5rpIXv5MXtnrYLB5DkFeoqJst2d1ssztJqd7MWAkmoba7Isci2Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lVADhJ/c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9WGyG6jw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lVADhJ/c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9WGyG6jw"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743681479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nOXdSC/76SoEpTSftrnfQcrp9fghhEGma2SbAc4rv7A=;
	b=lVADhJ/cq15w1KgQfAjHX++Zph7sC1VdlFREd/DNyv9Y4Bx2YvNMyqVkdrOYRmw6SaR3TG
	dEGji++so+N7ILnqtxobRNOjFu5N3nK1Fo39fR6QFSCLBn43nYThO5s2dRCe4UfYr/gtps
	OCGFYAMg828uCH4jx2I1VupPX+nhdg1jH6depgP0ay3s0IT0l1i1Tm8B6uGVgCxZyczLRN
	Qo5ibBSH2+EmksfMWY6Bks7sAfgy26mIzsM3Rn09zCfcTWdTAst9pgM8IvaRGeUPkNax4h
	Df2JvCy6stfEu2Sfa+d7QJYrGa9Flc0iQbkbDMzkWt0gn+msdIMwLWGZ+ocfLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743681479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nOXdSC/76SoEpTSftrnfQcrp9fghhEGma2SbAc4rv7A=;
	b=9WGyG6jw5xzTjaGtPio/zNELtx41m1umu2z17vpCJnjrA3AvKw4rVV63ZWvCVR45LAJ7kk
	HP8e0iVMH7KPT3Cg==
To: Yunhui Cui <cuiyunhui@bytedance.com>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, pmladek@suse.com, arnd@arndb.de,
 andriy.shevchenko@linux.intel.com, namcao@linutronix.de,
 benjamin.larsson@genexis.eu, schnelle@linux.ibm.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: Re: [PATCH] serial: 8250: fix panic due to PSLVERR
In-Reply-To: <20250403090336.16643-1-cuiyunhui@bytedance.com>
References: <20250403090336.16643-1-cuiyunhui@bytedance.com>
Date: Thu, 03 Apr 2025 14:03:58 +0206
Message-ID: <84iknl5uex.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-04-03, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> an error response if an attempt is made to read an empty RBR (Receive
> Buffer Register) while the FIFO is enabled.
>
> In serial8250_do_startup, calling serial_port_out(port, UART_LCR,
> UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
> function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> Execution proceeds to the dont_test_tx_en label:
> ...
> serial_port_in(port, UART_RX);
> This satisfies the PSLVERR trigger condition.
>
> Because another CPU(e.g., using printk) is accessing the UART (UART
> is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) ==
> (lcr & ~UART_LCR_SPAR), causing it to enter dw8250_force_idle().

Didn't this[0] patch resolve this exact issue?

John Ogness

[0] https://lore.kernel.org/lkml/20220713131722.2316829-1-vamshigajjela@google.com
