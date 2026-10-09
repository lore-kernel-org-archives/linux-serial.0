Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA21C318B9B;
	Fri,  9 Oct 2026 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535171; cv=none; b=HbuMBGdS8wcr6/p/q6xMzEChIyme1JgCjgW5LKRCXzaAsdc3l0NK70zAyOjA1JFtky9VM2ePbF4tGSHpw4KQhx0bOEQctgNPKE0yavHd0qPBqofQPa2PcYt0lR2Uf2fDRfES6GbgABXmSmSPwYEPNyagh/x7EUkoA+PyOx2be24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535171; c=relaxed/simple;
	bh=Ek0Ev7kge84bu1PET5jYEBIebPmFy/wtj0z1m5U9z44=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=vEIDS72qIKShbCGmhSVSabnr8CJKnUphmikDa1RilXBMwhTVz4BKKvLMEt2CcP5UyVjKy+uqL2NSjlReyerpSwLbcneMGG/F3RvkHduwU6KL2ssaGLK2KudymfUy3XLNFb98DkLgcL6yugm7YyloJurHL/+1/Gt26WrwJhPklig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ykw/RM0L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ykw/RM0L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F201F000FF;
	Fri,  9 Oct 2026 08:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791535169;
	bh=iCOfB4v4TOWPCDQGVyTwpBbkk/pMrmULcUAOdNMUHtk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ykw/RM0L6EqxjBQ7pIaUXDSU8lyxMFqyVk3UIRPw4LBIRgODxNlVZWPCsrtj1lZvu
	 rqf7xUmp8yD4PfgdcmL33iDF27j3wOxkRzB+J/ncxQJMEspy/1a9jUd3pPt0XyXeaD
	 1g/kO5xYV8xJtjg52Uy5R9O+qKa//oQZ5fcO5IFXoz9gsmQHcGIUWEijXnzqg/SktC
	 96O+n0G+cPVlfJOzaY4Naqis+GHPesauyf/RO2h15OPIcRL9jQy8IYMYEmQdK5pcFN
	 jYHK+OACUNYdRiwEDPLiiVVlLOsWupZmibhgmic//KU4V+L7szjz05Vgs6MNHTbcFT
	 G45P7lsFJDnIw==
Message-ID: <sashiko-outbox-165099@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] serial: wk2xxx: Add WK2xxx SPI UART driver
Reply-To: sashiko-reviews@lists.linux.dev
To: zjzhao@edatec.cn
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20261009082530.248219-2-zjzhao@edatec.cn>
References: <cover.20261009.wk2xxx.v5@edatec.cn>
 <20261009082530.248219-2-zjzhao@edatec.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 08:39:28 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 13 potential issue=
(s) to consider:
- [High] tty: Bus error hides handled interrupts, risking IRQ storm disable=
ment
- [High] tty: UART ports exposed to userspace before IRQ handler registrati=
on
- [High] tty: wk2xxx_shutdown lacks synchronization with concurrent IRQ han=
dler
- [High] tty: Shared register lock held while sleeping blocks entire chip
- [High] tty: FIFO burst read applies single error status to all characters
- [High] tty: Shared threaded IRQ requested without primary handler fails
- [High] tty: SPI register read before device clock is enabled
- [Medium] tty: Initial RS485 config silently discarded before port opens
- [Medium] tty: Hardware flow control cannot be disabled once enabled
- [Medium] tty: Missing uart_read_port_properties() call in probe
- [Medium] tty: Data race in one->config.flags update without port->lock
- [Medium] tty: Truncation of intermediate fractional baud rate calculation
- [Medium] tty/serial: data race in wk2xxx_handle_rx() during port->icount =
updates
--

commit bdebcf784ac6f738394efad39bd16c7783d79d1f
Author: Zi Jie Zhao <zjzhao@edatec.cn>

serial: wk2xxx: Add WK2xxx SPI UART driver

This commit adds a driver for WK2xxx SPI-to-UART bridge ICs, supporting
up to four full-duplex UART channels over a single SPI interface. The
driver registers the ports, handles interrupts via a kthread worker, and
supports device tree properties.

