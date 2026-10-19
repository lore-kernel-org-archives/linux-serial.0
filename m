Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC073B840E
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403491; cv=none; b=Udd9S8SkpZC7wM+7k/cNK05gONp10mfZbLSF1WKspYHy1BSK9Z4sQjWrcCP70ueccg1qnjChoD9MMVnvW0foNZaHIXYZZuKvdxWoaAP8Z8XMuGwapiB56QiKRX+ksUQW+WKbZzawbWkcJQSwOsch0UY+qDy0ye7Oqpxn+5NOLUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403491; c=relaxed/simple;
	bh=CQ8pZolWohyMub2+MjTTAa+4BZ2Sd7Md73pzRqy1G24=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CB7bwatrYre7ls0VcbjI99cG4lAkhIaqh6d34Vvo8h8ROiTxfrx8Xm+OtcHRpw5XNXA3oVnO/FosxFrGegU8OM9ulm2oyynVxT1GBwE6cqopKJcanmzfbFQDLR1MEVWvc3Ibw9pJWK1EehgR+2YuvwAMn3+9gOMETTJ0mdyW8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNUPsbEd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNUPsbEd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFB11F000C4;
	Mon, 19 Oct 2026 09:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792403490;
	bh=zU1Z1yHM7Dl8P7kr0Iq+7ao9OleF1c0QNl48uaXrREc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eNUPsbEdalQv55LmJ923alQmWXMZmEeM4PcIaWk7UjITXt5E9yUoC4VsIRG/WWRT1
	 pSw8LXqoU3erQ6KdB4TKMsdKym7OXMsNH2hDISV9ybB0LQI8WKfwiib4lvhedKqxb5
	 FnCIn7R22upGfdjsedmY4nlfgumW11Ugut5aBW1x8LQZcf8HLu4d28o3N4fpYpE5LS
	 SwUSXS2ZI8SJ1YhQ1k4TbvO+AN7RAjwh5ZxFqHZxHv4koOpKq27v9f01R8C/19nVdb
	 0zaVmQE1Vkh/U+OTp/oL1xjddwiha7DTl8tkIJ/ENT+F2FpxDLHGB8LcqbYmuG9Tzg
	 A7p0nmQPE6EGg==
Message-ID: <sashiko-outbox-176923@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] serial: amba-pl011: keep RS485 transmission
 running on reconfiguration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261019-devel-nbuchwitz-pl011-rs485-reconfig-stall-v3-2-072a9c82ea5e@tipi-net.de>
References: <20261019-devel-nbuchwitz-pl011-rs485-reconfig-stall-v3-0-072a9c82ea5e@tipi-net.de>
 <20261019-devel-nbuchwitz-pl011-rs485-reconfig-stall-v3-2-072a9c82ea5e@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:51:29 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] serial: amba-pl011: stale port->rs485.flags used in pl011_rs485_co=
nfig()
- [Medium] serial: amba-pl011: active TX REG_CR not updated in pl011_rs485_=
config()
- [Medium] serial: amba-pl011: pl011_tx_pending() mistakes queued data for =
active TX
--

commit c96a4ef5d1b833aa81d92c6442b9a03293883b06
Author: Nicolai Buchwitz <nb@tipi-net.de>

serial: amba-pl011: keep RS485 transmission running on reconfiguration

This commit avoids calling pl011_rs485_tx_stop() in pl011_rs485_config()
when a transmission is already in progress, preventing the transmitter
from being disabled while TX interrupts are still pushing data into the
FIFO. It also preserves uap->rs485_break unless RS485 mode is being
disabled.

> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> index 6adfe7a1e0487..14f0e8aa56fd2 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c

[ ... ]

> @@ -2550,7 +2550,9 @@ static int pl011_rs485_config(struct uart_port *por=
t, struct ktermios *termios,
>  		   tty_port_initialized(&port->state->port) &&
>  		   pl011_tx_pending(uap, tx_stopped)) {
>  		pl011_rs485_tx_resume(uap, rs485, tx_stopped);
> -	} else if (port->rs485.flags & SER_RS485_ENABLED) {
> +	} else if ((port->rs485.flags & SER_RS485_ENABLED) &&
> +		   uap->rs485_tx_state =3D=3D OFF) {
> +		/* Set the idle level now, a transmission sets it when done */
>  		pl011_rs485_tx_stop(uap);
>  	}

[Severity: High]
Does this branch use stale flags from port->rs485 when called via
uart_set_rs485_config()?

