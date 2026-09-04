Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214DB358378;
	Fri,  4 Sep 2026 07:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507329; cv=none; b=Iv/Uy7IV5XCoSb0UQTPYbw1FFYaWVgrHdyblukzg9RHryy01WvUfWsLjDCTLlCZPpkwhgK0Bu27veDtgwBaJ1spqqWg4APb0oiOJsIjFhk3pPNhCAKChXEDNliOtz9j6m0qWC5rNB2bz08e9ZLiGMb7ZZFEem28VwWrjGQOOilQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507329; c=relaxed/simple;
	bh=iWAzl4uoU/1K673mwttMLcmuoCvVXtQ+uLGAbz5ZEEw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A6bl8DKT7Ow9kzKw0yULDb8tbIwto6DFVDUwgF81TEj0aD3qfBKxbni0AI8JqeVgUlrxc7JuHq6mjt4+f10WxdwS9E1pELFii4xsItTWP2rckxEI7jycNDAIwudMeYpg7O9cYsNVwtT8dSojaXwF7Pey62Aj+M4i84dtS1WYWOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nx2OjJFi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nx2OjJFi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8061F00A3E;
	Fri,  4 Sep 2026 07:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788507317;
	bh=LAMLr2jdnSmqhlIpiYjDGLF38WBsK+pg74McJVQALGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nx2OjJFinaz097Mr1ZJQtJ9/yb+4iby3DQkRbV3S4+4oRI0jfBB3jaHrqQBeRQzfx
	 tlZsr381ch/8W+S5FYuT/SHxTpzL6s5LjL5Lg43gCHrrP6yzLxGqq24BXSIpoOBcs5
	 Fj8ANyE/t+T3gTczNai+xMxBd27H5+Hew69gBCXXKUB4LuQtsk/d5dnOTKwm/e++PM
	 37uDqfhvJbPPRLzszZLeyo7fIgWNlgJ/Xg3WYMk/YliYxxfYT+6Gz7y7DcFfKSy/Nn
	 iEzPh4iuNbjIQDlSQj2d0uhcoAWHyo10OLB4T0FGFGvR7koqx8cP2bbYjWX+XAeIXf
	 dmcgvjQ3ifkvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] serial: wk2xxx: Add WK2xxx SPI UART driver
Reply-To: sashiko-reviews@lists.linux.dev
To: zjzhao <zjzhao@edatec.cn>
Cc: linux-serial@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260904072027.67473-2-zjzhao@edatec.cn>
References: <20260904072027.67473-1-zjzhao@edatec.cn>
 <20260904072027.67473-2-zjzhao@edatec.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 07:35:17 +0000
Message-Id: <20260904073517.6B8061F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 14 potential issue=
(s) to consider:
- [High] The IDA line number is freed before the UART port is unregistered,=
 allowing an ID reuse race condition.
- [High] Closing a single UART port unconditionally stops the shared pollin=
g loop, breaking all other active ports on the same SPI chip.
- [High] Ignored SPI read errors leave stack variables uninitialized, leadi=
ng to undefined control flow and leakage of stale buffer data to user-space.
- [High] Ports are registered and exposed to user-space before the IRQ hand=
ler and polling infrastructure are initialized.
- [High] Unprotected access to serial core data structures (xmit_fifo, x_ch=
ar, icount) without holding port->lock causes data races and severe kfifo c=
orruption.
- [High] SPI transfer buffers are allocated on the stack, violating DMA-saf=
ety requirements and potentially causing memory corruption or panics.
- [High] Late devm IRQ teardown causes Use-After-Free of port->state and kw=
orker task_struct if an interrupt fires during manual port removal.
- [High] Polling mode deadlocks the kworker thread permanently upon the fir=
st TX FIFO drain.
- [High] 64-bit division using the `/` operator will break kernel builds on=
 32-bit architectures.
- [Medium] The shared IRQ handler unconditionally returns IRQ_HANDLED, brea=
king shared interrupt semantics.
- [Medium] Standard termios CREAD (Receiver Enable) flag is incorrectly eva=
luated, failing to drop normal characters.
- [Medium] RX error flags from FSR are incorrectly applied to every charact=
er in the burst read.
- [Medium] wk2xxx_throttle() fails to disable the RX timeout interrupt, def=
eating flow control.
- [Medium] Incorrect implementation of unsupported RS485 delays.
--

