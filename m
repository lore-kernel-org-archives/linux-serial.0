Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801112E5B02
	for <linux-serial@vger.kernel.org>; Sun,  4 Oct 2026 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791117068; cv=none; b=N+ZQK/5DoMpB/jzYda5dL62MgBqSLxz0gDdIReieJjRk/SFxzMZjevsfLacM88lMBNW90GjrkMH9O9opRt0lQpmSO7uryMLVGX0ymd12aAHOQiq0ENOXtD3JKh6QBgsSe3OdW7p6MzoMsf1ydMxzBoFc7y2mIdzqhJP8p5I5mo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791117068; c=relaxed/simple;
	bh=gRG2AmsXU8Q5hwi7RJWhN5q6aSzI58HP0hdSZz9DW6I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rh84Rbls6z8QGFe0GcEYxbmvbe5WF+VIZ2IgGjGDiK0cwzxy9rfGS0+wJS6Xan/AIoDxqBoEmFYpciengg6WMMnyv3LgPXd2cRm6+wtlGc3dEXQPje1eqVLA68vAIVSRQdeb2Fe8p5EyJLNYtBPqk6WI8gKrmv0jrW66EPzYEwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmm1vJ4m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmm1vJ4m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045CC1F00893;
	Sun,  4 Oct 2026 12:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791117067;
	bh=bFwGO3gse27S4IxIq4SIY80DqqFK3b7hhjew3XUUMtI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mmm1vJ4mH61d8IN63fmmeERu6hOy2SB7ovpYNkslXy1paLhDFVLJJrB+I1rhmNFja
	 nbPzMXv6jB5NSnR1uVCdhbqqnuPAI5dvK4FCvHbRPolSgRnSVxrsgN1WahHqijTOGT
	 JdPw1QKIeE86/VK08HSqhx0Flp2bQ3/XXIpNAKjHJtVfsAH+0txAP4bsDeWSnZJFgo
	 Ps60NTZsIdqLfDk5ZgPMxIAh+YhZPv8gTzxjvfp1s0ruNJr2J1HEV8yenaLmfay/CZ
	 HEesKhCpHsj4E93XNtWthCc6liDzPqdILf2tkMmkGJdfXLAHvFJsnTWctfGR+/ZoRz
	 RwpFb4weWfkBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 9/9] serial: max310x: don't transmit while an RS485
 reconfigure is pending
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261004-max310x-rs485-sw-delay-v6-9-3a0ef13ed9e3@vaisala.com>
References: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
 <20261004-max310x-rs485-sw-delay-v6-9-3a0ef13ed9e3@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:31:06 +0000
Message-Id: <20261004123107.045CC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] serial: nbcon lock imbalance due to raw spinlock guard bypassing u=
art_port_lock API
--

commit 5e3096e423054b0fa2875676ddddb86c4d77f052
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

serial: max310x: don't transmit while an RS485 reconfigure is pending

This commit defers RS485 transmissions while a reconfigure is pending to
prevent transmitting with a half-switched state. It adds a pending flag
evaluated under the port lock and restarts transmission once applied.

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index eb1d2e3bc870e..f8247cf0358ba 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
[ ... ]
> @@ -997,9 +1008,10 @@ static void max310x_start_tx(struct uart_port *port)
>  			uart_port_lock(port);
>  			/*
>  			 * The lock was dropped: a teardown may have run to
> -			 * completion meanwhile. Re-check before starting.
> +			 * completion or a reconfigure may have been posted
> +			 * meanwhile. Re-check before starting.
>  			 */
> -			if (one->tx_teardown)
> +			if (one->tx_teardown || one->rs485_pending)
>  				return;
>  		}
> =20
[ ... ]
> @@ -1453,6 +1465,17 @@ static void max310x_rs_proc(struct work_struct *ws)
> =20
>  	max310x_port_update(&one->port, MAX310X_MODE2_REG,
>  			    MAX310X_MODE2_ECHOSUPR_BIT, mode2);
> +
> +	/*
> +	 * The configuration is applied: release any TX that start_tx()
> +	 * deferred while the reconfigure was pending, now on the right path.
> +	 */
> +	scoped_guard(spinlock_irqsave, &one->port.lock) {
> +		one->rs485_pending =3D false;
> +		if (one->port.x_char ||
> +		    !kfifo_is_empty(&one->port.state->port.xmit_fifo))
> +			max310x_start_tx(&one->port);
> +	}
>  }

[Severity: High]
Will this scoped guard usage cause an unbalanced nbcon lock release and
subsequent leak when max310x_start_tx() is called?

max310x_rs_proc() acquires port.lock using a raw spinlock_irqsave guard,
bypassing the mandatory nbcon acquisition performed by the uart_port_lock()
API.

Inside max310x_start_tx(), if the timer cancellation fails, it temporarily
drops and reacquires the lock using the standard API:

max310x_start_tx()
    ...
    uart_port_unlock(port);
    hrtimer_cancel(&one->tx_delay_tmr);
    uart_port_lock(port);
    ...

When this sequence is reached via max310x_rs_proc(), uart_port_unlock() will
attempt to release an nbcon lock that was never acquired, and
uart_port_lock() will acquire it.

When max310x_start_tx() returns, the scoped guard in max310x_rs_proc() will
only release the raw spinlock, leaving the nbcon lock leaked. This can
permanently freeze the console or trigger lockdep crashes when a user space
process reconfigures RS-485 while a transmission delay timer is active.

Should this use the serial core uart_port_lock APIs instead of a raw
spinlock guard to ensure balanced locking?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004-max310x-rs=
485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com?part=3D9
