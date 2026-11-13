Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582795;
	b=tMynqT5MbE1QTbA09z1BUWKNyAR6/wQNjWUy7eVq9AIcja9CcNpEZeJA7d6o98OiF/z4
	 UxvNvj+h/0gaXLz7aeDz+V3DYaPFoMeEyLRH58VGUrGyKxH6OVDBSFddSn9TUuGDwPp1i
	 IH/1e93m/2hgT0vHIyYn6HJ+w4pMHXfAw46qUDEngfp8J4rWDi1x2XPQyktHHh5Xox+8i
	 TEh2El5jo+up9OfLsl5G+0iVkWz3V7Z2UfaumvuxiubEwTH/RnwmPN5jnAZz0+RdMEStc
	 sFm1b797bG/p3MZQ7AZI3b5NXwAHnw4ibcZOFOJmL1wDPT6zyPvJRNd+Xtn4nvoo0ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582795;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1mPl7668NQ13T1GGRO2V/aRTDckbqTh3v7ieqCgwhqE=;
	b=vHuQdfJVWSzqI0gnLcHWqn5H2nSmPYkjhO3p7tVxK8rmEe0WJt32Z6IK4UbnXjsnW7Ms
	 Yf3bh3a+22uUPYvwdNABJQc5ueE57OpZK8PFNQtFESsZb8TCKSfxIsmTp58GTJpq+p3qq
	 IfgWMZyEYuL/bqmBvIkT+AY5XgmHfDZRfQUmE8S26zEQ9P93lrnVPl4PLJky1YP2cI1++
	 urkqnzKlVWYac/1iid6LqKqtbRe1hEhF16EHJFXtChpfSYViHKl5uLKfXq2PNpgqnmGIT
	 +l0b6y7d5184mhvf50QQoIJvt7WmVOWF20oViWu7jGI+Uf9FGcD2U6Vh7HGpHNce8Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iuOMayR3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E12606A323
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iuOMayR3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8550C1F000C4;
	Fri, 13 Nov 2026 15:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582794;
	bh=1mPl7668NQ13T1GGRO2V/aRTDckbqTh3v7ieqCgwhqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iuOMayR3KPp/1/kHrQF4UCfOOmMwTRo1CuBla625FjnnpO4TRedy66BEhYrcaKJFN
	 tcGDfQLJuIzpZwAa+EroFzL9sNQytR+Ccbw2HVQxeNQ/wvrhoPROtrwvs6fqYP6yEq
	 fEQBoMvWBHix2+zwh/22/CBJ7McdKptD7aGvZMLj5+BfzrcEtGTNWO0SABZ3RKlpd7
	 zA4EmgZn+12bYwJexmXBVB6cKlLxjQ5is5tO86gZ5tG57MoF2Xl2eR6L+l6juuzaZh
	 etRMqtVqR/2P8MuOp4ufQPNsCDizIMAsL7VBmc6JLtU8yd/fUyJwR9zZXoXryv7Byf
	 hA+dTIRSXOt9Q==
Message-ID: <sashiko-outbox-213064@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: xilinx_uartps: fix oops when disabling RS-485
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niko Mauno" <niko.mauno@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113145000.17691-1-niko.mauno@vaisala.com>
References: <20261113145000.17691-1-niko.mauno@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:13:14 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] serial: xilinx_uartps: uncancelled tx_timer in
  cdns_rs485_config()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] serial: xilinx_uartps: missing port lock in
  cdns_rs485_rx_callback() [1]
--

commit 3210e7db33392b91c77b40821a8026e9d89c30d1
Author: Niko Mauno <niko.mauno@vaisala.com>

serial: xilinx_uartps: fix oops when disabling RS-485

This commit moves the tx_timer hrtimer initialization from
cdns_rs485_config() to cdns_uart_probe() so that disabling RS-485 on a
port that was never in RS-485 mode does not cancel an uninitialized
timer.

> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xili=
nx_uartps.c
> index e8c4b1fa7658b..f93e374f6d0e5 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1620,10 +1620,6 @@ static int cdns_rs485_config(struct uart_port *por=
t, struct ktermios *termios,
>  		val &=3D ~CDNS_UART_MODEMCR_FCM;
>  		writel(val, port->membase + CDNS_UART_MODEMCR);
> =20
> -		/* Timer setup */
> -		hrtimer_setup(&cdns_uart->tx_timer, &cdns_rs485_tx_callback, CLOCK_MON=
OTONIC,
> -			      HRTIMER_MODE_REL);
> -
>  		/* Disable transmitter and make Rx setup*/
>  		cdns_uart_stop_tx(port);
>  	} else {

[Severity: Medium]
Should cdns_rs485_config() also cancel tx_timer when SER_RS485_ENABLED
is set?

When TIOCSRS485 reconfigures a port that already has tx_timer queued for
a transmit delay, cdns_uart_stop_tx() -> cdns_rs485_rx_setup() clears
rs485_tx_started without cancelling tx_timer.  If cdns_uart_start_tx()
runs before the timer expires, it sees !rs485_tx_started and calls
hrtimer_update_function() on the still-queued timer:

kernel/time/hrtimer.c:hrtimer_update_function() {
	...
	if (WARN_ON_ONCE(hrtimer_is_queued(timer)))
		return;
	...
}

This triggers a warning under CONFIG_PROVE_LOCKING and leaves the
existing callback in place.  If tx_timer was queued with
cdns_rs485_rx_callback, re-arming it in cdns_uart_start_tx() will run
cdns_rs485_rx_callback instead of cdns_rs485_tx_callback and stall TX.

> @@ -1782,6 +1778,8 @@ static int cdns_uart_probe(struct platform_device *=
pdev)
>  	port->rs485_config =3D cdns_rs485_config;
>  	port->rs485_supported =3D cdns_rs485_supported;
>  	cdns_uart_data->port =3D port;
> +	hrtimer_setup(&cdns_uart_data->tx_timer, &cdns_rs485_tx_callback,
> +		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	platform_set_drvdata(pdev, port);
> =20
>  	rc =3D uart_get_rs485_mode(port);

[Severity: High]
This problem wasn't introduced by this patch, but can
cdns_rs485_rx_callback() race with cdns_uart_set_mctrl() on
CDNS_UART_MODEMCR [1]?

When tx_timer is switched to cdns_rs485_rx_callback() for the after-send
delay, the callback invokes cdns_rs485_rx_setup() ->
cdns_rts_gpio_enable() without holding port->lock:

CPU0                              CPU1
cdns_rs485_rx_callback()          cdns_uart_set_mctrl()
  cdns_rs485_rx_setup()             uart_port_lock_irqsave(port)
    cdns_rts_gpio_enable()
      val =3D readl(...MODEMCR)
                                    val =3D readl(...MODEMCR)
                                    val |=3D CDNS_UART_MODEMCR_DTR
                                    writel(val, ...MODEMCR)
      val &=3D ~CDNS_UART_MODEMCR_RTS
      writel(val, ...MODEMCR)  <-- overwrites CPU1's update

The unlocked read-modify-write can drop concurrent modem control updates
such as DTR changes or leave RTS in the wrong state on the RS-485 bus.

[1] https://sashiko.dev/#/bug/linux-f32cec5a-9677-4aba-b408-e83f8b26002d

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113145000.1769=
1-1-niko.mauno@vaisala.com?part=3D1
