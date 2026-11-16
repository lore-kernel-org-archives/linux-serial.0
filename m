Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824331;
	b=zCkoVZ5wMEKgYf/NyTQcRXOVmD1GmlPqZXqaI5iRq9T+npBsYr9LwjOxtOW79gal94SD
	 InAGLiQN3o6e0gDGUaV1UttN31s9KdMG4fHPZTD+s83jT2rcVyt4yTy1ubFbcFGtMozQH
	 20SxKQ2//kC34frA/doyTatm1PLiTIEX0nhwD9Z7EhSIw6jzmxwbtlt46pzPPALADFFQe
	 sVkDSLvUi6WbbpWPL8LL73sCNW65eIyDEcIQ3wdjHLHueglUugk2swzUp3wwY/+4/H03L
	 MXkMravFaBBkB/2hfuELCT/NY7k3gyM8/SfB+vuJROgp3lEUyv5mA06ycnfkwLESovQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824331;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xqhoVFZ8cc86nj4yHxnnT6XqlHE9Y2ttgewFLPLa5W8=;
	b=BKqTr33agVKKxC1IapRjZkGvYDH/Zo2NwbrD9NNH2mqM05SxA04Roe/EKzwg3I+pPhzG
	 OE8qjyiDjlZNtmXo+8HFw4LqUOjpiCprJ7tWe/rEiOxCY5NyCA7hvrww2CkE901aAUvRb
	 1ChCrB3oiAMkL/m5tnEFYOJ9PMbSApOuWm5hvDm/3wwDPXnRkWArBI9puYuSzA0LJQq/u
	 3lEmdeAHna8MjGuPZlrf7gKWDbPfmD3GRcUifUI1IgSkgQx7nQUlZTHXif45vzHQx5KnA
	 twwgfyio39aUJ8O/paWXsKKGABDwe9ztj3ffo/XPC18X6x1blBZudAuQP1fjl2vh1EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuJZHdgM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D62606A339
	for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 10:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuJZHdgM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18C51F000C4;
	Mon, 16 Nov 2026 10:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794824330;
	bh=xqhoVFZ8cc86nj4yHxnnT6XqlHE9Y2ttgewFLPLa5W8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OuJZHdgMSAxp0WlYYehpRBRu9XVxWu5yGASnmCf+hieW5b3neb47w+bjOzhgBa4bK
	 UyHA/rSk1TcoLy8UU5x6qGVvxDXeO402S5L+95c5+tzJ7yGQ+WV2asu9ZoE32vgyGP
	 CgLaPzN07mokFmU525QwInS6YYuV1F03ZhUVwlcAX0SzlAP7yXkWZlmquNhveCT95b
	 vyiW/Zlv4FgtpiUf7scgxcPeXciUzjnCAqGR06MEmholyHBN4JLVpSwEzJ6WgG1dGt
	 Bo+E8wYtZ/ZaU8SoO4QjX41LDXGnz5nhH0AS96DMzsmGoh3DSC/zTm3etirCkX/ZRc
	 hUr/FToo+3lsQ==
Message-ID: <sashiko-outbox-216707@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] serial: max310x: do not advance the TX fifo past a
 flush
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261116-max310x-tx-fixes-v1-1-61c01f180911@vaisala.com>
References: <20261116-max310x-tx-fixes-v1-0-61c01f180911@vaisala.com>
 <20261116-max310x-tx-fixes-v1-1-61c01f180911@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 10:18:50 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] serial: max310x: out-of-bounds write in max310x_handle_rx()
  [1]
--

commit 12622456e1b4a71d597213ac90888e9dce7b8d1e
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

serial: max310x: do not advance the TX fifo past a flush

This commit copies outgoing bytes into a per-port buffer under the port
lock before transmitting over SPI and skips advancing the TX kfifo if
uart_flush_buffer() ran during the transfer.

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index a0ed70185555e..e6a740295b966 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -317,11 +317,13 @@ struct max310x_one {
>  	bool			sw_rts_during_tx;
>  	bool			cancel_tx_delay_tmr;
>  	bool			tx_teardown;	/* envelope being torn down */
> +	bool			tx_flushed;	/* fifo reset under a transfer */
>  	bool			rs485_pending;	/* rs_work not yet applied */
>  	bool			tx_break;	/* break_ctl() owns the transceiver */
>  	enum max310x_tx_state	tx_state;
> =20
>  	u8 rx_buf[MAX310X_FIFO_SIZE];
> +	u8 tx_buf[MAX310X_FIFO_SIZE];
>  };
>  #define to_max310x_port(_port) \
>  	container_of(_port, struct max310x_one, port)

[ ... ]

> @@ -931,23 +934,41 @@ static void max310x_handle_tx(struct uart_port *por=
t)
>  		return;
>  	}
> =20
> -	/*
> -	 * It's a circ buffer -- wrap around.
> -	 * We could do that in one SPI transaction, but meh.
> -	 */
>  	while (!kfifo_is_empty(&tport->xmit_fifo)) {
>  		unsigned int txlen, to_send;
> -		unsigned char *tail;
> +		unsigned long flags;
> =20
>  		/* Limit to space available in TX FIFO */
>  		txlen =3D max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
>  		txlen =3D port->fifosize - txlen;
> +		txlen =3D min(txlen, sizeof(one->tx_buf));

[Severity: Critical]
This problem wasn't introduced by this patch, but can max310x_handle_rx()
overflow one->rx_buf in the batched read path [1]?

drivers/tty/serial/max310x.c:max310x_handle_rx() {
	...
	if (port->read_status_mask =3D=3D MAX310X_LSR_RXOVR_BIT) {
		...
		sts =3D max310x_port_read(port, MAX310X_LSR_IRQSTS_REG);
		max310x_batch_read(port, one->rx_buf, rxlen);
	...
	} else {
		if (unlikely(rxlen >=3D port->fifosize)) {
			dev_warn_ratelimited(port->dev, "Possible RX FIFO overrun\n");
			port->icount.buf_overrun++;
			/* Ensure sanity of RX level */
			rxlen =3D port->fifosize;
		}
	...
}

Unlike the non-batched branch (and the new txlen clamp above), the batched
branch passes rxlen read from MAX310X_RXFIFOLVL_REG straight to
max310x_batch_read() without clamping it to sizeof(one->rx_buf).  If the
chip reports a length larger than MAX310X_FIFO_SIZE (128 bytes),
regmap_noinc_read() writes past the end of one->rx_buf and corrupts the
enclosing struct max310x_port allocation.

[1] https://sashiko.dev/#/bug/linux-faf2b0a9-9b3f-4e76-a18b-7e85a4d79395

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-max310x-tx=
-fixes-v1-0-61c01f180911@vaisala.com?part=3D1
