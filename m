Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8620F22B594;
	Fri,  4 Sep 2026 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515585; cv=none; b=qXZlyUsroMv/XH/R8qGSOBU1Wo3HIeBfb/bJBSih/RqucR09Y1bMZP23JcfdxHZZDRTGVRIBx3YgoHhf9V/1LJebcJGwYP3dRLo+a2JRprDL4sg1k5fUNNE7yN2qrwGlQO29k9fEeCZSO9PZKNBtbyZDEAJ0JAnlLiZch67CcJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515585; c=relaxed/simple;
	bh=3SFAlUsXdPQiSFbdG40FnLU6pamV+16xLUgy4/ivKyQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SHqybXynU17AtD73bOsr8OPBeMYVgM8YnoFYOFxSPPL/rZS/Ytiwu3GS1UVW470uiDmX1UspkEBlWt7TlkV9gIGNxxmHc+UMTVkjdo2hIqqp4k7s9Hta+sV6JemQ89xDQalhWdBFoQUbckE2xZNsm4cqf+w0Ai5M/sRM86+np7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyBUkJQS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyBUkJQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E8E1F00A3D;
	Fri,  4 Sep 2026 09:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788515584;
	bh=S5ZiLamK5gN4JpjJSxP0SoOmn6hcsLC3ZtZglO91IOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HyBUkJQSoxqaPgt+4kcorD9RUYVaYkzXOkvM3DbcN8o1IKfU0P8G8ml+/+4IwttA/
	 TaBdE9chjMhxICoB5lTGXasleiJdRctc2YSQT5RvZ50mpV/U+csbzyDjhs2s/lj5Qo
	 egswy7PVAJHvQmn1n3DYEvXrLywUuvWyjx+GtDsjNm9hQjJ5gKrlDQlVQRay7bEjSB
	 ar9L+P+GIwfKZ/7cPa6VuXfoxSYjA+SayEtdTgTOSn5N6deVhtOM7VTmRJLCDGr/pg
	 IAnm4HOnmjq5RU+J6qIJGnMKTTgRHqL9UF5o0kObZaDxWADs0QM3NZv1XXEFd9DXaq
	 ZdAHSb8QXa4aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] serial: wk2xxx: Add WK2xxx SPI UART driver
Reply-To: sashiko-reviews@lists.linux.dev
To: zjzhao@edatec.cn
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-serial@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260904093341.100826-2-zjzhao@edatec.cn>
References: <20260904072027.67473-1-zjzhao@edatec.cn>
 <20260904093341.100826-1-zjzhao@edatec.cn>
 <20260904093341.100826-2-zjzhao@edatec.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 09:53:03 +0000
Message-Id: <20260904095304.17E8E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [High] Requesting the threaded IRQ before UART ports are fully initialize=
d causes a NULL pointer dereference on early interrupts.
- [High] Unprotected lockless access to the UART transmit kfifo and `x_char=
` in `wk2xxx_handle_tx()`.
- [High] Race condition in polling worker initialization and cancellation c=
an permanently stall polling.
- [High] SPI transfer buffers embedded in `struct wk2xxx_port` violate DMA =
cache coherency rules.
- [High] Early return in `wk2xxx_handle_tx` after sending `x_char` stalls p=
ending transmission.
- [High] Improper teardown order in `wk2xxx_remove()` flushes the kworker b=
efore unregistering the port, leading to Use-After-Free.
- [High] Data race on the shared SPI transmit buffer `s->spi_tx` without lo=
ck protection.
- [High] Kernel panic via division by zero if `clock-frequency` device tree=
 property is 0.
- [Medium] Data race on port state and statistics due to missing `port->loc=
k` acquisition.
- [Medium] Improper teardown order in `wk2xxx_remove()` stalls the TX flush=
ing process during unbind.
--

commit 6a58cb664a5c2176dca76b8cff9410c1dd264818
Author: zjzhao <zjzhao@edatec.cn>

serial: wk2xxx: Add WK2xxx SPI UART driver
   =20
Add a driver for the WK2xxx SPI to UART bridge ICs (WK2124, WK2132,
WK2168, WK2202 and WK2204) from WKmic (Chengdu Weikai Microelectronics).
Each IC exposes two or four full-duplex UART channels with 256-byte
RX/TX FIFOs through a single SPI slave interface and one interrupt line.

