Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B904AD7FA
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403891; cv=none; b=qhPRxmcVM+G6s8TccYmNAswHgJ3vLJVq436DkVi0WEBbDkuulMJ6EniIiKqyNERaxq2hDbtPzECclPl16WIPoM6uTtsS8+ePvPtcSQRJJCWCNxlf1imlf3EH0ZBMpJCDEcV+qq58hHN/J+t1iUsZtv19sHldBEFwaHm8I/Ns1FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403891; c=relaxed/simple;
	bh=NcmOeYuiL4ZPz17z/opUoEeohBn7ZNpIlcrH2iaM2Hk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pH5RC5srYGPHxyRgqbHRApCijAmpDKe/GG+jVpjLbTHqDqzUIqWWqIfK7jJeB7F5iaYGKDmYxyqArkw9BUfqo/aCynmbhLzsjZ1hutItaBmRCHbYUxhW0L65VspakPjNm/HawOSwF5jVvDfym9BzWblAaKh7ooAuqb15TilsWc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddgFmwtT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddgFmwtT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B455A1F000C4;
	Mon, 19 Oct 2026 09:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792403889;
	bh=eDeMera/5y4LigXbItkbGFKxQWJgSKpptfi0ZY6PQqM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ddgFmwtTMgCUIV3Jc1qDKf0JLJOYzW6zCZoQgkGYy0OH3icdYaahgDjGSbsJaI3dt
	 1rknluSc5lOqoVMvY8+BCj7+j9YCxeujWFyPjaFTElqD2ISvX/I+yLMHoO/Axg/Dyu
	 +YIKwqdZhRgC0UcCX7YNUFzUWSweEy800K1q29HaMSyJ8YwztoJy10q+sfBpk16d+n
	 DPZyn0jRWWRSwPW+EQzIh03ZGcCOcb5bHX7N5wFefzD+NudvaThsq7dOwZSmNp/nEV
	 u0pYrxMeBJAD5xnYuNSszrHe+q5DlXNuRLNs1nCkCOBYX6IaZeoPIWLJ6UtiELx/jV
	 qgj7OZEhzIjSA==
Message-ID: <sashiko-outbox-176927@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] serial: amba-pl011: finish a transmission still
 running when RS485 is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261019-devel-nbuchwitz-pl011-rs485-reconfig-stall-v3-1-072a9c82ea5e@tipi-net.de>
References: <20261019-devel-nbuchwitz-pl011-rs485-reconfig-stall-v3-0-072a9c82ea5e@tipi-net.de>
 <20261019-devel-nbuchwitz-pl011-rs485-reconfig-stall-v3-1-072a9c82ea5e@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:58:09 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] serial: amba-pl011: pl011_tx_pending() treats unstarted TX as acti=
ve
- [High] serial: amba-pl011: old port->rs485 used in pl011_rs485_config() i=
dle path
--

commit be95e4add4b59e050ce0c42610dce83f5d1f930a
Author: Nicolai Buchwitz <nb@tipi-net.de>

serial: amba-pl011: finish a transmission still running when RS485 is enabl=
ed

When RS485 is enabled on an open port while a transmission from before RS485
was enabled is still running, this commit hands the transmission back to the
RS485 state machine so that the idle RTS level is set when it finishes.

> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> index 79776a882ae35..6adfe7a1e0487 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1734,6 +1734,18 @@ static unsigned int pl011_tx_empty(struct uart_por=
t *port)
>  							0 : TIOCSER_TEMT;
>  }
> =20
> +/* While output is stopped, only data already in the FIFO counts */
> +static bool pl011_tx_pending(struct uart_amba_port *uap, bool stopped)
> +{
> +	struct tty_port *tport =3D &uap->port.state->port;
> +
> +	if (!pl011_tx_empty(&uap->port))
> +		return true;
> +
> +	return !stopped &&
> +	       (!kfifo_is_empty(&tport->xmit_fifo) || pl011_dma_tx_queued(uap));
> +}
> +
>  static void pl011_maybe_set_bit(bool cond, unsigned int *ptr, unsigned i=
nt mask)
>  {
>  	if (cond)
> @@ -2454,13 +2466,63 @@ static int pl011_verify_port(struct uart_port *po=
rt, struct serial_struct *ser)
>  	return ret;
>  }
> =20
> +/*
> + * Data from before RS485 was enabled is still going out. Finish it as an
> + * RS485 transmission, so that its end sets the idle level.
> + */
> +static void pl011_rs485_tx_resume(struct uart_amba_port *uap,
> +				  const struct serial_rs485 *rs485, bool stopped)
> +{
> +	struct tty_port *tport =3D &uap->port.state->port;
> +	u32 cr =3D pl011_read(uap, REG_CR);
> +
> +	cr |=3D UART011_CR_TXE;
> +	if (!(rs485->flags & SER_RS485_RX_DURING_TX))
> +		cr &=3D ~UART011_CR_RXE;
> +	if (rs485->flags & SER_RS485_RTS_ON_SEND)
> +		cr &=3D ~UART011_CR_RTS;
> +	else
> +		cr |=3D UART011_CR_RTS;
> +	pl011_write(cr, uap, REG_CR);
> +
> +	/* pl011_break_ctl() ends the transmission when the break ends */
> +	if (pl011_read(uap, REG_LCRH_TX) & UART01x_LCRH_BRK) {
> +		uap->rs485_break =3D true;
> +		uap->rs485_tx_state =3D SEND;
> +		return;
> +	}
> +
> +	/*
> +	 * With only the FIFO left or output stopped, the TX path won't end it.
> +	 * The timer does, once the new settings are stored.
> +	 */
> +	if (stopped ||
> +	    (kfifo_is_empty(&tport->xmit_fifo) && !pl011_dma_tx_queued(uap))) {
> +		uap->rs485_tx_state =3D WAIT_AFTER_SEND;
> +		hrtimer_start(&uap->trigger_stop_tx, uap->rs485_tx_drain_interval,
> +			      HRTIMER_MODE_REL);
> +	} else {
> +		uap->rs485_tx_state =3D SEND;
> +	}
> +}

[Severity: High]
Can pl011_tx_pending() and pl011_rs485_tx_resume() treat an unstarted
transmission as already active in hardware when pl011_tx_empty(&uap->port) =
is
true?

When !stopped && (!kfifo_is_empty(&tport->xmit_fifo) ||
pl011_dma_tx_queued(uap)), pl011_tx_pending() returns true and
pl011_rs485_tx_resume() asserts RTS, enables UART011_CR_TXE, and sets
uap->rs485_tx_state =3D SEND without starting PIO/DMA or arming trigger_sto=
p_tx.
This assumes that either PIO (uap->im & UART011_TXIM) or DMA (uap->dmacr &
UART011_TXDMAE) is already active and will later invoke pl011_stop_tx().

However, there appear to be two paths where xmit_fifo is non-empty (or
dmatx.queued is true) and tx_stopped is false while neither UART011_TXIM nor
UART011_TXDMAE is active and the hardware FIFO is empty:

1. Asynchronous runtime PM resume on port->port_dev->dev:
amba_probe() enables runtime PM on port->dev, and serial_port_probe() enabl=
es
runtime PM autosuspend on port->port_dev->dev. When port_dev->dev is
runtime-suspended, uart_write() queues data in tport->xmit_fifo and calls
__uart_start(). Because pm_runtime_get(&port_dev->dev) is asynchronous,
__uart_start() returns without calling port->ops->start_tx(port), deferring
pl011_start_tx() to serial_port_runtime_resume().

If ioctl(TIOCSRS485) runs before serial_port_runtime_resume() acquires
port->lock, pl011_rs485_tx_resume() sets uap->rs485_tx_state =3D SEND and
asserts RTS. When serial_port_runtime_resume() then calls pl011_start_tx(),
it sees uap->rs485_tx_state =3D=3D SEND and transmits immediately, bypassing
delay_rts_before_send. Furthermore, if tcflush(fd, TCOFLUSH) (via
uart_flush_buffer()) clears xmit_fifo before serial_port_runtime_resume()
runs, serial_port_runtime_resume() sees __serial_port_busy(port) =3D=3D fal=
se and
skips start_tx(), leaving uap->rs485_tx_state stuck in SEND with RTS assert=
ed
and driving the RS485 bus indefinitely.

2. Concurrent __start_tty() (via TCXONC/TCOON or IXON START_CHAR):
n_tty_ioctl_helper() and n_tty_lookahead_flow_ctrl() call __start_tty()
without holding termios_rwsem or port->mutex. __start_tty() clears
tty->flow.stopped under tty->flow.lock before uart_start() acquires
port->lock to call pl011_start_tx(). If data was queued in xmit_fifo while
output was stopped (or DMA was paused with dmatx.queued =3D=3D true and the
hardware FIFO drained) and pl011_rs485_config() runs in that window,
tx_stopped is false, so pl011_rs485_tx_resume() sets uap->rs485_tx_state =3D
SEND and uart_start() -> pl011_start_tx() skips delay_rts_before_send.

