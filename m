Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED6E484248
	for <linux-serial@vger.kernel.org>; Mon,  5 Oct 2026 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207671; cv=none; b=SkGrjy0hI09oHOGlIb7/GMrfBOgvnLoCTRifH9RY+Albc6rqWXERb4k7sxDTTwRddZBik9nnIOuMXpWHOPQPNMcL1IAMoVt5TyVtj9gATPM3QoIYiBc4ZWVHE0gEmlqSJxhMSgilLTkulUtYcbio/xZ3TpG2/mWDGww8OB9KMk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207671; c=relaxed/simple;
	bh=z/N53aWqePVmwE7mpgmn5MUXw5M/T+0we+d87LIGAH4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kt3uednAFZ6knwbPvIfBgap1Z9fev7U5M1fcTDASISiagrgOvifgu7dQrILUGuo+uCVgdKtWDKv1nZmh+UekFtxSwdcMyVfx42cYJw39YErzOd29m/hl2kq2Dd40L1IwasvjFC6l8GB9Y6NB7hQ65AbE90GYJ4gJZgPQZmU5qnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJxKyBt2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJxKyBt2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6A11F00893;
	Mon,  5 Oct 2026 13:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207670;
	bh=d9x+QcL5ouF9e9Y1FtWsWTJ/UWvjH9MkOcgFZ25oAl0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CJxKyBt2dr9GQXoRnYmdGJJTDi/Z2jCfmpgG6rcBWT+pitWDGEfnPaBu7GR41sx8q
	 DU0Y7G5iuHcnjQHLAAN8P9sGkR/Ciey9NDaPDMyo6UQhriYZH5TqDyPVVO2dieJ5gB
	 c75SqByYlx6SXBh9O2xEPElW5XGl1T5UHTHqSWyj3uzkYKl7G+M0AboT1slz8ZvAsb
	 F/qv4n484q32GINGlvnu6UoCDARotA7LvSOmjYxgIwqd7Kr0yv5/Jf1ffkKw4pTrgR
	 9r0db1IIPw1kyNW6ejGMqSumQ53ZlHXMCh6fT3nLhf9E+SbZyYxZyIoYYoMvfhNcSP
	 ezlZhmGq/S93Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 9/9] serial: max310x: don't transmit while an RS485
 reconfigure is pending
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261005-max310x-rs485-sw-delay-v7-9-6ae392eca08c@vaisala.com>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
 <20261005-max310x-rs485-sw-delay-v7-9-6ae392eca08c@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 13:41:09 +0000
Message-Id: <20261005134109.EE6A11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] tty: max310x: tx_work bypasses rs485_pending gate allowing transmi=
ssion during reconfigure
- [High] tty: max310x: TOCTOU race on chip_tx_empty causes incorrect state =
rewind
--

commit 7203e556ec43dfcd637262655ece112903f9eb73
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

serial: max310x: don't transmit while an RS485 reconfigure is pending

This commit defers transmissions while an RS485 configuration is pending,
leaving data in the kfifo until rs_work finishes reprogramming the register=
s.
It drops the direct tx_work kick in the disable path in favor of restarting
the transmission once the configuration is fully applied.

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 5fdb9dfca6027..833ab4d461235 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c

[ ... ]

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
Does this check sufficiently gate the transmission?

While this defers synchronous writes, a TXEMPTY interrupt can asynchronously
queue tx_work during the pending RS485 reconfiguration:

max310x_port_irq()
  if (ists & MAX310X_IRQ_TXEMPTY_BIT)
      schedule_work(&s->p[portno].tx_work);

If tx_work executes concurrently with max310x_rs_proc(), it calls
max310x_handle_tx() which pumps data from xmit_fifo to the hardware FIFO:

max310x_handle_tx()
  while (!kfifo_is_empty(&tport->xmit_fifo)) {
      /* Limit to space available in TX FIFO */
      txlen =3D max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
      ...
  }

Since max310x_handle_tx() runs without holding a synchronizing lock or
checking the rs485_pending flag, can this regression allow background worke=
rs
to bypass the deferral mechanism and transmit data with a half-programmed
transceiver?

[ ... ]

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
> +
> +	uart_port_lock_irqsave(&one->port, &flags);
> +	one->rs485_pending =3D false;
> +	if (one->port.x_char ||
> +	    !kfifo_is_empty(&one->port.state->port.xmit_fifo)) {
> +		/*
> +		 * A send state adopted without chip data is the deferred
> +		 * write itself: restart it as a fresh envelope so the
> +		 * before-send delay is honoured.
> +		 */
> +		if (chip_tx_empty &&
> +		    READ_ONCE(one->tx_state) =3D=3D MAX310X_TX_SEND)
> +			WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);

[Severity: High]
Is it possible for chip_tx_empty to be stale here due to a race with tx_wor=
k?

The TX FIFO level is read outside the lock. Concurrently, tx_work can execu=
te
max310x_handle_tx() and write new data to the chip FIFO without acquiring
port->lock.

When max310x_rs_proc() then acquires port->lock, it uses the stale
chip_tx_empty value to rewind the transmission state to MAX310X_TX_OFF, even
though data is already being transmitted.

Can this incorrect rewind introduce a regression by breaking the timing
envelope, causing data to hit the RS485 bus without the configured
before-send delay?

> +		max310x_start_tx(&one->port);
> +	}
> +	uart_port_unlock_irqrestore(&one->port, flags);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-max310x-rs=
485-sw-delay-v7-0-6ae392eca08c@vaisala.com?part=3D9
