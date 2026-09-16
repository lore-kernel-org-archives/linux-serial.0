Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7AD43DA38
	for <linux-serial@vger.kernel.org>; Wed, 16 Sep 2026 07:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543604; cv=none; b=f1DX06ZAMhe++kfZusCqv2HlqqZIfqORYHZkKYUA3yOkPTqNHy9aVW53bel2na1yyBSTvCqYOi26V1roYs7gnn/s+W7cCfXnxIs5ZiQwjICT5J+SG/Xyhd6hbDmQpQYwfd9LYUUsDVDkd16Lz/zLfwdBl/3j0DFEX4FoH6Dw0gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543604; c=relaxed/simple;
	bh=Atax/dBCtzzh7hsEpWYQW9V3Kov4QirED6dCj/PL5rM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JjVzBYeFcj0b7AOsmcApUAaOgby8FT5DdQ7GSEgsbmxm4WV6yQbW0V9ZbE+/byIcfOrfNmfUz14y/RGxPRJMmlv+vDdh/W35RzAUVbri5X3sX1l9INbelZ2m0ysDoRHH4brglGGuRnAgJa/PFOpDp5+PSQQVoyTycuul5Q3ehnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWhdX/cl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWhdX/cl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725AC1F000FF;
	Wed, 16 Sep 2026 07:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789543592;
	bh=0YDv2Z1qJVAfLgNCyTPiu7yMmWsUgnkXCFcWnggNNWs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mWhdX/cl0T7MVcuFDkMvMWg4DbMbaegNrTGcpOf2wP+xaH5S9wOL3n4Nlq8igh/l1
	 wBo4Qrfq5tkJ7SNlnpbHXxPXoiQ6PcUbE5zlCsPtD8ZtJOM2TSozmQtg+iVcvOXzei
	 7YovrSXwfy8HozPhYRhlNjFkira9nj/kbxZNVbBLb09EzBhhLpthH59Gsz/z/aymJp
	 +d7MtMEH+2DEvNKIfq+29mvjkdQZfoMSsWDjLmaeXSfLD6uBrVA8HCR3nrKheAnRSO
	 I3RSiD2ydptd+fRg4dWlXNAZpSbhKRvC52BAwsj4NVPDu8OQ7xihEAQu5HIU01tpky
	 cuAJrhZujAs+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] serial: max310x: drive RTS in software when hardware
 delays are too short
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260916-max310x-rs485-sw-delay-v4-1-d37a694342cf@vaisala.com>
References: <20260916-max310x-rs485-sw-delay-v4-1-d37a694342cf@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 07:26:32 +0000
Message-Id: <20260916072632.725AC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] serial: max310x: race conditions from dropping port->lock in start=
_tx and rs485_config
- [High] serial: max310x: tx_work bypasses RS485 RTS before_send delay
- [Medium] serial: max310x: torn read of 64-bit one_character_duration on 3=
2-bit platforms
--

commit 5b4790196e82e4dace1f26d242e90569b9edc027
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

serial: max310x: drive RTS in software when hardware delays are too short
   =20
This commit adds a software-driven RTS path for the max310x UART driver to
handle RS485 setup and hold delays that exceed the hardware's capabilities.
It uses an hrtimer and worker threads to manually toggle RTS and drive data=
 out.

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 022502986c5fc..c217857f5d32a 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c

[ ... ]

