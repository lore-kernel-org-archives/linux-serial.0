Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795161189;
	b=uY6wpB/P4JQLkKHjfSUJqtBLDMsuoxgU7xszJ61mOBt1EKVOg82XCbWo5tQl6Y6HY/bp
	 gfrloqEvyMld9VlK/uFspm5C/NdEjUTIikjd7ZL9d8bVhFw7YEFY+ZhbfR1/xVAZikvgh
	 elo2reQqttJ0cCqcctmvNddM+Jp8ILtvXZu2l+flJLKGMdLcZMLEMfrhDo+0cI99Fl9N3
	 xoSEixMQiRb/u7saYb2n1XjOeXooQky6X6DI6134iIy1uLgmB8Bodh/mrwx5ZwkJhovAj
	 ubQwUJnBqwJ2O0Al8DkiUc78mgFEet+Msf37326cWMSrkD0kCk+WkLvhJeiFBmKTWsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161189;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0GkJ9RmMdyYoridcBkOqHyYHAtWew66RVmpofJaeUI8=;
	b=G7iA/6Rztq1SB+N7WSlWbDkM1fhG9247tBoNrhxTwZE7BJk15E7fGY+5H3udwSCSwpqU
	 dA83hP53nKa1N9JBe33vVoz1CAjOafC5sIrhrM5jC0PwaxUOH/60mmXqoteI6QZM7XbK3
	 H/DFMaxZZOGVClVNnFkY7khLICxJJrOvgK+q6WQN4+8/KJrqSSW1oS2rn2thRkWXuU4Dp
	 60qfqq5sIos327m/3sboM/2sB/NMH6pAHQU2mEQMh960r/7345He5hjBY3yJNZydvnZlg
	 boO7WRYkzEZ0QwOFtHjhJ5E+evjT/FpshEvf6jmuVD6u2plfJYqFZ0q2FBIZBaJZ0dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QGkGHmpA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD98606A320
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QGkGHmpA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EF31F000C6;
	Fri, 20 Nov 2026 07:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795161189;
	bh=0GkJ9RmMdyYoridcBkOqHyYHAtWew66RVmpofJaeUI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QGkGHmpATlYi+MJB9JPMwIyYwvsYxgqacpo9f1UE3Wgvh3rrtCSSKNJlitJshHZTT
	 ZvOFpjuBhkU6rHUy3+gkDkoye0rlg8GtGiGQQO/wDHgOTcC1TtxR1i3n0oqp3v2j6E
	 GBFoGiDXV/Ic7Gk2rIW+kQLdAIkokB2ZDyQk/yx6a4Tq17Nu+rf5hrC2+Eba/IVFav
	 vYc1Z4cWX3AjDwW0JehrjhJ713gbjNP27bgrO4ySlPJki01ve/MywXsaoJyHgYr0ak
	 OULRHe2UF4NoKVcVUWgV43wRQQWt73YNddXo/v/R6lfxaaCWkfMFiOoKRnGqrW9FBJ
	 TcjSa2EnhEuSw==
Message-ID: <sashiko-outbox-224662@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: max310x: look at the port once after enabling
 its interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261120-max310x-startup-irq-status-v1-1-aee4e1416cf6@vaisala.com>
References: <20261120-max310x-startup-irq-status-v1-1-aee4e1416cf6@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 07:53:08 +0000
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
- [High] serial: max310x: race between woken max310x_ist() and
  max310x_shutdown()
--

commit cc3a091769281e06df6acf169978f695b85e9541
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

serial: max310x: look at the port once after enabling its interrupts

