Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C2942643C
	for <linux-serial@vger.kernel.org>; Sun,  4 Oct 2026 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116917; cv=none; b=mof2zVp8lkXcuc7URszYGakvJRC4aqm3eS/z3jntTEEWDt+I47xqDevhJtOA11guGDkIfeQdI39/7rN92xtw8+m1Lap8L5ZevJCbeC15LpUIWuz98VEhiodgszdKFrNxXNsGDmIuSBI2AsmrkMvBbtQf92TeAY4TGbBdg3EvxeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116917; c=relaxed/simple;
	bh=rJhsmkRR59nGG3Vkpf5KuBW7IImIVCCJjgLNmxxNGzk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nK0FwNatOmi90thCOxOw4Jom/ZHIqr/ex4dVyQ5Yg0RrC5P+FjdbTmXoL/ssgofv6W4MsrxQvpSgK6YSJ0IbqsHyYX45nG3MyxeYWMk+1odChjDHjJDUd2yOADR84bJwUqvI4HUABkCFb/alYvJvC/iNwBW/CNMXsOaW+4Gyhy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZCxm4E0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZCxm4E0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E741F000FF;
	Sun,  4 Oct 2026 12:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791116915;
	bh=GDVZg5ESe+gwMWZZbm6efFYkEIdzvc4RYyfDGFJ9igA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WZCxm4E0O8xnzXzsPqHGwicuaFx0Yz/TKUVyDJfRkwYDy++LiL0Fn2IKBHBswCoAb
	 aAMB/9GJV6Q1WCfY9LhUsYA6TugimpJCq9YOgC/45VEqTED9bSKpWxUlS2pMk2odHd
	 i9EAbg0b7Lk/nnMrKrPPjO7zYsLGPBqXkhTRuj0QQ50VTVyeayIt+XYyr9OKxA9e9t
	 pJOuztdjC3nhJmYwij2iJ8kIB97umybyW0oIoLaFMqKKJfW+94ZCg5VWzE5iWfz5Ok
	 OqY4iQpEQYhQ6dxyLpWH0zHXu+mEhH5IT2w5TYZTL2F1BAGjhHEzEnih5JQ3R4pXSN
	 F7rjSOgwuw1NQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/9] serial: max310x: wait for TX to drain before
 powering down in shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261004-max310x-rs485-sw-delay-v6-5-3a0ef13ed9e3@vaisala.com>
References: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
 <20261004-max310x-rs485-sw-delay-v6-5-3a0ef13ed9e3@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:28:35 +0000
Message-Id: <20261004122835.92E741F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] serial: max310x: DoS via uninterruptible sleep in max310x_shutdown=
()
--

commit 418c89d1dd7ac6d2979824452f69b97e06892699
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

serial: max310x: wait for TX to drain before powering down in shutdown

This patch waits for the TX FIFO to drain before powering down the port
in max310x_shutdown(), calculating the per-character sleep duration
based on the configured baud rate.

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 2456a2af891f5..9dcc817b97945 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c

[ ... ]

> @@ -1124,10 +1126,13 @@ static void max310x_set_termios(struct uart_port =
*port,
>  	uart_update_timeout(port, termios->c_cflag, baud);
> =20
>  	/*
> -	 * Cache the new baud rate and reprogram the RS485 RTS delays, whose
> -	 * millisecond-to-bit-time conversion depends on it.
> +	 * Cache the new baud rate and the time it takes to clock out one
> +	 * character before reprogramming the RS485 RTS delays: the
> +	 * millisecond-to-bit-time conversion divides by the baud rate.
>  	 */
>  	to_max310x_port(port)->baud =3D baud;
> +	to_max310x_port(port)->char_time_us =3D
> +		DIV_ROUND_UP(USEC_PER_SEC * frame_bits, baud);

[Severity: High]
Does this calculation create a dangerously large sleep duration at extremely
low baud rates?

If a user configures a very low baud rate (e.g., 50 baud or even 1 baud), t=
his
value becomes extremely large since it scales inversely with the baud rate.

>  	max310x_set_rts_ctl_params(to_max310x_port(port));
>  }
> =20
> @@ -1223,6 +1228,22 @@ static int max310x_startup(struct uart_port *port)
> =20
>  static void max310x_shutdown(struct uart_port *port)
>  {
> +	struct max310x_one *one =3D to_max310x_port(port);
> +	unsigned int tries =3D port->fifosize + 1;
> +
> +	/*
> +	 * The tty layer's wait-until-sent is bounded by closing_wait, which
> +	 * can be configured to none, and a hangup reaches here with no wait
> +	 * at all, so the FIFO may still hold anything up to its full size.
> +	 * tx_empty() also only reflects the chip TX FIFO - the last character
> +	 * may still be in the transmit shift register. Let the FIFO drain and
> +	 * the final character clock out before the port is powered down,
> +	 * otherwise the transfer is truncated on the wire.
> +	 */
> +	while (!max310x_tx_empty(port) && tries-- > 0)
> +		fsleep(one->char_time_us);
> +	fsleep(one->char_time_us);

[Severity: High]
Can this loop be used to cause a local Denial of Service via an extended
D-state hang or Hung Task Panic?

If a user opens the TTY, configures a very low baud rate (e.g., speed 1-50),
disables CTS flow control (preventing the TX FIFO from draining), and closes
the device, max310x_shutdown() could call fsleep() up to 129 times in
TASK_UNINTERRUPTIBLE.

At 50 baud, char_time_us is 200,000, causing a 25.8 second uninterruptible
sleep per close(). At 1 baud, this sleep duration exceeds 20 minutes, which
would trigger the kernel's hung_task_panic. Even without a panic, the
extended D-state sleep holds the TTY port mutex, blocking system services
like udev or other users from accessing the port.

> +
>  	/* Disable all interrupts */
>  	max310x_port_write(port, MAX310X_IRQEN_REG, 0);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004-max310x-rs=
485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com?part=3D5
