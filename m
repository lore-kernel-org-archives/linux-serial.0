Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C92450AC16
	for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676733; cv=none; b=NVd/2vJ48GmkaCk2kDm4etQMZYn+pduvNkyIHHQLfdmvkTt74RVaWKpscZPPrDtKeW6hRZQvKVjDIL5z6h3gV9Dw1a+6DSshrYlVd8WbZbGxon8Rgu2FhvE0r0D0tlJPsz2VHok1B4mIbpH62jWNHH0X2RmxxY8vHYUpJNJC1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676733; c=relaxed/simple;
	bh=LI/WpayrjWYxVq5NhdPhSV+6AP5guX0HjZyf5qEwxzk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DbyOx3LIggVFFebMNXuuJP/iphWvv7owDvOKjADXzcRsKACNVw4pnePLMrRdkYcD++v6m/V4cLfMOuuIo3eRRU/1sn3iVG4Q2vA5Cf0CQ/1sHTb3QLsaiqYyK4fCSoNz5XsQNqGRxW7q5aZzva3z3UDQYya/ezhPCWx1bit6JMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwqnre5F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwqnre5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7670E1F000FF;
	Tue, 29 Sep 2026 10:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790676719;
	bh=Am73HUXLbJlOkhQ15Ijvig29OUYlAOg6QpUPD+nDKI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mwqnre5FlIhyRKUH2MUEsa66IqucLqRve/GreWoQODtNdJWsK8+/oAPJv4I4WkArN
	 DW12hiTETTFqabVZSsEEO3MPj7mdt6altcBXdl4FhLWR4HbWvUays0/oI/lA7+OgGX
	 CcVOHdIrRIq0IetXnvvAHDvUzKLfMXnqVpio4d0La19fGMsDk5ts/uhA/FgR0Lfx77
	 +cKjK55Bl9ybzGEQin2Yi4raeRjNH4Z+EmQHK+2hSJ1ku6Yej9MyhXmEko2rSiboNO
	 ozV2Ws9uJDAG6PZf6TfzHQ4RZaYyXmCP/PFqKQXLonpdX0R7/LrRzcMRNsa76fY2a9
	 JkLKoCWVLuMZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/8] serial: max310x: don't transmit while an RS485
 reconfigure is pending
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260929-max310x-rs485-sw-delay-v5-8-ae46afa583f2@vaisala.com>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
 <20260929-max310x-rs485-sw-delay-v5-8-ae46afa583f2@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 10:11:59 +0000
Message-Id: <20260929101159.7670E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] tty: max310x: missing port->x_char check when restarting deferred =
transmission
- [High] tty: max310x: tx_work bypasses rs485_pending check and transmits p=
rematurely
- [Medium] tty: max310x: missing rs485_pending re-validation in max310x_sta=
rt_tx()
--

commit 1a4bdd512b6e5258a8a653f209426aca40bb8efb
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

    serial: max310x: don't transmit while an RS485 reconfigure is pending

This commit defers transmission in the max310x serial driver while an RS485
reconfiguration is pending. It aims to prevent transmitting data onto the w=
ire
while the transceiver is in an inconsistent state by keeping data in the kf=
ifo
until the new configuration is fully applied.

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 6ad27eb8a3258..7036710942a42 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
[ ... ]
> @@ -965,6 +966,16 @@ static void max310x_start_tx(struct uart_port *port)
>  	if (one->tx_teardown)
>  		return;
> =20
> +	/*
> +	 * An RS485 reconfigure is scheduled but not applied yet: transmitting
> +	 * now would use the old path against half-programmed registers - a
> +	 * TIOCSRS485 switching paths followed immediately by a write puts the
> +	 * data on the wire with the transceiver released. Leave the data in
> +	 * the kfifo; rs_work restarts TX once the configuration is applied.
> +	 */
> +	if (one->rs485_pending)
> +		return;
> +

[Severity: High]
Is premature transmission adequately prevented here if an interrupt occurs =
or
if tx_work is already queued?

If rs485_pending is true, max310x_start_tx() defers transmission, but
max310x_port_irq() can still queue tx_work on a hardware TX empty interrupt:

static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
{
	...
		if (ists & MAX310X_IRQ_TXEMPTY_BIT)
			schedule_work(&s->p[portno].tx_work);
	...
}

When max310x_handle_tx() runs, it unconditionally pumps data without checki=
ng
if an RS485 reconfigure is currently pending:

static void max310x_handle_tx(struct uart_port *port)
{
	...
	while (!kfifo_is_empty(&tport->xmit_fifo)) {
		...
		to_send =3D kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
		max310x_batch_write(port, tail, to_send);
		...
	}
}

Will this cause data to be transmitted onto the wire while the RS485 transc=
eiver
is in an inconsistent, partially-programmed state, defeating the purpose of
the patch?


[Severity: Medium]
Could a race condition cause transmission against a pending RS485
reconfiguration when the lock is dropped later in max310x_start_tx()?

max310x_start_tx() drops the port->lock to wait for timer cancellation:

		if (unlikely(res =3D=3D -1)) {
			one->cancel_tx_delay_tmr =3D true;
			uart_port_unlock(port);
			hrtimer_cancel(&one->tx_delay_tmr);
			uart_port_lock(port);
			/*
			 * The lock was dropped: a teardown may have run to
			 * completion meanwhile. Re-check before starting.
			 */
			if (one->tx_teardown)
				return;
		}

		max310x_delayed_start_tx(port);

If ioctl(TIOCSRS485) runs concurrently while the lock is dropped and sets
rs485_pending =3D true, we re-acquire the lock and check tx_teardown, but w=
e do
not check rs485_pending again. Does this allow transmission to begin while =
the
transceiver state is mid-switch?

>  	if (READ_ONCE(one->sw_rts_during_tx)) {
>  		/*
>  		 * The before- and after-send phases share one delay timer. If an
[ ... ]
> @@ -1395,6 +1406,16 @@ static void max310x_rs_proc(struct work_struct *ws)
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
> +		if (!kfifo_is_empty(&one->port.state->port.xmit_fifo))
> +			max310x_start_tx(&one->port);
> +	}
>  }

[Severity: High]
Are deferred transmissions properly restarted if there is a pending XON/XOFF
character but the FIFO is empty?

If uart_send_xchar() queues an XON/XOFF character in port->x_char while an
RS485 reconfiguration is pending, transmission is deferred because
max310x_start_tx() returns immediately.

Later, this logic attempts to restart deferred transmissions but only checks
!kfifo_is_empty(&one->port.state->port.xmit_fifo). If the standard FIFO is
empty, max310x_start_tx() is not re-invoked.

Could this leave port->x_char permanently unsent and cause flow control to =
stall
indefinitely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-max310x-rs=
485-sw-delay-v5-0-ae46afa583f2@vaisala.com?part=3D8
