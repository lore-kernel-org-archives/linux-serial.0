Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ECA521231;
	Thu,  1 Oct 2026 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790877693; cv=none; b=Lx2qZIlbIdMvOvwjnrZqtl0tQg/HmeiXf63IOLeC2KOiAfOZw0nIwJEgxqhTbDemjvTaE+kIcteqa/PegxMpBhdoc9oyQqAIKnydZv7dmWDPXQoTU9nHQhjWn7nmDI4afqtzGXEgxq8CQ4b8wU7KYRi/0erpubm1Zr6B1q6GUnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790877693; c=relaxed/simple;
	bh=aEDw5hZ//7m5nhHGnBjLYUV0ItHIvvjfj1ynDWO5MUQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BSqA5boSeLVmBaTriHlir+I5BPMCsRl708N9Tf+ZPcE96M8sOME2g1dgRlUx609qp/IZ6DhxjKkEtCy/33ogJ4RUPg9Gf5Cza+XBfcb+BcSRZKUT0npGdgOgQ/gcT0c0I2jZj3V/BD5G6N6Q+Mkd5J1bSQUjzN24hMr743yLZwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=npvZGArS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=86dTVzPJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="npvZGArS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="86dTVzPJ"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790877681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bg6X++N0P8HvYAAkstMHcuFUVvMgN/yHRNpbRzzG2qk=;
	b=npvZGArSx1Ug2AC3rzY75+qszyw2pf84zqgrtotKp0whnQRNxdN5j/WkdJk6vazFi62/gh
	W7xGvvTgc8AxlwVINKsGow0D/JwDdIM43cqLFy76HCMrBaC4o2TsKzLIq3+ORRjnzDdVWU
	Rg4vP5V916No7zUA/KtnADaoq0IIQLEWGmX6G85N201N4qdrAxa7e7xvYgTdvuEU2SkYZA
	qferDmcBzH5bJXdgu8tFuzRKlCdqpAtrQDE1A6qYOHSaJ2QhhjbC35EtSkFv6lI59IG+rN
	vjK85b80QzqXmXG+CkYaa2rfU2QuxWivmXRZCatvzUD0F9VgvEDpVM8Ubsjgkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790877681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bg6X++N0P8HvYAAkstMHcuFUVvMgN/yHRNpbRzzG2qk=;
	b=86dTVzPJr2UIPiSPS1EEkG8rKCASUOnBW8axJRIOYEyJrqkRMZOhAaYrgGp7im2aNFzOTY
	m92SLJr+WskNYCBw==
To: Imre Kaloz <kaloz@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-serial@vger.kernel.org, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] MIPS: SGI-IP27: print the NMI dump on an nbcon console
In-Reply-To: <55083820-478c-e6a6-b129-467140f161db@kernel.org>
References: <20261001155013.1694-1-kaloz@kernel.org>
 <87ece98je8.fsf@jogness.linutronix.de>
 <55083820-478c-e6a6-b129-467140f161db@kernel.org>
Date: Thu, 01 Oct 2026 20:07:20 +0206
Message-ID: <87bj9d8fm7.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-01, Imre Kaloz <kaloz@kernel.org> wrote:
> nmi_dump() has no caller in Linux. install_cpu_nmi_handler() stores
> its address in the per-CPU NMI vector the PROM keeps in low memory,
> and the PROM jumps to it when the system controller asserts NMI on
> the CPUs: the "nmi" command at the L1 (or the MMSC on an Origin
> 2000), typically used to get a dump out of a hung machine.
>
> Every CPU that takes the NMI enters nmi_dump(). The first one to get
> nmi_lock waits until all online CPUs have arrived, prints the saved
> state of every CPU and ends with the NI_PORT_RESET write. The others
> spin on nmi_lock, which is never released. No CPU goes back to the
> interrupted context

Thanks for the explanation. I guess it should have been obvious, also
because @nmi_lock is locked and never unlocked.

> @@ -183,6 +184,12 @@ static void nmi_dump(void)
>  	 */
>  	arch_spin_lock(&nmi_lock);
>
> +	/*
> +	 * No CPU leaves the NMI handler before the hub reset below, so an
> +	 * nbcon console's printer thread would never print the dump.
> +	 */
> +	nbcon_cpu_emergency_enter();
> +

Note that putting the CPU into emergency state does not cause any
printing. A later printk call is required.

Also note that only _this_ CPU is put into the emergency state. So any
printk's on other CPUs will not be visible until _this_ CPU performs a
printk.

In order to make sure that any backlog is flushed, I suggest also
adding:

	printk_trigger_flush();

after the loop waiting for the other CPUs, just before triggering the
reset.

John
