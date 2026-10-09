Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17C23BB9F8;
	Fri,  9 Oct 2026 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791529766; cv=none; b=bfqQ8FWtysS0xyI2OhG6Eb+LQmrwscbmFreFma43IEnMySMu7NwOjLLmyhi0rPqmvXvkVRJgOClc3+ZTwsmu+V0u36X6rK9F2e9r5Iwz5wSmrSjkgUSwNCvQDZZX8N5lYBO7GMF+RRxs2rRep/46T1yuWM2Eo8yMmiuTP0mBgmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791529766; c=relaxed/simple;
	bh=IMJwlmyH735lcMT6PevrMZITlNxWEAUPJrPdTS7J18o=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WTiNyw4N/YxzvALKSJiXWvcTkHrkHLsixR+73h9KMJrBsMEfsmLO0KpKHRiwtRQV/0+I54ZzIKwlum2nfPIsyZho6wAcHTHbIJNWiDpN7p6E06aRiUkngVABsBxS5O8UTXQxX1fICcmmbKYRZYRUHt0Z+QGYlHXm51AOLPYz9Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wan7+YmK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wan7+YmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448401F000FF;
	Fri,  9 Oct 2026 07:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791529764;
	bh=mVzE88Y2bQTQUEIo3dTKd68gkpNh1ZHTrP7KFLkmW50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wan7+YmKWO9QSDX9KFxqzV+W5zBuzEDEy3iCtpHkOUI83c+6FWSFStY9cHPHsrcW/
	 jeZeO6+JSTqjaeXPXimQVOmn+aHln0AoDFPtuXR4HXFF4u3sSznxIddMLUIhOXLIQO
	 EQbmclQ1TJWe4M5b7XuunhrIILZqVjimGWeBO+l2ZiKRmAcXkZoiO8gynr+ZVbDd7d
	 1onPcsupQvBcIWfwYvQsRHVXYOrM2IuG855/cBE3Lz7lyEl/iIkqbvSNOircBkMHc0
	 TYP7EnPOdrM/a0rs1kkLUzyf/agSunGxfrq+/Fyzd+SBBn8UAWrw2LQJKXhVsWdqZK
	 SpMJXlg1VmIWA==
Message-ID: <sashiko-outbox-164979@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] tty: serial: qcom_geni_serial: Add GPI DMA support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naresh Maramaina" <naresh.maramaina@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20261009-add-gpi-dma-support-for-uart-v1-4-c69e728df686@oss.qualcomm.com>
References: <20261009-add-gpi-dma-support-for-uart-v1-0-c69e728df686@oss.qualcomm.com>
 <20261009-add-gpi-dma-support-for-uart-v1-4-c69e728df686@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 07:09:23 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [Critical] tty: serial: qcom_geni_serial: RX DMA is never safely stopped =
or cancelled, leading to UAF
- [High] tty: serial: qcom_geni_serial: Broken GPI TX DMA cancellation and =
TOCTOU races
- [High] tty: serial: qcom_geni_serial: Lockless TX kfifo access and missin=
g flush validation cause data corruption
- [High] tty: serial: qcom_geni_serial: Workqueues destroyed before port un=
registration cause UAF
- [High] tty: serial: qcom_geni_serial: Invalid DMA buffer ownership transf=
er corrupts TX data
- [High] tty: serial: qcom_geni_serial: TX path permanently stalls after a =
single transfer
- [Medium] tty: serial: qcom_geni_serial: Multiple resource and DMA mapping=
 leaks on initialization error paths
- [Medium] tty: serial: qcom_geni_serial: Squashed dma_request_chan error b=
reaks probe deferral
- [Medium] tty: serial: qcom_geni_serial: Incorrect tx_empty reporting brea=
ks tcdrain
- [Medium] tty: serial: qcom_geni_serial: Callbacks access port state witho=
ut locks on error
--

commit 795e95674391634c4084de89abe8cbcd0788b18d
Author: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
Subject: tty: serial: qcom_geni_serial: Add GPI DMA support

