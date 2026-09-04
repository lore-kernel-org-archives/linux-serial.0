Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CDA3EB802;
	Fri,  4 Sep 2026 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520210; cv=none; b=UjKnWf59qa5aPlJsnoe1FNm+SJc0svR4T7DqqA7vXCyDBWnvfBvaB431x+nq1K1ClIKmxiuzXWXvF0WA8Onaq7Rt/o8v6kUS70iHq0dz690CgmKJl+Y1q3Np1/Afh2m80iNFCZ6T+acU7Owkla/hEgQ3BmX3KL3h4CAyoIVbZy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520210; c=relaxed/simple;
	bh=+3kqsLOjrOl8dfb6u30uY5BIeEk6KjN2L1HR0KkWZSY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qpFWIb7S+ghe+O3o8h7JwgxAKIjGmjECIg284F7vyUKMxknqCzyKsb5SC11tcg6pD0DZhuGY07r23hsLyqB49okRlhg6YEf455AmV9X0LBg3TZgTxWpwiCCkjkC5JBnkaqSGYAHURotWkh707I79FW/O5ibaWGPs8kcxVMK8jQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fB1kfpxR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fB1kfpxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6143D1F00A3F;
	Fri,  4 Sep 2026 11:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788520208;
	bh=k1mz2fa2Xrj+OvtsLvvdX+AJ+RBBNpA52n8W3pdaytI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fB1kfpxRWCha3EcPbnNGFl6AzCwHv9BGXQsu23YwAQrtTgmaC5ES1IVJfFguVgssr
	 SugQqCdKG0uTtkEJQTOv5eUvyi3UzYeCbjCg+PsQ30JC/1oZeIjcve1hDepFe6vTVb
	 yV0jrk9TZ4+udYqFNWd/xk7luDBpdrZMAUnhQal+g2+nX9iYhXPAzM6emjh2Ech5yM
	 jIfQ93zceT1eaijyGrGd1GbjGePpEBjwUx5jKzH2DpacUfqYm+9YUs2bBp7W0DUOh1
	 9RmtZ9sFzJazIEKERekqcXBQlMiozX0qVgAyo7IQ3Y1HgGYVaoFT6tugMQkZZcZuOB
	 Tbndm6ckzxTzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] serial: wk2xxx: Add WK2xxx SPI UART driver
Reply-To: sashiko-reviews@lists.linux.dev
To: zjzhao <zjzhao@edatec.cn>
Cc: linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260904105243.120769-2-zjzhao@edatec.cn>
References: <20260904093341.100826-1-zjzhao@edatec.cn>
 <20260904105243.120769-1-zjzhao@edatec.cn>
 <20260904105243.120769-2-zjzhao@edatec.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:10:07 +0000
Message-Id: <20260904111008.6143D1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Missing port lock synchronization for statistics and kfifo acc=
ess causes data races, ring buffer corruption, and heap buffer overflows.
- [Critical] The `spi_rx` DMA buffer shares a cacheline with the `p[]` flex=
ible array, which can lead to memory corruption on non-cache-coherent archi=
tectures.
- [High] Ignored SPI read errors corrupt global chip state.
- [High] Returning IRQ_HANDLED on SPI bus error leads to IRQ storm.
- [High] UART ports are registered and exposed to userspace before the SPI =
IRQ is requested, leading to potentially missed edge-triggered interrupts a=
nd permanent port hangs.
- [High] Lockless access to `port->rs485.flags` in `wk2xxx_reconf_rs485()` =
can race with concurrent modifications from the `TIOCSRS485` ioctl.
- [Medium] Overrun and other error markers are incorrectly amplified and du=
plicated for every byte in a bulk RX chunk, degrading reliability.
- [Medium] Lost RX data when wk2xxx_fifo_read fails mid-transfer.
--

commit c961eb76f21270c39040554c82f8108729896107
Author: zjzhao <zjzhao@edatec.cn>
serial: wk2xxx: Add WK2xxx SPI UART driver

This commit adds a new driver for the WK2xxx SPI to UART bridge ICs. The
driver registers up to four full-duplex UART channels and supports hardware
flow control and RS485.

diff --git a/drivers/tty/serial/wk2xxx.c b/drivers/tty/serial/wk2xxx.c
index 0000000000000..f8005bbec9374
--- /dev/null
+++ b/drivers/tty/serial/wk2xxx.c
@@ -0,0 +1,1401 @@

[ ... ]

> +struct wk2xxx_port {
> +	const struct wk2xxx_devtype	*devtype;
[ ... ]
> +	/*
> +	 * Shared SPI transfer buffers. All SPI accesses are serialized by
> +	 * s->reg_lock, so these are never used concurrently. Each buffer is
> +	 * cache-line aligned so that DMA cache maintenance performed on a
> +	 * buffer never invalidates a line shared with the fields above.
> +	 */
> +	u8				spi_tx[WK2XXX_MAX_SPI_LEN + 1] ____cacheline_aligned;
> +	u8				spi_rx[WK2XXX_MAX_SPI_LEN + 1] ____cacheline_aligned;
> +	struct wk2xxx_one		p[];
> +};

