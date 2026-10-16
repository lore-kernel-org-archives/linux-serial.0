Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD3041DE11
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 07:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137295; cv=none; b=PRH1D5gsKn9R6Gqmpl5Fh0m/CzUg2RFbQ/DX1pa9TqNWuO8qB3YIH7c2fYa5C9gCmE8X7tFz4JmKok0bIerh7BnvoGWdieiTq0HO0bDthED5J9wfau9BqpQC3GKOpB/UgQnJpuo4BGoCc1pg3QQWy/pzmwtTjH7i9q+aOlqdFSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137295; c=relaxed/simple;
	bh=+0VgGLyW7k5RuT6Ll8yInsySwKXkE2Kd8HN553y3Tsw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QZi83ZEazE5AUOm0UA+znZztp71RWsAcLDFNwEYok6ggXYrPf0YyNw+44HV/4A4EkzYwBVWbOkqY9/k7xL8qLiv5yX/uey2vLiH7n6ockTU2WmoNgE4y3/an6PBTtYDLESXTzvCT6mFLbGbw84cpbu94OhQp2f4BvnW9DecRa64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8caZhOz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8caZhOz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5041F000C4;
	Fri, 16 Oct 2026 07:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792137293;
	bh=SdbP1xnfjnprSOVGCWoPUxnbNtiMHut/VlQI9VdYchE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I8caZhOzbs5Sd5SQLefvFc3EgttpxY9/JM45ef2fmK6muWefBn2jE6GHBftOiOZCz
	 pb0ha09pgAqqfVUOcgl+N/qz4mhYdzV8PXf4H2HDqsRhbTbMT1Kwv+Nre7ZPRFG5Fy
	 nCR5S82HiT/09DhjoSjLfVn4vTsnBtipMlr2J1EmThF/X43HdSUlv64Ik0zI/svVGV
	 BP5RsESl/HltlXVA+SxBplxCf1jEyN8GOAFB5FdE/BNlbQMNUscfhjFCrkWBiAs9Wk
	 FbfwvOVBsrBk+HFyNKcuhn3dMtoZGeGPekNlFKgYUYkav7RN9k9TZnxebdzBlGM89O
	 qJDy0L5s5cLcw==
Message-ID: <sashiko-outbox-173980@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] serial: amba-pl011: finish a transmission still
 running when RS485 is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261016-devel-nbuchwitz-pl011-rs485-reconfig-stall-v1-1-f07d4da714be@tipi-net.de>
References: <20261016-devel-nbuchwitz-pl011-rs485-reconfig-stall-v1-0-f07d4da714be@tipi-net.de>
 <20261016-devel-nbuchwitz-pl011-rs485-reconfig-stall-v1-1-f07d4da714be@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:54:53 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tty: amba-pl011: zero-interval hrtimer storm causing lockup
--

commit 7358b5653ca0d3eb43821ade63d833e853201457
Author: Nicolai Buchwitz <nb@tipi-net.de>

serial: amba-pl011: finish a transmission still running when RS485 is enabl=
ed

This commit addresses an issue in the amba-pl011 serial driver where
disabling and re-enabling RS485 during an ongoing transmission could leave
the state OFF while data is still going out. It introduces a mechanism to
resume the RS485 transmission and drain the FIFO properly.

> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> index 79776a882ae35..057bb74f3d85d 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c

[ ... ]

> @@ -2454,6 +2466,38 @@ static int pl011_verify_port(struct uart_port *por=
t, struct serial_struct *ser)
>  	return ret;
>  }
> =20
> +/*
> + * RS485 is enabled while data sent before is still going out. Finish it=
 as
> + * an RS485 transmission, so that its end sets the idle level.
> + */
> +static void pl011_rs485_tx_resume(struct uart_amba_port *uap,
> +				  const struct serial_rs485 *rs485)
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
> +	/*
> +	 * With only the FIFO left, the TX path does not stop the transmission.
> +	 * Drain it from the timer, which runs once the new settings are stored.
> +	 */
> +	if (kfifo_is_empty(&tport->xmit_fifo) && !pl011_dma_tx_queued(uap)) {
> +		uap->rs485_tx_state =3D WAIT_AFTER_SEND;
> +		hrtimer_start(&uap->trigger_stop_tx, uap->rs485_tx_drain_interval,
> +			      HRTIMER_MODE_REL);

[Severity: High]
Could uap->rs485_tx_drain_interval be zero here if this path is reached
before pl011_set_termios() has executed?

If RS485 is enabled at boot via device tree, uart_add_one_port() calls
pl011_rs485_config() before set_termios() runs. If the bootloader or
earlycon left characters in the hardware TX FIFO, pl011_tx_pending() will
evaluate to true and trigger this new pl011_rs485_tx_resume() path.

Since set_termios() hasn't run yet, rs485_tx_drain_interval is 0.
The timer will expire immediately in hardirq context and call
pl011_rs485_tx_stop().

Because the hardware FIFO is still not empty, pl011_rs485_tx_stop() will
observe the condition and endlessly reschedule itself with the same 0=20
interval:

drivers/tty/serial/amba-pl011.c:pl011_rs485_tx_stop() {
    ...
    if (uap->rs485_tx_state =3D=3D WAIT_AFTER_SEND) {
        if (!pl011_tx_empty(port)) {
            hrtimer_start(&uap->trigger_stop_tx,
                          uap->rs485_tx_drain_interval,
                          HRTIMER_MODE_REL);
            return;
        }
    ...
}

Would this create an interrupt storm that stalls the CPU until the hardware
FIFO drains (or permanently, if hardware flow control prevents draining)?

Note that the follow-up patch (Patch 2 of 2) in this series modifies
pl011_rs485_config(), but appears to leave this vulnerable condition
exactly the same.

> +	} else {
> +		uap->rs485_tx_state =3D SEND;
> +	}
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-devel-nbuc=
hwitz-pl011-rs485-reconfig-stall-v1-0-f07d4da714be@tipi-net.de?part=3D1
