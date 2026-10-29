Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261220;
	b=Id1vzpesJhwXkNHIJUlLnrJdQmxoYnoRlt1vMEHtJ/S+tM4x34gahbttaWDcc6eHxbv/
	 ewjVM+y72jyxV/BL0oU96seqoXwtv8uE5a7G3xzx02kCHB2+9qA3dOzXNQtZtwNC6YMLo
	 29fhFWal5IRuVt7FqLR87bncV4gDOpv3TJ6K+v8CQOFvFBZOigiUEpIKmlVYhtEuYmecQ
	 MGc10B2sA1+LPN2BuAzz2mwWiDZCB1jfxpcv1ckrV5Z4ulfbX6P6+PSO+vHv30jHXG82i
	 4qA1oo5FxYRQ7H6b5h9RPID3giFLwzlLdmHFhjgKRaiWf0tph3dZQ7f8cC6ogDVoIpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261220;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ws0wmsu8MwZXjRuDGVq8XFSZI1ucban0G0LDxPDtq2E=;
	b=jjBNiBigiMsZEZRTYBSh7+JfRL7kA6/kBlOJCrwKifdJ+zJ+y9EoGTY9epuqt9FMNEy1
	 GbcGR26TKDXmuc/eIgGpxK3OatYbr1f1fwDsJhIcqi1fSQ3wMIpltgmE9cVftMDugbjaF
	 5gxPj2mYlr9rGe4b8TB5aYAG/dbSezy4vtvyVmSl5llwFOxiK03DKckjQrUZJEQMHjhZV
	 wYsVD/lPwgNvoA4B1DV9qruQioD1XjU01niiSR7rDHDBi0hyv3NaXpLgOTaGTZOvO7mXU
	 giyySjSTdnqm9t4dR0q8feTJv070NThO53uTlufeqWSyYDKTby8V7yk1UYasX+KUWhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hj0mQuIC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2764606A32D;
	Thu, 29 Oct 2026 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hj0mQuIC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F33F1F01825;
	Thu, 29 Oct 2026 08:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793261219;
	bh=ws0wmsu8MwZXjRuDGVq8XFSZI1ucban0G0LDxPDtq2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hj0mQuICaLYkuPbbiCiTQ8y8rOWgeTlpfX5D6x13I3DZHr4yEX1/nz8OboXjeb12d
	 TKK6lzjdQXPs/bKQFcq0Eyxqa+FWZABWON9PdE04h9qpgPxaFs8iIFB86Qmkg2UiXt
	 pvH1ynVeNYTAsIQ35RAzBegMjRwUikbYnZVRGuJmhd4H9p2RmF7fME0yBQSlEL/Io/
	 tICuZdqmHaxIB8SDmXy1TfRb3xJp7xxBziTvQdj0vCRiYd5suTmO9JctuYHlmFTbBQ
	 zgFUew+cuESdGkoNj5tYn83jqL63ATu0JWZ7b9mvsQkhL5nqnX6dXXP/SVO72rwZ/Q
	 Kh/VM/X3XuMiw==
Message-ID: <sashiko-outbox-188946@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/6] serial: core: allow drivers to reserve flushed
 transmit storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261029-submit-serial-8250-dma-cancel-v1-v8-3-3fd56ba352ed@gmail.com>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-3-3fd56ba352ed@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:06:58 +0000
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
- [High] serial: core: lockdep assertion failure in uart_write_wakeup() via=
 asc_startup()
- [High] serial: core: lost tty->write_wait wakeup on flush when xmit is no=
t writable
--

commit 887d77aad417709eb7acabd98bee111266577f06
Author: James Hilliard <james.hilliard1@gmail.com>

serial: core: allow drivers to reserve flushed transmit storage

