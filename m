Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2D749BD74;
	Fri, 25 Sep 2026 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346857; cv=none; b=LqfSL/3n6pWNA9QqXe7XsQqFADDCoql9UloqnT0XlGMOLE1joohCYlvxrELh2E1YfybdDgZXL5YLpZTsadsqH77VJrXjHc5I9B6he5jBiSLmzkAe8Wq42R+yQqQS7nZ/Vth/WWCrz7wTh6KzSagY3UuInq47WazkAGpLjb0DjLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346857; c=relaxed/simple;
	bh=bKkuGxfOxzaLYyp0hGDj4e2Ohf6CsH16L/JAA+NSwHM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BINwAz1qjyHaScWaXVTIxCNoH/QgrjplqgBTrl1c2lDpEpz+SKn7NbYI5p7PF8jiLH9hGUirEHEXRlOR9bS7qrMCMomEHplrsXG3knUlOlKu46zzOS5quQH5Kt/KqMyXy/ERql7MSTLl7vtCF+SwMYR2eMmVyu/8VewIDa3TKvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gArfMHyZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JcdcPsYg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gArfMHyZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JcdcPsYg"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790346845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ullJlH2+Q9p4FY6fzdXG/lE4kV0UYlYXUeINOaUW0b4=;
	b=gArfMHyZNHKVkhGPZNVXh1uhe31Tid8nL8MnFMaFgV+B1LwwBaXBx5zUuujv+gJBoufF53
	dCaD6HHUndIviPEjnmPZK0N1rUPuLV93eVqMOZ804k+1dC+Z9+AkF7HpH8mnd8DITSz3EY
	Qvj3QAg1fEX9VR5BTvXEeBwrqi5DYWHRVjRof/beYD8UmWyaczkiRURzEXbuOHbw8pWero
	NaSbUS0NAbmsD7BskxKhBgKExGg9M8u/nVZXrwI3YeOq9v+bgf6wLah0NIKfLVBfxehyAN
	IyYFACnhK7+OvXC1MYw1Vmu3UBNVRrryL4Uhytfp3knesi20lETmA9juyx4HoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790346845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ullJlH2+Q9p4FY6fzdXG/lE4kV0UYlYXUeINOaUW0b4=;
	b=JcdcPsYgGEAiuT21yvyGPXqdKIPJdMR19/BNxzAI528Yiflo+Fmqd5JbZ6oVxauUNv/g98
	nBPgnYvOgP9LvOBg==
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
Subject: Re: [PATCH 2/2] braille: nbcon: Use nbcon atomic console callbacks
In-Reply-To: <20260922072558.98854-3-pmladek@suse.com>
References: <20260922072558.98854-1-pmladek@suse.com>
 <20260922072558.98854-3-pmladek@suse.com>