commit fa4922eb42a208a55c46770ba645376285db8163
Author: zjzhao <zjzhao@edatec.cn>
Subject: serial: wk2xxx: Add WK2xxx SPI UART driver

This commit adds a new serial driver for the WK2xxx SPI to UART bridge ICs.
It supports up to four full-duplex UART channels over a single SPI slave
interface, with features like hardware flow control and RS485, using a
kthread worker for register accesses.

> diff --git a/drivers/tty/serial/wk2xxx.c b/drivers/tty/serial/wk2xxx.c
> new file mode 100644
> index 0000000000000..184bef9b0fa81
> --- /dev/null
> +++ b/drivers/tty/serial/wk2xxx.c
[ ... ]
> +static int wk2xxx_raw_read(struct wk2xxx_port *s, u8 addr, u8 *val)
> +{
> +	u8 tx[2] =3D { WK2XXX_SPI_READ | addr, 0 };
> +	u8 rx[2] =3D { 0, 0 };
> +	int ret;
> +
> +	ret =3D wk2xxx_spi_transfer(s, tx, rx, sizeof(tx));

[Severity: High]
Is it safe to pass stack-allocated buffers to spi_sync() here and in the
fifo access functions?

Stack memory is typically not DMA-safe and can lack cacheline alignment,
potentially causing memory corruption or panics on cache-incoherent
architectures.

[ ... ]
> +static void wk2xxx_throttle(struct uart_port *port)
> +{
> +	unsigned long flags;
> +
> +	/* Stop draining the RX FIFO to apply back-pressure. */
> +	uart_port_lock_irqsave(port, &flags);
> +	wk2xxx_ier_clear(port, WK2XXX_SIER_RFTRIG_IEN_BIT);
> +	uart_port_unlock_irqrestore(port, flags);
> +}

[Severity: Medium]
Does this sequence fully apply back-pressure?

The RX timeout interrupt (WK2XXX_SIER_RXOUT_IEN_BIT) remains enabled. If any
bytes remain in the hardware FIFO, the timeout interrupt will eventually fi=
re
and push more characters, defeating the flow control request.

[ ... ]
> +static void wk2xxx_handle_tx(struct uart_port *port)
> +{
[ ... ]
> +	to_send =3D kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
> +	sent =3D to_send;
> +	while (to_send) {
> +		unsigned int chunk =3D min_t(unsigned int, to_send,
> +					   WK2XXX_MAX_SPI_LEN);
> +
> +		wk2xxx_fifo_write(s, portno, tail, chunk);
> +		tail +=3D chunk;
> +		to_send -=3D chunk;
> +	}
> +	uart_xmit_advance(port, sent);

[Severity: High]
Does this lockless access to tport->xmit_fifo expose the buffer to races?

Because wk2xxx_fifo_write() can sleep, a concurrent flush operation could
acquire port->lock and reset the kfifo. If that happens, the subsequent
lockless uart_xmit_advance() could increment the fifo out index beyond the
in index, leading to underflows and heap corruption.

[ ... ]
> +static void wk2xxx_handle_rx(struct uart_port *port)
> +{
[ ... ]
> +	u8 fsr, rfcnt, lsr =3D 0, flag =3D TTY_NORMAL;
> +
> +	wk2xxx_port_reg_read(s, portno, WK2XXX_FSR_REG, &fsr);
[ ... ]
> +	wk2xxx_port_reg_read(s, portno, WK2XXX_RFCNT_REG, &rfcnt);

[Severity: High]
If the SPI transaction fails here, the return value is ignored.

Could this leave rfcnt uninitialized, using its stale value to dictate how
much memory is read? Since wk2xxx_fifo_read() can also fail silently, this
might push unmodified, stale heap data directly to user-space.

> +	/* Map the FIFO status register error flags to line status. */
> +	if (fsr & WK2XXX_FSR_ERR_MASK) {
[ ... ]
> +	}
> +
> +	port->icount.rx +=3D rxlen;
> +
> +	for (i =3D 0; i < rxlen; ++i) {
> +		u8 ch =3D one->buf[i];
[ ... ]
> +		uart_insert_char(port, lsr, WK2XXX_LSR_OE_BIT, ch, flag);
> +	}

[Severity: Medium]
Does reading fsr once and applying the exact same lsr error flags to every
character in the loop incorrectly flag valid characters as corrupted?

A single corrupted byte in the hardware FIFO could cause the entire batch
to be marked with framing, parity, or overrun errors.

[ ... ]
> +static bool wk2xxx_port_irq(struct wk2xxx_port *s, unsigned int portno)
> +{
> +	struct uart_port *port =3D &s->p[portno].port;
> +	u8 sifr, sier;
> +	bool rc =3D false;
> +
> +	wk2xxx_port_reg_read(s, portno, WK2XXX_SIFR_REG, &sifr);
> +	wk2xxx_port_reg_read(s, portno, WK2XXX_SIER_REG, &sier);

[Severity: High]
If the SPI transaction fails here, the return value is ignored.

Could this leave sifr and sier uninitialized, causing undefined behavior
and spurious interrupt handling based on stack garbage?

[ ... ]
> +static irqreturn_t wk2xxx_irq(int irq, void *dev_id)
> +{
[ ... ]
> +		for (i =3D 0; i < s->devtype->nr_uart; ++i)
> +			if (gifr & BIT(i))
> +				keep_polling |=3D wk2xxx_port_irq(s, i);
> +	} while (keep_polling);
> +
> +	return IRQ_HANDLED;
> +}

[Severity: Medium]
If keep_polling evaluates to false on the first iteration, this function
unconditionally returns IRQ_HANDLED even though no device interrupt was
pending.

Will this mask unhandled interrupts and break semantics for other
devices sharing the IRQ line?

[ ... ]
> +static void wk2xxx_poll_proc(struct kthread_work *ws)
> +{
> +	struct wk2xxx_port *s =3D container_of(ws, struct wk2xxx_port,
> +					     poll_work.work);
> +
> +	/* Reuse the IRQ handler; the interrupt ID is unused here. */
> +	wk2xxx_irq(0, s);
> +
> +	kthread_queue_delayed_work(&s->kworker, &s->poll_work,
> +				   msecs_to_jiffies(WK2XXX_POLL_PERIOD_MS));
> +}

[Severity: High]
Can this lead to a permanent deadlock when the TX FIFO drains?

The wk2xxx_poll_proc runs on s->kworker and processes the loop until the
device is idle. When TX empties, wk2xxx_handle_tx attempts to disable the
interrupt by queuing reg_work via wk2xxx_ier_clear to the very same
s->kworker. Since the worker is already blocked waiting for the interrupt
to clear in the keep_polling loop, reg_work never runs, creating an
infinite loop.

[ ... ]
> +static int wk2xxx_config_rs485(struct uart_port *port, struct ktermios *=
termios,
> +			       struct serial_rs485 *rs485)
> +{
[ ... ]
> +		if (rs485->delay_rts_after_send)
> +			return -EINVAL;

[ ... ]
> +static const struct serial_rs485 wk2xxx_rs485_supported =3D {
> +	.flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
> +		 SER_RS485_RTS_AFTER_SEND,
> +	.delay_rts_before_send =3D 1,
> +	.delay_rts_after_send =3D 1,	/* Not supported but keep returning -EINVA=
L */
> +};

[Severity: Medium]
Is it intentional to advertise up to 1ms of delay_rts_after_send support to
the serial core, but then explicitly return -EINVAL in wk2xxx_config_rs485
when that delay is requested?

This mismatch causes valid user-space ioctls to fail unexpectedly.

[ ... ]
> +static unsigned int wk2xxx_tx_empty(struct uart_port *port)
> +{
> +	struct wk2xxx_port *s =3D dev_get_drvdata(port->dev);
> +	u8 fsr;
> +
> +	wk2xxx_port_reg_read(s, port->iobase, WK2XXX_FSR_REG, &fsr);
> +
> +	return (fsr & (WK2XXX_FSR_TDAT_BIT | WK2XXX_FSR_TBUSY_BIT)) ? 0 :
> +		TIOCSER_TEMT;
> +}

[Severity: High]
Like the previous read functions, SPI failures here are ignored.

Will this leave fsr uninitialized and evaluate arbitrary stack garbage in
the ternary logic?

[ ... ]
> +static void wk2xxx_calc_divisor(unsigned long clk, unsigned int baud,
> +				u8 *baud0, u8 *baud1, u8 *pres)
> +{
[ ... ]
> +	*pres =3D ((unsigned long long)(clk % (baud * 16)) * 100 / baud + 50) /=
 100;
> +}

[Severity: High]
Can this division cause link failures on 32-bit architectures?

The code casts clk to a 64-bit unsigned long long and then divides by the
32-bit baud using the native / operator, which breaks 32-bit builds lacking
libgcc.

[ ... ]
> +static void wk2xxx_set_termios(struct uart_port *port, struct ktermios *=
termios,
> +			       const struct ktermios *old)
> +{
[ ... ]
> +	/* Set status ignore mask. */
> +	port->ignore_status_mask =3D 0;
> +	if (termios->c_iflag & IGNBRK)
> +		port->ignore_status_mask |=3D WK2XXX_LSR_BI_BIT;
> +	if (!(termios->c_cflag & CREAD))
> +		port->ignore_status_mask |=3D WK2XXX_LSR_BRK_ERROR_MASK;

[Severity: Medium]
Does this correctly filter out characters when the receiver is disabled via
CREAD?

By setting only error bits in the ignore mask, standard characters with a
successful line status (lsr =3D=3D 0) will bypass the filter in
wk2xxx_handle_rx and continue being pushed to the TTY layer.

[ ... ]
> +static void wk2xxx_shutdown(struct uart_port *port)
> +{
[ ... ]
> +	if (s->polling)
> +		kthread_cancel_delayed_work_sync(&s->poll_work);

[Severity: High]
Since s->poll_work is shared across all UART ports on the SPI chip, won't
shutting down a single port permanently cancel the shared polling loop?

This appears to starve all other concurrent open ports on the same device
of TX and RX events.

[ ... ]
> +static int wk2xxx_probe(struct spi_device *spi)
> +{
[ ... ]
> +		/* Register port. */
> +		ret =3D uart_add_one_port(&wk2xxx_uart, &s->p[i].port);
> +		if (ret)
> +			goto out_ports;
> +
> +		port_registered[i] =3D true;
> +	}
> +
> +	if (spi->irq <=3D 0) {
[ ... ]
> +	ret =3D devm_request_threaded_irq(dev, spi->irq, NULL, wk2xxx_irq,

[Severity: High]
Does exposing the port to user-space before its interrupt handler is
requested create a race condition?

If the port is opened immediately after uart_add_one_port, wk2xxx_startup
will unmask IC hardware interrupts before the handler is actually registere=
d,
potentially causing unhandled IRQ storms that disable the shared line.

[ ... ]
> +out_ports:
> +	for (i =3D 0; i < devtype->nr_uart; i++) {
> +		if (s->p[i].port.line < WK2XXX_MAX_DEVS)
> +			ida_free(&wk2xxx_lines, s->p[i].port.line);
> +		if (port_registered[i])
> +			uart_remove_one_port(&wk2xxx_uart, &s->p[i].port);
> +	}

[Severity: High]
Does freeing the IDA line before unregistering the port expose a race
condition?

Releasing the ID early could allow a concurrent probe to claim the same
line ID before uart_remove_one_port is fully processed, leading to
subsystem corruption.

[ ... ]
> +static void wk2xxx_remove(struct spi_device *spi)
> +{
> +	struct wk2xxx_port *s =3D dev_get_drvdata(&spi->dev);
> +	int i;
> +
> +	for (i =3D 0; i < s->devtype->nr_uart; i++) {
> +		ida_free(&wk2xxx_lines, s->p[i].port.line);
> +		uart_remove_one_port(&wk2xxx_uart, &s->p[i].port);
> +	}

[Severity: High]
Along with the IDA freeing issue mentioned above, is there a use-after-free
risk here if a hardware interrupt fires?

The IRQ was requested via the managed devm_request_threaded_irq API, so it
stays active until after this function returns and devres cleanup runs.
However, uart_remove_one_port frees the port state manually, meaning a late
interrupt could deference freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904072027.6747=
3-1-zjzhao@edatec.cn?part=3D1