This commit wakes the IRQ thread once at the end of max310x_startup() and
tracks ports to poll in s->poll_ports so characters received between FIFO
reset release and the initial status read are not stranded.

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index de8a1f05cf30e..cdd1655c9f35c 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
[ ... ]
> @@ -1076,7 +1077,7 @@ static irqreturn_t max310x_ist(int irq, void *dev_i=
d)
>  			WARN_ON_ONCE(regmap_read(s->regmap,
>  						 MAX310X_GLOBALIRQ_REG, &val));
> =20
> -			irq =3D val;
> +			irq =3D val & ~xchg(&s->poll_ports, 0);
> =20
>  			for_each_clear_bit(port, &irq, s->devtype->nr) {
>  				done =3D false;
> @@ -1539,6 +1540,7 @@ static int max310x_rs485_config(struct uart_port *p=
ort, struct ktermios *termios
> =20
>  static int max310x_startup(struct uart_port *port)
>  {
> +	struct max310x_port *s =3D dev_get_drvdata(port->dev);
>  	struct max310x_one *one =3D to_max310x_port(port);
>  	unsigned int val;
> =20
> @@ -1595,11 +1597,19 @@ static int max310x_startup(struct uart_port *port)
>  	val =3D MAX310X_IRQ_RXEMPTY_BIT | MAX310X_IRQ_TXEMPTY_BIT;
>  	max310x_port_write(port, MAX310X_IRQEN_REG, val | MAX310X_IRQ_CTS_BIT);
> =20
> +	/*
> +	 * A character received since the FIFO reset has lost its interrupt
> +	 * to the status read above: have the handler look at this port once.
> +	 */
> +	set_bit(one - s->p, &s->poll_ports);
> +	irq_wake_thread(port->irq, s);
> +
>  	return 0;
>  }
> =20
>  static void max310x_shutdown(struct uart_port *port)
>  {
> +	struct max310x_port *s =3D dev_get_drvdata(port->dev);
>  	struct max310x_one *one =3D to_max310x_port(port);
> =20
>  	/*
> @@ -1612,6 +1622,7 @@ static void max310x_shutdown(struct uart_port *port)
>  	scoped_guard(spinlock_irqsave, &port->lock)
>  		one->tx_teardown =3D true;
>  	max310x_port_write(port, MAX310X_IRQEN_REG, 0);
> +	clear_bit(one - s->p, &s->poll_ports);

[Severity: High]
Can the IRQ thread woken by max310x_startup() run max310x_port_irq()
during or after max310x_shutdown(), re-arming one->tx_work after
cancel_work_sync(&one->tx_work)?

CPU0                                CPU1 (IRQ thread)
max310x_startup()
  set_bit(..., &s->poll_ports)
  irq_wake_thread(port->irq, s)
                                    max310x_ist()
                                      xchg(&s->poll_ports, 0)
max310x_shutdown()
  one->tx_teardown =3D true
  max310x_port_write(..., IRQEN, 0)
  clear_bit(..., &s->poll_ports)
  ...
  /* pulses MAX310X_MODE2_FIFORST_BIT,
     latching TXEMPTY in IRQSTS */
  cancel_work_sync(&one->tx_work)
  max310x_power(port, 0)
                                      max310x_port_irq()
                                        ists =3D ...IRQSTS_REG
                                        schedule_work(&one->tx_work)
uart_shutdown()
  uart_free_xmit_buf()
    kfree(port.xmit_fifo)
                                    max310x_tx_proc()
                                      max310x_handle_tx()
                                        <-- use-after-free on xmit_fifo

On multi-port chips, max310x_ist() consumes s->poll_ports with xchg()
before iterating over the ports, so clear_bit() in max310x_shutdown() does
not stop an already woken thread from visiting the port.  On single-port
chips (s->devtype->nr =3D=3D 1), the else branch in max310x_ist() ignores
s->poll_ports altogether and unconditionally calls max310x_port_irq(s, 0).

Because serial_core only calls synchronize_irq() in uart_port_shutdown()
after uport->ops->shutdown() returns, max310x_shutdown()'s FIFO reset can
latch MAX310X_IRQ_TXEMPTY_BIT and MAX310X_IRQ_CTS_BIT in
MAX310X_IRQSTS_REG, and max310x_port_irq() does not check
one->tx_teardown before scheduling one->tx_work.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-max310x-st=
artup-irq-status-v1-1-aee4e1416cf6@vaisala.com?part=3D1
