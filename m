Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1904306B3D;
	Thu,  1 Oct 2026 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872787; cv=none; b=UZtvJN5QZEto5TltoKEYxr0ppVAYtXtuOhjZPfh5Hd0Qe+uL6dZdygLvjevcsihmzQ9KxrSwp31ztzl5sFeazjyLoTYeaFH8Py7qOl758uJhZShvdn1i+R14pBHoFucmJCRvIywoFTaPcicOyUw0RYWQ562oDFvu0AcjUjDwaTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872787; c=relaxed/simple;
	bh=CoFIg5zVxdnbRNF+xA6y6DD9CF5IBpGo8K9jZgyNx3w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kaqBlTxaUPITMooQa4fKaJ1pTI21KHooF5ud9IGMJBVhc/nJ9+KBnfKwjvDNDWk/OZlocf0GdzzuwgOO51+x0NtRU40xoIyWTvQDFNESavtP8dRNJJYQsTbnDMRyh364YI770fL2KrpYUk0PxE/xaxC1gutIphgnPUWR+H2BDww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CplMPwRu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VHCx7DuI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CplMPwRu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VHCx7DuI"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790872783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dW+cKpw6NdVRG/EtiOgDyZsg/gwP7QSsUMI8sG6iNmE=;
	b=CplMPwRudXp//hBgERoFxRn7Fjmt5Pds98oTs2ahHQAsV5AnmZct5dhPqw2fIAzNCpt+jb
	BYkcvIWsAUP/0DER5dvEeMzYdS4IzM1SOpSd+oQy48E7uQf3z6mjZrTgEuens/cx0DUrH7
	J4ZjlRHb689GsYpHapad9NaZTZbX4UZ9Yddp5Gb8gDuS+duTw0tdn4JDCGljnlXQYz49fA
	r95YsBMKWlPTFhRi6uBe6T0rvmi/85N09xZh/om6UO1ZYt758cj6OMwKSMS4qvbGMty1PL
	yVi0PaKEC+qZ6OpkNrhQr5ix0/QD83w4K9wCyAZVPB7jJGIRYS1DDXHMNGsPEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790872783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dW+cKpw6NdVRG/EtiOgDyZsg/gwP7QSsUMI8sG6iNmE=;
	b=VHCx7DuIamZChKkQRioT97bAfm8uBI3g7ZQ9nSUagzTCKeo6XhP1bL1UWVP3ZkehW2aMYb
	cHSUPIHM8i/t6/Cg==
To: Imre Kaloz <kaloz@kernel.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-serial@vger.kernel.org, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] MIPS: SGI-IP27: print the NMI dump on an nbcon console
In-Reply-To: <20261001155013.1694-1-kaloz@kernel.org>
References: <20261001155013.1694-1-kaloz@kernel.org>
Date: Thu, 01 Oct 2026 18:45:43 +0206
Message-ID: <87ece98je8.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-01, Imre Kaloz <kaloz@kernel.org> wrote:
> Since the 8250 console became nbcon, printk() in nmi_dump() only queues
> records for the printer thread, which never runs because no CPU leaves
> the NMI handler before the hub reset. Print the dump from an emergency
> section.

Please excuse my ignorance, but could you inform me about the context?
When is nmi_dump() called? Does the hardware always reset/reboot/hang
from this call?

> Fixes: d3539347022a ("serial: 8250: Switch to nbcon console, take 2")
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
>  arch/mips/sgi-ip27/ip27-nmi.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/mips/sgi-ip27/ip27-nmi.c b/arch/mips/sgi-ip27/ip27-nmi.c
> index fc2816398d0c..4447c0bec8b4 100644
> --- a/arch/mips/sgi-ip27/ip27-nmi.c
> +++ b/arch/mips/sgi-ip27/ip27-nmi.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <linux/console.h>
>  #include <linux/kernel.h>
>  #include <linux/mmzone.h>
>  #include <linux/nodemask.h>
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
>  #ifdef REAL_NMI_SIGNAL
>  	/*
>  	 * Wait up to 15 seconds for the other cpus to respond to the NMI.

The CPU enters an emergency state, but shouldn't it exit the emergency
state at some point? Or does the machine always unstoppably
reset/reboot/hang after this point?

John Ogness
