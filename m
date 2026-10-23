Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717045;
	b=kdKiBNP9SZjJEqFgp6W3cxcUouQxjlYyt+oh2a55jGW/U7a/ivKKD4AKIzjQzvnpbr+y
	 AyXrZbvqRq7uEsnljDi+nZw00jRKsDAzyG4k2oaEJI92Y0WUrLy7/MSkJLr48gsNP5BW6
	 iolTtQvHrxWcXCl1UwKXaUSMSFK7KITMcboFT828k9tPX0d3g4TkzB6lX8f78BmlCPHKV
	 qeZrB75Tx7bZzf6dqQ4cElBuiOv5u6IU0KU2wi8aVS/qKglVHSn+VnAjgg7zTQwP+ZXJf
	 hz/HHLTCy/qWhVrJaDO9Co37Zx3Hw4XA1Gfji4NT1aSZgewOPecb6o6PBUHnH4eLXhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717045;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hjurFGa5UfxZ1thkkG3svF13D7aCE8L7hAG5CidjkSs=;
	b=zvXylAjw7YoHNJbKIALYz9mcF3M9EyMlEthklR/pLVTDzZ/eTMH4ymSBf19sg2uTKr4Z
	 QwbhNUkPD6JYajerTJYas/vfUY5YC9rtPU2OJQCz8SRqHqjNLurWCa3HRaWGuM0mWbSR7
	 Rs1jt5Hw7tJFSTlUZGZB6dFWo3szP8mdI8bc00iMiKdx2buBNAwnshqcxmp1Lrwb7jvdO
	 94C2r9xgXLNDT7ns0gK9jaJGi5YHzv6QZGiHxE4uXmnUAO19Br27n20zfsqJaVDhCDTWq
	 BrIFwzrOgAhhElApe+zKLb+NPbthPEcm/zCl72qODyf2Dd8rPGrpaFH8m61tMdQqWPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqcDvf2P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D985A606A319
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 00:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqcDvf2P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1061F01825;
	Fri, 23 Oct 2026 00:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792717044;
	bh=hjurFGa5UfxZ1thkkG3svF13D7aCE8L7hAG5CidjkSs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nqcDvf2PQv3IIWYpC6hZGQNaoXDzIaJ0Rlsz7roswhFSNBwtGct8WOekec7PTvYON
	 4/YHCYrCUM/VfNmhKFduIKBz0Sa8g+9UP6tHsxKAwggT1DRmcwdXxnjRgDd41UoI/J
	 vl0p8+Sq+4hEK0MZEEl3c56kOkH65ySS/cbxMx6yUQh5fUOXteTe1gVMwE8T9ikeWj
	 A1QPvDBIG5qHGGjR68JiNHZuLCUjfOTjdBu6gBFQDx/P2dGwBDhxLmpyRLQdP96U6x
	 IvJzRTsDqaERSM8I933aGoXVsJvU2eyQ/T8ZPCX6Dkk8AkoVw2nyVJ9JpnD/iD5WBT
	 H+hNDMqohoZQg==
Message-ID: <sashiko-outbox-182187@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261022-submit-serial-8250-dma-cancel-v1-v2-4-088ea51e3891@gmail.com>
References: <20261022-submit-serial-8250-dma-cancel-v1-v2-0-088ea51e3891@gmail.com>
 <20261022-submit-serial-8250-dma-cancel-v1-v2-4-088ea51e3891@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 00:57:23 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] serial: 8250: dw8250_handle_irq() skips RX timeout quirk while rx_=
terminating
- [High] serial: 8250: RX interrupts unmasked in UART_IER during RX DMA err=
or recovery
- [Medium] serial: 8250: serial8250_stop_rx() drops UART_IER_RTOIE from dma=
->rx_ier
- [Medium] serial: 8250: serial8250_rx_dma_flush() allows PIO RX while DMA =
runs on shutdown
--

commit d3768e2140777caa150bf17338f045f59925e47a
Author: James Hilliard <james.hilliard1@gmail.com>

serial: 8250: retire canceled RX DMA before reusing the receive buffer

This commit reserves the RX DMA buffer until a workqueue item has drained
canceled completion callbacks after an RX timeout flush, and adds error
recovery that masks receive interrupts and falls back to PIO if pausing or
terminating RX DMA fails.

> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250=
/8250_dma.c
> index bb30d3588f16f..4cadb3eef9413 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c

[ ... ]