> +
>  static int pl011_rs485_config(struct uart_port *port, struct ktermios *t=
ermios,
>  			      struct serial_rs485 *rs485)
>  {
>  	struct uart_amba_port *uap =3D
>  		container_of(port, struct uart_amba_port, port);
> +	bool tx_stopped =3D uart_tx_stopped(port);
> =20
>  	uap->rs485_break =3D false;
> +
> +	/*
> +	 * Output is marked stopped before stop_tx pauses DMA. Pause it now, so
> +	 * that clearing TXE below cannot strand DMA data in the FIFO. Output
> +	 * stopped after this check is ended by stop_tx.
> +	 */
> +	if ((rs485->flags & SER_RS485_ENABLED) && tx_stopped)
> +		pl011_dma_tx_stop(uap);
> +
>  	if ((port->rs485.flags & SER_RS485_ENABLED) &&
>  	    !(rs485->flags & SER_RS485_ENABLED)) {
>  		bool tx_pending =3D uap->rs485_tx_state =3D=3D WAIT_AFTER_RTS;
> @@ -2483,6 +2545,11 @@ static int pl011_rs485_config(struct uart_port *po=
rt, struct ktermios *termios,
>  		if (tx_pending && !uart_tx_stopped(port) &&
>  		    !pl011_dma_tx_start(uap))
>  			pl011_start_tx_pio(uap);
> +	} else if ((rs485->flags & SER_RS485_ENABLED) &&
> +		   uap->rs485_tx_state =3D=3D OFF &&
> +		   tty_port_initialized(&port->state->port) &&
> +		   pl011_tx_pending(uap, tx_stopped)) {
> +		pl011_rs485_tx_resume(uap, rs485, tx_stopped);
>  	} else if (port->rs485.flags & SER_RS485_ENABLED) {
>  		pl011_rs485_tx_stop(uap);
>  	}

[Severity: High]
When enabling RS485 via TIOCSRS485 while pl011_tx_pending(uap, tx_stopped) =
is
false, doesn't checking port->rs485.flags in the final else-if branch skip
pl011_rs485_tx_stop(uap) because port->rs485 still holds the old configurat=
ion?

In uart_set_rs485_config(), port->rs485_config(port, &tty->termios, &rs485)=
 is
called before port->rs485 =3D rs485 is assigned:

drivers/tty/serial/serial_core.c:uart_set_rs485_config() {
    ...
	ret =3D port->rs485_config(port, &tty->termios, &rs485);
	if (!ret) {
		port->rs485 =3D rs485;
    ...
}

When RS485 was previously disabled, UART011_CR_TXE is set in REG_CR (either
from pl011_startup() or from disabling RS485 in pl011_rs485_config()) and
UART011_CR_RTS reflects the RS232 mctrl state. If RS485 is then enabled when
no transmission is pending (or when tx_stopped is true and the hardware FIFO
is empty, which is the case the new pl011_dma_tx_stop(uap) call above prepa=
res
for so that clearing TXE below cannot strand DMA data), pl011_tx_pending()
returns false.

Execution then reaches:

	} else if (port->rs485.flags & SER_RS485_ENABLED) {
		pl011_rs485_tx_stop(uap);
	}

Because port->rs485.flags does not yet have SER_RS485_ENABLED set,
pl011_rs485_tx_stop() is not called (and if pl011_stop_tx() runs later in t=
he
tx_stopped case, it also skips pl011_rs485_tx_stop() because
uap->rs485_tx_state =3D=3D OFF). As a result, UART011_CR_TXE is not cleared=
 and
UART011_CR_RTS is not set to the RS485 idle level.

Additionally, even when port->rs485.flags already had SER_RS485_ENABLED set
and TIOCSRS485 reconfigures SER_RS485_RTS_AFTER_SEND while idle,
pl011_rs485_tx_stop() -> pl011_rs485_tx_stop_now() reads
port->rs485.flags & SER_RS485_RTS_AFTER_SEND from the old port->rs485 rather
than the new rs485 struct.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-devel-nbuc=
hwitz-pl011-rs485-reconfig-stall-v3-0-072a9c82ea5e@tipi-net.de?part=3D1
