Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE924A4824;
	Fri, 25 Sep 2026 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344137; cv=none; b=QdyMM3yudEb5K+vt+QG/EmrqPzrFhYCLxsO6JxGEQ2V8PxAZ1akbkO+V3i61e2I8QZTKCioXG9+HzJtNK2JL+BvqOIJhgkgS0cETeOnOJhoOv29bwuMswJ2BRiZUSZDuKOhoxBKLyq/onB1c8HX+9MNez7JXZJlpr2AKJoiqM5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344137; c=relaxed/simple;
	bh=77/6/CXC5eEqOAbDf2VL5do3xXWQl21bE1WQ8hsWW4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CANYiwHD7Nht+3jh13c2Ggsr8tJ2Kyqadv9WjCE1XDzj+SvylNXWia5SYYJZYf+XHPhe3vLLcPY07SwCim6VTMH74166DUfSJQC+0gDYn2D+LVTKnxW5p+g4EBiG1mS9jcsDttDG4jd57tETt2O9A8riji9go7GXBf1/3eWHl+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TIEOfqiF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vfZ14JnL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TIEOfqiF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vfZ14JnL"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790344133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tYq97oBUtqR+GJo2BO+H3oAKBSljqVFGPXkhvtP6W3g=;
	b=TIEOfqiFnn2bA05tS7ahPWr6OCJYpVsTTbd1idE1tBQ28eaCWu6n2b62YA4ea8SHqGZxXl
	dF2O+L35o1ZdSz9itUt42YRUpLB+48/aM5dLT5ONq7odRYy68WINrHWqnbk8vYhvC/CBxT
	/BhNMFTU4T9JcIj1+3CLuqbhVgS/VPL7/Q+YWNRnHYGPtyeK6R9j9e6GO6Hc7OAKPJ8hsx
	ZgUCGvWYFtDP24v7LEh96qpQxQ/pgA6dhoJnracxMRsLsTKVgnd1vT8rPoZEsl6eqIu6gI
	BFY5ZE/usZz+POcjKJuOuTMvya7v94wu+icZ5QszlSPi+7zrgSGXb1qPWaL7kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790344133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tYq97oBUtqR+GJo2BO+H3oAKBSljqVFGPXkhvtP6W3g=;
	b=vfZ14JnLmaRieMbG3YR5Q1yn/4Xrf8ae0Oi8uKfMCxwnXAcJlIYBx5yehqnoQ0Eh/F+dyZ
	U7RYzo1dmj9sb5BQ==
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
Subject: Re: [PATCH 1/2] printk: nbcon: Introduce Braille helpers
In-Reply-To: <20260922072558.98854-2-pmladek@suse.com>
References: <20260922072558.98854-1-pmladek@suse.com>
 <20260922072558.98854-2-pmladek@suse.com>
Date: Fri, 25 Sep 2026 15:54:52 +0206
Message-ID: <87fqyxigqj.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-09-22, Petr Mladek <pmladek@suse.com> wrote:
> These helpers will be used when calling console->write_atomic
> in the Braille console driver.
>
> The Braille console is not registered as a standard printk console.
> Instead, it is integrated with the virtual terminal (VT) and writes
> data using the legacy con->write() callback of the associated serial
> console driver.
>
> When the underlying console driver is converted to the NBCON API, the
> Braille console needs to use the con->write_atomic() callback instead.
> This callback must be synchronized by acquiring the nbcon console context.
>
> Fixes: d3539347022a ("serial: 8250: Switch to nbcon console, take 2")

This is not 8250 specific. But I am not sure which commit you want to
mark as Fixes.

For 62627bf0cadf ("kdb: Adapt kdb_msg_write to work with NBCON
consoles") there was no Fixes tag.

> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  include/linux/console.h |  8 ++++++
>  kernel/printk/nbcon.c   | 59 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
>
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 502d1abe3f50..d780f6de303a 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -615,6 +615,10 @@ extern bool nbcon_allow_unsafe_takeover(void);
>  extern bool nbcon_kdb_try_acquire(struct console *con,
>  				  struct nbcon_write_context *wctxt);
>  extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
> +extern bool nbcon_is_braille(struct nbcon_write_context *wctxt);
> +extern bool nbcon_braille_try_acquire(struct console *con,
> +				      struct nbcon_write_context *wctxt);
> +extern void nbcon_braille_release(struct nbcon_write_context *wctxt);
>  
>  /*
>   * Check if the given console is currently capable and allowed to print
> @@ -678,8 +682,12 @@ static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
>  static inline bool nbcon_kdb_try_acquire(struct console *con,
>  					 struct nbcon_write_context *wctxt) { return false; }
>  static inline void nbcon_kdb_release(struct nbcon_write_context *wctxt) { }
> +static inline bool nbcon_is_braille(struct nbcon_write_context *wctxt) { return false; }
>  static inline bool console_is_usable(struct console *con, short flags,
>  				     bool use_atomic) { return false; }
> +static inline bool nbcon_braille_try_acquire(struct console *con,
> +					     struct nbcon_write_context *wctxt) { return false; }
> +static inline void nbcon_braille_release(struct nbcon_write_context *wctxt) { }
>  #endif
>  
>  extern int console_set_on_cmdline;
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index d17704fe93ae..a5e053ffe4da 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -2002,3 +2002,62 @@ void nbcon_kdb_release(struct nbcon_write_context *wctxt)
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
> + *
> + * Context: Can be called in any context but only when Braille console is
> + *	registered and the struct console could not disappear.
> + */
> +bool nbcon_is_braille(struct nbcon_write_context *wctxt)
> +{
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +	struct console *con = ctxt->console;
> +
> +	return con && con->flags & CON_BRL;
> +}
> +
> +/**
> + * nbcon_braille_try_acquire - Try to acquire nbcon console for braille_write()
> + *
> + * @con:	The nbcon console to acquire
> + * @wctxt:	The nbcon write context to be used on success
> + *
> + * Context:	braille_write() for emitting a single buffer on Braille console.
> + *
> + * Return:	True if the console was acquired. False otherwise.
> + *
> + * Braille console is not registered as a proper printk consoles. Instead,
> + * it is integrated with the graphical virtual terminal.
> + *
> + * This function acquires the nbcon console using priority NBCON_PRIO_EMERGENCY.
> + */
> +bool nbcon_braille_try_acquire(struct console *con,
> +			   struct nbcon_write_context *wctxt)
> +{
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +
> +	memset(ctxt, 0, sizeof(*ctxt));
> +	ctxt->console = con;
> +	ctxt->prio    = NBCON_PRIO_EMERGENCY;
> +
> +	return nbcon_context_try_acquire(ctxt, false);
> +}

This is really the same thing as nbcon_kdb_try_acquire().

As you mentioned in your cover letter, it is a bug that
nbcon_kdb_try_acquire() enters an unsafe section because @unsafe is a
bool rather than a usage counter.

Since we have limited bits for struct nbcon_state, we need to stop
entering unsafe within nbcon_kdb_try_acquire(). As I mentioned in the
response to your cover letter, all the other CPUs should be quiesced
anyway.

John
