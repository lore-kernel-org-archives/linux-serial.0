Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284970;
	b=APJ6acmDuiNm/8dnCclwuKShZ6waL/WL7MkbmlH7IOj/WZBynr0TLsCgIeZ4MRAO2Kb0
	 w1/uS5j0vZ3buFq/s8aAZwLjZ0N6O8lkWsZoPBtopOhx5Vi+DKSlGYgOAb08fF1ma/b84
	 /zqfxNvoAQ5C+qmH0WiyQ6hpC5XOzmy8G9eb6HxVaHaA6sR+VuyP754SN0rLZy4z1GLlg
	 IAoRK3QqHEdnthjkV01nwCbLwqIIcUgb5qO+oGPnClYzttGWgJzXjOMy6hpd5J6oz4AzN
	 F5C6xxweILsAE5PKym92tShXsY6xeHqYZ7cYrUqAv/lTBYM2tafmJ0IKqUjwGbLqPqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284970;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aRvyMRxi2YMN81Cd/v7vKPkrYP8524VjnRocSpFpqL0=;
	b=nD0nQWOt3cefOuaoGF3Av9ScPQ4t9zjDN0WLIz3agmuZ58EHQWG6XjrokuoXyGUEXcRc
	 BRJK9NRMdY4tZiLIQv72cuGCtKEWFFm3btf5U4QhjfZunHxGN+qxxC7r+7C53Km2czqHl
	 nMsmPv8rXWAKuxjS98pFqUw6H/fAxvbQtDu+rbLImCdpbXEWle6nZe9P7UAckjeePSm+l
	 L2SW8nRBcu7Z/L0tu1WPoZeF/I0clqpOaKe60tOwM+cCGubFr9s9+ia++dokathTg0G9T
	 zF58jOe/7hb5ywc1eWjfQWKsvCBs7dgj9zq5SmIq4dcOdJzz2UK5DQj+5uEMDapZU6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KD7Vseot;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0844F606A32A;
	Tue, 10 Nov 2026 04:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KD7Vseot
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EDA1F008A3;
	Tue, 10 Nov 2026 04:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284969;
	bh=aRvyMRxi2YMN81Cd/v7vKPkrYP8524VjnRocSpFpqL0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KD7Vseot308j5qW/a/Laq1MfPSxzPE4BOdQ0Fo/1diNwGk5eGW9u5KBD+W7dKbhg4
	 W4JsDwUXDVreaajgQyHqZHerPiLBLIn/JLaO+yKM4CMd7V4YOwctbg2VzEjMMbwiy9
	 reDNJiGr5xFkQiC039N9tD4cxSakmXq0H5WpcktJ3zdBUl1nimjuQW1MMavbUMPWsf
	 GUXPVo6sDLFG4p2781K927w8OzHgg7vDcIXBc81HgZNusS+oHDfmDgRg9agdRAz8sA
	 +6iXPlydzstx2DI+me9ebvYLnVJXkrj+rzRn416p2UcfLtEcx9sfmuePppWv+uSTB/
	 dlJZuXfRrs76A==
Message-ID: <sashiko-outbox-206203@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 4/8] serial: 8250_omap: quiesce DMA IRQ handling
 before shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261109-submit-serial-8250-dma-cancel-v1-v11-4-6364edca63d6@gmail.com>
References: <20261109-submit-serial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com>
 <20261109-submit-serial-8250-dma-cancel-v1-v11-4-6364edca63d6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:29:28 +0000
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
- [Medium] serial: 8250_omap: UART_OMAP_EFR2 cleared before locked RX
  DMA flush
--

commit 4f01158f98251ff9fc53053baff46ab365f1866d
Author: James Hilliard <james.hilliard1@gmail.com>

serial: 8250_omap: quiesce DMA IRQ handling before shutdown

This commit gates DMA IRQ handling on up->dma->shutting_down under the
port lock, moves the final RX DMA flush into that locked section, and
switches omap_8250_shutdown() from disable_irq_nosync() to disable_irq()
before releasing DMA resources.

> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/825=
0/8250_omap.c
> index 5e114dd8f9bfb..51013dd2d8510 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -771,10 +771,6 @@ static void omap_8250_shutdown(struct uart_port *por=
t)
>  	guard(serial8250_rpm)(up);
> =20
>  	flush_work(&priv->qos_work);
> -	if (up->dma) {
> -		guard(uart_port_lock_irq)(port);
> -		omap_8250_rx_dma_flush(up);
> -	}
> =20
>  	serial_out(up, UART_OMAP_WER, 0);
>  	if (priv->habit & UART_HAS_EFR2)
> @@ -782,13 +778,16 @@ static void omap_8250_shutdown(struct uart_port *po=
rt)
> =20
>  	/* Synchronize UART_IER access against the console. */
>  	scoped_guard(uart_port_lock_irq, port) {
> -		if (up->dma)
> +		if (up->dma) {
>  			up->dma->shutting_down =3D true;
> +			omap_8250_rx_dma_flush(up);
> +		}
>  		up->ier =3D 0;
>  		serial_out(up, UART_IER, 0);
>  	}

[Severity: Medium]
Can clearing UART_OMAP_EFR2 before acquiring port->lock leave
UART_OMAP_EFR2_TIMEOUT_BEHAVE set after shutdown?

Moving omap_8250_rx_dma_flush() into the locked block places it after
serial_out(up, UART_OMAP_EFR2, 0x0):

CPU0                              CPU1
omap_8250_shutdown()              omap_8250_dma_handle_irq()
  serial_out(up, UART_OMAP_EFR2, 0x0)
                                    uart_port_lock(port)
                                    /* shutting_down is still false */
                                    am654_8250_handle_rx_dma()
                                      omap_8250_rx_dma(up)
                                      serial_out(up, UART_OMAP_EFR2,
                                        UART_OMAP_EFR2_TIMEOUT_BEHAVE)
                                    uart_port_unlock(port)
  uart_port_lock_irq(port)
  up->dma->shutting_down =3D true
  omap_8250_rx_dma_flush(up)      <-- EFR2 is not cleared again

Neither omap_8250_startup() nor omap8250_restore_regs() resets
UART_OMAP_EFR2, so UART_OMAP_EFR2_TIMEOUT_BEHAVE stays set across
shutdown.  Clearing UART_OMAP_EFR2 inside the port->lock block after
omap_8250_rx_dma_flush() would also match the flush-then-clear order in
am654_8250_handle_rx_dma().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-submit-ser=
ial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com?part=3D4