> diff --git a/drivers/tty/serial/wk2xxx.c b/drivers/tty/serial/wk2xxx.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/tty/serial/wk2xxx.c
[ ... ]
> +static void wk2xxx_ier_set(struct uart_port *port, u8 bit)
> +{
> +	struct wk2xxx_one *one =3D to_wk2xxx_one(port, port);
> +	struct wk2xxx_port *s =3D dev_get_drvdata(port->dev);
> +
> +	lockdep_assert_held_once(&port->lock);
> +
> +	one->config.flags |=3D WK2XXX_RECONF_IER;
[ ... ]
> +static int wk2xxx_config_rs485(struct uart_port *port, struct ktermios *=
termios,
> +			       struct serial_rs485 *rs485)
> +{
> +	struct wk2xxx_one *one =3D to_wk2xxx_one(port, port);
> +	struct wk2xxx_port *s =3D dev_get_drvdata(port->dev);
[ ... ]
> +	/*
> +	 * RTS is driven by hardware and its timing cannot be influenced
> +	 * from the driver. Non-zero RTS delays are rejected (sanitized to
> +	 * zero) by the serial core.
> +	 */
> +	one->config.flags |=3D WK2XXX_RECONF_RS485;

[Severity: Medium]
Is there a data race on the config.flags field here?

The serial core can invoke the rs485_config callback without holding
port->lock. In wk2xxx_config_rs485(), the driver modifies one->config.flags
locklessly. Concurrently, functions like wk2xxx_ier_set() modify the exact
same field while holding port->lock.

If these run concurrently, could we silently drop either the RS485
configuration flag or the interrupt mask update?

[ ... ]
> +static void wk2xxx_reg_proc(struct kthread_work *ws)
> +{
> +	struct wk2xxx_one *one =3D to_wk2xxx_one(ws, reg_work);
> +	struct wk2xxx_port *s =3D dev_get_drvdata(one->port.dev);
> +	struct wk2xxx_one_config config;
> +	unsigned long irqflags;
> +
> +	uart_port_lock_irqsave(&one->port, &irqflags);
> +	config =3D one->config;
> +	memset(&one->config, 0, sizeof(one->config));
> +	uart_port_unlock_irqrestore(&one->port, irqflags);
> +	if (!READ_ONCE(one->active))
> +		return;

[Severity: Medium]
Will the initial RS485 configuration from the device tree be discarded here?

During probe, uart_add_one_port() invokes wk2xxx_config_rs485() to apply
device tree settings, which queues reg_work. If the worker thread runs
wk2xxx_reg_proc() before the port is opened (meaning wk2xxx_startup() hasn't
been called and active is false), the early return skips the SPI writes and
clears the pending config flags, permanently losing the RS-485 mode
configuration.

[ ... ]
> +static void wk2xxx_handle_rx(struct uart_port *port)
> +{
[ ... ]
> +	if (fsr & WK2XXX_FSR_ERR_MASK) {
> +		if (fsr & WK2XXX_FSR_RFPE_BIT) {
> +			port->icount.parity++;
> +			lsr |=3D WK2XXX_LSR_PE_BIT;
> +			flag =3D TTY_PARITY;
> +		}
> +		if (fsr & WK2XXX_FSR_RFFE_BIT) {
> +			port->icount.frame++;
> +			lsr |=3D WK2XXX_LSR_FE_BIT;
> +			flag =3D TTY_FRAME;
> +		}

[Severity: Medium]
Are these lockless updates to the port->icount fields safe?

When wk2xxx_handle_rx() processes received data, it increments icount fields
and calls uart_insert_char() without acquiring port->lock. Concurrently, a
userspace application invoking the TIOCGICOUNT ioctl calls uart_get_icount(=
),
which acquires port->lock and copies the entire structure. Without locking =
on
the writer side, could concurrent reads cause torn or inconsistent statisti=
cs?

[ ... ]
> +	for (i =3D 0; i < rxlen; ++i) {
> +		u8 ch =3D one->rx_buf[i];
> +		u8 overrun =3D overrun_pending ? WK2XXX_LSR_OE_BIT : 0;
> +
> +		if (uart_handle_sysrq_char(port, ch))
> +			continue;
> +
> +		uart_insert_char(port, lsr, overrun, ch, flag);
> +		overrun_pending =3D false;
> +	}

[Severity: High]
Does this apply a single FSR error status to every character in the FIFO
burst?

The driver reads the FIFO status register once, then performs a burst read
of up to 256 bytes. If any error bit is set in that single snapshot, the
corresponding flag is applied to every character in the burst when calling
uart_insert_char(). Could a single flawed character cause the entire block
of valid characters to be flagged as erroneous?

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
> +			return IRQ_NONE; /* Bus error; treat the interrupt as spurious. */

[Severity: High]
If an interrupt is successfully handled in a previous loop iteration, does
returning IRQ_NONE here discard that handled state?

If handled gets lost because of a subsequent SPI bus error, the core IRQ
subsystem will log the interrupt as unhandled. Repeated occurrences could
cause the kernel to permanently disable the shared interrupt line.

[ ... ]
> +static void wk2xxx_conf_port(struct uart_port *port, u8 lcr, u8 fwcr,
> +			     u8 baud0, u8 baud1, u8 pres)
> +{
[ ... ]
> +	guard(mutex)(&s->reg_lock);
> +
> +	wk2xxx_raw_port_read(s, portno, WK2XXX_SIER_REG, &sier);
> +	wk2xxx_raw_port_write(s, portno, WK2XXX_SIER_REG, 0);
> +
> +	timeout_us =3D max_t(unsigned long, jiffies_to_usecs(uart_fifo_timeout(=
port)),
> +			   WK2XXX_TX_TIMEOUT_US);
> +	ret =3D read_poll_timeout(wk2xxx_raw_port_read, read_ret,
> +				(read_ret || !(fsr & WK2XXX_FSR_TBUSY_BIT)),
> +				WK2XXX_TX_POLL_US, timeout_us, false, s, portno,
> +				WK2XXX_FSR_REG, &fsr);

[Severity: High]
Will holding s->reg_lock while sleeping block the entire chip?

The reg_lock serializes all SPI communication, and read_poll_timeout() can
sleep for potentially hundreds of milliseconds waiting for the TX FIFO to
drain. Since the lock is held across this sleep, wouldn't it prevent all
other sub-UARTs from being serviced, causing massive latency spikes and RX
FIFO overruns on other active ports?

[ ... ]
> +	wk2xxx_raw_port_write(s, portno, WK2XXX_LCR_REG, lcr);
> +
> +	if (fwcr) {
> +		wk2xxx_raw_port_write(s, portno, WK2XXX_FWCR_REG, fwcr);
> +		wk2xxx_raw_port_write(s, portno, WK2XXX_SPAGE_REG, 1);
> +		/* FWTH and FWTL are the flow-control stop and resume thresholds. */
> +		wk2xxx_raw_port_write(s, portno, WK2XXX_FWTH_REG, 0xf0);
> +		wk2xxx_raw_port_write(s, portno, WK2XXX_FWTL_REG, 0x80);
> +		wk2xxx_raw_port_write(s, portno, WK2XXX_SPAGE_REG, 0);
> +	}

[Severity: Medium]
If hardware flow control is later disabled by userspace, fwcr will be 0.
Since there is no else branch to write 0 to WK2XXX_FWCR_REG, how does the
driver clear a previously enabled hardware flow control state?

[ ... ]
> +static void wk2xxx_calc_divisor(unsigned long clk, unsigned int baud,
> +				u8 *baud0, u8 *baud1, u8 *pres)
> +{
[ ... ]
> +	rem =3D clk % (baud * 16);
> +	*pres =3D (u32)div_u64((u64)rem * 100, baud);
> +	*pres =3D (*pres + 50) / 100;
> +}

[Severity: Medium]
Is the intermediate calculation truncated here?

The div_u64() call produces a value that can be larger than 255, but
assigning it directly to the u8 pointer *pres truncates it to 8 bits. The
subsequent division by 100 operates on this truncated value, which seems li=
ke
it could produce a wildly incorrect fractional divisor at high baud rates.

[ ... ]
> +static void wk2xxx_shutdown(struct uart_port *port)
> +{
> +	struct wk2xxx_one *one =3D to_wk2xxx_one(port, port);
> +	struct wk2xxx_port *s =3D dev_get_drvdata(port->dev);
> +	unsigned int portno =3D port->iobase;
> +	u8 reg;
> +
> +	WRITE_ONCE(one->active, false);
> +	kthread_cancel_work_sync(&one->tx_work);
> +	kthread_cancel_work_sync(&one->reg_work);
> +	kthread_cancel_delayed_work_sync(&one->tx_empty_work);

[Severity: High]
Does wk2xxx_shutdown() need synchronization with the threaded IRQ handler?

It sets active =3D false and cancels workers, but without synchronize_irq()=
 or
disable_irq(), the handler can run concurrently. If the handler evaluates t=
he
active check before this clears it, could it re-queue workers or update
buffers after the logical shutdown is complete?

[ ... ]
> +static int wk2xxx_request_irq(struct wk2xxx_port *s)
> +{
> +	struct device *dev =3D &s->spi->dev;
> +	int ret;
> +
> +	ret =3D request_threaded_irq(s->spi->irq, NULL, wk2xxx_irq,
> +				   IRQF_TRIGGER_LOW | IRQF_SHARED | IRQF_ONESHOT,
> +				   dev_name(dev), s);

[Severity: High]
Will this request_threaded_irq() call always fail with -EINVAL?

The core IRQ subsystem forbids requesting an IRQF_SHARED threaded IRQ with a
NULL primary handler, because it needs to verify if the shared interrupt
belongs to the device before waking the thread. This failure would force the
driver into the fallback edge-triggered path, potentially causing missed
interrupts.

[ ... ]
> +static int wk2xxx_probe(struct spi_device *spi)
> +{
[ ... ]
> +	/*
> +	 * The WK2xxx has no identification register, so the best we can do
> +	 * is to check that communication is at all possible.
> +	 */
> +	ret =3D wk2xxx_reg_read(s, WK2XXX_GENA_REG, &val);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read GENA register\n");
> +
> +	s->clk =3D devm_clk_get_enabled(dev, NULL);

[Severity: High]
Is it safe to perform the SPI register read before enabling the device cloc=
k?

Internal logic and SPI interfaces often require the core clock to be active.
Without it, this initial read might time out or return garbage, causing pro=
be
to fail erroneously.

[ ... ]
> +		/*
> +		 * Temporarily retarget dev's fwnode to the per-port subnode
> +		 * so uart_get_rs485_mode() picks up the per-port properties.
> +		 */
> +		ret =3D 0;
> +		if (port_np && devtype->has_rs485) {
> +			device_set_node(dev, of_fwnode_handle(port_np));
> +			ret =3D uart_get_rs485_mode(&s->p[i].port);
> +			device_set_node(dev, saved_fwnode);
> +		}
> +		of_node_put(port_np);
> +		if (ret)
> +			goto out_ports;
> +
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
> +		ret =3D wk2xxx_request_irq(s);

[Severity: Medium]
The commit message mentions applying "serial and RS-485 properties from each
serial@N DT subnode". While uart_get_rs485_mode() handles the RS-485
properties, it looks like a call to uart_read_port_properties() is missing
here. Does this mean standard properties like clock-frequency, fifo-size,
and the serial alias will be ignored?

[Severity: High]
Could exposing ports to userspace via uart_add_one_port() before registering
the IRQ handler in wk2xxx_request_irq() be risky?

If a process opens the port immediately, wk2xxx_startup() will enable
hardware interrupts on the device. Since the OS handler is not yet
registered, an asserted interrupt would be unhandled, potentially resulting
in an interrupt storm that disables the shared IRQ line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009082530.2482=
19-1-zjzhao@edatec.cn?part=3D2
