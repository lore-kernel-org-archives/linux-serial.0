Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC09361972
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788204957; cv=none; b=pmeuvG2GdIUxJrMsdYqb6qsh3j8S+M0APHsFX9lpYWvpXfvypWNGcNH6abpXCCfDaPULXuRvzJaQAu0kjBrWckYNkzwNnDyVbCGpvo3uK/9dm24J+coy+JXLr29Jt0OkNkuzOEDjJKKn48gqw287s4Td/Dhji5XJjo6v2+eMEh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788204957; c=relaxed/simple;
	bh=oohkAkWZly0AGGLB0AGXpAqRERgzY/EQKQaldEqG6tg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rz203ZfNcVywg7cexp1JXEkNKi/sQAQN4OvfWuBmD/TunLnLns/OgwY0MHh18dIppSmGwUnBM9VONMXNu1Gub4AO8bYVG3eyeVtEEdvPUDjSwdXGUO4W0+C4osID1qwywhz9WYKHN6sF0xqJOEn2SWBaxiTdMaFvXDq2k07WHNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erzHypT/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erzHypT/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61471F000E9;
	Mon, 31 Aug 2026 19:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788204955;
	bh=t8kVAitDWw/DMuA/winDi/U5cuI7c73QJ3t2p6hK/MI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=erzHypT/pr3zo3oaZFMhSiRcX0wDHEd4O+wVKHEyToKuQOHAUl85Ffw/ZbmOnA/ee
	 7QZFzQP8590DR82DDnXdUmpI6EUJNVSONLP/M+Kd2y0jGLQOfeTvmhEqzncF6BViZt
	 s/7zqMFzqhzt/zoOY1r/X/rBwEvydCT+Cqws9vFM9CO3Cmx7tddhSVn3BxLKPg4FSa
	 mHHa/lSvisjUYix0iz5wpIqG/6XhS3boL+SA1xZNgX+BzlqH+lNblXHGypBBsIMXOs
	 r8WI3oEkrHg6wPjbyTIXExtm+t3ab0iFjBzccphE4A1ezHOG+sBZC3zfZz/tEk+I6J
	 DII2duXWMBWjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] serial: 8250_mid: wait for LSR tx empty before
 setting termios
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tate Whiteberg" <whiteberg@arista.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260831165911.2029839-3-whiteberg@arista.com>
References: <20260831165911.2029839-1-whiteberg@arista.com>
 <20260831165911.2029839-3-whiteberg@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:35:55 +0000
Message-Id: <20260831193555.C61471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Spin-waiting for up to 1 second with interrupts disabled causes se=
vere scheduling latency and hard lockups.
- [High] The baud rate hardware state update is split across two critical s=
ections, leaving a race window for corrupted transmissions.
- [High] Bypassing the `uart_port_lock` wrappers fails to acquire the nbcon=
 console lock.
- [High] `scoped_guard(spinlock_irq)` unconditionally enables interrupts on=
 exit, violating caller context guarantees.
- [Low] Missing `MODULE_IMPORT_NS("SERIAL_8250")` causes modpost errors for=
 modular builds.
--

commit 7b0bf61b54075c1cffc2c3cc1ed56d43ba829821
Author: Tate Whiteberg <whiteberg@arista.com>
Subject: serial: 8250_mid: wait for LSR tx empty before setting termios

This commit modifies mid8250_set_termios() to lock the port and wait for the
transmitter to empty before updating baud rate registers. This is intended =
to
prevent transmission corruption when updates occur while data is still in
flight.

> diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250=
/8250_mid.c
> index 82656645b8a64..c02ecb96e8b6f 100644
> --- a/drivers/tty/serial/8250/8250_mid.c
> +++ b/drivers/tty/serial/8250/8250_mid.c

[ ... ]

> @@ -231,11 +233,16 @@ static void mid8250_set_termios(struct uart_port *p=
, struct ktermios *termios,
>  	}
> =20
>  	rational_best_approximation(fuart, mid->board->freq, w, w, &mul, &div);
> -	p->uartclk =3D fuart * 16 / ps;		/* core uses ps =3D 16 always */
> =20
> -	writel(ps, p->membase + INTEL_MID_UART_PS);		/* set PS */
> -	writel(mul, p->membase + INTEL_MID_UART_MUL);		/* set MUL */
> -	writel(div, p->membase + INTEL_MID_UART_DIV);
> +	scoped_guard(spinlock_irq, &p->lock) {

[Severity: High]
Does using scoped_guard(spinlock_irq, ...) here unconditionally enable
interrupts on exit, violating caller context guarantees?

If set_termios is called from a context where interrupts are already disabl=
ed
(such as early console initialization or system resume), this will unmask
interrupts prematurely.

Also, does bypassing the uart_port_lock wrappers fail to acquire the nbcon
console lock? This could result in concurrent nbcon atomic console printers
mutating UART state simultaneously.

> +		p->uartclk =3D fuart * 16 / ps;	/* core uses ps =3D 16 always */
> +
> +		serial8250_wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);

[Severity: High]
Can this call cause a hard lockup?

Because scoped_guard(spinlock_irq, ...) is active, interrupts are strictly
disabled here. Looking at the called function:

void serial8250_wait_for_xmitr(struct uart_8250_port *up, int bits)
{
    ...
    if (uart_console_hwflow_active(&up->port) && !up->canary) {
        for (tmout =3D 1000000; tmout; tmout--) {
            ...
            udelay(1);
...

This loop busy-waits for up to 1 second. When called under a spinlock with
interrupts disabled, this can block the CPU and trigger the NMI watchdog.

[Severity: Low]
Does this missing namespace import cause modpost errors for modular builds?

The patch uses the serial8250_wait_for_xmitr symbol which is exported in the
SERIAL_8250 namespace, but fails to import the namespace via
MODULE_IMPORT_NS("SERIAL_8250").

> +
> +		writel(ps, p->membase + INTEL_MID_UART_PS);	/* set PS */
> +		writel(mul, p->membase + INTEL_MID_UART_MUL);	/* set MUL */
> +		writel(div, p->membase + INTEL_MID_UART_DIV);
> +	}
> =20
>  	serial8250_do_set_termios(p, termios, old);

[Severity: High]
Is there a race condition introduced by splitting the hardware state update
across two critical sections?

The lock is released at the closing brace of the scoped_guard, and then
reacquired inside serial8250_do_set_termios():

void serial8250_do_set_termios(...)
{
    ...
    scoped_guard(serial8250_rpm, up) {
        guard(uart_port_lock_irqsave)(port);
        ...

This creates a window where a concurrent uart_write or TX interrupt handler
could acquire the lock between these two critical sections and transmit data
using a mismatched clock and divisor configuration.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831165911.2029=
839-1-whiteberg@arista.com?part=3D2
