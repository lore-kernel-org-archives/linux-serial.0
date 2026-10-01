Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF413522F0F;
	Thu,  1 Oct 2026 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868725; cv=none; b=uyo6dloKf3rLpeGO98eUFqyFORlYl1DxBa0vySNrRn6E8BP9e7BIYrAxAtYZDmhOHYaheoro4LhqvElEWTAWtoXitgfs0pPW57aK6SNOZjz4kZ0L47fC3kMWqQq55JLFWcGWEK8htmI9XchfShW96F9DIoRvEVGvVVyeAXWaGbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868725; c=relaxed/simple;
	bh=JYrN9j5krzWTQXncBY8sXhYhVm4F5RKYlxSpaDYJAIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gmRD4JbYNMaTzQ9hhccW3jeTsaopcXQltDYxVEEI8r0cNQKMD1YKjvY/NrpE/A1yUjGRTm6wQF+xjVSolNmWzJpWFjE8V2UNAdSuXomc8CljHb5Z32qNQxYHp5s0a519LEr1ms4pk459K/0Ymzf1bo8nRmqToRN68Hd4v0KRT4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1MlFMhfI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ADnEo9hl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1MlFMhfI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ADnEo9hl"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790868721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IMcZIsXFB0CDHoIkMqyDGGmuJaB97LktfnXqfpwg8z0=;
	b=1MlFMhfI8gv8Ta1u3i00YT1yR4E0PSxHqQ0CbzRalDxXUSppWE3dadhsG4hNFyJwQxWW6r
	knx4R+ZGsZgbJ8u+yj3QubarJndb+100IZx9WKZ1G9Dv428XAxf6S8GhJ2XWrpck5PN+vP
	xZFgLoJ+9Q+ha2U2jzt9Heo2ns9wqPkdXpqE5gd1LVl6F5oyKmm0nYEKf2Q8bFBeSOOUUT
	cGUKdY3i6KZhJz2cDUDxW/nlI6y9yckHtZZU4v6Npp+o4vyvie6IMYEMvFwwuxq4bO11A0
	QkDj/vqQi5sHv7PxnrQs1++hus8KvEM1kMqb+gwVOGOAcZxW/hRhubpzdfqDsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790868721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IMcZIsXFB0CDHoIkMqyDGGmuJaB97LktfnXqfpwg8z0=;
	b=ADnEo9hlJ0BRBHM84GI2q5P/0RN7xT/GLo9SroJdO10A1+x/dr43Nt6vQzTDWO8Y2c12M2
	WWR1SjSZVtAO58DQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Marcos Paulo de Souza <mpdesouza@suse.com>, Samuel
 Thibault <samuel.thibault@ens-lyon.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Fushuai Wang <wangfushuai@baidu.com>, Kees
 Cook <kees@kernel.org>, Stepan Ionichev <sozdayvek@gmail.com>,
 linux-serial@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>,
 linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v4 1/1] braille: nbcon: Allow to use a serial console
 with NBCON API as Braille console
In-Reply-To: <20261001140727.124398-2-pmladek@suse.com>
References: <20261001140727.124398-1-pmladek@suse.com>
 <20261001140727.124398-2-pmladek@suse.com>
Date: Thu, 01 Oct 2026 17:38:01 +0206
Message-ID: <87h5j58mj2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-01, Petr Mladek <pmladek@suse.com> wrote:
> The Braille console is not registered in console_list. Instead, it is
> integrated with the virtual terminal (VT) and shows what is displayed
> on the terminal. It writes the data using con->write*() callback
> of the associated serial console driver.
>
> braille_write() is called from the VT code under console_lock().
> The associated serial console driver can be converted to the NBCON API
> though. The situation is similar to flushing nbcon consoles in the legacy
> loop when some boot consoles are still registered, see
> nbcon_legacy_emit_next_record().
>
> But there is a big difference though. braille_write() is not directly
> called from the code paths flushing registered consoles. The VT code
> expects that braille_write() succeeds. It does not replay the message
> when it can't acquire the ownership. As a result, braille_write():
>
>   + must try harder to get the ownership.
>
>   + has to be synchronized only against non-printk serial console
>     which depend nbcon_device_try_acquire() using NBCON_PRIO_NORMAL.
>
> Let's look at it from another side and try to simulate the original
> locking using the NBCON API:
>
>   1. Take con->device_lock(), aka the port->lock in the legacy serial
>      console driver.
>
>   2. Acquire nbcon context to provide some synchronization for a panic()
>      context. Use NBCON_PRIO_NORMAL because it contends only with
>      nbcon_device_try_acquire() users. Do it in a busy loop. It should
>      always succeed when con->device_lock() succeeded because all other
>      users do the same. The only exception is when the context get acquired
>      by a CPU handling panic.
>
>   3. In panic, disable interrupts and try to acquire the nbcon context.
>      Use NBCON_PRIO_PANIC. And try even an unsafe takeover because
>      otherwise the Braille console won't see the text shown during panic().
>      It is similar to the oops_in_progress/trylock handling in the legacy
>      serial console driver.
>
> Finally, avoid the newline prepending logic in the existing serial console
> drivers when they are used as a Braille console. As explained above,
> the Braille console shows the last modified line on the terminal (VT).
> braille_write() is called when single characters are added. Most
> messages are not ended by newline. Anyway, the VT code does not have
> logic to reply partially printed messages.
>
> Fixes: 13189fa73afa ("printk: nbcon: Rely on kthreads for normal operation")
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Minor comments follow, but no need to send a v5 for them. You could fix
them up on your own.

Reviewed-by: John Ogness <john.ogness@linutronix.de>

> diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
> index 06b43b678d6e..fc6cd3530b28 100644
> --- a/drivers/accessibility/braille/braille_console.c
> +++ b/drivers/accessibility/braille/braille_console.c
> @@ -353,13 +406,16 @@ int braille_register_console(struct console *console, int index,
>  	if (!console_options)
>  		/* Only support VisioBraille for now */
>  		console_options = "57600o8";
> +
>  	if (braille_co)
>  		return -ENODEV;
> +
>  	if (console->setup) {
>  		ret = console->setup(console, console_options);
>  		if (ret != 0)
>  			return ret;
>  	}
> +
>  	console->flags |= CON_ENABLED;
>  	console->index = index;
>  	braille_co = console;

This hunk is pure whitespace cleanup. It is a leftover from when you
actually made changes here. I am OK if you keep it, but I would drop
this hunk.

> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index d17704fe93ae..8dac9bda4fe0 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -2002,3 +2003,81 @@ void nbcon_kdb_release(struct nbcon_write_context *wctxt)
>  	 */
>  	__nbcon_atomic_flush_pending_con(ctxt->console, prb_next_reserve_seq(prb));
>  }
> +
> +/**
> + * nbcon_is_braille - Checks whether the nbcon write context is using Braille console
> + *
> + * @wctxt:	checked nbcon write context
> + *
> + * Return: True when the write context is associated with a Braille console.
> + *	   Othrewise, return false.

One more:  Otherwise

I ran a spellcheck on the whole patch this time, so we should be good
after this.

Thanks for doing the heavy lifting on this so quickly.

John
