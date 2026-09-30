Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A09D1C84A2
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781005; cv=none; b=j2Ht3LqSdpU2WinO/NZsibSe7mRZLjNmshnfMnndkMgg9BYUpRwuLV0+Kilm64y5foV5AkjJDevlLW3Y8jjtFylrCmFBPYB0PxiD8pbw2IQ+LiV2QfHjbdPDzwNH0q6KYyxHe182an+nhT/5c24Rkve2YxwmA1AM4QCVDm8A6Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781005; c=relaxed/simple;
	bh=A26YQbZWzrxsknntiE7TRiUR1pM/CRlHnhXM6Qh3+Bs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hnjT7884D5+hMLUUF0yd5yBJGE2I/yHCq7hbUJlh6zevOPCnTUEn95FtbzvToBwrZvdLCAuJDLN4NS9x9a1TTSgnyhE+fqwundH5HY7WEJ7t8oIz9+oHoWdxktExt9zUzAvpIBFp0C4k9bJC5hooGG3Ja/SH9Mc5rPd8RjtolxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYfJy+Ls; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYfJy+Ls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69331F0089D;
	Wed, 30 Sep 2026 15:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780983;
	bh=ukPQXDbQoJB8huSINw2B5LWvDG1pn3WiaLyaO88iOrg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dYfJy+LsfPmduDRpEl1cPV5Ys1mYlyUsaRLAz4iHZjwZUGcAjpNXjn8k5oHyegEsr
	 M15RxyUP9koVFeWoWEKeX4UVRu4r3zcwBe357GGkWk3KikHWWUcruKYRJ6aQHgGnZ8
	 uR2/vH8/CtNtCkRdQItepEEguNKCWcinHj+yE91rsAVDBoqv5H2LQSj4UQEOXMhRYg
	 N7nAfZOk7ZBffzih1Zy9lUaJzmZe5Uf74LqJGaKcN4jVxEw1EF9dsRrAnZN5ZVYwIM
	 bw+ezrlLnKTrN4uTqagqCQ+OVB+LNbMBd5dar4UwkD45/l2epKSxo2KSXn9vOwwlcb
	 7t+eC9ifUT0bQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 RESEND 1/2] serial: sc16is7xx: refill TX FIFO below
 trigger using fresh TXLVL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Mbewe" <paultyson.mbewe@ziehl-abegg.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260930145628.566535-2-paultyson.mbewe@ziehl-abegg.de>
References: <20260930145628.566535-1-paultyson.mbewe@ziehl-abegg.de>
 <20260930145628.566535-2-paultyson.mbewe@ziehl-abegg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 15:09:43 +0000
Message-Id: <20260930150943.B69331F0089D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] serial: sc16is7xx: unbounded tx refill loop starves rx irqs
--

commit a658261936f3762a047ddfec6aa9737edd0babeb
Author: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>

serial: sc16is7xx: refill TX FIFO below trigger using fresh TXLVL

This commit changes the driver to continually refill the hardware TX FIFO
by polling the available space (TXLVL) until the hardware reports a level
strictly below the trigger.

Link: https://lore.kernel.org/linux-serial/20260623112225.82386-3-paultyson=
.mbewe@ziehl-abegg.de/

> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7x=
x.c
> index fa7805d2cde23..1f7e98c2b5709 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c

[ ... ]

> @@ -687,7 +698,14 @@ static void sc16is7xx_handle_tx(struct uart_port *po=
rt)
> =20
>  		sc16is7xx_fifo_write(port, tail, to_send);
>  		uart_xmit_advance(port, to_send);
> -		txlen -=3D to_send;
> +
> +		if (kfifo_is_empty(&tport->xmit_fifo))
> +			break;
> +
> +		/* Refill below the trigger to enable the next THRI crossing. */
> +		txlen =3D sc16is7xx_txlvl(port);
> +		if (txlen < SC16IS7XX_TX_TRIGGER_LEVEL)
> +			break;
>  	}

[Severity: High]
Could updating the loop boundary directly from the hardware without an
iteration limit cause an unbounded loop that starves RX interrupts?

If the UART baud rate exceeds the I2C or SPI bus throughput (for example,
921600 baud over 400kHz I2C), the hardware TX FIFO will drain faster than
sc16is7xx_fifo_write() can fill it over the bus.

In this scenario, the fresh txlvl reading remains high, meaning the loop ex=
it
condition fails to trigger. This allows the loop to spin continuously until
the 4KB xmit_fifo is completely emptied.

Because sc16is7xx_handle_tx() is executed in the shared IRQ handling thread,
spinning here completely blocks the thread while it flushes the xmit_fifo. =
RX
interrupts cannot be serviced during this time, which could cause the 64-by=
te
hardware RX FIFO to rapidly overrun, resulting in data loss.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930145628.5665=
35-1-paultyson.mbewe@ziehl-abegg.de?part=3D1
