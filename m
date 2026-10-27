Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100469;
	b=L7EfvxOkjgB7rHIMGpa/gfTlcO1SVDS15YQF2wmfo058o/p5wxPukIbJJ5EpJhgE3QRO
	 vG++pn/9Yv4r96VyCfX48Lgzuy8F/whvs7kcfOp2WxFN/vOfYzYXPrHEKR+1i3KXqiZxf
	 1UFwLSgNZsXx/4VghGc3kvc07fQHCzhJ6F/51ed/bqLVmD37Tzf40ZngITDv3hGPMuC39
	 4gGLGtn9SPHLj84pXIukUoWutRG0kjreFnLRMJgHWw5mlmiII1aCWza4ExT+uR6+U/rlU
	 ZZR8WWbWYbxM8ClrZNOsAcK6iukNyhaM3csz5Pd/hxFrTyj7iH0RUPV/GfX0Db2YS2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100469;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=48QzCh9o95pMJJVcSE1w4N3eswsieHxCakj7OfTn4Og=;
	b=gM+1FW9QymW1b2reL59MUAJKiWxi575vKfG1weaCNGxi93fKlBtyP2uG/82odlV5SUtj
	 3T1qOxwA/YI0K6I9jMozMAwYyrdB0wFQnCCAIz/ppNSTIahwzn+Ci2VH6PuqaQQ7PAbfL
	 4jdaSLCBHpB+PgRc8sOOMSOtfOl/fXGC3GQxVo1F2qGvEBKyUmKXo07orjQDPaFq9pyjw
	 /qWy+f9I/8i8xNZLQctCnMf4JLgJbuqdBAURGHTnUsMhQjhdV7b/1jqur61KA2ybs99pw
	 5LdBAkjn9jYQzERuoky/+HxOqVaxkS0iZ/t/L46HtQPG1ajoYCotX54QLJ3ATO4KX2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B5qo2Nyv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598A8606A31D
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B5qo2Nyv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD211F01829;
	Tue, 27 Oct 2026 11:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793100469;
	bh=48QzCh9o95pMJJVcSE1w4N3eswsieHxCakj7OfTn4Og=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B5qo2NyvE0uCJEvBNCs24uJxjM3kSu9n9/64MK8x7axt/sXl9d9G1z2Vwq4txxSfY
	 MrPpvW1yVWxhor8ZPMbYIrhq4NxGxAHLhd1a5s7oAHjoC/zHVvct+noEcGx18fxZ6X
	 5u0CxvzyBgPfYGxcsELpnzoHMO+J35fR0681JkhpCGQL7+5sW9fVBMQ8yOKCJeHW3N
	 s6rrr1Khh2K3uFFgW2kpvh9dFU6qee/siZ6UOvYZvB949t4CTrEq8cq8Pi8CZgXxeg
	 xSMRLBzJre8HvSgxTF6FRgU5omOtpzcSKjkxZriUoaZMRo5wVzNVBTJBy/ayU1tkxQ
	 cGsixi+jakHPg==
Message-ID: <sashiko-outbox-186441@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/24] serial: 8250: cancel overrun backoff work on port
 shutdown and unregister
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-8-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-8-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:27:48 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] serial: 8250: overrun_backoff work re-enables UART_IER during shut=
down
- [High] serial: 8250: omap_8250_shutdown() cancels backoff work before IRQ=
 sync
- [High] serial: 8250: serial8250_unregister_port() cancels work before por=
t removal
--

commit b6ddb65f5590db91bc37f52c6acea3923b0b8f2e
Author: Joshua Rogers <linux@joshua.hu>

serial: 8250: cancel overrun backoff work on port shutdown and unregister

This commit adds cancel_delayed_work_sync() calls for the overrun_backoff
delayed work in serial8250_do_shutdown(), omap_8250_shutdown(), and
serial8250_unregister_port() to prevent the work callback from firing after
port teardown.

> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/825=
0/8250_core.c
> index 5730ef97f836e..af94ed4e633eb 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -950,6 +950,9 @@ void serial8250_unregister_port(struct uart_8250_port=
 *uart)
> =20
>  	serial8250_em485_free(uart);
> =20
> +	if (uart->overrun_backoff_time_ms)
> +		cancel_delayed_work_sync(&uart->overrun_backoff);
> +
>  	uart_remove_one_port(&serial8250_reg, &uart->port);

[Severity: High]
Is cancel_delayed_work_sync(&uart->overrun_backoff) called too early here,
before uart_remove_one_port() shuts down the port and quiesces its IRQ?

Callers such as of_platform_serial_remove() in
drivers/tty/serial/8250/8250_of.c call serial8250_unregister_port() directly
without shutting the port down first. An open port is only shut down and its
IRQ synchronized inside uart_remove_one_port():

uart_remove_one_port()
  -> serial_ctrl_unregister_port()
    -> serial_core_unregister_port()
      -> serial_core_remove_one_port()
        -> uart_shutdown()
          -> uart_port_shutdown()
            -> uport->ops->shutdown(uport)
            -> synchronize_irq(uport->irq)
        -> uport->ops->release_port(uport)

Similarly, in omap8250_remove(), omap_8250_shutdown() only masks the IRQ
with disable_irq_nosync(port->irq) and relies on uart_remove_one_port() to
run synchronize_irq(uport->irq). Because cancel_delayed_work_sync() runs
before uart_remove_one_port(), any overrun_backoff work scheduled while the
port is still active or before synchronize_irq() completes will not be
canceled after uart_remove_one_port() unmaps and releases the port.