> @@ -787,8 +907,13 @@ static void max310x_handle_tx(struct uart_port *port)
>  		return;
>  	}
> =20
> -	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
> +		struct max310x_one *one =3D to_max310x_port(port);
> +
> +		if (READ_ONCE(one->sw_rts_during_tx))
> +			max310x_delayed_stop_tx(port);
>  		return;
> +	}
> =20
>  	/*
>  	 * It's a circ buffer -- wrap around.
>  	 * We could do that in one SPI transaction, but meh.
>  	 */
>  	while (!kfifo_is_empty(&tport->xmit_fifo)) {
>  		unsigned int txlen, to_send;

[Severity: High]
Does this bypass the before_send delay if an interrupt triggers tx_work ear=
ly?

If any interrupt, such as an RX interrupt, occurs during the
MAX310X_TX_WAIT_BEFORE_SEND window, max310x_port_irq() reads IRQSTS and
observes the TXEMPTY bit is set. It then independently schedules tx_work.

Since max310x_handle_tx() doesn't verify if tx_state is MAX310X_TX_SEND,
could it execute prematurely and pump data into the hardware FIFO, shifting
it out before the RTS setup delay completes?

[ ... ]

> @@ -813,11 +938,48 @@ static void max310x_handle_tx(struct uart_port *por=
t)
>  		uart_write_wakeup(port);
>  }
> =20
> +/* called with port.lock taken and irqs off */
>  static void max310x_start_tx(struct uart_port *port)
>  {
>  	struct max310x_one *one =3D to_max310x_port(port);
> =20
> -	schedule_work(&one->tx_work);
> +	if (READ_ONCE(one->sw_rts_during_tx)) {
> +		/*
> +		 * The before- and after-send phases share one delay timer. If an
> +		 * after-send release is pending, cancel it before starting a new
> +		 * TX so the just-asserted RTS is not yanked; re-arming the timer
> +		 * for the before-send phase then supersedes the release.
> +		 */
> +		int res =3D 0;
> +
> +		if (READ_ONCE(one->tx_state) =3D=3D MAX310X_TX_WAIT_AFTER_SEND)
> +			res =3D hrtimer_try_to_cancel(&one->tx_delay_tmr);
> +		if (unlikely(res =3D=3D -1)) {
> +			one->cancel_tx_delay_tmr =3D true;
> +			uart_port_unlock(port);
> +			hrtimer_cancel(&one->tx_delay_tmr);
> +			uart_port_lock(port);
> +		}
> +
> +		max310x_delayed_start_tx(port);

[Severity: High]
Can device shutdown complete while the port lock is dropped here?

If max310x_shutdown() runs concurrently and powers off the device while
the lock is dropped, max310x_delayed_start_tx() will blindly queue
rts_work when the lock is reacquired.

Could this result in the worker later accessing hardware registers via
SPI/I2C on a powered-off device?

[ ... ]

> @@ -1042,38 +1306,55 @@ static void max310x_set_termios(struct uart_port =
*port,
> =20
>  	/* Update timeout according to new baud rate */
>  	uart_update_timeout(port, termios->c_cflag, baud);
> +
> +	/*
> +	 * Cache the new baud rate and the time it takes to clock out one
> +	 * character so the RTS-timing decision in max310x_set_rts_ctl_params()
> +	 * and the post-TX delay in max310x_delayed_stop_tx() can use them.
> +	 */
> +	to_max310x_port(port)->baud =3D baud;
> +	to_max310x_port(port)->one_character_duration =3D
> +		us_to_ktime(DIV_ROUND_UP(USEC_PER_SEC * frame_bits, baud));

[Severity: Medium]
Could this result in a torn read on 32-bit platforms?

max310x_set_termios() writes the 64-bit one_character_duration without
holding the port lock (the serial core only holds termios_rwsem).

Concurrently, workers like max310x_delayed_stop_tx() and max310x_shutdown()
read this variable. Since 64-bit reads and writes are not atomic on 32-bit
platforms, could a torn read yield a massively inflated or negative value,
causing tx_delay_tmr to misfire or max310x_shutdown() to spin indefinitely?

[ ... ]

> @@ -1084,6 +1365,7 @@ static int max310x_rs485_config(struct uart_port *p=
ort, struct ktermios *termios
>  				struct serial_rs485 *rs485)
>  {
>  	struct max310x_one *one =3D to_max310x_port(port);
> =20
> -	if ((rs485->delay_rts_before_send > 0x0f) ||
> -	    (rs485->delay_rts_after_send > 0x0f))
> -		return -ERANGE;
> +	rs485->delay_rts_before_send =3D min(rs485->delay_rts_before_send, 100U=
);
> +	rs485->delay_rts_after_send  =3D min(rs485->delay_rts_after_send,  100U=
);
> +
> +	/*
> +	 * Make sure no SW-timed RTS toggle survives an RS485 disable, even
> +	 * if the delay timer happens to be running right now.
> +	 */
> +	if (!(rs485->flags & SER_RS485_ENABLED)) {
> +		one->cancel_tx_delay_tmr =3D true;
> +		if (hrtimer_try_to_cancel(&one->tx_delay_tmr) =3D=3D -1) {
> +			uart_port_unlock(port);
> +			hrtimer_cancel(&one->tx_delay_tmr);
> +			uart_port_lock(port);
> +		}
> +		WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
> +	}

[Severity: High]
Does dropping the lock here introduce a race condition with start_tx()?

If max310x_rs485_config() drops the lock to wait for the hrtimer, and
start_tx() concurrently queues rts_work, max310x_rs485_config() will
overwrite tx_state to MAX310X_TX_OFF when it reacquires the lock.

Could this sabotage the queued worker and permanently stall transmission
for pending data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-max310x-rs=
485-sw-delay-v4-1-d37a694342cf@vaisala.com?part=3D1
