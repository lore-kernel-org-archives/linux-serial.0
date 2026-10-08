Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2E439CD17
	for <linux-serial@vger.kernel.org>; Thu,  8 Oct 2026 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453835; cv=none; b=HPfQcqpSJh8dWDwbXv6bYkjJhEuUO782mnY/V1cfYSWVOm2l93bqBB9YXf9AYlHXzaNKWywiaxA4AlgY9YtBVTGhk/r4CQvFvp1OXIniCU0TFEfsg3hg03wU6I3w6RdTiYKp41vq2RVCcFmUMZ24++Dw4iNLpeD9zNxwk2i5iNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453835; c=relaxed/simple;
	bh=PhqZrCtOUIR/wUh8L92oqCaruxcMxKo+mQSHIl5ZDU4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HnkM1ngbFSZ3/9BI5S8NZw1DnxH+i8Ea8fqt/WLnY0gX+Y66JIofXXv5jIzEGtNONrFSxiUtoVb5d5bKvMyG9YgnAMPIpg2vypqCzxBf0waly0D2SsikCCE7qJNxA6eSZT6aem9zOK+2LMPrnBG2a9nfivj+O5S2fYW4SUlKhHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aV5L07HJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aV5L07HJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7141F00893;
	Thu,  8 Oct 2026 10:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791453832;
	bh=vtb6RwtnUK4Hc2SikE61sNvaVBc+UvKnE+Ah2kgcFUY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aV5L07HJ4dHItTKguU6laII6N8neCndo7uKYTRSJlCCS4Du/rzUP5WzeDItlirAP8
	 ENO2e8s30gO0e3ji1SQp/Ps+1DdEvqYqvEqKpeRX0bwpAIOgxIdWEd/JHwJ9WHXiQR
	 j8TOnQenppo5wTyKWypBcSj0b/0JfI7uDOw9FMjZie9p8oXaSuPCP61Kw8TzXv4yJP
	 cVecKNrhtI24jX/D186bk+YThFhmBOw9WHyU6JLuVmjC0NEvoDNoyAmDDRlj6xd70w
	 szImrs5QONuSpxTDxQmOg1JfKWlp31V4Z98OFRhyCG5DumLz31nm8WXfqt6D6zYbvo
	 Q4OWe/itsFXEQ==
Message-ID: <sashiko-outbox-163985@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 9/9] serial: max310x: don't transmit while an RS485
 reconfigure is pending
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261008-max310x-rs485-sw-delay-v8-9-6ba881f81e1f@vaisala.com>
References: <20261008-max310x-rs485-sw-delay-v8-0-6ba881f81e1f@vaisala.com>
 <20261008-max310x-rs485-sw-delay-v8-9-6ba881f81e1f@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 10:03:52 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] tty: max310x tx_work bypasses rs485_pending deferral
- [High] tty: max310x: kfifo corruption in max310x_handle_tx()
- [Medium] tty: max310x: rs_work outlives port shutdown causing suspended d=
evice access
--

commit fddc249318df6e2dd69c19bbf8a221d220eb0e4a
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

serial: max310x: don't transmit while an RS485 reconfigure is pending

TIOCSRS485 applies its register changes asynchronously. This patch defers
transmission by adding an rs485_pending flag to start_tx() to prevent
transmitting against a half-switched state.

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 5fdb9dfca6027..833ab4d461235 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> [ ... ]
> @@ -979,6 +980,16 @@ static void max310x_start_tx(struct uart_port *port)
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

[Severity: High]
Can the asynchronous transmit worker tx_work bypass this deferral check?

If a trailing TXEMPTY interrupt from a previous transmission schedules
tx_work right as rs485_config() marks the reconfigure pending and new data
is written to the kfifo, it looks like tx_work will execute
max310x_handle_tx() and unconditionally drain the newly written data to the
chip's FIFO.

Does this put data on the wire while rs_work is concurrently modifying the
transceiver configuration registers, causing the same half-switched
transmission this was meant to fix?

[Severity: High]
Does the lockless execution of max310x_handle_tx() via tx_work create a
kfifo corruption risk against uart_flush_buffer()?

max310x_handle_tx() computes the buffer length and performs a blocking
SPI/I2C write locklessly. If a concurrent ioctl(fd, TCFLSH, TCOFLUSH)
triggers uart_flush_buffer(), the serial core acquires port->lock and calls
kfifo_reset(&tport->xmit_fifo).

When max310x_batch_write() returns, does uart_xmit_advance() increment the
reset kfifo->out pointer, causing it to underflow past kfifo->in and
potentially leaking up to UART_XMIT_SIZE bytes of stale kernel memory to
the serial bus?

> [ ... ]
> @@ -1465,6 +1479,31 @@ static void max310x_rs_proc(struct work_struct *ws)
> =20
>  	max310x_port_update(&one->port, MAX310X_MODE2_REG,
>  			    MAX310X_MODE2_ECHOSUPR_BIT, mode2);
> +
> +	/*
> +	 * The configuration is applied: release any TX that start_tx()
> +	 * deferred while the reconfigure was pending, now on the right
> +	 * path. start_tx() can drop and retake the lock through the
> +	 * uart_port API - a raw spinlock guard here would unbalance it.
> +	 */
> +	chip_tx_empty =3D !max310x_port_read(&one->port,
> +					   MAX310X_TXFIFOLVL_REG);

[Severity: Medium]
Can rs_work outlive port shutdown and access a powered-off device here?

max310x_shutdown() cancels tx_work and rts_work and powers down the port,
but deliberately omits canceling rs_work. A pending rs_work will wait on
port->mutex while uart_shutdown is executing.

After uart_shutdown finishes and releases port->mutex, max310x_rs_proc()
acquires the mutex and executes. Will it then perform SPI/I2C register reads
and writes, such as this new MAX310X_TXFIFOLVL_REG read, on the device that
was just powered off?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-max310x-rs=
485-sw-delay-v8-0-6ba881f81e1f@vaisala.com?part=3D9
