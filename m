Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793408641;
	b=N9pznKYXIDA26j61XrTv9nGi4enr3Mtp+Qv2vMkWCpbSRGMKSu2N5AK/D0Q3X60AIQmA
	 3WuCXtQfH1reg0FNH0AT5GbEMTCFgcGNXXH3HHlsUW590xDAQzvrXw+/QH95htu/nvYEq
	 Vo+FUVsEfd/6O1VBiV/6ahmD8pY5aUG0YVl4Q+1hikzyek3V7O9+30paCxlXkJnOPoIZp
	 eAKrSx2g0RwLlM/Sg73ZOkWSwAaKfdX7nqIWtiN4rUviqxqNU5PXqzgytM84TiJzfw0mn
	 uBLdsSv7U/OQ9f0mlJonUCZf9QgJDP39BEXkmoRrJM70NvjrabwbrZfYP0T1/wCeesw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793408641;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=a1CbCW0Dp4if+t8lu2uVlq23sebU/fkxrgKkEzine8Q=;
	b=tN3/BYRAiS9OuMPz3jeDUpSD/HlC3c0N4vSpNq2eLMjAfsgM5+2c8VZPjteAkz46jdX/
	 IqbMxflQmSqjkAwVF3SZQJcG6oOqvYuBOXWPd3D6LfyEizEw4lJw2ojdacMQv8k4c1PJs
	 cq+FEsfs4pR1lQ7Jv4LS41ipj41x/ldf+XMIHJ4GEOJnkIkUu+aUQcINOn3fBZ2Hu1rv+
	 PKfv9UeBJKZBtScozUiAh0LQ/MUC622cXX+3q2/k9Gbi5ZW7+SJvzZl9QA6Q1I51zBh6m
	 S0FjwYC70/zDkz52b/RjcB1NxcUHZiqIq7zFlfzTED300JxTsQ67c6vIajU+UlA9wcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HV2nQ3eA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EA2606A31A
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 01:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HV2nQ3eA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C031F000C1;
	Sat, 31 Oct 2026 01:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793408640;
	bh=a1CbCW0Dp4if+t8lu2uVlq23sebU/fkxrgKkEzine8Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HV2nQ3eAAn3JlfV5uriDD2N7emX2xDJ/zpRQTyqgAs6iuw65fElPVBxkU39hFFxrc
	 uAa4PmWz2hun9w7gh2w4JT3PXp0GhMV29hiQw499nDMr4U/KShhzXPFM/go2BFeSM7
	 L1kYYn3HzLyWt+axnjGSCFmz02tsi1U2JotWhEivKFkOYkv7LCgkdncccH/hMlGgj0
	 2inHQNgHLFBaQfyAp8AMnHIgFHgOSghqKDNQ1O2yQkh2rS09EtI2Mn3NZgsdrf2d1y
	 0HxQcsm1KbYfrrBcCCbG9y3llIGirjh8AQN+tIewuihDlR45AC5UgbjeesiGsz3Wl/
	 4wKvBz0g+hItA==
Message-ID: <sashiko-outbox-191689@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] tty: serial: samsung: do not re-arm RX DMA once RX
 has been stopped
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samarth Narang" <samarth.colleges@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261031004217.3340610-3-samarth.colleges@gmail.com>
References: <20261031004217.3340610-1-samarth.colleges@gmail.com>
 <20261031004217.3340610-3-samarth.colleges@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 01:03:59 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tty: serial: samsung: s3c24xx_serial_rx_chars_dma() ignores rx_ena=
bled
--

commit 487da6105041ec489b81c069edfdd379610e15fb
Author: Samarth Narang <samarth.colleges@gmail.com>

tty: serial: samsung: do not re-arm RX DMA once RX has been stopped

This commit prevents s3c24xx_serial_rx_dma_complete() from re-arming RX DMA
after ourport->rx_enabled has been cleared, and clears ourport->rx_enabled
under the port lock during s3c64xx_serial_shutdown().

