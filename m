Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792716736;
	b=H1t/gcwtJ9lN8XmmEnZ4sx7IqCRPm345hNIDrX373A/IzpQJ3S7LaCavCIJl1T2zAH9r
	 LwsNe1bwMJwCWgHQ9W6spPyfauulsiZsNfbvmKpjBZ8IerckGU70Z8xtTbIF6A/1sDBqi
	 2IK8Ss97SCGbWwQGIayPbrtnZgoHDLNpGhyXYy3uHwjQQt2Zf3h7rruKo9ZInu21A91Ul
	 rPIgP+wsWvomwQUZZOmkQb3S7WmUk+Rmrj9m96r2fcEV/+BfgI/2A4xhciCcc81XBtKHi
	 n2eMwRLwyqLf5wkS/sveHaMXt7MZ7uMVdLbQWWjWej4cKgQtIAcd7xgYl7JchXYOgDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792716736;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zJzjrrhzM0ixSiXTJfMiX4V75XXZHU0uRHaVUY1PWrE=;
	b=GMTDR7osm9qtILHuG+PSr6VHkFawuTb4/acQoUKYt4lZAPqQBTMHxUjehXpIf6wtbUmA
	 kdhrEYUFdYMtiZd4jTeeqqh7Jh4vMjKEFKIWgS7EX/kOR9e9B9s4ns2xUJ/nAYQjm9oVn
	 eL4whEHFUslcENVNAMbQ36EkDT669E8C4hcO1HVAATDhhFKYlnOEeNTRpGTEF/WNbb0to
	 SiZA446Zb4chjpmMQsZkagM+eP4TOlk0J5BMzvAV24zP7/jb3bod/B5BoEcPgfsxNihU2
	 cJLfbL4OyjBBrd9OqrTPjviNyxotfe4TthjXfVtUyiqa5PqopdJkM7xce0dGvO+6FSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EWvm7ZWn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E06606A319
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 00:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EWvm7ZWn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C8C1F01825;
	Fri, 23 Oct 2026 00:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792716735;
	bh=zJzjrrhzM0ixSiXTJfMiX4V75XXZHU0uRHaVUY1PWrE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EWvm7ZWn2wFcXwnMueucL6hZd0Ss2x+d/XalUg25sDWdq8nguzTJ5Xx1KkxK8KUSp
	 nKOu8bSyiy53uS5iAgNSQzQGt4HesjssoxI32RxFWKU75bFzolcbiBtNOPqeeJ2f29
	 g4opXFvGKMGCcxI9FDvQslAqffWhy3AZpSm27FUy6HzzLiyqiEucwDCcNH+RRwFJQn
	 WLpkHbftopQ/Ee+0LJ4fgjz+J6tFArmJ7QT8vLAuGQwNn78JWihISmis8G0YLpiJab
	 U1ksVrasA7miSO+axxumEWRsRpMQx+4EEeElv95/7bSjiTHolkHiimg1Xk/Tfaz1Vn
	 kh4K5oAhaSwXw==
Message-ID: <sashiko-outbox-182185@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] serial: core: allow drivers to reserve flushed
 transmit storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261022-submit-serial-8250-dma-cancel-v1-v2-2-088ea51e3891@gmail.com>
References: <20261022-submit-serial-8250-dma-cancel-v1-v2-0-088ea51e3891@gmail.com>
 <20261022-submit-serial-8250-dma-cancel-v1-v2-2-088ea51e3891@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 00:52:15 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] serial: core: uart_flush_buffer() and uart_write_wakeup() ignore x=
mit_blocked
- [Medium] serial: core: uart_write() and __uart_start() start TX while xmi=
t_blocked
--

commit 31d69e636df648aacf81276c435bae5c06cd9f96
Author: James Hilliard <james.hilliard1@gmail.com>

serial: core: allow drivers to reserve flushed transmit storage