Date: Fri, 25 Sep 2026 16:40:04 +0206
Message-ID: <87cxu1ien7.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-09-22, Petr Mladek <pmladek@suse.com> wrote:
> The Braille console is integrated with the virtual terminal (VT) and
> writes its data using the legacy con->write() callback of the associated
> serial console driver.
>
> However, once the underlying console driver is converted to the NBCON
> API, it should use the con->write_atomic() callback, which must be
> synchronized by acquiring the nbcon console context.
>
> Adapt braille_write() to handle NBCON consoles:
>
> 1. Acquire the nbcon console ownership using NBCON_PRIO_EMERGENCY
>    priority before printing, disabling local interrupts to prevent
>    any nested calls into the driver.
> 2. Call the con->write_atomic() callback to write the buffer.
> 3. Release the nbcon console ownership and restore local interrupts.
>
> Also, adjust __serial8250_console_write() in the 8250 serial driver to
> exclude Braille consoles from the newline prepending logic. The serial
> port is not used for standard printk logging which might be interrupted
> in the middle of the operation. In the Braille mode, the serial driver
> is supposed to write exactly what it gets. In fact, it does not print
> any newlines at all in this case.
>
> Fixes: d3539347022a ("serial: 8250: Switch to nbcon console, take 2")
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  .../accessibility/braille/braille_console.c   | 38 ++++++++++++++++++-
>  drivers/tty/serial/8250/8250_port.c           |  5 ++-
>  2 files changed, 40 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
> index 06b43b678d6e..cd1019d478db 100644
> --- a/drivers/accessibility/braille/braille_console.c
> +++ b/drivers/accessibility/braille/braille_console.c
> @@ -62,14 +62,32 @@ static void braille_write(u16 *buf)
>  {
>  	static u16 lastwrite[WIDTH];
>  	unsigned char data[1 + 1 + 2*WIDTH + 2 + 1], csum = 0, *c;
> +	struct nbcon_write_context wctxt = { };
> +	unsigned long flags;
> +
>  	u16 out;
>  	int i;
>  
>  	if (!braille_co)
>  		return;
>  
> +	if (braille_co->flags & CON_NBCON) {
> +		/*
> +		 * Braille console might be called from unknown context via
> +		 * vt_console_print() from console_unlock() from printk().

printk()?

> +		 * Use the atomic callback and synchronize it just using
> +		 * the console context. Disable interrupts to prevent a nested
> +		 * call into the driver code which might cause a deadlock when
> +		 * trying to acquire the console ownership, see
> +		 * __nbcon_atomic_flush_pending_con().
> +		 */
> +		local_irq_save(flags);

This is not acceptable for PREEMPT_RT.

local_lock_irqsave() should be appropriate since this driver is not
called from printk(). ...if we want to take this route. More below...

> +		while (!nbcon_braille_try_acquire(braille_co, &wctxt))
> +			cpu_relax();
> +	}
> +
>  	if (!memcmp(lastwrite, buf, WIDTH * sizeof(*buf)))
> -		return;
> +		goto release_nbcon;
>  	memcpy(lastwrite, buf, WIDTH * sizeof(*buf));
>  
>  #define SOH 1
> @@ -102,7 +120,23 @@ static void braille_write(u16 *buf)
>  	*c++ = csum;
>  	*c++ = ETX;
>  
> -	braille_co->write(braille_co, data, c - data);
> +	if (braille_co->flags & CON_NBCON) {
> +		if (braille_co->write_atomic &&
> +		    !braille_co->flags & CON_NBCON_ATOMIC_UNSAFE) {
> +			nbcon_write_context_set_buf(&wctxt, (char *)data, c - data);
> +			braille_co->write_atomic(braille_co, &wctxt);
> +		} else {
> +			pr_warn_once("Braille requires a safe braille_co->write_atomic callback\n");
> +		}
> +	} else {
> +		braille_co->write(braille_co, data, c - data);
> +	}
> +
> +release_nbcon:
> +	if (braille_co->flags & CON_NBCON) {
> +		nbcon_braille_release(&wctxt);
> +		local_irq_restore(flags);
> +	}
>  }

If we want to "convert" the Braille console to NBCON, we need to have
established contexts so that we know what we can do. kdb was a horrible
hack that was only acceptable because when kdb is active, the whole
system goes out to lunch. But for the Braille console we need some
sanity because this is a live system.

AFAICT braille_write() is called from interrupt-handler and task
contexts. Can we buffer the writes and wake a dedicated kthread to
processes them using ->lock() and ->write_thread()? We can use spinlocks
to synchronize the FIFO buffer.

>  /* Follow the VC cursor*/
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 38fa45e74a37..6eb0b439e433 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3417,8 +3417,11 @@ static void __serial8250_console_write(struct uart_8250_port *up,
>  	 * If the console printer did not fully output the previous line, it
>  	 * must have been handed or taken over. Insert a newline in order to
>  	 * maintain clean output.
> +	 *
> +	 * Braille consoles are an exception. The serial port is not used
> +	 * for printk(). The driver is supposed to write exactly what it gets.
>  	 */
> -	if (!up->console_line_ended) {
> +	if (unlikely(!up->console_line_ended && !nbcon_is_braille(wctxt))) {

Indeed. I am just wondering if it should be more generic.

nbcon_is_registered() ?
nbcon_supports_printk() ?

Or do we really want Braille to be the one and only exception.

Also note that this code exists in other NBCON drivers as well. At some
point we will need to create a general solution to adding \n on
takeovers.

John