This commit adds support for the GPI DMA interface in the QCOM Geni serial
driver. It configures hardware flow control, DMA channels, and RX buffers
when the UART engine operates in GPI mode.

> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 4a6f526340b8d..eb66194a7f645 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c

[ ... ]

> @@ -828,6 +828,11 @@ static void handle_rx_uart(struct uart_port *uport, =
u32 bytes)
> =20
>  static unsigned int qcom_geni_serial_tx_empty(struct uart_port *uport)
>  {
> +	struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> +
> +	if (port->gpi_mode)
> +		return !port->tx_dma_addr ? TIOCSER_TEMT : 0;
> +

[Severity: Medium]
Does this reporting logic correctly account for pending asynchronous TX wor=
k?=20

If qcom_geni_serial_start_tx_dma() queues the tx_xfer_work on the workqueue,
the tx_dma_addr remains 0 until the work actually maps the buffer. Could th=
is
cause polling functions like uart_wait_until_sent() to prematurely return
TIOCSER_TEMT and assume the shift registers are idle while data is still
waiting to be transmitted?

>  	return !readl(uport->membase + SE_GENI_TX_FIFO_STATUS);
>  }
> =20
> @@ -848,6 +849,17 @@ static void qcom_geni_serial_stop_tx_dma(struct uart=
_port *uport)
>  {
>  	struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> =20
> +	if (port->gpi_mode && port->tx_dma_addr) {
> +		/*
> +		 * Allow tx_xfer_work to finish. Buffer cleanup is deferred until
> +		 * the DMA channel has been terminated.
> +		 */
> +		port->gpi->tx_cancel_pending =3D true;
> +		complete(&port->gpi->tx_xfer_completion);
> +		queue_work(port->gpi->tx_wq, &port->gpi->tx_cancel_work);
> +		return;
> +	}
> +
>  	if (qcom_geni_serial_main_active(uport))
>  		__qcom_geni_serial_cancel_tx_cmd(uport);

[Severity: High]
Is it safe to bypass cancellation if tx_dma_addr is zero?

If start_tx_dma() has queued tx_xfer_work but hasn't yet executed and mapped
the buffer, tx_dma_addr will still be 0. This seems to allow the asynchrono=
us
work to start up later even after the port believes it has stopped.

Furthermore, if tx_dma_addr is 0 in GPI mode, this drops through to call
__qcom_geni_serial_cancel_tx_cmd(), which writes directly to the SE hardware
registers. Can this collide with the GPI DMA controller's operation?

[ ... ]

> @@ -1056,6 +1056,11 @@ static void qcom_geni_serial_stop_rx_dma(struct ua=
rt_port *uport)
>  	if (!qcom_geni_serial_secondary_active(uport))
>  		return;
> =20
> +	if (port->gpi_mode) {
> +		queue_work(port->gpi->rx_wq, &port->gpi->rx_cancel_work);
> +		return;
> +	}
> +

[Severity: Critical]
Will this GPI mode branch ever execute?

In GPI mode, S_IRQ_EN is disabled during initialization, so the call to
qcom_geni_serial_secondary_active() above it will always evaluate to false.
Could this prevent the rx_cancel_work from ever being queued, leaving the
RX DMA permanently active?

[ ... ]

> @@ -1381,6 +1381,16 @@ static void qcom_geni_serial_shutdown(struct uart_=
port *uport)
>  	/* Atomic console output queues tx_kick without taking the port lock. */
>  	WRITE_ONCE(port->tx_kick_enabled, false);
>  	irq_work_sync(&port->tx_kick);
> +
> +	if (port->gpi_mode) {
> +		qcom_geni_serial_stop_tx_dma(uport);
> +		flush_workqueue(port->gpi->tx_wq);
> +		flush_workqueue(port->gpi->rx_wq);
> +
> +		pm_runtime_put_sync(uport->dev);
> +		return;
> +	}
> +

[Severity: Critical]
Should qcom_geni_serial_stop_rx_dma() be called in this branch before we sh=
ut
down the device?=20

Without stopping RX, the DMA channel seems to be left running while
pm_runtime_put_sync() powers off the device, which might lead to severe
memory corruption or IOMMU faults.

[Severity: High]
Can these flush_workqueue() calls trigger a use-after-free panic during dev=
ice
removal?=20

Looking at qcom_geni_serial_remove(), it calls destroy_workqueue() on both =
of
these workqueues before it invokes uart_remove_one_port(), which synchronou=
sly
executes this shutdown callback. Passing destroyed workqueues into the flush
API can cause crashes.

[ ... ]

> +static void
> +qcom_geni_serial_gpi_rx_callback_result(void *cb, const struct dmaengine=
_result *result)
> +{
> +	struct qcom_geni_serial_port *port =3D cb;
> +	struct uart_port *uport =3D &port->uport;
> +	struct tty_port *tport =3D &uport->state->port;
> +	size_t bytes =3D UART_XMIT_SIZE - result->residue;
> +	u8 idx =3D port->gpi->rx_done_index;
> +	int ret;
> +
> +	if (result->result !=3D DMA_TRANS_NOERROR) {
> +		dev_err(uport->dev, "rx dma xfer failed: %d\n", result->result);
> +		qcom_geni_serial_stop_rx_dma(uport);
> +		qcom_geni_serial_start_rx_dma(uport);
> +		return;
> +	}

[Severity: Medium]
Is it intended to call qcom_geni_serial_stop_rx_dma() here without holding
the uport->lock? The stop routines appear to assume they are serialized by
the port lock.

[Severity: Critical]
Does this logic unconditionally restart the DMA pipeline even on an intenti=
onal
cancellation?

If the DMA channel is intentionally halted (which might return an error code
like DMA_TRANS_ABORTED), qcom_geni_serial_start_rx_dma() will immediately
re-arm it, completely nullifying any attempt to cleanly halt the RX channel.

[ ... ]

> +static void
> +qcom_geni_serial_gpi_tx_callback_result(void *cb, const struct dmaengine=
_result *result)
> +{
> +	struct qcom_geni_serial_port *port =3D cb;
> +	struct uart_port *uport =3D &port->uport;
> +	struct tty_port *tport =3D &uport->state->port;
> +	unsigned long flags;
> +
> +	if (result->result !=3D DMA_TRANS_NOERROR) {
> +		dev_err(uport->dev, "tx dma xfer failed: %d\n", result->result);
> +		qcom_geni_serial_stop_tx_dma(uport);
> +		return;
> +	}

[Severity: Medium]
Similar to the RX callback, does this call to qcom_geni_serial_stop_tx_dma()
need to be protected by uart_port_lock_irqsave() to prevent concurrent
modifications to the hardware and driver state?

> +
> +	uart_port_lock_irqsave(uport, &flags);
> +	uart_xmit_advance(uport, port->gpi->xmit_size - result->residue);
> +	complete(&port->gpi->tx_xfer_completion);
> +
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
> +		uart_write_wakeup(uport);
> +	uart_port_unlock_irqrestore(uport, flags);
> +}

[Severity: High]
Does this blindly advance the kfifo pointers after they could have been res=
et?

Because the tx_xfer_work reads the kfifo without holding the spinlock, anot=
her
TTY operation (like uart_flush_buffer) could zero out the FIFO pointers whi=
le
the DMA transfer is mid-flight. When the transfer finishes, calling
uart_xmit_advance() here will push the out pointer past the in pointer (0),
corrupting the kfifo state and causing out-of-bounds accesses.

[Severity: High]
Are we missing logic here to queue another TX work element if there is still
unsent data remaining in the FIFO?=20

Because hardware TX interrupts are disabled in GPI mode, if we don't manual=
ly
re-arm the next DMA transfer, the transmission pipeline could permanently s=
tall
until a new userspace write explicitly triggers it.

[ ... ]

> +static void qcom_geni_serial_gpi_tx_xfer_work(struct work_struct *work)
> +{
> +	struct qcom_geni_serial_gpi *gpi =3D container_of(work, struct qcom_gen=
i_serial_gpi,
> +							tx_xfer_work);
> +	struct qcom_geni_serial_port *port =3D gpi->port;
> +	struct uart_port *uport =3D &port->uport;
> +	struct tty_port *tport =3D &uport->state->port;
> +	struct dma_slave_config config =3D {};
> +	struct dma_async_tx_descriptor *desc;
> +	unsigned long flags =3D DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
> +	unsigned long time_left;
> +	unsigned long timeout;
> +	dma_cookie_t tx_cookie;
> +	u8 *tail =3D NULL;
> +	int ret;
> +
> +	gpi->xmit_size =3D kfifo_out_linear_ptr(&tport->xmit_fifo, &tail,
> +					      UART_XMIT_SIZE);

[Severity: High]
Can this race with the TTY layer modifying the transmit buffer?

The shared transmit buffer is being accessed here without the necessary
spinlock serialization (uport->lock). This lockless access makes it possible
for the kfifo state to be modified out from underneath the running DMA work=
er.

> +	if (!gpi->xmit_size)
> +		return;
> +
> +	config.peripheral_config =3D &gpi->peripheral;
> +	config.peripheral_size =3D sizeof(gpi->peripheral);
> +
> +	ret =3D dmaengine_slave_config(gpi->tx_chan, &config);
> +	if (ret) {
> +		dev_err(uport->dev, "tx dma config error: %d\n", ret);
> +		return;
> +	}
> +
> +	port->tx_dma_addr =3D dma_map_single(port->se.dev->parent, tail,
> +					   gpi->xmit_size, DMA_TO_DEVICE);
> +	ret =3D dma_mapping_error(port->se.dev->parent, port->tx_dma_addr);
> +	if (ret) {
> +		dev_err(uport->dev, "DMA mapping failure: %d\n", ret);
> +		port->tx_dma_addr =3D (dma_addr_t)NULL;
> +		return;
> +	}
> +
> +	dma_sync_single_for_cpu(port->se.dev->parent, port->tx_dma_addr,
> +				gpi->xmit_size, DMA_TO_DEVICE);

[Severity: High]
Does calling dma_sync_single_for_cpu() immediately after dma_map_single()
invalidate the device's ownership of the memory?

By forcefully revoking the device's ownership before transmission begins, t=
he
DMA controller might be instructed to read stale or uninitialized CPU cache
lines on non-coherent platforms, which corrupts the transmitted data.

> +	desc =3D dmaengine_prep_slave_single(gpi->tx_chan, port->tx_dma_addr,
> +					   gpi->xmit_size, DMA_MEM_TO_DEV, flags);
> +	if (!desc) {
> +		dev_err(uport->dev, "Error setting up tx desc\n");
> +		goto err;
> +	}
> +
> +	desc->callback_result =3D qcom_geni_serial_gpi_tx_callback_result;
> +	desc->callback_param =3D port;
> +	tx_cookie =3D dmaengine_submit(desc);
> +	if (dma_submit_error(tx_cookie)) {
> +		dev_err(uport->dev, "%s: dmaengine_submit failed: %d\n", __func__, tx_=
cookie);
> +		dmaengine_terminate_sync(gpi->tx_chan);
> +		goto err;
> +	}
> +	reinit_completion(&port->gpi->tx_xfer_completion);
> +	dma_async_issue_pending(gpi->tx_chan);

[Severity: High]
Could the reinit_completion() call overwrite the cancellation signal?

If qcom_geni_serial_stop_tx_dma() concurrently executes and issues a
complete() signal, the reinit_completion() here would wipe out that signal.
This causes the worker thread to hang on the subsequent completion timeout.

[ ... ]

> +static int qcom_geni_serial_prepare_gpi_rx_dma(struct qcom_geni_serial_p=
ort *port)
> +{
> +	struct qcom_geni_serial_gpi *gpi =3D port->gpi;
> +	struct uart_port *uport =3D &port->uport;
> +	int i, ret;
> +
> +	for (i =3D 0; i < NUM_GPI_RX_BUFFERS; i++) {
> +		gpi->rx_buf[i] =3D devm_kzalloc(uport->dev, UART_XMIT_SIZE, GFP_KERNEL=
);
> +		if (!gpi->rx_buf[i])
> +			return dev_err_probe(uport->dev, -ENOMEM, "RX buffer %d\n", i);
> +
> +		gpi->rx_dma_addr[i] =3D dma_map_single(port->se.dev->parent, gpi->rx_b=
uf[i],
> +						     UART_XMIT_SIZE, DMA_FROM_DEVICE);
> +		ret =3D dma_mapping_error(port->se.dev->parent, gpi->rx_dma_addr[i]);
> +		if (ret) {
> +			dev_err(uport->dev, "Failed to map gpi rx buffer[%d]\n", i);
> +			return ret;
> +		}
> +	}
> +	return 0;
> +}

[Severity: Medium]
Are the earlier DMA mappings leaked if this loop fails?

If dma_map_single() fails on an iteration i > 0, the function returns the
error directly without unwinding and unmapping the successful mappings from
the previous iterations.

[ ... ]

> +static int qcom_geni_serial_setup_gpi_dma(struct qcom_geni_serial_port *=
port)
> +{
> +	struct qcom_geni_serial_gpi *gpi =3D port->gpi;
> +	int ret =3D -EINVAL;
> +
> +	gpi->tx_chan =3D dma_request_chan(port->se.dev, "tx");
> +	if (IS_ERR(gpi->tx_chan)) {
> +		dev_err(port->se.dev, "Failed to get tx DMA ch\n");
> +		return ret;
> +	}

[Severity: Medium]
Does this squash important probe deferral error codes?

The original error from dma_request_chan() (such as -EPROBE_DEFER) is lost
and replaced by the hardcoded -EINVAL. This converts a normal transient pro=
be
deferral into a permanent initialization failure for the device.

[ ... ]

> @@ -1352,13 +1805,26 @@ static int qcom_geni_serial_port_setup(struct uar=
t_port *uport)
>  		return -ENXIO;
>  	}
> =20
> +	port->gpi_mode =3D readl(uport->membase + GENI_IF_DISABLE_RO) & FIFO_IF=
_DISABLE;
> +	if (port->gpi_mode) {
> +		geni_se_select_mode(&port->se, GENI_GPI_DMA);
> +		ret =3D qcom_geni_serial_gpi_init(port);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	qcom_geni_serial_stop_rx(uport);
> =20
>  	ret =3D setup_fifos(port);
>  	if (ret)
>  		return ret;

[Severity: Medium]
Does this return early without cleaning up the initialized GPI state?

If setup_fifos() fails, the error code is returned without unwinding the
resources acquired in qcom_geni_serial_gpi_init(). Since port->setup has not
yet been set to true, the teardown logic in qcom_geni_serial_remove() will
also skip freeing these leaked workqueues and DMA mappings.

[ ... ]

> @@ -2035,6 +2565,14 @@ static void qcom_geni_serial_remove(struct platfor=
m_device *pdev)
> =20
>  	WRITE_ONCE(port->tx_kick_enabled, false);
>  	irq_work_sync(&port->tx_kick);
> +
> +	if (port->gpi_mode && port->setup) {
> +		destroy_workqueue(port->gpi->tx_wq);
> +		destroy_workqueue(port->gpi->rx_wq);
> +		qcom_geni_serial_release_gpi_dma(port);
> +		qcom_geni_serial_unprepare_gpi_rx_dma(port);
> +	}
> +
>  	dev_pm_clear_wake_irq(&pdev->dev);
>  	device_init_wakeup(&pdev->dev, false);
>  	if (!port->dev_data->console)

[Severity: High]
Are the workqueues being destroyed too early in the port lifecycle?

This code destroys the workqueues right before calling uart_remove_one_port=
(),
which synchronously runs qcom_geni_serial_shutdown() if the port is open. As
seen earlier, that shutdown callback invokes flush_workqueue() on these
newly-freed workqueues.

[Severity: Medium]
Will this leak resources if initialization failed partway through?

Because cleanup is gated behind the port->setup boolean, early failures in
qcom_geni_serial_port_setup() mean these resources will never be freed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-add-gpi-dm=
a-support-for-uart-v1-0-c69e728df686@oss.qualcomm.com?part=3D4