[Severity: Critical]
Could this struct layout allow the spi_rx DMA buffer to share a cacheline w=
ith
the flexible array p[]?

Because WK2XXX_MAX_SPI_LEN + 1 is 31 bytes, which is not a multiple of typi=
cal
cacheline sizes, the compiler may place p[0] at the next 8-byte boundary. T=
his
would cause spi_rx and p[0] to share a cacheline.

On non-cache-coherent architectures, DMA invalidation of spi_rx might disca=
rd
concurrent CPU writes to p[0] (such as acquiring its tx_lock), or CPU
writebacks could clobber the incoming DMA data.

[ ... ]

> +static int wk2xxx_raw_read(struct wk2xxx_port *s, u8 addr, u8 *val)
> +{
> +	u8 *tx =3D s->spi_tx;
> +	u8 *rx =3D s->spi_rx;
> +	int ret;
> +
> +	tx[0] =3D WK2XXX_SPI_READ | addr;
> +	tx[1] =3D 0;
> +	ret =3D wk2xxx_spi_transfer(s, tx, rx, 2);
> +	if (ret) {
> +		*val =3D 0;
> +		return ret;
> +	}

[ ... ]

> +static void wk2xxx_handle_tx(struct uart_port *port)
> +{
[ ... ]
> +	to_send =3D kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
> +	sent =3D 0;
> +	while (to_send) {
> +		unsigned int chunk =3D min_t(unsigned int, to_send,
> +					   WK2XXX_MAX_SPI_LEN);
> +
> +		if (wk2xxx_fifo_write(s, portno, tail, chunk))
> +			break;
> +		tail +=3D chunk;
> +		to_send -=3D chunk;
> +		sent +=3D chunk;
> +	}
> +	uart_xmit_advance(port, sent);
> +
> +	scoped_guard(uart_port_lock_irqsave, port) {

[Severity: Critical]
Is it safe to call uart_xmit_advance() locklessly before entering the
scoped_guard?

This modifies port->icount.tx and the kfifo out index outside the port lock.
If a concurrent userspace thread invokes the TCFLSH ioctl, uart_flush_buffe=
r()
could set the kfifo's in and out pointers to 0.

If this lockless uart_xmit_advance() subsequently adds to the out pointer, =
it
could integer-underflow the kfifo length calculation. This would cause
kfifo_avail() to return a massive buffer size and lead to an out-of-bounds
memcpy() on the next write().

[ ... ]

> +static void wk2xxx_handle_rx(struct uart_port *port)
> +{
[ ... ]
> +	/* Read the FIFO contents in chunks. */
> +	len_p =3D 0;
> +	while (rxlen) {
> +		chunk =3D min_t(unsigned int, rxlen, WK2XXX_MAX_SPI_LEN);
> +		if (wk2xxx_fifo_read(s, portno, one->buf + len_p, chunk))
> +			return;

[Severity: Medium]
If wk2xxx_fifo_read() fails mid-transfer, does returning directly here cause
silent data loss?

By issuing an early return, any bytes successfully read into one->buf during
previous iterations of the loop are completely discarded. A break statement
might be needed instead so the already-read characters can be processed and
pushed to the TTY buffer.

> +		len_p +=3D chunk;
> +		rxlen -=3D chunk;
> +	}
> +	rxlen =3D len_p;
> +
> +	/* Map the FIFO status register error flags to line status. */
> +	if (fsr & WK2XXX_FSR_ERR_MASK) {
> +		if (fsr & WK2XXX_FSR_RFPE_BIT) {
> +			port->icount.parity++;
> +			lsr |=3D WK2XXX_LSR_PE_BIT;
> +			flag =3D TTY_PARITY;
> +		}

[Severity: Critical]
Are there missing locks around the port->icount statistics updates here?

Updating the port statistics without holding the port lock could cause data
races with concurrent readers.

[ ... ]

> +		if (fsr & WK2XXX_FSR_RFOE_BIT) {
> +			port->icount.overrun++;
> +			lsr |=3D WK2XXX_LSR_OE_BIT;
> +			flag =3D TTY_OVERRUN;
> +		}
[ ... ]
> +	for (i =3D 0; i < rxlen; ++i) {
> +		u8 ch =3D one->buf[i];
> +
> +		if (uart_handle_sysrq_char(port, ch))
> +			continue;
> +
> +		if (lsr & port->ignore_status_mask)
> +			continue;
> +
> +		uart_insert_char(port, lsr, WK2XXX_LSR_OE_BIT, ch, flag);
> +	}

[Severity: Medium]
Does passing the global overrun marker to uart_insert_char() for every byte=
 in
the burst incorrectly amplify a single error?

Since the hardware FSR register provides a global status rather than a
per-byte status, mapping it to lsr and passing it to uart_insert_char() for
every processed byte will insert a TTY_OVERRUN dummy character for every
single byte in the FIFO burst.

This means one actual FIFO overrun will insert up to 256 dummy overrun
characters into the TTY buffer and mark all successfully read bytes as
corrupted.

[ ... ]

> +static irqreturn_t wk2xxx_irq(int irq, void *dev_id)
> +{
[ ... ]
> +	do {
> +		u8 gifr;
> +		int i;
> +
> +		keep_polling =3D false;
> +
> +		if (wk2xxx_reg_read(s, WK2XXX_GIFR_REG, &gifr))
> +			return IRQ_HANDLED; /* Bus error; give up this pass. */

[Severity: High]
Can returning IRQ_HANDLED on a bus error prevent the IRQ subsystem from
masking a stuck interrupt?

If reading the global interrupt flag register fails and the interrupt is
level-triggered (or stays asserted by hardware), returning IRQ_HANDLED defe=
ats
the spurious interrupt detector. The kernel will continuously re-invoke the
handler in a tight loop, leading to an IRQ storm.

Returning IRQ_NONE would allow the kernel to mask the rogue interrupt when =
no
hardware state is successfully cleared.

[ ... ]

> +static void wk2xxx_reconf_rs485(struct uart_port *port)
> +{
> +	struct wk2xxx_port *s =3D dev_get_drvdata(port->dev);
> +	u8 rs485 =3D 0;
> +
> +	if (port->rs485.flags & SER_RS485_ENABLED) {

[ ... ]

> +static void wk2xxx_reg_proc(struct kthread_work *ws)
> +{
[ ... ]
> +	uart_port_unlock_irqrestore(&one->port, irqflags);
> +
> +	if (config.flags & WK2XXX_RECONF_IER)
> +		wk2xxx_port_reg_update(s, one->port.iobase, WK2XXX_SIER_REG,
> +				       config.ier_mask, config.ier_val);
> +
> +	if (config.flags & WK2XXX_RECONF_RS485)
> +		wk2xxx_reconf_rs485(&one->port);
> +}

[Severity: High]
Might wk2xxx_reconf_rs485() race with concurrent modifications from the
TIOCSRS485 ioctl?

The kworker deliberately drops port->lock before invoking
wk2xxx_reconf_rs485(), which then reads port->rs485.flags locklessly.

If userspace sets the RS485 configuration via the ioctl, wk2xxx_config_rs48=
5()
defers execution to the kworker. The kworker might execute and read the old
configuration before the serial core has a chance to update port->rs485,
causing the hardware configuration to become permanently out of sync.

[ ... ]

> +static int wk2xxx_startup(struct uart_port *port)
> +{
> +	struct wk2xxx_port *s =3D dev_get_drvdata(port->dev);
> +	unsigned int portno =3D port->iobase;
> +	u8 reg;
> +
> +	scoped_guard(mutex, &s->reg_lock) {
> +		/* Enable the sub-UART. */
> +		wk2xxx_raw_read(s, WK2XXX_GENA_REG, &reg);
> +		reg |=3D BIT(portno);
> +		wk2xxx_raw_write(s, WK2XXX_GENA_REG, reg);

[Severity: High]
If wk2xxx_raw_read() fails due to a transient SPI error, will this silently
disable all other active sub-UARTs?

When the initial SPI read fails, it forces the output variable reg to 0, but
the code ignores the error. Setting the bit for this port against a 0 value
and writing it back inadvertently zeroes out the enable and interrupt bits =
for
all other active ports on the chip, breaking them.

[ ... ]

> +static int wk2xxx_probe(struct spi_device *spi)
> +{
[ ... ]
> +	for (i =3D 0; i < devtype->nr_uart; ++i) {
[ ... ]
> +		/* Register port. */
> +		ret =3D uart_add_one_port(&wk2xxx_uart, &s->p[i].port);
> +		if (ret)
> +			goto out_ports;
> +
> +		port_registered[i] =3D true;
> +	}
> +
> +	/*
> +	 * Request the IRQ only after every port is registered so that an early
> +	 * interrupt can never reach a port whose port->state is not ready yet.
> +	 * We first try to acquire the IRQ line as a level IRQ; if that
> +	 * succeeds, we can allow sharing the interrupt as well.  In case the
> +	 * interrupt controller doesn't support that, we fall back to a
> +	 * non-shared falling-edge trigger.
> +	 */
> +	if (!s->polling) {
> +		ret =3D request_threaded_irq(spi->irq, NULL, wk2xxx_irq,
> +					   IRQF_TRIGGER_LOW | IRQF_SHARED |
> +					   IRQF_ONESHOT, dev_name(dev), s);

[Severity: High]
Is it safe to register the UART ports and expose them to userspace before
requesting the SPI IRQ?

Because uart_add_one_port() exposes the TTY device, userspace can immediate=
ly
open() it. This executes wk2xxx_startup() which enables hardware interrupts=
 on
the WK2xxx chip.

If the chip pulls the interrupt line low immediately (such as for a TX empty
condition) and the system falls back to IRQF_TRIGGER_FALLING, the initial
falling edge will be missed because the OS has not requested the IRQ yet. T=
he
line would remain low, but because it is edge-triggered, the interrupt will
never fire again, permanently hanging the port.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904105243.1207=
69-1-zjzhao@edatec.cn?part=3D1
