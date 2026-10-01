Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597EB4078D5
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848752; cv=none; b=pRTxL1xXSKNilmTxRgpB/iYwJpRHb9T4btlYaimp7rO6Jenom1wdvNpndB4LpfR9lRly1VU0k8uQulZ/ndwTu6KEv+vm+nKTLVBjwva7Tb8CXoa7dZdMNb4quCyN7rTQyfDnYYQkDQ9XKxoa6Mn8ci3ZHJguYPY3lG7LL+dvTp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848752; c=relaxed/simple;
	bh=gmDg5X138LaqCbpBrQyuawt0nVtYZEJaS9q3BjanmoM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IfPgh2q87EkyiHWXjtRtzFtWMVqE6vfMD2+qnJTVq+iv33GGzDNwLv2IBBZSqrAebG2rX0Gxp0XyVqMUSHMznJzzQIY4j/ECyP6Xn4iuTDjDerrkBh3T/oZIHmWGf33PfGpb1uLpY0OXyHm9NZQ61maHkRQiki8tiHiJoEJ/IfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIMObqbc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIMObqbc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC4B1F000FF;
	Thu,  1 Oct 2026 09:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790848750;
	bh=7AGC/v63G2sKe4j4nWex6odS3rIyY+va2HnUbR9nrmM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SIMObqbcSpmfx6yPcwqObShD1Gc6Mfsknxk8ZSgBC6VvFObXqFHiAam4fngt2aeQp
	 Eo+apnPFIMYChvt7eqUaFOi6Wt1WW4RgAodMLgqyGadCujEV+wO9YFTrLAq2YWr/sU
	 xSMJZ5HUN3TSvHLFvmuxSYvC5Ym0M/55jGPZtQNUyW9dSwRod8WQ+0WjXVRDO2Ga3U
	 fN8MUcN/gSti/aIlEQTIx/s8cqneDif4mLBlEyPTXYm5tMNas9MqezZnpuhUQyOXIy
	 xjJWqCwwtF81VyIXsroxundKGYkNOqdkh4TXCxhWH0diAag6cpqkIxBcnhE1sNSKyF
	 jCOeRMIjBi8Bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/1] braille: nbcon: Allow to use a serial console
 with NBCON API as Braille console
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Mladek" <pmladek@suse.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261001093946.112999-2-pmladek@suse.com>
References: <20261001093946.112999-1-pmladek@suse.com>
 <20261001093946.112999-2-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 09:59:10 +0000
Message-Id: <20261001095910.9AC4B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] vt/braille: sleep in atomic context via nbcon task callbacks
- [High] vt/braille: infinite busy-loop deadlock during concurrent panic
- [Low] tty/sifive: build failure due to unlinely() typo
- [Low] printk/8250: linker error due to missing EXPORT_SYMBOL_GPL
- [Low] vt/braille: uninitialized variable locked compiler warning
--

commit cad32ed5b6a2a2082f9354528d2e20acb9b2661a
Author: Petr Mladek <pmladek@suse.com>

braille: nbcon: Allow to use a serial console with NBCON API as Braille con=
sole

This commit allows serial consoles using the NBCON API to act as Braille
consoles. It simulates the original locking by taking the device lock and
acquiring the nbcon context, and it updates existing serial drivers to avoid
newline prepending when used as a Braille console.

> diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/ac=
cessibility/braille/braille_console.c
> index 06b43b678d6ea..78611019b671e 100644
> --- a/drivers/accessibility/braille/braille_console.c
> +++ b/drivers/accessibility/braille/braille_console.c
> @@ -62,14 +62,45 @@ static void braille_write(u16 *buf)
>  {
>  	static u16 lastwrite[WIDTH];
>  	unsigned char data[1 + 1 + 2*WIDTH + 2 + 1], csum =3D 0, *c;
> +	struct nbcon_write_context wctxt =3D { };
> +	unsigned long flags;
> +	bool locked;

[Severity: Low]
Could this trigger a -Wmaybe-uninitialized compiler warning?

The compiler evaluates two independent calls to panic_on_this_cpu() in this
function. Because panic_on_this_cpu() reads an atomic variable, the compiler
may consider execution paths where the first check is false (skipping
initialization of the locked variable) and the second is true (reading the
locked variable).

Should the result of panic_on_this_cpu() be cached in a local variable?

[ ... ]
> +	if (braille_co->flags & CON_NBCON) {
> +		if (panic_on_this_cpu()) {
> +			local_irq_save(flags);
> +			locked =3D nbcon_braille_try_acquire(braille_co, &wctxt);
> +			/* NBCON API strictly requires the ownership. */
> +			if (!locked) {
> +				local_irq_restore(flags);
> +				return;
> +			}
> +		} else {
> +			braille_co->device_lock(braille_co, &flags);

[Severity: High]
Does this sleep in an atomic context?

braille_write() is invoked from keyboard_notifier_call() via the
keyboard_notifier_list atomic notifier chain with local interrupts disabled.
The device_lock() callback is documented as a task-context API that may
block (e.g., using a mutex). Is it safe to call it here?

> +			while (!nbcon_braille_try_acquire(braille_co, &wctxt))
> +				cpu_relax();

[Severity: High]
Can this loop cause a deadlock during a concurrent panic?

If CPU A runs braille_write() in the non-panic path and enters this loop,
and concurrently CPU B triggers a panic and acquires the console context
with NBCON_PRIO_PANIC, CPU A will attempt to acquire with NBCON_PRIO_NORMAL
which unconditionally fails against panic priority.

Because braille_write() runs with local IRQs disabled, CPU A would spin
infinitely and could never be interrupted by the panic IPI from CPU B.

[ ... ]
> @@ -102,7 +133,27 @@ static void braille_write(u16 *buf)
>  	*c++ =3D csum;
>  	*c++ =3D ETX;
> =20
> -	braille_co->write(braille_co, data, c - data);
> +	if (braille_co->flags & CON_NBCON) {
> +		nbcon_write_context_set_buf(&wctxt, (char *)data, c - data);
> +		if (panic_on_this_cpu())
> +			braille_co->write_atomic(braille_co, &wctxt);
> +		else
> +			braille_co->write_thread(braille_co, &wctxt);

[Severity: High]
Does this also sleep in an atomic context?

Similar to device_lock(), the write_thread() callback is strictly a
task-context API. Calling it from the atomic notifier context could lead
to deadlocks or might_sleep() splats.

[ ... ]
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 45dc9ab5bfd87..9019b2fe221f0 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3432,8 +3432,11 @@ static void __serial8250_console_write(struct uart=
_8250_port *up,
>  	 * If the console printer did not fully output the previous line, it
>  	 * must have been handed or taken over. Insert a newline in order to
>  	 * maintain clean output.
> +	 *
> +	 * Braille consoles are an exception. The serial port is not used
> +	 * for printk(). The driver is supposed to write exactly what it gets.
>  	 */
> -	if (!up->console_line_ended) {
> +	if (unlikely(!up->console_line_ended && !nbcon_write_context_is_braille=
(wctxt))) {

[Severity: Low]
Could this result in a linker error for modular builds?

__serial8250_console_write() calls nbcon_write_context_is_braille(), but
the latter is not exported via EXPORT_SYMBOL_GPL() in kernel/printk/nbcon.c.
Because the 8250 driver can be built as a loadable module=20
(CONFIG_SERIAL_8250=3Dm), will this break the build due to unresolved
external symbols?

[ ... ]
> diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
> index 5d76f04736260..9d67ee3561d60 100644
> --- a/drivers/tty/serial/sifive.c
> +++ b/drivers/tty/serial/sifive.c
> @@ -821,7 +821,7 @@ static void sifive_serial_console_write_atomic(struct=
 console *co,
>  	ier =3D __ssp_readl(ssp, SIFIVE_SERIAL_IE_OFFS);
>  	__ssp_writel(0, SIFIVE_SERIAL_IE_OFFS, ssp);
> =20
> -	if (!ssp->console_line_ended)
> +	if (unlinely(!ssp->console_line_ended && !nbcon_is_braille(co)))

[Severity: Low]
Does this code cause a build failure?

This looks like a typo ("unlinely" instead of "unlikely"). Because the macro
is undeclared, does this halt compilation when CONFIG_SERIAL_SIFIVE is
enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001093946.1129=
99-1-pmladek@suse.com?part=3D1
