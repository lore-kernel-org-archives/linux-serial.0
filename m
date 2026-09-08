Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F968519929;
	Tue,  8 Sep 2026 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788864259; cv=none; b=I0jDoyBctdy5JKd5VUuihO1tV7ppUHstBVEZNFG6+H6CZaPpcCYP0kMJKXZ4R+oXPQsd2FB73ccotSNXZUF/2O03TlSjczYrN17q61vMdaC7kj5CtnNrgSGlDUlpnYtdylYBhExtX3DRU/DcxBBcXTl7n3DioRejVvWfOfpZhwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788864259; c=relaxed/simple;
	bh=gbAlidygxk94zk3/WSntggQJAuRKtZnPLiSVxKcHsws=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GAU1Muwn5alJ8pvZfUWoS9fbuMgOlP7xg6898OLdRtExl0t7+NBjwm7zm+Pq2SH46+YHUzgHzSSuX6XvgjYdEgis/U9dcUF61C5ocw980O49FcH/eOCnw4tp4GfwctX6mD9WYDUNRhIUhgxJsEpqxsVjURXiok6UMvMjJX1M9yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bu5c3lRv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu5c3lRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF0D1F00A3A;
	Tue,  8 Sep 2026 10:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788864257;
	bh=DqKdPD3RRD1JhstaJB5YFIaX8JFP4SPiPL+dCdHEuMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bu5c3lRvGT9JhkuHfO4NDsDq6ApaiY5vcZi40CwNR5bUdvtGWjPT03GlqY/cnvcjs
	 Pq1j6M+U9PWh/mjR2kVZDeEC4YqS6MKsBnLGk4yxeu8HSCKODBz2M/MmjhD0aJbokM
	 9ndp0KyxV5hYjHZAgArv+ny9dQS3YPbPn/p/DEtrERQvOJ0zMjlOCBoHNLlS0No8QZ
	 gjXA+fv0QMpZdz1Nd3IqYfuvTh19wTLoqpkWgTIvuPuQJARjhgwgKdhEKyGxBgjPRE
	 JPOGwYjCQ9XmNmqFgvB1BTdBARroVSyfgO64wZtjXi8gywR4C4K4hYQTZ0PCoXXWEJ
	 eOPwA4bi+38rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] serial: wk2xxx: Add WK2xxx SPI UART driver
Reply-To: sashiko-reviews@lists.linux.dev
To: zjzhao@edatec.cn
Cc: robh@kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260908103129.58085-3-zjzhao@edatec.cn>
References: <20260908103129.58085-1-zjzhao@edatec.cn>
 <20260908103129.58085-3-zjzhao@edatec.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 10:44:13 +0000
Message-Id: <20260908104417.7EF0D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] UART transmit FIFO data corruption and stats race due to missing p=
ort lock in wk2xxx_handle_tx().
- [High] TTY buffer flood due to persistent overrun flag in batch RX loop.
- [High] The tx_empty callback performs a synchronous SPI read which sleeps=
 while the serial core holds the port spinlock.
- [High] Early return on SPI error in wk2xxx_shutdown skips essential softw=
are state cleanup, causing open_ports to permanently leak.
- [Medium] OF node reference leak when parsing DT nodes for non-RS485 varia=
nts.
- [Medium] Commit message claims to apply serial properties from DT subnode=
s, but they are not applied.
- [Low] The driver intentionally breaks the build on architectures with L1_=
CACHE_BYTES < 31 (e.g., m68k).
--

commit 8ec8660308853d2cff61b90024208e8b3e1bafdb
Author: Zi Jie Zhao <zjzhao@edatec.cn>
Subject: serial: wk2xxx: Add WK2xxx SPI UART driver

This commit introduces a new driver for the WK2xxx SPI to UART bridge ICs.
It models the driver after the NXP sc16is7xx driver, utilizing a kthread
worker for SPI register accesses and supporting polled or interrupt-driven
operation.

> diff --git a/drivers/tty/serial/wk2xxx.c b/drivers/tty/serial/wk2xxx.c
> index 0000000000000..15869fbdeab07
> --- /dev/null
> +++ b/drivers/tty/serial/wk2xxx.c
[ ... ]
> +	/*
> +	 * Shared SPI transfer buffers. All SPI accesses are serialized by
> +	 * s->reg_lock, so these are never used concurrently. Each buffer is
> +	 * cache-line aligned and sized to a full cache line, so DMA cache
> +	 * maintenance on one of them can never invalidate a line shared
> +	 * with any other field (notably the p[] array below).
> +	 */
> +	u8				spi_tx[L1_CACHE_BYTES] ____cacheline_aligned;
> +	u8				spi_rx[L1_CACHE_BYTES] ____cacheline_aligned;
> +	struct wk2xxx_one		p[];
> +};
> +
> +static_assert(WK2XXX_MAX_SPI_LEN + 1 <=3D L1_CACHE_BYTES);

