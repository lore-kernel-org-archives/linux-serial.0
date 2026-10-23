Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792798997;
	b=JLvRipEklwDD9ixafOsQKnQuHBaR58Pn7xSHfBkQdRB6lzRX9UOCJnCUtS0mYt5Uk11E
	 h4YoySePzIuiGwc28PXZ8ULVc5n09IF8F4P1C0MQxmFu+32W2J8MXsdjMgzXzdkIGSj7q
	 q4wPrpclxpZpEpR/PXa7G4FzxTwTDfCm1SHQUZOcqDQfaGhIoxv5o4wLs4roWumCZcDip
	 xWUxyNdlM/rUaXBylBvTOfKLlMVq2bwozgpC61JoxsaE4+ojsrBg2aznyg1MsjxwoewFD
	 m32yc0uzON8MQ4AWq8zMC4fN/Yu9YNohw24jb58EZyGcYepkDOhVlTTW6DQnrUHZ4oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792798997;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FPsfde8YxOHDp7aosHgoVbONaJKp2v6gpfuF7Irl66k=;
	b=UEFKwHdd1Fs9wwEzpeUL1nZZQfFJIAIHzzIAp3NsrwqeOmhakcug6WxACZstw4PwdHiX
	 tLLjgRUrFlBhpXaAEVv9t4dot1aBNWwverzE8e8XZGlJIN2LJB92BoQQrJYJg1/p+Bcox
	 v2oWJb+KJE9bp/sGc760UY+cEU6nA3zuRmAmbizKrUJTwVvKt6ljGTjM0jnrkLQnVZgYY
	 BWmGLD16CbQ9XkjXIiIzqSgKY7KcU6MdH0EvYXwAwb+wTSBejbqEvCQ9BCWQ8cYHfUD2h
	 RS4L3CvwhCUFMPHYDnHcY8+f6cGEF6dhpk8RichDFccdbyHXbYiOc9arkcOPXjV6ZQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C21q8aO0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073BC606A31B
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C21q8aO0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846541F01825;
	Fri, 23 Oct 2026 23:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792798996;
	bh=FPsfde8YxOHDp7aosHgoVbONaJKp2v6gpfuF7Irl66k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C21q8aO0Nq1d2hycLGV9HhBYO46X20Jp9gbrwgonlNoBq1ycfs/by0v7sy7m+Hoaz
	 jbcc1fwsJSrFMWxmBxlNnt1bOhqjT8TUKbvJOmg0EhbTme1LskU0itMmYOqKDraF5O
	 evRL6CVgis7cmg6yx/bykeCnQ8rkRFVvAXi4mg6P1czv+5axEoIIxhTRhaJZw8ksdW
	 roOS93gIz4EKjrkAUlANaPFdFqE2dulCEgvzlH0UzFEKVC6GWVI+p4fwydBruKVci4
	 J1HbLQh2zE92QVGUG3gQqrV1cSXpKhTaqPighvLqmmmEsMLuWk+HOwDUi7zOVzrmrg
	 OX1s0JxoWYpug==
Message-ID: <sashiko-outbox-183428@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] serial: core: allow drivers to reserve flushed
 transmit storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023-submit-serial-8250-dma-cancel-v1-v4-2-e759de1839de@gmail.com>
References: <20261023-submit-serial-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com>
 <20261023-submit-serial-8250-dma-cancel-v1-v4-2-e759de1839de@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 23:43:16 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] serial: core: race and late unblock in uart_resume_port()
- [High] serial: core: stale xmit_blocked in uart_alloc_xmit_buf() when reu=
sing xmit_buf
- [High] serial: core: permanent TX block if uart_xmit_unblock() runs durin=
g startup
- [Medium] serial: core: lost deferred write wakeup when restarting open po=
rt
--

commit f5e8cd060228c45857c337ffa1d0fd793601a7e0
Author: James Hilliard <james.hilliard1@gmail.com>

serial: core: allow drivers to reserve flushed transmit storage

This commit adds uart_xmit_block() and uart_xmit_unblock() so UART drivers =
can
reserve the transmit FIFO buffer after uart_flush_buffer() until any in-fli=
ght
asynchronous DMA transfer and its completion callbacks have retired. While
blocked, write_room() reports zero, write() and put_char() reject new data,
and write wakeups are deferred until the reservation is released.

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index c0deec0e6af41..e5756934b8f47 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -119,10 +119,56 @@ void uart_write_wakeup(struct uart_port *port)

[ ... ]

> +void uart_xmit_unblock(struct uart_port *port)
> +{
> +	lockdep_assert_held_once(&port->lock);
> +	if (!port->state->xmit_blocked || !tty_port_initialized(&port->state->p=
ort))
> +		return;
> +	port->state->xmit_blocked =3D false;
> +	uart_write_wakeup(port);
> +}
> +EXPORT_SYMBOL_GPL(uart_xmit_unblock);

[Severity: High]
Can checking !tty_port_initialized(&port->state->port) in uart_xmit_unblock=
()
leave state->xmit_blocked permanently stuck at true if a flush and DMA
retirement complete during port startup?