Also, when serial8250_isa_devs is non-NULL right below,
serial8250_unregister_port() resets the subdriver-owned fields on the shared
serial8250_ports[] entry and re-registers it as a placeholder port:

	if (serial8250_isa_devs) {
		...
		uart->gpios =3D NULL;
		uart->dma =3D NULL;
		uart->rs485_start_tx =3D NULL;
		uart->rs485_stop_tx =3D NULL;

Should uart->overrun_backoff_time_ms also be reset to 0 there so the
recycled port slot does not retain the previous subdriver's backoff setting?

> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/825=
0/8250_omap.c
> index 29a203ed93fd8..07ebed6ac6c91 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -786,6 +786,9 @@ static void omap_8250_shutdown(struct uart_port *port)
> =20
>  	disable_irq_nosync(port->irq);
> =20
> +	if (up->overrun_backoff_time_ms)
> +		cancel_delayed_work_sync(&up->overrun_backoff);

[Severity: High]
Can an in-flight omap8250_irq() handler on another CPU schedule
up->overrun_backoff after cancel_delayed_work_sync() returns here?

In omap_8250_shutdown(), disable_irq_nosync(port->irq) masks the interrupt
line without waiting for an already-executing IRQ handler on another CPU to
finish (whereas serial_core only calls synchronize_irq(uport->irq) in
uart_port_shutdown() after uport->ops->shutdown(uport) has already returned,
and uart_suspend_port() does not call synchronize_irq() at all).

Meanwhile, in drivers/tty/serial/8250/8250_omap.c:omap8250_irq(), UART_LSR
is read before acquiring port->lock, and schedule_delayed_work() is called
outside port->lock even if UART_IER has already been cleared to 0 by
omap_8250_shutdown():

	if ((lsr & UART_LSR_OE) && up->overrun_backoff_time_ms > 0) {
		unsigned long delay;

		/* Synchronize UART_IER access against the console. */
		uart_port_lock(port);
		up->ier =3D serial_port_in(port, UART_IER);
		if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
			port->ops->stop_rx(port);
		} else {
			/* Keep restarting the timer until
			 * the input overrun subsides.
			 */
			cancel_delayed_work(&up->overrun_backoff);
		}
		uart_port_unlock(port);

		delay =3D msecs_to_jiffies(up->overrun_backoff_time_ms);
		schedule_delayed_work(&up->overrun_backoff, delay);
	}

If omap8250_irq() is past the UART_LSR read on another CPU when
omap_8250_shutdown() runs, couldn't it call
schedule_delayed_work(&up->overrun_backoff, delay) after
cancel_delayed_work_sync(&up->overrun_backoff) has already completed,
causing serial_8250_overrun_backoff_work() to fire after the port is shut
down or runtime-suspended?

> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 4afebd96e0621..710d2a28b9182 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2497,6 +2497,9 @@ void serial8250_do_shutdown(struct uart_port *port)
> =20
>  	synchronize_irq(port->irq);
> =20
> +	if (up->overrun_backoff_time_ms)
> +		cancel_delayed_work_sync(&up->overrun_backoff);

[Severity: High]
What happens if serial_8250_overrun_backoff_work() is already executing when
serial8250_do_shutdown() (or omap_8250_shutdown()) clears up->ier and
UART_IER?

Both serial8250_do_shutdown() and omap_8250_shutdown() clear up->ier and
UART_IER under port->lock and then drop port->lock before calling
cancel_delayed_work_sync(&up->overrun_backoff):

	scoped_guard(uart_port_lock_irqsave, port) {
		up->ier =3D 0;
		serial_port_out(port, UART_IER, 0);
	}

	synchronize_irq(port->irq);

	if (up->overrun_backoff_time_ms)
		cancel_delayed_work_sync(&up->overrun_backoff);

In drivers/tty/serial/8250/8250_core.c, serial_8250_overrun_backoff_work()
unconditionally re-enables RX interrupts under port->lock:

static void serial_8250_overrun_backoff_work(struct work_struct *work)
{
	struct uart_8250_port *up =3D container_of(to_delayed_work(work), struct u=
art_8250_port,
						 overrun_backoff);

	guard(uart_port_lock_irqsave)(&up->port);
	up->ier |=3D UART_IER_RLSI | UART_IER_RDI;
	serial_out(up, UART_IER, up->ier);
}

If the delayed work timer expires just before cancel_delayed_work_sync() so
serial_8250_overrun_backoff_work() is waiting on up->port.lock while
shutdown clears UART_IER (or starts running during synchronize_irq()), it
will acquire up->port.lock as soon as shutdown releases it and write
UART_IER_RLSI | UART_IER_RDI back into up->ier and the hardware UART_IER
register.

cancel_delayed_work_sync() will then wait for that callback to finish and
return, leaving UART_IER_RLSI | UART_IER_RDI enabled on the shut-down port.
Furthermore, in serial8250_do_shutdown(), the IRQ handler (such as
fsl8250_handle_irq()) remains registered until up->ops->release_irq(up) at
the end of the function, so a subsequent overrun interrupt before
release_irq() can fire and call schedule_delayed_work(&up->overrun_backoff,
delay) again after cancel_delayed_work_sync() has already completed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D8
