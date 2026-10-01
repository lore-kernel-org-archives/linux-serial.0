Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C6B38DC5C;
	Thu,  1 Oct 2026 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790884511; cv=none; b=GqlXQ8tfvBM3XtKOi1TTVvTjeO/tD61t3K6bb6++Gmx4+sSZNfcANYVmVYm51vCzLA+LkFazNPbcgHOdbeHkehuaXTGeUPgYS5/2Ht7QCKXuelZxWsEtM04neb8ugATYLe5tsUaJasTYvTuCRyJjUn5rOiUcigYsih12o3+YUO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790884511; c=relaxed/simple;
	bh=BAn03zenaHr0MOgnV3RrrNBx+2PlflDO3oYaTmxtGgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yp4GX6deeIcdPZIh6G+RBqFYd79XieKws8GCmRXTLZdGrjBTD1HUpuACZn6apM2K3y/qEKSoGUuDVcbnjdtZqe4Fj38JQH4FuAgxpkPxqDTik7S5RAa1dIVPziS7/Lt/I0ZYAmucGb3cIQNXS/w2zonaOWauD0tXlWn698qFSgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NfH27TeW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h9YNRJqT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NfH27TeW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h9YNRJqT"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790884505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BAn03zenaHr0MOgnV3RrrNBx+2PlflDO3oYaTmxtGgA=;
	b=NfH27TeWZ3BhMGiTvlqoe12wMpI0/J8cChRFmik00U0BHZ0F5L0oTp8lbrxohr7g3ub5yz
	pOJOjrKJP/RWqbm0dfTg313+wmA9fYaJfDkXqPfTReDnbQ97sl4xwsU8r4ONmIpSsQgrrW
	vhNuTc6bW0RK7VQyhYfXuEuqB/rDqaFK3pGBdj3vavDiJqN321nkWn8HywPAfZg9u/XmvZ
	SAy7rHDsr4d6qKOAMS5aKUrqhDUTWrElZIuJy+IuM/KvF8ybtAiP73UMkGwZ9GrX7okDA8
	eENvT1Q/C52UhlSc+84KR76WkvBDmBbx99SdztBlHMFOsqfFjGayvEfpFenjxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790884505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BAn03zenaHr0MOgnV3RrrNBx+2PlflDO3oYaTmxtGgA=;
	b=h9YNRJqTLHdr28MdjoLkYkdUAh8RKBwP3s+iPV99H87oii06SkXzC45OYGS/vpZWVZzSiP
	0mHJerXOtETyoQAw==
To: Imre Kaloz <kaloz@kernel.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-serial@vger.kernel.org, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2] MIPS: SGI-IP27: print the NMI dump on an nbcon console
In-Reply-To: <20261001191938.3256-1-kaloz@kernel.org>
References: <20261001191938.3256-1-kaloz@kernel.org>
Date: Thu, 01 Oct 2026 22:01:04 +0206
Message-ID: <875wzl8acn.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-01, Imre Kaloz <kaloz@kernel.org> wrote:
> Since the 8250 console became nbcon, printk() in nmi_dump() only queues
> records for a printer thread that never runs, as no CPU leaves the NMI
> handler. Print from an emergency section and flush pending records
> before the hub reset.
>
> Fixes: d3539347022a ("serial: 8250: Switch to nbcon console, take 2")
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