This commit adds uart_xmit_block() and uart_xmit_unblock() so serial drivers
can reserve flushed transmit FIFO storage until asynchronous DMA transfers
have retired. It also gates writes and write-ready wakeups on port readiness
and storage reservation state under the UART port lock.

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index c0deec0e6af41..11bd1260cdc63 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -100,6 +100,11 @@ static inline struct uart_port *uart_port_check(stru=
ct uart_state *state)
>  	return state->uart_port;
>  }
> =20
> +static bool uart_xmit_writable(const struct uart_state *state)
> +{
> +	return state->xmit_ready && !state->xmit_blocked;
> +}
> +
>  /**
>   * uart_write_wakeup - schedule write processing
>   * @port: port to be processed
> @@ -114,15 +119,79 @@ static inline struct uart_port *uart_port_check(str=
uct uart_state *state)
>  void uart_write_wakeup(struct uart_port *port)
>  {
>  	struct uart_state *state =3D port->state;
> +
> +	lockdep_assert_held_once(&port->lock);

[Severity: High]
Can this trigger a lockdep warning when opening or resuming an ST ASC serial
port?

During port startup or resume, uart_port_startup() and uart_resume_port()
invoke uport->ops->startup(uport) with port->mutex held, but without
port->lock held.

In drivers/tty/serial/st-asc.c, asc_startup() calls asc_transmit_chars()
without holding port->lock:

drivers/tty/serial/st-asc.c:asc_startup() {
	...
	asc_transmit_chars(port);
	asc_enable_rx_interrupts(port);

	return 0;
}

asc_transmit_chars() calls uart_port_tx_limited(), which expands
__uart_port_tx() in include/linux/serial_core.h:

	pending =3D kfifo_len(&__tport->xmit_fifo);
	if (pending < WAKEUP_CHARS) {
		uart_write_wakeup(__port);

Because pending is below WAKEUP_CHARS on startup, __uart_port_tx() calls
uart_write_wakeup() without port->lock held, hitting the new
lockdep_assert_held_once(&port->lock) assertion and reading
state->xmit_ready and state->xmit_blocked unlocked.

[ ... ]

> @@ -682,8 +762,9 @@ static void uart_flush_buffer(struct tty_struct *tty)
>  	kfifo_reset(&state->port.xmit_fifo);
>  	if (port->ops->flush_buffer)
>  		port->ops->flush_buffer(port);
> +	/* Serialize the wakeup with reservation changes, including another flu=
sh. */
> +	uart_write_wakeup(port);
>  	uart_port_unlock_deref(port, flags);
> -	tty_port_tty_wakeup(&state->port);
>  }

[Severity: High]
Could replacing tty_port_tty_wakeup(&state->port) with uart_write_wakeup(po=
rt)
here cause threads waiting for the transmit buffer to drain in
tty_wait_until_sent() or set_termios() to miss their wakeup and hang?

Waiters in tty_wait_until_sent() and set_termios() sleep on tty->write_wait
until !tty_chars_in_buffer(tty), which checks kfifo_len(&state->port.xmit_f=
ifo).
Previously, uart_flush_buffer() emptied xmit_fifo via kfifo_reset() and
unconditionally called tty_port_tty_wakeup(&state->port), which woke
tty->write_wait.

With uart_write_wakeup(port), the wakeup is skipped whenever
!uart_xmit_writable(state) (when state->xmit_ready is false or
state->xmit_blocked is true):

1. If uart_flush_buffer() runs while the port is suspended
   (state->xmit_ready is false), kfifo_reset() empties xmit_fifo so
   tty_chars_in_buffer(tty) becomes 0, but uart_write_wakeup() returns early
   without waking tty->write_wait.

2. If port->ops->flush_buffer(port) calls uart_xmit_block(port),
   state->xmit_blocked is set to true and uart_write_wakeup() suppresses the
   wakeup in uart_flush_buffer(). If the port is subsequently shut down or
   suspended before the async transfer retires (via uart_shutdown(),
   uart_tty_port_shutdown(), or uart_suspend_port()), state->xmit_ready is =
set
   to false before uport->ops->shutdown(uport) runs:

drivers/tty/serial/serial_core.c:uart_shutdown() {
	...
	if (uport) {
		scoped_guard(uart_port_lock_irq, uport)
			state->xmit_ready =3D false;
		serial_base_port_shutdown(uport);
	}
	...
	if (tty_port_initialized(port)) {
		...
		uart_port_shutdown(port);
	}
}

   When uport->ops->shutdown(uport) then retires the transfer and calls
   uart_xmit_unblock(uport), uart_write_wakeup(uport) sees state->xmit_ready
   is false and returns early again, permanently losing the deferred wakeup
   for any drain waiters on tty->write_wait.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-submit-ser=
ial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com?part=3D3
