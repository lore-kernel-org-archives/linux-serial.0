Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792826697;
	b=Icd4Lxu1FPBh+XpNOU3HEXbAb5p9ryQtJHjIrxZmImAxmNVFefONGlYeuaEbC6xSsnfO
	 9rDZyh0xb1OkSyhTs755BB7eetXBc8ev+vydVF4CGAnbflMyC5K/mZw7mCvDZqluKqshr
	 VrOFmRM5I4shH69fSaxY3I21VoA3gwyghyCmUDEtEZRLXGg1uQNqj2RU47V7BHZjDDmH4
	 pNGdYW7epXXxPM6wLfvWeCHxeS7pNdem7gdcZrBXrgu/O2W69mkMAx2+Ha/0S89qardGV
	 Icpzcb7DZ1A0onZ1OWOzVcaMjatWHhOO43VRD92+FSt4Dp5o7x3FI6C+ZmjIis/FKyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792826697;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mliuCbsxIb8acnPuAlhgKMxCC9FokkYb16aWtaL9rEs=;
	b=cItkChnWrhRj5dGYq1uqJM5a/zVOJ0y1PNRmFMyIV9M/zxAQsKqkLKHebopJJQ1Dq58/
	 nTSSRj8TszglIVdQZDoKyxrhhdvm+xnyD45JzHJ7BUfMURrGrwO2J3KycdOBv8O4caJzh
	 R9/ESsBrGe+pm39W5F5aS6l5V1+ahHcgAMZ2elltS57yKy6VwuOdFd5WoLKsYogu9B84l
	 iUokDi2miDLvfayQChmk6+sefa7lX7rz0BV17fXBe7D2G+66qp6Vvhe8ETxAi5MUYXvKY
	 ZX2MLIFEYsR/1PGLpjAv2RWCD0zF7m/E+zFgBH8XUfgIw4RcfDmWfK0l1HV5VwStI/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGIB90Je;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2789F606A31A;
	Sat, 24 Oct 2026 07:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGIB90Je
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B43C1F01825;
	Sat, 24 Oct 2026 07:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792826696;
	bh=mliuCbsxIb8acnPuAlhgKMxCC9FokkYb16aWtaL9rEs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BGIB90JexS2jS9DC6JJy9FlgGotdfXGY6Zwktb+OnmwSTV03CShtX0RpCy5EcfUCz
	 e5zJi5vqG4/hl7zYL8YWBgl97J3i5ZxkcDVteLOCtSJHR0hxNToc7w1P1nmKZcAFdw
	 vtEGKIw9VZSzts/05AN4v95gXF+YsS+Ky8rk2cJKF9KKBlRbbL+EYcFdRli1SoJ5cS
	 U30z7CxKGGOfwvhM6r1CXq/GA9JVUKjFJGmnMcQIdzlLGfMO8pVfm4a6Gx2b4ElurG
	 fLDM2baeY57PyBfeXsZhuc0YANC6yfAk8CdrnpfHFRzREcj39jX3ZBUJ2j0iWDB81q
	 eBPkpQac6qzCA==
Message-ID: <sashiko-outbox-183582@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/5] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261024-submit-serial-8250-dma-cancel-v1-v5-5-9e52968928d2@gmail.com>
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v5-5-9e52968928d2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 07:24:56 +0000
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
- [High] serial: 8250_dma: dev_warn() called under port lock in serial8250_=
rx_dma_flush_work()
--

commit 0ccef758673ba1627cbc368a7ea2a4a045241f8f
Author: James Hilliard <james.hilliard1@gmail.com>

serial: 8250: retire canceled RX DMA before reusing the receive buffer

This commit reserves the RX DMA buffer until a worker has drained canceled
callbacks and falls back to PIO via a recovery worker if pausing, querying
status, or terminating the RX DMA channel fails.

> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250=
/8250_dma.c
> index 1a070967bf571..801221baded0a 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -86,53 +86,96 @@ void serial8250_tx_dma_sync_buffer(struct uart_8250_p=
ort *p,
[ ... ]
> +static void serial8250_rx_dma_flush_work(struct work_struct *work)
> +{
> +	struct uart_8250_dma *dma =3D container_of(work, struct uart_8250_dma, =
rx_flush_work);
> +	struct uart_8250_port *p =3D dma->port;
> +	bool recover;
> +	int ret;
> +
> +	/* All packed flags share the port lock, including this worker snapshot=
. */
> +	scoped_guard(uart_port_lock_irqsave, &p->port)
> +		recover =3D dma->rx_err;
> +
> +	if (recover) {
> +		ret =3D dmaengine_terminate_sync(dma->rxchan);
> +		if (ret) {
> +			/* Retain ownership and keep RX masked if DMA cannot be stopped. */
> +			dev_err(p->port.dev, "failed to stop RX DMA: %d\n", ret);
> +			return;
> +		}
> +	} else {
> +		dmaengine_synchronize(dma->rxchan);
> +	}
> +
> +	guard(serial8250_rpm)(p);
> =20
> -	uart_port_lock_irqsave(&p->port, &flags);
> +	guard(uart_port_lock_irqsave)(&p->port);
> +
> +	dma->rx_terminating =3D false;
> +	dma->rx_running =3D 0;
>  	if (dma->shutting_down)
> -		goto out;
> -	if (dma->rx_running)
> -		__dma_rx_complete(p);
> +		return;
> =20
> -	/*
> -	 * Cannot be combined with the previous check because __dma_rx_complete=
()
> -	 * changes dma->rx_running.
> -	 */
> -	if (!dma->rx_running && (serial_lsr_in(p) & UART_LSR_DR))
> -		p->dma->rx_dma(p);
> -out:
> -	uart_port_unlock_irqrestore(&p->port, flags);
> +	if (!recover)
> +		return;
> +
> +	/* Apply the current enables, including any intervening stop_rx(). */
> +	serial8250_out_IER(p, p->ier);
> +	dev_warn(p->port.dev, "RX DMA failed, using PIO\n");

[Severity: High]
Does calling dev_warn() while holding p->port.lock with interrupts disabled=
 in
serial8250_rx_dma_flush_work() violate the printk and serial console locking
hierarchy?

When RX DMA recovery is triggered via dma_rx_complete() or
serial8250_rx_dma_flush() -> serial8250_rx_dma_recover(),
serial8250_rx_dma_flush_work() takes guard(uart_port_lock_irqsave)(&p->port)
for the remainder of the function and calls dev_warn() under p->port.lock.

In drivers/tty/serial/serial_core.c, uart_port_spin_lock_init() assigns eve=
ry
uart_port->lock the shared lockdep class port_lock_key:

  static void uart_port_spin_lock_init(struct uart_port *port)
  {
          spin_lock_init(&port->lock);
          lockdep_set_class(&port->lock, &port_lock_key);
  }

Normal console paths acquire console_lock_dep_map and console_owner_dep_map
outside port_lock_key. Calling dev_warn() while holding p->port.lock enters:

  vprintk_emit()
    -> console_trylock_spinning()
       -> console_flush_all()
          -> console_emit_next_record()
             -> console_lock_spinning_enable()

which acquires console_owner_dep_map inside port_lock_key and invokes legacy
serial console write callbacks that also acquire port_lock_key, risking loc=
kdep
splats or a console-owner spin deadlock.

Should the port lock use scoped_guard(uart_port_lock_irqsave, &p->port) so
that p->port.lock is released after serial8250_out_IER(p, p->ier) and before
dev_warn() is called?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-submit-ser=
ial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com?part=3D5