This commit adds uart_xmit_block() and uart_xmit_unblock() so UART drivers
with asynchronous TX DMA can reserve flushed transmit buffer storage until
in-flight transfers and completion callbacks retire. While blocked,
uart_write_room() returns zero and uart_write() and uart_put_char() reject
new data until uart_xmit_unblock() wakes writers.

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index c0deec0e6af41..f82c812f842f1 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -123,6 +123,46 @@ void uart_write_wakeup(struct uart_port *port)
>  }
>  EXPORT_SYMBOL(uart_write_wakeup);
> =20
> +/**
> + * uart_xmit_block - reserve flushed transmit storage
> + * @port: port whose transmit storage is still in use
> + *
> + * A driver may call this from ->flush_buffer() if DMA still owns the old
> + * transmit data. The logical FIFO has already been emptied, but writers
> + * must not overwrite its storage until uart_xmit_unblock() is called.
> + * write_room() reports zero and write()/put_char() accept no data meanw=
hile.
> + *
> + * The driver must unblock after retiring the transfer, including on shu=
tdown.
> + * Repeated calls are idempotent, not nested reservations.
> + *
> + * Context: @port->lock held.
> + */
> +void uart_xmit_block(struct uart_port *port)
> +{
> +	lockdep_assert_held_once(&port->lock);
> +	port->state->xmit_blocked =3D true;
> +}
> +EXPORT_SYMBOL_GPL(uart_xmit_block);
> +
> +/**
> + * uart_xmit_unblock - release reserved transmit storage and wake writers
> + * @port: port whose storage is available again
> + *
> + * The old transfer must no longer access the FIFO storage, and any requ=
ired
> + * DMA synchronization must have completed before this call.
> + *
> + * Context: @port->lock held.
> + */
> +void uart_xmit_unblock(struct uart_port *port)
> +{
> +	lockdep_assert_held_once(&port->lock);
> +	if (!port->state->xmit_blocked)
> +		return;
> +	port->state->xmit_blocked =3D false;
> +	uart_write_wakeup(port);
> +}
> +EXPORT_SYMBOL_GPL(uart_xmit_unblock);

[Severity: High]
Should uart_flush_buffer() and uart_write_wakeup() suppress waking the TTY
layer while state->xmit_blocked is true?

In drivers/tty/serial/serial_core.c, uart_flush_buffer() resets the FIFO,
calls port->ops->flush_buffer(port) where the driver calls
uart_xmit_block(port), drops port->lock, and then unconditionally calls
tty_port_tty_wakeup():

drivers/tty/serial/serial_core.c:uart_flush_buffer() {
	...
	kfifo_reset(&state->port.xmit_fifo);
	if (port->ops->flush_buffer)
		port->ops->flush_buffer(port);
	uart_port_unlock_deref(port, flags);
	tty_port_tty_wakeup(&state->port);
}

Similarly, uart_write_wakeup() does not check state->xmit_blocked:

drivers/tty/serial/serial_core.c:uart_write_wakeup() {
	struct uart_state *state =3D port->state;
	...
	BUG_ON(!state);
	tty_port_tty_wakeup(&state->port);
}

If a caller invokes uart_write_wakeup() while state->xmit_blocked is true
(for example via uart_handle_cts_change(), __uart_port_tx(), or a driver TX
interrupt seeing kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS), or when
uart_flush_buffer() finishes, tty_port_tty_wakeup() -> tty_wakeup() runs
while uart_write_room() is still 0 and uart_write() / uart_put_char() still
reject all data.

Because uart_flush_buffer() also drops port->lock before calling
tty_port_tty_wakeup(), a concurrent writer that sees state->xmit_blocked,
gets 0 from uart_write(), and sets TTY_DO_WRITE_WAKEUP in that window will
have its wakeup bit consumed immediately by uart_flush_buffer() while
state->xmit_blocked is still true.

When tty_wakeup() fires while state->xmit_blocked is true, several line
disciplines and TTY clients break:

1. In drivers/tty/n_tty.c:n_tty_write_wakeup():

	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
	kill_fasync(&tty->fasync, SIGIO, POLL_OUT);

TTY_DO_WRITE_WAKEUP is cleared and SIGIO is sent while uart_write_room() is
0 (so n_tty_poll() reports no EPOLLOUT). If the process checks poll() or
select() rather than calling write() during the premature signal,
TTY_DO_WRITE_WAKEUP remains cleared and the later uart_xmit_unblock() ->
uart_write_wakeup() will not send SIGIO when the buffer is actually
unblocked.