> @@ -262,16 +317,49 @@ int serial8250_rx_dma(struct uart_8250_port *p)
>  	return 0;
>  }
> =20
> -void serial8250_rx_dma_flush(struct uart_8250_port *p)
> +int serial8250_rx_dma_flush(struct uart_8250_port *p)
>  {
>  	struct uart_8250_dma *dma =3D p->dma;
> +	struct dma_tx_state state;
> +	enum dma_status status;
> +	int ret;
> =20
> -	if (!dma || !dma->rxchan || !dma->rx_running)
> -		return;
> +	lockdep_assert_held_once(&p->port.lock);
> =20
> -	dmaengine_pause(dma->rxchan);
> -	__dma_rx_complete(p);
> -	dmaengine_terminate_async(dma->rxchan);
> +	if (!dma || dma->shutting_down || !dma->rxchan || !dma->rx_running)
> +		return 0;

[Severity: Medium]
When dma->shutting_down is true while dma->rx_running is still non-zero (or
while dma->rx_err is set during recovery), serial8250_rx_dma_flush() returns
0 without pausing or stopping the RX DMA channel.

In drivers/tty/serial/8250/8250_port.c, serial8250_do_shutdown() sets
up->dma->shutting_down =3D true under port->lock before calling
synchronize_irq(port->irq), and only terminates the RX DMA channel afterward
in serial8250_release_dma():

drivers/tty/serial/8250/8250_port.c:serial8250_do_shutdown() {
	scoped_guard(uart_port_lock_irqsave, port) {
		if (up->dma)
			up->dma->shutting_down =3D true;
		up->ier =3D 0;
		serial_port_out(port, UART_IER, 0);
	}

	synchronize_irq(port->irq);

	if (up->dma)
		serial8250_release_dma(up);
}

If an in-flight IRQ handler (such as serial8250_default_handle_irq() or
dw8250_handle_irq()) is waiting on port->lock when serial8250_do_shutdown()
sets shutting_down =3D true, serial8250_handle_irq_locked() -> handle_rx_dm=
a()
evaluates !serial8250_rx_dma_flush(up) as true and proceeds to drain UART_RX
via serial8250_rx_chars().

Could that allow PIO FIFO reads to run concurrently with an active, unpaused
RX DMA transfer during shutdown?

> +	if (dma->rx_terminating) {
> +		if (dma->rx_err) {
> +			/* A termios or RS485 change may have enabled RX interrupts. */
> +			serial8250_rx_dma_mask(p);
> +			return -EIO;
> +		}
> +		return 0;
> +	}

[Severity: High]
Is re-masking RX interrupts inside serial8250_rx_dma_flush() sufficient when
termios, RS485, or overrun backoff paths modify UART_IER while dma->rx_err =
is
set?

During RX DMA error recovery (or permanently if dmaengine_terminate_sync()
fails in serial8250_rx_dma_flush_work()), serial8250_set_ier(),
serial8250_em485_stop_tx(), and serial_8250_overrun_backoff_work() in
drivers/tty/serial/8250/8250_port.c can still set UART_IER_RTOIE or
UART_IER_RLSI | UART_IER_RDI in up->ier and write up->ier directly to
UART_IER (with serial8250_em485_stop_tx() also resetting the FIFOs via
serial8250_clear_and_reinit_fifos()).

However, serial8250_handle_irq_locked() only calls handle_rx_dma() ->
serial8250_rx_dma_flush() when (status & (UART_LSR_DR | UART_LSR_BI)) &&
!skip_rx is true:

drivers/tty/serial/8250/8250_port.c:serial8250_handle_irq_locked() {
	if (!(status & (UART_LSR_FIFOE | UART_LSR_BRK_ERROR_BITS)) &&
	    (port->status & (UPSTAT_AUTOCTS | UPSTAT_AUTORTS)) &&
	    !(up->ier & (UART_IER_RLSI | UART_IER_RDI)))
		skip_rx =3D true;

	if (status & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
		...
		if (!up->dma || handle_rx_dma(up, iir))
			status =3D serial8250_rx_chars(up, status);
	}
}

If serial8250_set_ier() enables UART_IER_RTOIE on a port with UART_CAP_RTOIE
and hardware flow control (UPSTAT_AUTOCTS | UPSTAT_AUTORTS) while
UART_IER_RLSI | UART_IER_RDI remain masked, skip_rx is true, so an RX timeo=
ut
interrupt will never reach handle_rx_dma() or serial8250_rx_chars() to be
cleared or re-masked.

Similarly, if an unmasked RX interrupt fires when UART_LSR_DR | UART_LSR_BI
is clear (for instance, on a DesignWare empty-FIFO UART_IIR_RX_TIMEOUT while
up->dma->rx_running is still 1, or if the unstopped DMA channel drains the
byte before serial_lsr_in()), handle_rx_dma() is skipped and the interrupt
remains unmasked.

Could those UART_IER writers avoid enabling RX interrupts while RX DMA
recovery owns the mask, rather than relying on serial8250_rx_dma_flush() to
catch the resulting interrupt?

> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
> index eca02e8bd6d13..8a637a85f1013 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c

[ ... ]

> @@ -435,10 +441,11 @@ static int dw8250_handle_irq(struct uart_port *p)
>  	 * read.  If we don't do this then the "RX TIMEOUT" interrupt will
>  	 * fire forever.
>  	 *
> -	 * This problem has only been observed so far when not in DMA mode
> -	 * so we limit the workaround only to non-DMA mode.
> +	 * Only read the FIFO when DMA no longer owns it, including PIO fallback
> +	 * after a DMA error.
>  	 */
> -	if (!(quirks & DW_UART_QUIRK_SKIP_EMPTY_FIFO_READ) && !up->dma && rx_ti=
meout) {
> +	if (!(quirks & DW_UART_QUIRK_SKIP_EMPTY_FIFO_READ) &&
> +	    (!up->dma || !up->dma->rx_running) && rx_timeout) {
>  		status =3D serial_lsr_in(up);
> =20
>  		/*

[Severity: High]
When an RX timeout flushes DMA in serial8250_rx_dma_flush(),
dma->rx_terminating is set to true and dmaengine_terminate_async() stops the
transfer so PIO can drain the FIFO, but dma->rx_running remains 1 until
serial8250_rx_dma_flush_work() runs in process context:

drivers/tty/serial/8250/8250_dma.c:serial8250_rx_dma_flush() {
	serial8250_rx_dma_copy(p, &state);
	dma->rx_terminating =3D true;
	ret =3D dmaengine_terminate_async(dma->rxchan);
	if (ret)
		goto recover;

	/* Keep the buffer reserved until any old completion has returned. */
	schedule_work(&dma->rx_flush_work);
	return 0;
}

If the DesignWare UART triggers an empty-FIFO UART_IIR_RX_TIMEOUT interrupt
during this window before serial8250_rx_dma_flush_work() executes,
(!up->dma || !up->dma->rx_running) in dw8250_handle_irq() evaluates to false
and skips the dummy serial_port_in(p, d->data.srbr) read. Because UART_LSR_=
DR
and UART_LSR_BI are clear, serial8250_handle_irq_locked() does not read RBR
either.

Wouldn't that leave the level-triggered RX timeout interrupt asserted and
cause an interrupt storm that prevents serial8250_rx_dma_flush_work() from
running on the local CPU? Also, right below in dw8250_handle_irq(), the
DW_UART_QUIRK_IS_DMA_FC check tests up->dma->rx_running and would still wri=
te
RZN1_UART_RDMACR and DW_UART_DMASA on subsequent RX timeouts even after
serial8250_rx_dma_flush() has already terminated the transfer.

> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index f36f7e18ab951..2f901e97aaded 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1305,6 +1305,8 @@ static void serial8250_stop_rx(struct uart_port *po=
rt)
> =20
>  	guard(serial8250_rpm)(up);
> =20
> +	if (up->dma)
> +		up->dma->rx_ier =3D 0;
>  	up->ier &=3D ~(UART_IER_RLSI | UART_IER_RDI);
>  	serial_port_out(port, UART_IER, up->ier);
>  }

[Severity: Medium]
In drivers/tty/serial/8250/8250_dma.c, serial8250_rx_dma_mask() moves
UART_IER_RDI | UART_IER_RLSI | UART_IER_RTOIE out of p->ier and into
p->dma->rx_ier.

Here in serial8250_stop_rx(), up->ier only clears ~(UART_IER_RLSI |
UART_IER_RDI), whereas up->dma->rx_ier =3D 0 clears UART_IER_RTOIE as well.=
 If
serial8250_stop_rx() is called during RX DMA error recovery (for example,
via serial8250_em485_start_tx() during half-duplex RS485 transmission, where
serial8250_em485_stop_tx() later only re-enables UART_IER_RLSI |
UART_IER_RDI), wouldn't clearing all of up->dma->rx_ier lose UART_IER_RTOIE
once PIO fallback completes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-submit-ser=
ial-8250-dma-cancel-v1-v2-0-088ea51e3891@gmail.com?part=3D4