In drivers/tty/serial/serial_core.c, uart_set_rs485_config() invokes
port->rs485_config() before updating port->rs485:

	scoped_guard(uart_port_lock_irqsave, port) {
		ret =3D port->rs485_config(port, &tty->termios, &rs485);
		if (!ret) {
			port->rs485 =3D rs485;

Because port->rs485 still holds the old settings inside
pl011_rs485_config(), two regressions can happen when uap->rs485_tx_state
is OFF:

1. When enabling RS485 from RS232 mode via TIOCSRS485 while no
transmission is pending (!pl011_tx_pending(uap, tx_stopped)),
port->rs485.flags does not have SER_RS485_ENABLED set yet. This branch is
skipped, leaving UART011_CR_TXE enabled from RS232 mode (which can also
strand paused DMA data if tx_stopped is true) and leaving UART011_CR_RTS
at its RS232 state rather than the RS485 idle level.

2. When RS485 is already enabled and TIOCSRS485 changes the RTS polarity
(SER_RS485_RTS_AFTER_SEND) while idle, pl011_rs485_tx_stop() calls
pl011_rs485_tx_stop_now(), which reads the old port->rs485.flags instead
of rs485->flags:

	if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
		cr &=3D ~UART011_CR_RTS;
	else
		cr |=3D UART011_CR_RTS;

Should this condition check rs485->flags & SER_RS485_ENABLED, and pass the
new rs485 configuration down when setting the idle state?

[Severity: Medium]
What happens to REG_CR if SER_RS485_RTS_ON_SEND or SER_RS485_RX_DURING_TX
is reconfigured via TIOCSRS485 while a transmission is active
(uap->rs485_tx_state !=3D OFF)?

When RS485 remains enabled and uap->rs485_tx_state is WAIT_AFTER_RTS,
SEND, WAIT_AFTER_SEND, or WAIT_AFTER_SEND_DELAY, pl011_rs485_config() now
skips all branches in this if/else-if chain.

However, pl011_rs485_tx_start() has already programmed UART011_CR_RTS and
UART011_CR_RXE in REG_CR using the old flags:
- In WAIT_AFTER_RTS, when trigger_start_tx expires,
  pl011_trigger_start_tx() sets uap->rs485_tx_state =3D SEND and calls
  pl011_start_tx() without re-running pl011_rs485_tx_start().
- In WAIT_AFTER_SEND or WAIT_AFTER_SEND_DELAY, if new TX data arrives,
  pl011_rs485_tx_start() cancels trigger_stop_tx, sets
  uap->rs485_tx_state =3D SEND, and returns early without updating REG_CR.

Won't this leave UART011_CR_RTS and UART011_CR_RXE at the old settings in
REG_CR for the rest of the active or pending transmission?

[Severity: Medium]
Can pl011_tx_pending() mistake queued data for an already active
transmission when called from pl011_rs485_config()?

In drivers/tty/serial/amba-pl011.c, pl011_tx_pending() checks:

static bool pl011_tx_pending(struct uart_amba_port *uap, bool stopped)
{
	struct tty_port *tport =3D &uap->port.state->port;

	if (!pl011_tx_empty(&uap->port))
		return true;

	return !stopped &&
	       (!kfifo_is_empty(&tport->xmit_fifo) || pl011_dma_tx_queued(uap));
}

If output was stopped (tty->flow.stopped is true) while uart_write()
queued data into tport->xmit_fifo (or pl011_stop_tx() paused a queued DMA
transfer), uap->rs485_tx_state is OFF and neither PIO (UART011_TXIM) nor
DMA (UART011_TXDMAE) is active in hardware.

When output is restarted in drivers/tty/tty_io.c:__start_tty():

	if (!tty->flow.stopped || tty->flow.tco_stopped)
		return;
	tty->flow.stopped =3D false;
	if (tty->ops->start)
		tty->ops->start(tty);

tty->flow.stopped is cleared under tty->flow.lock before uart_start()
acquires port->lock. If TIOCSRS485 runs pl011_rs485_config() under
port->lock during this window (or while __uart_start() has deferred
start_tx() to runtime PM resume, or between uart_put_char() and
uart_flush_chars()), tx_stopped is false and pl011_tx_pending() returns
true even though no transmission has started.

pl011_rs485_config() then calls pl011_rs485_tx_resume(), which asserts
RTS, enables UART011_CR_TXE, and sets uap->rs485_tx_state =3D SEND directly.
When uart_start() subsequently acquires port->lock and calls
pl011_start_tx(), won't it see uap->rs485_tx_state =3D=3D SEND and transmit
immediately without waiting for delay_rts_before_send?

Should pl011_tx_pending() check whether TX is actually active in the
driver (such as uap->im & UART011_TXIM or uap->dmacr & UART011_TXDMAE)
rather than checking whether xmit_fifo or DMA has queued data while
!stopped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-devel-nbuc=
hwitz-pl011-rs485-reconfig-stall-v3-0-072a9c82ea5e@tipi-net.de?part=3D2