In tty_port_open(), uart_set_info() (TIOCSSERIAL), and uart_do_autoconfig()
(TIOCSERCONFIG), uart_startup() -> uart_port_startup() allocates
state->port.xmit_buf, invokes uport->ops->startup(uport) (enabling interrup=
ts
and DMA), and configures line settings before tty_port_set_initialized(port,
true) is called:

drivers/tty/tty_port.c:tty_port_open() {
	...
		clear_bit(TTY_IO_ERROR, &tty->flags);
		if (port->ops->activate) {
			int retval =3D port->ops->activate(port, tty);
			if (retval) {
				set_bit(TTY_IO_ERROR, &tty->flags);
				return retval;
			}
		}
		tty_port_set_initialized(port, true);
	...
}

During that window, tty_port_initialized() is still false, while TTY_IO_ERR=
OR
is already cleared and neither uart_write(), uart_put_char(), nor
uart_flush_buffer() checks tty_port_initialized() or acquires port->mutex.

If TX DMA is started and flushed in this window (for example via RX echo and
a VINTR/VQUIT/VSUSP signal character in n_tty_receive_signal_char() ->
isig() -> tty_driver_flush_buffer(), or via a concurrent write() and
ioctl(TCFLSH, TCOFLUSH) on an existing descriptor), uart_flush_buffer() cal=
ls
port->ops->flush_buffer(port) -> uart_xmit_block().

If that DMA transfer finishes retiring and calls uart_xmit_unblock() before
tty_port_set_initialized(port, true) runs, uart_xmit_unblock() sees
!tty_port_initialized() and returns early without clearing
state->xmit_blocked. When tty_port_set_initialized(port, true) subsequently
executes in tty_port_open(), uart_set_info(), or uart_do_autoconfig(),
nothing calls uart_xmit_unblock(), leaving TX permanently wedged with
uart_write_room() returning 0 and uart_write()/uart_put_char() dropping all
writes.

[ ... ]