[Severity: Low]
Does this intentionally break the build for architectures with a cache line=
=20
size smaller than 31 bytes (such as m68k where L1_CACHE_BYTES is 16)?=20

Might it be better to size the array to something like=20
max(L1_CACHE_BYTES, 32) instead of failing the compilation?

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

[Severity: High]
Is it safe to manipulate the xmit_fifo pointers and call uart_xmit_advance(=
)=20
here without holding the port lock?

If a concurrent operation like a tcflush() ioctl resets the FIFO via=20
uart_flush_buffer() (which zeroes the in and out indices), could this=20
lockless uart_xmit_advance() call advance the out index beyond the in index=
,=20
causing a substantial underflow and subsequent data corruption?

[ ... ]
> +static void wk2xxx_handle_rx(struct uart_port *port)
> +{
[ ... ]
> +	/* Map the FIFO status register error flags to line status. */
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

[Severity: High]
Could this loop insert an excessive number of dummy overrun characters into=
=20
the TTY buffer?

Since lsr is modified once outside the loop when the WK2XXX_FSR_RFOE_BIT is=
=20
set, the WK2XXX_LSR_OE_BIT remains active for the entire iteration. When=20
uart_insert_char() evaluates this bit, it will insert a dummy overrun byte=
=20
for every single character in this chunk (up to 256 times) for a single=20
overrun event.

[ ... ]
> +static unsigned int wk2xxx_tx_empty(struct uart_port *port)
> +{
> +	struct wk2xxx_port *s =3D dev_get_drvdata(port->dev);
> +	u8 fsr =3D 0;
> +
> +	if (wk2xxx_port_reg_read(s, port->iobase, WK2XXX_FSR_REG, &fsr))
> +		return TIOCSER_TEMT;

[Severity: High]
Can this sequence sleep while executing in an atomic context?

The serial core routinely invokes the ops->tx_empty() callback while holdin=
g=20
the port spinlock with interrupts disabled (for instance, during the=20
TIOCSERGETLSR ioctl). However, wk2xxx_port_reg_read() performs a synchronou=
s=20
spi_sync() transfer which can sleep.

[ ... ]
> +static void wk2xxx_shutdown(struct uart_port *port)
> +{
> +	struct wk2xxx_port *s =3D dev_get_drvdata(port->dev);
> +	unsigned int portno =3D port->iobase;
> +	u8 reg;
> +
> +	scoped_guard(mutex, &s->reg_lock) {
> +		/* Disable the sub-UART interrupt in the global mask. */
> +		if (wk2xxx_raw_read(s, WK2XXX_GIER_REG, &reg))
> +			return;

[Severity: High]
If this SPI read fails, the function returns early. Does this leave the=20
software state permanently out of sync?

By returning here, the function skips the atomic_dec_return(&s->open_ports)=
=20
and kthread_flush_worker() cleanup steps at the end of wk2xxx_shutdown().=20
This leaves the open_ports counter permanently elevated and strands the=20
polling kthread so it can never be stopped.

[ ... ]
> +static int wk2xxx_probe(struct spi_device *spi)
> +{
[ ... ]
> +		/* Locate the matching "serial@i" DT subnode, if any. */
> +		for_each_available_child_of_node(dev->of_node, child) {
> +			u32 reg;
> +
> +			if (!of_node_name_eq(child, "serial"))
> +				continue;
> +			if (of_property_read_u32(child, "reg", &reg))
> +				continue;
> +			if (reg =3D=3D i) {
> +				port_np =3D child;
> +				break;
> +			}
> +		}
[ ... ]
> +		/*
> +		 * Temporarily retarget dev's fwnode to the per-port subnode
> +		 * so uart_get_rs485_mode() picks up the per-port properties.
> +		 */
> +		if (port_np && devtype->has_rs485) {
> +			device_set_node(dev, of_fwnode_handle(port_np));
> +			ret =3D uart_get_rs485_mode(&s->p[i].port);
> +			device_set_node(dev, saved_fwnode);
> +			of_node_put(port_np);
> +			if (ret)
> +				goto out_ports;
> +		}

[Severity: Medium]
Is there a device tree node reference leak here for non-RS485 variants?

The port_np reference is acquired via the for_each_available_child_of_node(=
)=20
loop earlier. However, if devtype->has_rs485 evaluates to false (such as fo=
r=20
the WK2132 or WK2202 variants), this block is entirely bypassed and=20
of_node_put(port_np) is never called.

[Severity: Medium]
The commit message states the driver will "apply serial and RS-485 properti=
es=20
from each serial@N DT subnode to the corresponding channel."

While uart_get_rs485_mode() is called in this block, should there also be a=
=20
call to uart_read_port_properties() to ensure the generic serial properties=
=20
(like tx-trigger or rx-trigger) are actually applied as described?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908103129.5808=
5-1-zjzhao@edatec.cn?part=3D2
