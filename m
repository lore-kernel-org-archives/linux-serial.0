Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792824632;
	b=InXZ1GXWgVLSt00VYShny5o/u9Ihwia5g6gp7/tpCkJh3MAomSJ2cPz6qd4L32dPq+ps
	 00bmMLmnt1DnJepNUcdHWbUv1yo2fqdB1V52Ax/1BGfqBsAD3eBW8W3CDoIMsvtOdAC/e
	 we0jcP9Sdp9Jx7UQABVFlSfHMKq2CG9cvV82Jg9X02SmZVp9/a694+joDYVXM91Lfuit5
	 eEygs8ZBZtc0KV3R0dpUw4kMZXY6EiXP4siOTkYH86qObsO34CWLcXsq7l+FNGDlEYWvj
	 zzYiHWL73DVNKqyCTSkjdbE9ER7RhHBe6wWEuUQtOp7dvbfTjm9UeYU4x/0oNqeshpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792824632;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U7lkWM1icUBok0mW0cdkmYyTSqtjf9+7YVfQCQ/6Bro=;
	b=IKICRIuqeuqC/5UBxnwTK7j7HLVudWbjviang2ZJvAM6VIkMGBtoS5L66ebW6aLAFCsS
	 kOb3xUsHOlo1Jn6PoxEj8UYypxg5jvG5IOWid4Uug6piluN4sDxe+AXRrR4qIuiQaMuMq
	 nukiaZMPo8d8bmEuPdq+fyEfUrRvTwmLPsK5g6giCTCA6FsgHAqElmdcVwAD98vKE6ATT
	 egweMqYwJTUfToThpA4AXfJccbtmqd7uQiEcefLKJi8GvXfQxC8sITiNBBIcedv2Pc5Mr
	 ASC6Bz7XaaJ/4tCYL5kyByIa7m07f3z9NysoFiSHhnlZ6oFCe0n5iK8uzbkDBWWOPrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d1bDNlKv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FE4606A31A;
	Sat, 24 Oct 2026 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d1bDNlKv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF121F01825;
	Sat, 24 Oct 2026 06:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792824631;
	bh=U7lkWM1icUBok0mW0cdkmYyTSqtjf9+7YVfQCQ/6Bro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d1bDNlKvLO1wnTd4A6+6/yItsAANhcrCheZzS2NVRM1oR3P4rHQqOFO8AHXgy+H5X
	 brGOtwPf7wDorTIPfHe9mOSKfmG7kKPvDCjklmHHamXkZSPynrpq0ffFxJr6Vv8ahF
	 nEYQu1vyXytUJmHuBzvdjf/e9kmWUB0hCl1+sXUrg6VW/IreA803GbhdA5nL+XIeXe
	 qzSMplrNaEgO9bxKYfeRq2BVEzbXXiuyXR8abMRwmgo0ORsaAFUuLOqHNy/a/LmKz2
	 PMPNHygqDtaJt1hwoa4GHK0q+5Mq0UDk4pmtug6enAXUMbSLDBl2tcgFQFfUgd7/Xl
	 uXF4AJ925vmkA==
Message-ID: <sashiko-outbox-183574@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/5] serial: serialize asynchronous write wakeups
 with the port lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 06:50:30 +0000
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
- [High] serial: clps711x: deadlock between uart_clps711x_int_tx() and stop=
_tx()
--

commit dc0a2d4e309be9916a0d844a2a8caf7397942a8f
Author: James Hilliard <james.hilliard1@gmail.com>

serial: serialize asynchronous write wakeups with the port lock

This commit acquires the UART port lock around asynchronous write wakeups
and transmit helpers in several serial drivers so that uart_write_wakeup()
is serialized with port-locked serial-core state changes.

> diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
> index 83186bf500027..054b9d8359de2 100644
> --- a/drivers/tty/serial/clps711x.c
> +++ b/drivers/tty/serial/clps711x.c
> @@ -174,8 +174,10 @@ static irqreturn_t uart_clps711x_int_tx(int irq, voi=
d *dev_id)
>  			break;
>  	}
> =20
> -	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
> -		uart_write_wakeup(port);
> +	scoped_guard(uart_port_lock_irqsave, port) {
> +		if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
> +			uart_write_wakeup(port);
> +	}

[Severity: High]
Can acquiring port->lock in uart_clps711x_int_tx() deadlock with
uart_clps711x_stop_tx()?

The serial core invokes uart_ops->stop_tx() (uart_clps711x_stop_tx()) with
port->lock held, for example during uart_stop(), uart_flush_buffer(), or
uart_port_shutdown(). Inside uart_clps711x_stop_tx(), it calls synchronous
disable_irq(port->irq) while holding port->lock:

drivers/tty/serial/clps711x.c:uart_clps711x_stop_tx() {
	struct clps711x_port *s =3D dev_get_drvdata(port->dev);

	if (s->tx_enabled) {
		disable_irq(port->irq);
		s->tx_enabled =3D 0;
	}
}

If uart_clps711x_int_tx() is running concurrently (on another CPU or in a
threaded interrupt handler) and attempts to acquire port->lock while
uart_clps711x_stop_tx() holds port->lock and waits inside
disable_irq(port->irq) for the interrupt handler to complete, won't both
contexts deadlock waiting on each other?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-submit-ser=
ial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com?part=3D2
