Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D5A18A933;
	Wed, 16 Oct 2024 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729102312; cv=none; b=Eh/4Devl0DyeBvLkZMIYc1AF2rS0jKHk25rBLmdSFWflrAjPEj3Dueptl2MLRGTMkzSX9CZoPkVIewFH094luL6sbrgT1J+7YFHYMlmm+aTe73APQKvNSoQCul/AypBmrO0AbaY0ttiACgmhFQYCcbqwL2WMcZucDxr17i4R6lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729102312; c=relaxed/simple;
	bh=+Wn+Zx7onK8xaH489hDkGOEs/OTWomDLOs5/E97dhOw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EHLzGqnEXM4VZoUNwTiiaVPntPxAhUjOH8Q0DmKCn5RXpWg5zbewnAIZe2H9c3CPMLF3uE19dPi7Gd2VJ8Edizq7ChQOLllDmB+jOl6KR2e3Z5gVsoZhDZFyY1UoIZYA5yQYn+15t+Lfwk7f+Ob7VOPXYaPtkVtaQTINavta2nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YwSKQ73I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L8bYn70U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YwSKQ73I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L8bYn70U"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729102308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kvAgcpABznH0KWyxGhEZ8TIjmB/x70Rq0aMQaMrxErQ=;
	b=YwSKQ73IfSIQOzsYw2Z8Xx+yQ0BHXvgHtCc5MDOW7dovN+Xw/arAqK/4iORFGhu9LDkVeM
	PaN3OK05ha29Av82/GLcHiJiSe/N44wKBZBEVH8icElHpV6T6SnVd1Prqpus/3VOXVpjbo
	+SBstJ3noe0FToeGKBTO/EfJFXSkzUIWlpFYq6mYjVjzJLnfUulR7/DKeoVrKm3xjfWhJd
	WjVKx5WJvmSYodenqEsR90tSAu5dFCx/pSYY19zCpuwnaAE9NQrKJ1IzJSwvwcmiJ2O4w6
	ff2giYNKoSuobVqK1MzRECYa/JCV0orkBz1G2fC3XhhB5KDPnUyZ1GNJTcx4Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729102308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kvAgcpABznH0KWyxGhEZ8TIjmB/x70Rq0aMQaMrxErQ=;
	b=L8bYn70UqZcP2iKldhYHnVv7gh4R30TOJKkQc6AMBR/o63oLhDhYbyMRW9dnJusejiZIjT
	Tv29b2ZaAATa0+Dg==
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Marcos Paulo
 de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH 1/2] printk: Introduce LOUD_CON flag
In-Reply-To: <20241016-printk-loud-con-v1-1-065e4dad6632@suse.com>
References: <20241016-printk-loud-con-v1-0-065e4dad6632@suse.com>
 <20241016-printk-loud-con-v1-1-065e4dad6632@suse.com>
Date: Wed, 16 Oct 2024 20:17:48 +0206
Message-ID: <84plnz29zv.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Marcus,

On 2024-10-16, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> Introduce LOUD_CON flag to printk.

Generally speaking, I do not like the name "LOUD_CON". The flag is
related to records, not consoles. Something like "NO_SUPPRESS" or
"FORCE_PRINT" might be more appropriate. Note that naming is not my
strength.

> The new flag will make it possible to
> create a context where printk messages will never be suppressed. This
> new context information will be stored in the already existing
> printk_context per-CPU variable. This variable was changed from 'int' to
> 'unsigned int' to avoid issues with automatic casting.
>
> This mechanism will be used in the next patch to create a loud_console
> context on sysrq handling, removing an existing workaround on the
> loglevel global variable. The workaround existed to make sure that sysrq
> header messages were sent to all consoles.

IMO the more interesting aspect is that the "loud" flag is stored in the
ringbuffer so that the message is not suppressed, even if printed later
(for example because it was deferred). This actually even fixes a bug
since the current workaround will not perform as expected if the sysrq
records are deferred (for example due to threaded printing or consoles
that are registered later).

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index beb808f4c367..b893825fe21d 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1321,6 +1321,7 @@ static void boot_delay_msec(int level)
>  	unsigned long timeout;
>  
>  	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
> +		|| is_printk_console_loud()
>  		|| suppress_message_printing(level)) {

I do not think "loud" should be a reason to skip the delays. The delays
are there to slow down printing. I would think that for "loud" messages,
this is even more important. I suppose this function (as well as
printk_delay()) would need a new boolean parameter whether it is a
"loud" message. Then:

	|| (!loud_con && suppress_message_printing(level))

> @@ -2273,6 +2274,9 @@ int vprintk_store(int facility, int level,
>  	if (dev_info)
>  		flags |= LOG_NEWLINE;
>  
> +	if (is_printk_console_loud())
> +		flags |= LOG_LOUD_CON;
> +
>  	if (flags & LOG_CONT) {
>  		prb_rec_init_wr(&r, reserve_size);
>  		if (prb_reserve_in_last(&e, prb, &r, caller_id, PRINTKRB_RECORD_MAX)) {

I guess LOG_LOUD_CON should also be set in the LOG_CONT case (like
LOG_NEWLINE does).

> diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
> index 2b35a9d3919d..4618988baeea 100644
> --- a/kernel/printk/printk_safe.c
> +++ b/kernel/printk/printk_safe.c
> @@ -12,7 +12,30 @@
>  
>  #include "internal.h"
>  
> -static DEFINE_PER_CPU(int, printk_context);
> +static DEFINE_PER_CPU(unsigned int, printk_context);
> +
> +#define PRINTK_SAFE_CONTEXT_MASK		0x0000ffffU
> +#define PRINTK_LOUD_CONSOLE_CONTEXT_MASK	0xffff0000U
> +#define PRINTK_LOUD_CONSOLE_CONTEXT_OFFSET	0x00010000U
> +
> +void noinstr printk_loud_console_enter(void)
> +{
> +	cant_migrate();
> +	this_cpu_add(printk_context, PRINTK_LOUD_CONSOLE_CONTEXT_OFFSET);
> +}

Have you tested this with lockdep? AFAICT, the write_sysrq_trigger()
path can migrate since it is only using rcu_read_lock() in
__handle_sysrq().

John Ogness
