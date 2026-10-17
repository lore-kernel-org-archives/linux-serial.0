Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312FD4052D7
	for <linux-serial@vger.kernel.org>; Sat, 17 Oct 2026 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792219519; cv=none; b=liyrFbgC04NSMHhpXBZoSTA3zGSPNDZTLTMeILzMPYmUV2EPaBq9ZtrayFGRTCZG69v0+auBYgsYtLkFsmLFFXH1ADnCDHw3p7zxc4Znu91yvTkGKRYlpLUBuyiekR6WFa7IrNKwCeouiA9/Yo2NCGDBMI5kFyNyNTdel58Hk2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792219519; c=relaxed/simple;
	bh=grhxcWC2pNrdNBFdyX4xb+w/uc1gNulL+ZTw46aQ4tM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=a5vJV3gkt+jxyFEyCJUegHKPwWH2q/kIyGa9KBfK2c+tkxbApO/zSa5oIxEbiP1URNps/eGcE0+//mQJqi2v+dfqRSl1i9kX282pAnSY3XhBPI0bnf3FD2GU8SBagDzj0RiZXnIZ2j1jcc2xN7umWLd4SU2O9Uijyqv6/LUvOdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJZE4FrN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJZE4FrN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB611F000C4;
	Sat, 17 Oct 2026 06:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792219517;
	bh=Vle975pNLfHteVU7AoNfL6Le3kOkzpcB4apWR5qYjuA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nJZE4FrN//X3xapJlDq5ZG1DhnJCMAz7tYPCKCW0KFI4J3sonRPmbIynk5nFbJIxX
	 msCnk7t2i9IIYxjSAYJLGQAkBPOExj1+oUz8MlLqWbQodFBD01W3L0G9VzTW49eY++
	 13j2YjzcWSL19o0LK02fXhKTAzYymk8Kt3armtK6zU3pqioyVcHk3UrpPQ3vjEnkoZ
	 LO1Wm+94XbEMJgah1yggtUOVcnivad2pDy+mRdbUodp1BVhwQ2FeF+uZrWCoS0THL3
	 yXOcnqs6PEAIp4uesugXsQJp9Aj155CD9k5V+WvPJPn67j5VVHCccbD7XD7J/uB7F1
	 ma+X7EYlEGGXA==
Message-ID: <sashiko-outbox-175339@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] serial: amba-pl011: keep RS485 transmission
 running on reconfiguration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261017-devel-nbuchwitz-pl011-rs485-reconfig-stall-v2-2-6f457a1ee527@tipi-net.de>
References: <20261017-devel-nbuchwitz-pl011-rs485-reconfig-stall-v2-0-6f457a1ee527@tipi-net.de>
 <20261017-devel-nbuchwitz-pl011-rs485-reconfig-stall-v2-2-6f457a1ee527@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 06:45:17 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] serial: amba-pl011: use stale port->rs485 in pl011_rs485_config(=
) when idle
- [Medium] serial: amba-pl011: missing break state adoption in pl011_rs485_=
tx_resume()
--

commit 9fbf19b5c7b65c594ac562200928bbeb7a3c720b
Author: Nicolai Buchwitz <nb@tipi-net.de>

serial: amba-pl011: keep RS485 transmission running on reconfiguration

This commit prevents pl011_rs485_config() from stopping an ongoing RS485
transmission when RS485 settings are updated, and preserves uap->rs485_break
unless RS485 mode is being disabled.

> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> index 3b9cce435c650..036a7245f1f29 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2506,8 +2506,6 @@ static int pl011_rs485_config(struct uart_port *por=
t, struct ktermios *termios,
>  		container_of(port, struct uart_amba_port, port);
>  	bool tx_stopped =3D uart_tx_stopped(port);
> =20
> -	uap->rs485_break =3D false;
> -
>  	/*
>  	 * Output is marked stopped before stop_tx pauses DMA. Pause it now, so
>  	 * that clearing TXE below cannot strand DMA data in the FIFO. Output
> @@ -2521,6 +2519,8 @@ static int pl011_rs485_config(struct uart_port *por=
t, struct ktermios *termios,
>  		bool tx_pending =3D uap->rs485_tx_state =3D=3D WAIT_AFTER_RTS;
>  		u32 cr =3D pl011_read(uap, REG_CR);
> =20
> +		uap->rs485_break =3D false;
> +
>  		/*
>  		 * Leaving RS485 mode, which only enables the transmitter while
>  		 * sending. Don't stop it, as that stalls a DMA transfer still
> @@ -2543,7 +2543,9 @@ static int pl011_rs485_config(struct uart_port *por=
t, struct ktermios *termios,
>  		   tty_port_initialized(&port->state->port) &&
>  		   pl011_tx_pending(uap, tx_stopped)) {
>  		pl011_rs485_tx_resume(uap, rs485, tx_stopped);

[Severity: Medium]
What happens if RS485 is enabled via TIOCSRS485 while a break is active on
the port (or if RS485 is disabled during a break, clearing uap->rs485_break
above while UART01x_LCRH_BRK remains set in REG_LCRH_TX, and then re-enable=
d)?

While UART01x_LCRH_BRK is set, the PL011 keeps UART01x_FR_BUSY asserted in
REG_FR, so pl011_tx_pending() returns true via !pl011_tx_empty() and enters
pl011_rs485_tx_resume():

drivers/tty/serial/amba-pl011.c:pl011_rs485_tx_resume() {
    ...
	if (stopped ||
	    (kfifo_is_empty(&tport->xmit_fifo) && !pl011_dma_tx_queued(uap))) {
		uap->rs485_tx_state =3D WAIT_AFTER_SEND;
		hrtimer_start(&uap->trigger_stop_tx, uap->rs485_tx_drain_interval,
			      HRTIMER_MODE_REL);
	} else {
		uap->rs485_tx_state =3D SEND;
	}
}

Because pl011_rs485_tx_resume() does not check REG_LCRH_TX for
UART01x_LCRH_BRK and set uap->rs485_break =3D true, uap->rs485_break stays
false. Could this cause pl011_trigger_stop_tx() -> pl011_rs485_tx_stop() to
bypass the uap->rs485_break check and continuously re-arm trigger_stop_tx
every character interval in hardirq context for the entire duration of the
break?

> -	} else if (port->rs485.flags & SER_RS485_ENABLED) {
> +	} else if ((port->rs485.flags & SER_RS485_ENABLED) &&
> +		   uap->rs485_tx_state =3D=3D OFF) {
> +		/* Set the idle level now, a transmission sets it when done */
>  		pl011_rs485_tx_stop(uap);
>  	}

[Severity: Medium]
During TIOCSRS485, uart_ioctl() -> uart_set_rs485_config() invokes
port->rs485_config() before storing the new configuration into port->rs485:

drivers/tty/serial/serial_core.c:uart_set_rs485_config() {
    ...
		ret =3D port->rs485_config(port, &tty->termios, &rs485);
		if (!ret) {
			port->rs485 =3D rs485;
    ...
}

And pl011_rs485_tx_stop() -> pl011_rs485_tx_stop_now() also reads
port->rs485.flags:

drivers/tty/serial/amba-pl011.c:pl011_rs485_tx_stop_now() {
    ...
	if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
		cr &=3D ~UART011_CR_RTS;
	else
		cr |=3D UART011_CR_RTS;
    ...
}

Because port->rs485 still holds the old settings here, can this cause two
issues when configuring an idle port (uap->rs485_tx_state =3D=3D OFF and
!pl011_tx_pending()) via TIOCSRS485:

1. When enabling RS485 for the first time, port->rs485.flags & SER_RS485_EN=
ABLED
   is still false, so pl011_rs485_tx_stop() is skipped, leaving UART011_CR_=
TXE
   enabled while uap->rs485_tx_state =3D=3D OFF and leaving UART011_CR_RTS =
at its
   RS232 level?

2. When RS485 is already enabled and TIOCSRS485 changes the RTS polarity
   (SER_RS485_RTS_ON_SEND vs SER_RS485_RTS_AFTER_SEND),
   pl011_rs485_tx_stop_now() programs UART011_CR_RTS using the old
   port->rs485.flags instead of the new rs485->flags, driving the wrong RTS
   idle level?

Should this branch check rs485->flags & SER_RS485_ENABLED and apply the new
rs485->flags when setting the idle state?

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017-devel-nbuc=
hwitz-pl011-rs485-reconfig-stall-v2-0-6f457a1ee527@tipi-net.de?part=3D2
