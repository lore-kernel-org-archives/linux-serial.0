Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6283BCD0E
	for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748775; cv=none; b=UtIewhlPLuNiwB1gyyZcOeuSf6qdHYjDT8nRE3CvVcq22g24QF35qli/MAayJM68FQ3PlyFHO0EVbt5yjilx4o1onYyelspUQj5/Mpuddrj/K6PC6ZBmTZJj/ywJLZ8InA8tZe0W3H+3ykdWv/iQvjEhoVg2f1etJY86azRbM8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748775; c=relaxed/simple;
	bh=/IZ5GN/rkQDYU/T0e2XcgWtwVV5F/ZldOx+M84bMchw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=u2y6pa0THSMcGDK5ksiMitJJWnr7box2XrnuTXwJ1GrULPZGerebl+/4bRnajGClwFAO6d6NNXsp4ZZhToev4aGQ8jN3TH+RSBBFBVp2fghIt1LEY0JdElzMPKaN4mDH74nCYURsO80bC1r251t3cl/IFZ0MwUsy8Hnrwks7meQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6qkMHuI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6qkMHuI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366561F0089B;
	Sun, 11 Oct 2026 19:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791748774;
	bh=ohqxcyFMxRAMYrJNnGSOigCIi614RjGunYtsIuP+G+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A6qkMHuIxfgL0FGaYNyGC8Uj0KHAfFgTBfVRv7csqyktaAhn7/2TWeuJjBguGGyza
	 RpR4UWZbxdYUlrJ9FsjO/jquqlXqzKAJOxu8Wu54S8P1A9qdQAAAG2OnZlWq9iJx8z
	 nDFdGriVh7rZCpNiVJn4tfl6Nr/TpDew8+E/ED4BRq0y2zIPr1eWrs3qqJFYkP9FF8
	 ayZqkPaTc4Qw/TL4odeYGzgNWzms507yyMnBTKtHQm1ypAmKuqZravR7lJ+DbWQsrf
	 mFhpa9luiJQVMiLorcGF2lWwUEWMl7HjMt7cybThoLUVu8WRSqtYaxyfGq1rRPZuAO
	 q66JIb+lULKJQ==
Message-ID: <sashiko-outbox-167434@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: amba-pl011: keep transmitter enabled when
 disabling RS485
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261011-fix-pl011-rs485-txe-v1-1-302b6c034b7f@tipi-net.de>
References: <20261011-fix-pl011-rs485-txe-v1-1-302b6c034b7f@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 19:59:33 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tty: serial: amba-pl011: stalled transmission when disabling RS4=
85 during deferred start
--

commit fd97eed6e0ab8bd63d1bb5300339347d34c58cdc
Author: Nicolai Buchwitz <nb@tipi-net.de>

serial: amba-pl011: keep transmitter enabled when disabling RS485

This commit addresses an issue where disabling RS485 mode on an open port
turns off the transmitter, causing pending output and active DMA transfers
to stall. It updates pl011_rs485_config() to leave the transmitter enabled
and cancel pending timers when transitioning out of RS485 mode.

> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2397,8 +2397,24 @@ static int pl011_rs485_config(struct uart_port *po=
rt, struct ktermios *termios,
>  	struct uart_amba_port *uap =3D
>  		container_of(port, struct uart_amba_port, port);
> =20
> -	if (port->rs485.flags & SER_RS485_ENABLED)
> +	if ((port->rs485.flags & SER_RS485_ENABLED) &&
> +	    !(rs485->flags & SER_RS485_ENABLED)) {
> +		u32 cr =3D pl011_read(uap, REG_CR);
> +
> +		/*
> +		 * Leaving RS485 mode, which only enables the transmitter while
> +		 * sending. Don't stop it, as that stalls a DMA transfer still
> +		 * in flight. Drop a pending deferred stop and keep it enabled.
> +		 */
> +		hrtimer_try_to_cancel(&uap->trigger_start_tx);

[Severity: Medium]
Does canceling trigger_start_tx here without manually starting the
transmission risk permanently stranding queued characters?

If a userspace application writes data with a non-zero delay_rts_before_send
in RS485 mode, transmission is deferred via this timer.

If the application then immediately disables RS485 mode via ioctl(TIOCSRS48=
5)
before the timer fires, this code cancels the start timer.

Since there is no fallback to manually kick the stalled transmission (such =
as
calling pl011_dma_tx_start() or pl011_start_tx_pio()), the TX interrupt
remains masked and the DMA is never started. This could cause subsequent
calls to tcdrain() or close() to hang indefinitely.

> +		hrtimer_try_to_cancel(&uap->trigger_stop_tx);
> +		uap->rs485_tx_state =3D OFF;
> +
> +		cr |=3D UART011_CR_TXE | UART011_CR_RXE;
> +		pl011_write(cr, uap, REG_CR);
> +	} else if (port->rs485.flags & SER_RS485_ENABLED) {
>  		pl011_rs485_tx_stop(uap);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-fix-pl011-=
rs485-txe-v1-1-302b6c034b7f@tipi-net.de?part=3D1