Link: https://lore.kernel.org/r/20261030162334.3000737-1-samarth.colleges@g=
mail.com

> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 2f6c69beccb74..3f2346f4fd0a9 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -622,7 +622,8 @@ static void s3c24xx_serial_rx_dma_complete(void *args)
>  		tty_kref_put(tty);
>  	}
> =20
> -	s3c64xx_start_rx_dma(ourport);
> +	if (ourport->rx_enabled)
> +		s3c64xx_start_rx_dma(ourport);
> =20
>  	uart_port_unlock_irqrestore(port, flags);
>  }
> @@ -1165,10 +1166,13 @@ static void s3c24xx_serial_release_dma(struct s3c=
24xx_uart_port *p)
>  static void s3c64xx_serial_shutdown(struct uart_port *port)
>  {
>  	struct s3c24xx_uart_port *ourport =3D to_ourport(port);
> +	unsigned long flags;
> =20
> +	uart_port_lock_irqsave(port, &flags);
>  	ourport->tx_enabled =3D 0;
>  	ourport->tx_mode =3D 0;
>  	ourport->rx_enabled =3D 0;
> +	uart_port_unlock_irqrestore(port, flags);

[Severity: High]
Does s3c24xx_serial_rx_chars_dma() also need to check ourport->rx_enabled
after acquiring the port lock?

In drivers/tty/serial/samsung_tty.c, s3c24xx_serial_rx_chars_dma() reads
S3C2410_UTRSTAT before acquiring uart_port_lock(port), and then proceeds
without checking whether ourport->rx_enabled is still set:

drivers/tty/serial/samsung_tty.c:s3c24xx_serial_rx_chars_dma() {
	utrstat =3D rd_regl(port, S3C2410_UTRSTAT);
	rd_regl(port, S3C2410_UFSTAT);

	uart_port_lock(port);

	if (!(utrstat & S3C2410_UTRSTAT_TIMEOUT)) {
		s3c64xx_start_rx_dma(ourport);
		if (ourport->rx_mode =3D=3D S3C24XX_RX_PIO)
			enable_rx_dma(ourport);
		goto finish;
	}

	if (ourport->rx_mode =3D=3D S3C24XX_RX_DMA) {
		dmaengine_pause(dma->rx_chan);
		dmaengine_tx_status(dma->rx_chan, dma->rx_cookie, &state);
		dmaengine_terminate_all(dma->rx_chan);
		received =3D dma->rx_bytes_requested - state.residue;
		s3c24xx_uart_copy_rx_to_tty(ourport, t, received);

		enable_rx_pio(ourport);
	}
}

If an RX interrupt fires on another CPU and spins on port->lock while
s3c24xx_serial_stop_rx() or s3c64xx_serial_shutdown() clears
ourport->rx_enabled (especially during s3c64xx_serial_shutdown(), where
S3C64XX_UINTM is only masked after free_irq()), s3c24xx_serial_rx_chars_dma=
()
can enter the critical section after ourport->rx_enabled is 0.

When S3C2410_UTRSTAT_TIMEOUT is not set, s3c24xx_serial_rx_chars_dma() will
call s3c64xx_start_rx_dma() and enable_rx_dma(), restarting RX DMA after
s3c24xx_serial_stop_rx() has already stopped reception and terminated the
channel.

When S3C2410_UTRSTAT_TIMEOUT is set, neither s3c24xx_serial_stop_rx() nor
s3c24xx_serial_rx_dma_complete() (when skipping s3c64xx_start_rx_dma()
because ourport->rx_enabled is 0) resets ourport->rx_mode from
S3C24XX_RX_DMA. Could s3c24xx_serial_rx_chars_dma() then query
dmaengine_tx_status() on a dma->rx_cookie that was already completed or
terminated (where state.residue is 0) and copy dma->rx_bytes_requested
(PAGE_SIZE) bytes of stale data from dma->rx_buf into the tty flip buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031004217.3340=
610-1-samarth.colleges@gmail.com?part=3D2
