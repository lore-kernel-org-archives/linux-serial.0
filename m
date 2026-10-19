Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F4555CE9E
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419369; cv=none; b=ZPNtV/H5PklSodiAQb2rBKQ5H4v/lnrWl1+ADCVItqH9iCLQCNigyUbT1l8lTScsuC+qqpxZXroAs6CFNmgWlj7e6rLBq36u3Nrim9MKcUEIYMtNHxUuyVEVBmyQ/rM9ggCebfrPuh1z8N6sXCsL+uM6QMtfFGSf9PwDboqqBq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419369; c=relaxed/simple;
	bh=zA0HfqQOZgZbP3gH9h9Nb9QX/QYCs5Lt+CYwwAcdlCA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZYmQ63YqLxALZuKDE6EiWbbxh7WHlT4I2Slgaj1O2d4Vh0Q5jjsT6y3kcSox4u+MQlYAo6Bt6P6e8iTG8JJd2dua/1nJ0OtvaGt4x7iJg1cDb9vcLMOLZv/WJ2Grb1iA51kjH+uc2QrYcpqIIM22Z7qV32Xfw9lzrwwOx+zGbX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4H8kIaF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4H8kIaF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C299F1F000C5;
	Mon, 19 Oct 2026 14:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792419368;
	bh=33qOAmfcRP9GqzKiZkCc7fgeYFOUQjcQ4K+IdAXKkbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T4H8kIaFbRWKTefNrPUB40vZM+dMiTPA4OaZA3dhvLh08z++7BPlgvEXJTOhutKpj
	 5v3DlJSUjP3JmRU705WebWdatt4VAfb2lvXreUmv8cdeLSzDWG014J550/bhR13LtP
	 EUzF1Jlhy+iVi7q4hxlEeaI2XlSOKDVXzIxa19h11VOQJANZ2/sqyQWtapE0Nk5sRT
	 GNK05qVWbrTcWkeUCKF3M0ONnrsGTvBYB/bzq0Xef+Rml+Rbqk33v0L184LVqlHoHo
	 Taqae+cqOs0uOZcQQEmkSqK7urdXqZGHMpsCM30Y3r0JtmHFagCOuVga443ocXkYBs
	 rvG0Wi0iHE9JQ==
Message-ID: <sashiko-outbox-177334@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: timbuart: kill tasklet after freeing IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "LI xiao" <lixiao0@hdu.edu.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <AMoAIAAtLCMmxKHlfyhDJarK.3.1792416715880.Hmail.252270051@hdu.edu.cn>
References: <AHQArwC2LDgmty1sqnW35KqM.1.1792408152646.Hmail.252270051@hdu.edu.cn>
 <2026101954-snarl-frenzy-da86@gregkh>
 <AMoAIAAtLCMmxKHlfyhDJarK.3.1792416715880.Hmail.252270051@hdu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:16:07 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] tty: timbuart: tasklet rescheduled via timbuart_start_tx() aft=
er shutdown causes UAF
--

commit 2fa5108233918f24d98748eb13c80825cd7a576d
Author: LI xiao <lixiao0@hdu.edu.cn>

tty: timbuart: kill tasklet after freeing IRQ

This commit moves tasklet_kill() from timbuart_remove() to
timbuart_shutdown() immediately after free_irq() so that any tasklet
scheduled by the interrupt handler is drained before port resources are
released.

> diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuart.c
> index 7a0326e7102a2..c561ca7021901 100644
> --- a/drivers/tty/serial/timbuart.c
> +++ b/drivers/tty/serial/timbuart.c
> @@ -254,6 +254,7 @@ static void timbuart_shutdown(struct uart_port *port)
>  		container_of(port, struct timbuart_port, port);
>  	dev_dbg(port->dev, "%s\n", __func__);
>  	free_irq(port->irq, uart);
> +	tasklet_kill(&uart->tasklet);
>  	iowrite32(0, port->membase + TIMBUART_IER);
> =20
>  	timbuart_flush_buffer(port);
> @@ -474,7 +475,6 @@ static void timbuart_remove(struct platform_device *d=
ev)
>  {
>  	struct timbuart_port *uart =3D platform_get_drvdata(dev);
> =20
> -	tasklet_kill(&uart->tasklet);
>  	uart_remove_one_port(&timbuart_driver, &uart->port);
>  	uart_unregister_driver(&timbuart_driver);
>  	kfree(uart);

[Severity: Critical]
Can uart->tasklet still be scheduled via timbuart_start_tx() after
timbuart_shutdown() or when tty_port_initialized() is false, leading to a
use-after-free of struct timbuart_port and a NULL or unmapped dereference of
uart->port.membase in timbuart_tasklet()?

In addition to the IRQ handler, timbuart_start_tx() unconditionally schedul=
es
the tasklet:

drivers/tty/serial/timbuart.c:timbuart_start_tx() {
	struct timbuart_port *uart =3D
		container_of(port, struct timbuart_port, port);

	/* do not transfer anything here -> fire off the tasklet */
	tasklet_schedule(&uart->tasklet);
}

In drivers/tty/serial/serial_core.c, neither __uart_start() nor
uart_send_xchar() checks tty_port_initialized(port) or port_dev->tx_enabled
before calling port->ops->start_tx(port):

drivers/tty/serial/serial_core.c:__uart_start() {
	if (!pm_runtime_enabled(port->dev) || pm_runtime_active(&port_dev->dev))
		port->ops->start_tx(port);
}

drivers/tty/serial/serial_core.c:uart_send_xchar() {
	...
	else {
		guard(uart_port_lock_irqsave)(port);
		port->x_char =3D ch;
		if (ch)
			port->ops->start_tx(port);
	}
}

During a normal close in tty_port_close(), tty_port_shutdown() clears
tty_port_initialized(port) and calls:

  uart_tty_port_shutdown()
    -> uart_port_shutdown()
      -> timbuart_shutdown()

When tasklet_kill(&uart->tasklet) in timbuart_shutdown() drains an in-flight
timbuart_tasklet(), timbuart_handle_rx_port() -> timbuart_rx_chars() calls
tty_flip_buffer_push(tport), which queues tport->buf.work (flush_to_ldisc).
Because port->itty and tty->ldisc remain active until tty_release_struct()
after tty_port_close() returns, flush_to_ldisc() can run on another CPU aft=
er
timbuart_shutdown() returns and before tty_ldisc_flush() in
tty_port_close_end() acquires buf->lock. Inside n_tty_receive_buf_common()
(even while tty->closing =3D=3D 1), receiving STOP_CHAR followed by START_C=
HAR
under default IXON termios (n_tty_receive_buf_closing() ->
n_tty_receive_char_closing() -> n_tty_receive_char_flow_ctrl() -> start_tty=
()
-> uart_start() -> __uart_start()), reaching the throttle threshold under
IXOFF (n_tty_check_throttle() -> tty_throttle_safe() -> uart_throttle() ->
uart_send_xchar()), or having EXTPROC set (__receive_buf() ->
uart_flush_chars() -> uart_start() -> __uart_start()) calls
timbuart_start_tx() and schedules uart->tasklet after timbuart_shutdown() h=
as
completed.

Similarly, if timbuart_startup() fails in request_irq() for a CAP_SYS_ADMIN
opener, uart_port_startup() returns 1 with state->port.xmit_buf allocated,
tty_port_open() returns 1 with tty_port_initialized(port) still false, and
uart_open() returns 0. A subsequent open() in tty_port_open() executes
clear_bit(TTY_IO_ERROR, &tty->flags) before port->ops->activate(), allowing=
 a
concurrent write() or ioctl(TCXONC) on the open descriptor (or
ioctl(TIOCSETD) -> tty_set_ldisc() -> n_tty_open() -> tty_unthrottle() ->
uart_unthrottle() -> uart_send_xchar()) to invoke timbuart_start_tx() and
schedule uart->tasklet while tty_port_initialized(port) remains false.

When timbuart_tasklet() runs after timbuart_shutdown(), it unconditionally
writes RXBAF | RXBF | RXTT | CTS_DELTA to TIMBUART_IER:

drivers/tty/serial/timbuart.c:timbuart_tasklet() {
	...
	iowrite32(ier, uart->port.membase + TIMBUART_IER);
}

which re-enables hardware interrupts after timbuart_shutdown() cleared
TIMBUART_IER. Furthermore, because tty_port_initialized(port) is false in
these cases, serial_core_remove_one_port() skips uart_shutdown() during
timbuart_remove():

drivers/tty/serial/serial_core.c:serial_core_remove_one_port() {
		if (tty_port_initialized(port))
			uart_shutdown(NULL, state);
	}

	/*
	 * Free the port IO and memory resources, if any.
	 */
	if (uport->type !=3D PORT_UNKNOWN && uport->ops->release_port)
		uport->ops->release_port(uport);
}

With tasklet_kill(&uart->tasklet) removed from timbuart_remove(),
timbuart_release_port() unmaps and zeroes port->membase and timbuart_remove=
()
frees uart via kfree(uart) while uart->tasklet is still scheduled or runnin=
g.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/AMoAIAAtLCMmxKHlfyh=
DJarK.3.1792416715880.Hmail.252270051@hdu.edu.cn?part=3D1
