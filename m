Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792780804;
	b=PNV+wLNiDO/2LBKy8gfdMYgut2WNz6Mt6f3LajLbg4No/hUE+kLPBSzZYoqvhWw/tdww
	 b7N6p0OGffY59OuzcBBb5Z17fOA3CiX1Q/vqUV6QVjnpfSYNI6qgPNEGKN6gtFayuanMg
	 S1bf/2aJmUtccKAH3R9C1G6DZkrORpslM0bWYvbYFtDDVhBsNo9kbYDucyGaqKg7cltbj
	 sBc6W+eO+Us81F7hhbBhgh42ztybCQfLmT9+vmVG3E5jnLjOgvsmrlzYgnyBR2JIQgbiW
	 izJhxs7d2eChwC4utNzz+vN1LLRl07x/wKsKEnQsdpIJlXXysNBlQjhMZkHrRuu3s7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792780804;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0gGA7273TDq9AAWUONdDIMgpPkvGCdrxko62X2P7Rkk=;
	b=f6i0Tp/v2IK+7LnxtVa1VR8YXxM5RUuoO3DWDW7pzlqicHauRcVIYZduBBBSBRk6PfEI
	 JycI3se9oVsw7CIX1eyj5hS63KWBdhQH5ybIeruWqwuiUJx7jS9eu/asY6nx2C71oOiuP
	 pQ73wKcb4ZteCk7pAuTKNwWumiWdBX0OCf7b/Z+0R7Mug72Y2BkfrNRw9t8hO/ID1RJwf
	 GmB3Fg+yvRfB26mJeWkGeR4WBXlIAB18EhuA+JjFX9A4XzWvcdc+52tJ6jMwU/EFU40Pj
	 YJX8sG1hMZdXcKXdYL00OOFzTBVdP+qVbACUJmSL9p4AOvbGmWqlOiw8yk50dAhbmsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MzzmlTdm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC4A606A31A
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MzzmlTdm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294D61F01825;
	Fri, 23 Oct 2026 18:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792780803;
	bh=0gGA7273TDq9AAWUONdDIMgpPkvGCdrxko62X2P7Rkk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MzzmlTdmbkze40cbT+lsY9dV9/Gppvckb3qwxyKFDy2mwjtM7RgwR0Tu7wVbMX35c
	 iWgyNkYMIU9oe6ABU+mzmdRuL5fj1rXN/8mcgveY/BZIdY02LtXJy19tLwX/Bb0Ckg
	 Jc/qtQLIJSU2BhRfVN14bNK83flrCnPoSkQACWs/O6GB8RNoK5gDT3aR16EczEfNI8
	 75dFL01qOBSr9XV8MA5uFdXBjJ1PlmC4eILMwtJnqWEuN+axkNVOYWEhcDAPPFXNPc
	 dMStlTaIvUz/Cccd9k3C8yJY2FdtPwrRbhyi/lbeeZVBXzJsIKSZnE1cdhrEVlqIhr
	 a5qry2VV2Wxyg==
Message-ID: <sashiko-outbox-183078@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] serial: core: allow drivers to reserve flushed
 transmit storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023-submit-serial-8250-dma-cancel-v1-v3-2-d78f9e4c4932@gmail.com>
References: <20261023-submit-serial-8250-dma-cancel-v1-v3-0-d78f9e4c4932@gmail.com>
 <20261023-submit-serial-8250-dma-cancel-v1-v3-2-d78f9e4c4932@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 18:40:02 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] serial: core: uart_xmit_unblock() unblocks TX and wakes writers =
on shutdown
--

commit 6406836c9f0fb8695332478ed1176afc95924b74
Author: James Hilliard <james.hilliard1@gmail.com>

serial: core: allow drivers to reserve flushed transmit storage

This commit adds uart_xmit_block() and uart_xmit_unblock() to allow UART
drivers to reserve the transmit FIFO buffer across asynchronous DMA flush
completion while deferring TTY write wakeups and blocking new writes.

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index c0deec0e6af41..cb4e98886cee9 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -119,10 +119,53 @@ void uart_write_wakeup(struct uart_port *port)
>  	 * closed.  No cookie for you.
>  	 */
>  	BUG_ON(!state);
> +	if (state->xmit_blocked)
> +		return;
>  	tty_port_tty_wakeup(&state->port);
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
> + * Write wakeups are deferred until the reservation is released.
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

[Severity: Medium]
When a driver calls uart_xmit_unblock() from its uport->ops->shutdown()
callback as required by the documented contract in include/linux/serial_cor=
e.h
(for example via serial8250_release_dma() in the follow-up 8250 change), can
this unblock transmit and trigger uart_write_wakeup() while the port is
shutting down or suspending and state->port.xmit_buf is still allocated?

If a transmit flush calls uart_xmit_block() while TX DMA is active and the
port then enters shutdown or suspend before the asynchronous flush complete=
s,
uport->ops->shutdown() runs before state->port.xmit_buf is freed in
drivers/tty/serial/serial_core.c:

uart_tty_port_shutdown()
    serial_base_port_shutdown(uport);
    uart_port_shutdown(port);
        uport->ops->shutdown(uport);
    ...
    uart_free_xmit_buf(port);

and in uart_suspend_port(), ops->shutdown(uport) is called without freeing
state->port.xmit_buf at all:

uart_suspend_port()
    ops->shutdown(uport);

In tty_port_close(), tty_port_shutdown() also runs before tty->flags has
TTY_IO_ERROR set, before tty_port_tty_set(port, NULL), and before
tty_ldisc_release(), while drivers drop port->lock across sleeping calls su=
ch
as dma_release_channel() and free_irq() after calling uart_xmit_unblock().

If a woken or concurrent writer (such as a line discipline write_work
handler, a serdev client, or a thread in n_tty_write() during uart_set_info=
()
or uart_do_autoconfig() -> uart_shutdown()) calls uart_write() in that wind=
ow,
it sees state->port.xmit_buf !=3D NULL and !state->xmit_blocked, queues byt=
es
into state->port.xmit_fifo, and calls __uart_start(state) ->
port->ops->start_tx(port) on a shut-down or suspending port (which in 8250
drivers can acquire an unbalanced runtime PM reference via
serial8250_rpm_get_tx() or re-enable transmit interrupts after DMA teardown,
and in uart_tty_port_shutdown() any newly queued bytes are then discarded by
uart_free_xmit_buf()).

Should uart_xmit_unblock(), uart_write(), and __uart_start() avoid waking
writers or starting transmission when the port is no longer initialized or =
is
being shut down?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-submit-ser=
ial-8250-dma-cancel-v1-v3-0-d78f9e4c4932@gmail.com?part=3D2