> diff --git a/drivers/tty/serial/wk2xxx.c b/drivers/tty/serial/wk2xxx.c
> index 0000000000000..77f288e452340
> --- /dev/null
> +++ b/drivers/tty/serial/wk2xxx.c
> @@ -176,11 +176,11 @@ struct wk2xxx_port {
>  	atomic_t			open_ports;
>  	/*
>  	 * Shared SPI transfer buffers. All SPI accesses are serialized by
>  	 * s->reg_lock, so these are never used concurrently.
>  	 */
>  	u8				spi_tx[WK2XXX_MAX_SPI_LEN + 1];
>  	u8				spi_rx[WK2XXX_MAX_SPI_LEN + 1];
>  	struct wk2xxx_one		p[];
>  };

[Severity: High]
Does embedding these buffers directly without ____cacheline_aligned risk
cacheline tearing during DMA operations?

When the SPI subsystem maps these buffers for DMA transfers on
non-cache-coherent architectures, cache invalidation during unmap could
destroy adjacent fields in the same cache line. If there are concurrent
CPU writes to neighboring fields like open_ports or polling, could they
be silently overwritten by stale cache data?

[ ... ]

> @@ -382,9 +382,9 @@ static int wk2xxx_fifo_read(struct wk2xxx_port *s, un=
signed int portno,
> =20
>  	if (len =3D=3D 0 || len > WK2XXX_MAX_SPI_LEN)
>  		return -EINVAL;
> =20
>  	memset(tx, 0, WK2XXX_MAX_SPI_LEN + 1);
>  	tx[0] =3D wk2xxx_port_addr(portno, WK2XXX_SPI_FIFO_READ);
> =20
>  	guard(mutex)(&s->reg_lock);

[Severity: High]
Is it safe to modify the shared s->spi_tx buffer before acquiring the
s->reg_lock mutex?

If multiple threads execute wk2xxx_fifo_read or wk2xxx_fifo_write
concurrently, it seems they would mutate this unprotected buffer
simultaneously, corrupting the SPI commands.

[ ... ]

> @@ -487,9 +487,9 @@ static void wk2xxx_handle_tx(struct uart_port *port)
> =20
>  	guard(mutex)(&one->tx_lock);
> =20
>  	if (unlikely(port->x_char)) {
>  		wk2xxx_port_reg_write(s, portno, WK2XXX_FDAT_REG, port->x_char);
>  		port->icount.tx++;
>  		port->x_char =3D 0;
>  		return;
>  	}

[Severity: High]
Does this code modify port->x_char and port->icount.tx without holding
the required port->lock?

[Severity: High]
Also, does this early return stall pending transmission if an x_char is
sent?

By returning immediately, it bypasses the logic at the end of the function
that checks the xmit_fifo and re-enables the hardware transmit interrupt
(WK2XXX_SIER_TFTRIG_IEN_BIT), which might strand the remaining data in
the kfifo.

> @@ -511,8 +511,8 @@ static void wk2xxx_handle_tx(struct uart_port *port)
>  		txlen =3D WK2XXX_MAX_TX_CHARS;
> =20
>  	to_send =3D kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
>  	sent =3D 0;
>  	while (to_send) {
>  		unsigned int chunk =3D min_t(unsigned int, to_send,
>  					   WK2XXX_MAX_SPI_LEN);

[Severity: High]
Is it safe to access and advance the serial core kfifo without holding
port->lock?

If the serial core concurrently executes an operation like
uart_flush_buffer (which calls kfifo_reset), the kfifo internal
state could be corrupted.

[ ... ]

> @@ -582,3 +582,3 @@ static void wk2xxx_handle_rx(struct uart_port *port)
>  	}
> =20
>  	port->icount.rx +=3D rxlen;

[Severity: Medium]
Is it safe to increment the receive byte counter without locking? This could
lead to lost updates if there are concurrent readers or writers.

[ ... ]

> @@ -819,4 +819,4 @@ static void wk2xxx_calc_divisor(unsigned long clk, un=
signed int baud,
>  	unsigned int div, rem;
> =20
>  	div =3D clk / (baud * 16);
>  	if (div =3D=3D 0)

[Severity: High]
Could baud be zero here and cause a division by zero panic?

If clock-frequency is set to 0 in the device tree, uart_get_baud_rate
will fall back to returning 0, resulting in baud being 0 here.

[ ... ]

> @@ -849,6 +849,6 @@ static void wk2xxx_set_termios(struct uart_port *port=
, struct ktermios *termios,
> =20
>  	/* Configure flow control. */
>  	port->status &=3D ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS);
>  	if (termios->c_cflag & CRTSCTS) {
>  		fwcr =3D WK2XXX_FWCR_FWM_RTS_CTS;
>  		port->status |=3D UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
>  	}

[Severity: Medium]
Is it safe to modify port->status, port->read_status_mask, and
port->ignore_status_mask before the spinlock is acquired via
guard(uart_port_lock_irqsave) later in the function?

[ ... ]

> @@ -883,4 +883,4 @@ static int wk2xxx_startup(struct uart_port *port)
> =20
>  	/* Start the shared polling loop when the first port is opened. */
>  	if (s->polling && atomic_inc_return(&s->open_ports) =3D=3D 1)
>  		kthread_queue_delayed_work(&s->kworker, &s->poll_work,
>  					   msecs_to_jiffies(WK2XXX_POLL_PERIOD_MS));

[Severity: High]
Could this sequence race with port shutdown and permanently stall polling?

If port A shuts down concurrently with port B starting up, port B can queue
the delayed work just before port A executes
kthread_cancel_delayed_work_sync in wk2xxx_shutdown. This would leave
the polling loop cancelled even though open_ports is 1.

[ ... ]

> @@ -1054,5 +1054,5 @@ static int wk2xxx_probe(struct spi_device *spi)
>  		 */
>  		ret =3D request_threaded_irq(spi->irq, NULL, wk2xxx_irq,
>  					   IRQF_TRIGGER_LOW | IRQF_SHARED |
>  					   IRQF_ONESHOT, dev_name(dev), s);
>  		if (ret)

[Severity: High]
Can requesting the IRQ here before the UART ports are fully initialized cau=
se
a NULL pointer dereference on early interrupts?

If the UART device has a pending interrupt when the driver is probed, the
handler wk2xxx_irq will execute and traverse down to
tty_flip_buffer_push(&port->state->port) in wk2xxx_handle_rx.
Because port->state is not initialized until uart_add_one_port is
called later, this results in a NULL pointer dereference.

[ ... ]

> @@ -1115,4 +1115,4 @@ static int wk2xxx_probe(struct spi_device *spi)
>  	/* Crystal clock; allow an optional DT override. */
>  	uartclk =3D devtype->crystal_freq;
>  	if (device_property_read_u32(dev, "clock-frequency", &clock_freq) =3D=
=3D 0)
>  		uartclk =3D clock_freq;

[Severity: High]
Does this code apply the clock-frequency from the device tree without
validating it?

If the property is maliciously or accidentally set to 0, or a value less
than 16, it can lead to a division by zero panic in wk2xxx_calc_divisor.

[ ... ]

> @@ -1243,10 +1243,10 @@ static void wk2xxx_remove(struct spi_device *spi)
>  	 */
>  	if (s->irq_requested)
>  		free_irq(spi->irq, s);
> =20
>  	if (s->polling)
>  		kthread_cancel_delayed_work_sync(&s->poll_work);
> =20
>  	kthread_flush_worker(&s->kworker);
> =20
>  	for (i =3D 0; i < s->devtype->nr_uart; i++) {
>  		uart_remove_one_port(&wk2xxx_uart, &s->p[i].port);

[Severity: Medium]
Does freeing the IRQ before unregistering the port stall the TX flushing
process during unbind?

When uart_remove_one_port is executed, it attempts to wait for the
transmit FIFO to drain. Since the driver relies on hardware transmit interr=
upts
to wake the worker and send chunks of data from the software kfifo, prematu=
rely
freeing the IRQ disables this mechanism and the teardown sequence will hang
until internal timeouts trigger.

[Severity: High]
Also, does flushing the worker before unregistering the port lead to a
use-after-free?

While the worker is flushed, userspace or the TTY layer can still queue new
transmit works because the port remains fully registered. Once
uart_remove_one_port finishes, the port xmit_fifo buffer is
freed. A late tx_work that was queued during or immediately after the
flush will then execute and attempt to access the destroyed kfifo.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904093341.1008=
26-1-zjzhao@edatec.cn?part=3D1