2. In drivers/tty/serdev/serdev-ttyport.c:ttyport_write_wakeup() and
drivers/tty/n_gsm.c:gsm_data_kick(), TTY_DO_WRITE_WAKEUP is cleared and the
write wakeup callback is invoked while uart_write() still returns 0, losing
the one-shot wakeup needed when uart_xmit_unblock() is later called.

3. In drivers/net/mctp/mctp-serial.c:mctp_serial_tty_write_wakeup() ->
mctp_serial_tx_work():

	txlen =3D write_chunk(dev, buf + dev->txpos, 3 - dev->txpos);
	if (txlen <=3D 0) {
		dev->txstate =3D STATE_ERR;

Waking TX while state->xmit_blocked is true causes tty->ops->write() to
return 0, which puts the device into STATE_ERR and leaves its netdev TX
queue permanently stopped.

4. In drivers/input/joystick/iforce/iforce-serio.c:iforce_serio_write_wakeu=
p()
-> iforce_serio_xmit(), queued packets are drained into tty->ops->write()
while state->xmit_blocked is true and silently dropped. In serdev clients
such as btnxpuart_tx_work(), waking TX while serdev_device_write_buf()
returns 0 causes the worker to dequeue an skb, write 0 bytes, requeue it at
the head of nxpdev->txq, and loop. In slcan_transmit(), slip_transmit(), and
qcauart_transmit(), when xleft / tx_left is 0, the premature wakeup clears
TTY_DO_WRITE_WAKEUP and calls netif_wake_queue() while the UART still
rejects writes.

[ ... ]

> @@ -624,7 +665,7 @@ static ssize_t uart_write(struct tty_struct *tty, con=
st u8 *buf, size_t count)
>  		return 0;
>  	}
> =20
> -	if (port)
> +	if (port && !state->xmit_blocked)
>  		ret =3D kfifo_in(&state->port.xmit_fifo, buf, count);
> =20
>  	__uart_start(state);

[Severity: Medium]
When state->xmit_blocked is true, uart_write() skips kfifo_in() and queues 0
bytes, but still calls __uart_start(state) (which can also be reached via
uart_flush_chars() -> uart_start() when n_tty_write() sees 0 write_room in
O_OPOST mode):

drivers/tty/serial/serial_core.c:__uart_start() {
	struct uart_port *port =3D state->uart_port;
	struct serial_port_device *port_dev;
	int err;

	if (!port || port->flags & UPF_DEAD || uart_tx_stopped(port))
		return;
	...
	if (!pm_runtime_enabled(port->dev) || pm_runtime_active(&port_dev->dev))
		port->ops->start_tx(port);
}

Should __uart_start() (or uart_write()) avoid calling port->ops->start_tx()
while state->xmit_blocked is true?

In drivers whose start_tx() touches hardware before checking whether
xmit_fifo is empty, calling start_tx() with an empty FIFO while TX storage
is blocked has unintended side effects:

1. In drivers/tty/serial/fsl_lpuart.c:lpuart_start_tx(),
drivers/tty/serial/sh-sci.c:sci_start_tx(), and
drivers/tty/serial/atmel_serial.c:atmel_start_tx(), start_tx() enables TX
interrupts before checking kfifo_is_empty(), triggering a spurious TX
interrupt or tasklet that sees kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS
and calls uart_write_wakeup(port) while state->xmit_blocked is still true.

2. In drivers/tty/serial/atmel_serial.c:atmel_start_tx(), half-duplex RX is
stopped via atmel_stop_rx(port) and ATMEL_US_TXEN is re-enabled even though
TX storage is blocked and no data was queued.

3. In drivers/tty/serial/amba-pl011.c:pl011_start_tx(), when RS485 is
enabled (SER_RS485_ENABLED), pl011_rs485_tx_start() is called before
checking whether xmit_fifo has data, asserting RTS and disabling RX
(~UART011_CR_RXE) on the RS485 bus despite 0 bytes being accepted.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-submit-ser=
ial-8250-dma-cancel-v1-v2-0-088ea51e3891@gmail.com?part=3D2
