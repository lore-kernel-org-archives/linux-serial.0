Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584756;
	b=R/7dx9ru1oNVkdDYYfgq8TmdCZO3vMl2PNc4p1iSCycp945YPGdU1rf2mQ1/gDYW+0ou
	 cVk8TuxXd3Oxx+xFvduJegKickGRUGMJfiIKWFzNWaFjWCJA9IWD8PcEoKQBqMQkoAPxi
	 yuc5FjR4AF8EG2BNgYZTvyGjS1i+T70PLn+n3WtwM8eUCCvEqf1hBpA6/eAmSnE6IAF7I
	 x6Y9ME0zJHeSey6LJxAEge6SchTMYtAAEYVmo1MhZnge4hVQMqakeAqGKVqC7o1C+EsB5
	 6PI8Vux9XqTt2M5mQgRY6+zg2I0Oy0kuAFAxC/zCuv+iIp2NDpVMceRjijWj1ZJsmvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584756;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T/1ww9SiJ6AQjrgsvSYYfSnVlVJYK8NZtbOjrMvf8fo=;
	b=4IMiJYXjjBs7cNxLiwpr3fq96U5kf+/Lx+EiKnWr29tz4l1QUkQqlWCe63tA9Onby7Fq
	 haCQTW5x0I3c+mfCCpuM+QRId0OzcigMQaM2iVI21thgEq/qGeaOhJ48XHRmCGLkhJDLU
	 KfkyoE0aPN0F2Bvg7BswqAR4PMv3YPk759mk2qhYOhYAqCBbvFsYzUbHLLEvk8LiML1x8
	 fVxgKbh11VhjnCcp5YXcBgJNq2N8MsR4kPr3h7BPCsra1Ib5WmbxMTuJHVtTPQFMlCMOQ
	 NNkwSi+BJKEBvTevfVPwf/bseOedh0VhDHsOc7WuKlc88haKZMaKAZN6+Sbgs74xkgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUYSvf7D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24640606A319
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUYSvf7D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAA91F000C4;
	Wed, 21 Oct 2026 12:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792584755;
	bh=T/1ww9SiJ6AQjrgsvSYYfSnVlVJYK8NZtbOjrMvf8fo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MUYSvf7DASCQUKLQsgplWtlrbmWfksbNZD9KmxtJpVMC+6cBza6Ux3p7KdcSNQaZd
	 OSHkIWf4EKk8g1BwNzy2UIcCW3DQijSOXJWBn128J0pTmCifhw9gYGD5H0n2ixnB/o
	 TK4Ym3lcM0iKYcriTq9rYDDMybzfbrGmQYUpGJlh8HoEEGObpR58QZ/Vsx/R0Zw4aw
	 kqkbCW/xguJpWn5Xrc7jL2oQJypAqZceio0KEbbynR/sIi1row6yYfssCdJdp3o3De
	 Y1mgS41CcimV9jcXIoFXNcKQrOgFsw1mow5JeiejEryIcXRhJ1Lz/iYHaamZgVY0E+
	 I5CZKvfDbbX/w==
Message-ID: <sashiko-outbox-180213@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] serial: amba-pl011: keep RS485 transmission
 running on reconfiguration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261021-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-2-ed10e219159a@tipi-net.de>
References: <20261021-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-0-ed10e219159a@tipi-net.de>
 <20261021-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-2-ed10e219159a@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 12:12:35 +0000
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
- [Medium] serial: amba-pl011: stale port->rs485 used in pl011_rs485_config=
()
--

commit 007a7e02762ccd2d731728a6d03676779b72e54d
Author: Nicolai Buchwitz <nb@tipi-net.de>

serial: amba-pl011: keep RS485 transmission running on reconfiguration

This commit updates pl011_rs485_config() so that reconfiguring RS485 while =
it
remains enabled only calls pl011_rs485_tx_stop() when no transmission is in
progress (uap->rs485_tx_state =3D=3D OFF), and only clears uap->rs485_break=
 when
leaving RS485 mode.

> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> index 1edbe75611e63..e4ac9225cdcba 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c

[ ... ]

> @@ -2540,7 +2541,9 @@ static int pl011_rs485_config(struct uart_port *por=
t, struct ktermios *termios,
>  		   tty_port_initialized(&port->state->port) &&
>  		   (pl011_tx_active(uap) || !pl011_tx_empty(port))) {
>  		pl011_rs485_tx_resume(uap, rs485);
> -	} else if (port->rs485.flags & SER_RS485_ENABLED) {
> +	} else if ((port->rs485.flags & SER_RS485_ENABLED) &&
> +		   uap->rs485_tx_state =3D=3D OFF) {
> +		/* Set the idle level now, a transmission sets it when done */
>  		pl011_rs485_tx_stop(uap);
>  	}

[Severity: Medium]
During a TIOCSRS485 ioctl, uart_set_rs485_config() invokes
port->rs485_config() before assigning the new configuration to port->rs485:

drivers/tty/serial/serial_core.c:uart_set_rs485_config() {
	...
	scoped_guard(uart_port_lock_irqsave, port) {
		ret =3D port->rs485_config(port, &tty->termios, &rs485);
		if (!ret) {
			port->rs485 =3D rs485;
	...
}

In drivers/tty/serial/amba-pl011.c, pl011_rs485_config() calls
pl011_rs485_tx_stop() -> pl011_rs485_tx_stop_now(), which reads
port->rs485.flags rather than the new rs485->flags:

drivers/tty/serial/amba-pl011.c:pl011_rs485_tx_stop_now() {
	...
	if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
		cr &=3D ~UART011_CR_RTS;
	else
		cr |=3D UART011_CR_RTS;
	...
}

Doesn't this cause three regressions when configuring RS485 via TIOCSRS485?

First, when RS485 is already enabled and idle (uap->rs485_tx_state =3D=3D O=
FF)
and userspace changes SER_RS485_RTS_AFTER_SEND, pl011_rs485_tx_stop_now()
programs UART011_CR_RTS using the old port->rs485.flags instead of the new
rs485->flags.

Second, because the else-if condition in pl011_rs485_config() checks
port->rs485.flags & SER_RS485_ENABLED instead of
rs485->flags & SER_RS485_ENABLED, newly enabling RS485 on an open, idle port
(where pl011_tx_active(uap) is false and pl011_tx_empty(port) is true) skips
both pl011_rs485_tx_resume() and pl011_rs485_tx_stop(), leaving
UART011_CR_TXE enabled and UART011_CR_RTS at its previous non-RS485 level.

Third, when RS485 is reconfigured while a transmission or break is active
(uap->rs485_tx_state !=3D OFF), all branches in pl011_rs485_config() are
skipped, so changes to SER_RS485_RTS_ON_SEND or SER_RS485_RX_DURING_TX in
rs485->flags are not applied to REG_CR for the ongoing transmission.

Should pl011_rs485_config() check rs485->flags & SER_RS485_ENABLED and apply
the new rs485->flags when setting the idle or active REG_CR state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-devel-nbuc=
hwitz-pl011-rs485-reconfig-stall-v4-0-ed10e219159a@tipi-net.de?part=3D2