> @@ -260,6 +309,7 @@ static int uart_alloc_xmit_buf(struct tty_port *port)
>  	uport =3D uart_port_ref_lock(state, &flags);
>  	if (!state->port.xmit_buf) {
>  		state->port.xmit_buf =3D buf;
> +		state->xmit_blocked =3D false;
>  		kfifo_init(&state->port.xmit_fifo, state->port.xmit_buf,
>  				PAGE_SIZE);
>  		uart_port_unlock_deref(uport, flags);

[Severity: High]
What happens in uart_alloc_xmit_buf() when state->port.xmit_buf is already
allocated and the else branch is taken?

In uart_alloc_xmit_buf(), state->xmit_blocked is only cleared when
state->port.xmit_buf is NULL:

drivers/tty/serial/serial_core.c:uart_alloc_xmit_buf() {
	...
	uport =3D uart_port_ref_lock(state, &flags);
	if (!state->port.xmit_buf) {
		state->port.xmit_buf =3D buf;
		state->xmit_blocked =3D false;
		kfifo_init(&state->port.xmit_fifo, state->port.xmit_buf,
				PAGE_SIZE);
		uart_port_unlock_deref(uport, flags);
	} else {
		uart_port_unlock_deref(uport, flags);
		kfree(buf);
	}
}

If uart_flush_buffer() sets state->xmit_blocked =3D true on an open port and
uart_suspend_port() then runs, uart_suspend_port() sets
tty_port_set_initialized(port, false) and calls ops->shutdown(uport) to
retire DMA without freeing state->port.xmit_buf, leaving state->xmit_blocked
set to true.

If the port is then closed while tty_port_initialized(port) is false,
tty_port_shutdown_locked() returns early without calling
uart_tty_port_shutdown() or uart_free_xmit_buf():

drivers/tty/tty_port.c:tty_port_shutdown_locked() {
	if (!tty_port_initialized(port))
		return;
	...
}

This can be reached without uart_resume_port() having run its unblock path,
for example when:
- a driver's suspend or freeze callback fails after calling
  uart_suspend_port() or serial8250_suspend_port() (such as
  omap8250_suspend(), pci1xxxx_suspend(), or imx_uart_suspend()), so the PM
  core skips the driver's resume callback;
- a driver's resume callback fails before calling uart_resume_port() or
  serial8250_resume_port() (such as omap8250_resume(), pci1xxxx_resume(),
  bcm2835aux_resume(), brcmuart_resume(), loongson_uart_resume(), or
  uniphier_uart_resume());
- a PCMCIA serial port (serial_cs.c) is suspended at runtime via sysfs
  pm_state and then closed and reopened; or
- a console port is suspended with console_suspend_enabled =3D=3D true and
  resumed after console_suspend_enabled is set to false, skipping the
  (console_suspend_enabled || !uart_console(uport)) block in
  uart_resume_port().

On a subsequent open (uart_open() -> tty_port_open() -> uart_port_activate()
-> uart_startup() -> uart_port_startup() -> uart_alloc_xmit_buf()) or
reconfiguration (uart_set_info() -> uart_startup() -> uart_port_startup()),
uart_alloc_xmit_buf() sees state->port.xmit_buf !=3D NULL, takes the else
branch, and leaves state->xmit_blocked set to true with no active DMA
transfer to ever call uart_xmit_unblock(). Could state->xmit_blocked remain
stuck true and permanently block all transmit operations on the port?

[Severity: Medium]
Also in uart_alloc_xmit_buf(), if state->xmit_blocked was true and a new
xmit_buf is allocated while the TTY remains open, could clearing
state->xmit_blocked =3D false directly without calling uart_write_wakeup() =
lose
a deferred write wakeup?

When uart_flush_buffer() runs on a port whose driver calls uart_xmit_block(=
),
uart_write_wakeup() suppresses tty_port_tty_wakeup(&state->port) and defers
waking writers on tty->write_wait and one-shot TTY_DO_WRITE_WAKEUP line
discipline callbacks until the reservation is released.

If the open port is then shut down and restarted via TIOCSERCONFIG
(uart_do_autoconfig()) or TIOCSSERIAL (uart_set_info() when change_port or
change_irq is true), or if uart_resume_port() fails ops->startup(uport) and
calls uart_shutdown(tty, state) followed by a later open() on the still-open
TTY, uart_shutdown() clears TTY_PORT_INITIALIZED before ops->shutdown(uport)
(making any driver uart_xmit_unblock() call a no-op) and frees xmit_buf via
uart_free_xmit_buf().

When uart_startup() -> uart_port_startup() -> uart_alloc_xmit_buf() then
allocates a new xmit_buf, it sets state->xmit_blocked =3D false without cal=
ling
uart_write_wakeup(), and nothing in the startup path triggers a TX wakeup
because the newly allocated FIFO is empty. Wouldn't writers sleeping on
tty->write_wait or line disciplines waiting for write_wakeup() stall?

[ ... ]

> @@ -2500,6 +2551,8 @@ int uart_resume_port(struct uart_driver *drv, struc=
t uart_port *uport)
>  					ops->start_tx(uport);
>  				}
>  				tty_port_set_initialized(port, true);
> +				scoped_guard(uart_port_lock_irq, uport)
> +					uart_xmit_unblock(uport);
>  			} else {
>  				/*
>  				 * Failed to resume - maybe hardware went away?

[Severity: High]
In uart_resume_port(), is calling uart_xmit_unblock(uport) after
ops->startup(uport), uart_change_line_settings(), and ops->start_tx(uport)
have already run and dropped uport->lock safe against a concurrent
uart_flush_buffer()?

Looking at the resume sequence in uart_resume_port():

drivers/tty/serial/serial_core.c:uart_resume_port() {
	...
			ret =3D ops->startup(uport);
			if (ret =3D=3D 0) {
				if (tty)
					uart_change_line_settings(tty, state, NULL);
				uart_rs485_config(uport);
				scoped_guard(uart_port_lock_irq, uport) {
					if (!(uport->rs485.flags & SER_RS485_ENABLED))
						ops->set_mctrl(uport, uport->mctrl);
					ops->start_tx(uport);
				}
				tty_port_set_initialized(port, true);
				scoped_guard(uart_port_lock_irq, uport)
					uart_xmit_unblock(uport);
			}
}

This placement appears to create two issues:

1. If state->xmit_blocked was false prior to suspend, ops->start_tx(uport) =
can
   start a new TX DMA transfer from state->port.xmit_buf (using data queued
   before suspend or written after ops->startup()). When the first
   scoped_guard(uart_port_lock_irq, uport) exits, uport->lock is released
   before tty_port_set_initialized(port, true) and the second scoped_guard
   calling uart_xmit_unblock(uport).

   Because uart_flush_buffer() only serializes on uport->lock and does not
   take port->mutex, a concurrent uart_flush_buffer() in that unlocked wind=
ow
   (for example via tcflush(TCOFLUSH), serdev_device_write_flush(), or an RX
   signal character in n_tty_receive_signal_char() ->
   tty_driver_flush_buffer()) will reset xmit_fifo and call
   port->ops->flush_buffer(port) -> uart_xmit_block(uport) to reserve
   state->port.xmit_buf for the newly started post-resume DMA transfer.

   Immediately afterward, uart_resume_port() sets
   tty_port_set_initialized(port, true), re-acquires uport->lock, and calls
   uart_xmit_unblock(uport), which cannot distinguish a stale pre-suspend
   reservation from the new post-resume reservation. Doesn't this clear
   state->xmit_blocked =3D false and wake writers to overwrite
   state->port.xmit_buf while the post-resume TX DMA transfer is still in
   flight?

2. Conversely, if state->xmit_blocked was true before suspend (and the old
   transfer was already retired by ops->shutdown(uport) in
   uart_suspend_port()), state->xmit_blocked remains true while
   uart_change_line_settings() runs during resume. If uport->hw_stopped
   transitions from true to false in uart_change_line_settings(),
   __uart_start(state) sees state->xmit_blocked && !port->x_char and returns
   early without starting TX.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-submit-ser=
ial-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com?part=3D2
