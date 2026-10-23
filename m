Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792780357;
	b=ScEMdV/rl+/5E4dhliMmWuZqF683lNSCKZgaX20LdFHmmphiXGdukQSL6UjUkZopIb3P
	 6ZrLACqlBZXsY85JjIiCv/kIUT0ylJWU6xmehJmH8bkqO1vcL89rUIqN4ZYWQiXpSgeoK
	 FH5zgqGJUHBVg8SVO/thS7vAC75tbsii/cZz0gs8v63NFxbg6hru4X8vuMDKhaqWyX6HI
	 VDttUCe94aIXstNE8RsHQKJWL27n1KimYWgvNQw2fuABB7TU6QgDTJ7TU6i7FN0NpA9b1
	 E1ZrCgYjim0MVH99ULjosEv6Y+SkkHVvMFOQrpNTrtvPW378rRsDU5iHStzdqKlUw9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792780357;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9iKbTwadZLj5Rvv7AiGUBhAIMjcsz9TCdgNM2HRsWQg=;
	b=S8gS1I9CwLx72NTz9fhGOdGWyrAgEywP31k4LgJWGoj5nB6kPo7vkXZPd1z4RAGuL3jY
	 QwvSNCWUeG0boQiw0QVor3Rd+HEp/8z2ReAyAKjRNxjZenX3JOrboBRi4uWyCI397pnBm
	 0WA3eiPFQ4OTK1u9RzssujwWY1Psne9sSUaSX/jwBuh4IzM+c/EG2KpsikOx55yAKOqNa
	 cM8muE0moZPYaM4aWAWvsHthOR2SFsU9EwtH6G9HjRR4F4+o2VLk0lb1RphWWFJlPj4Iv
	 edfsyX6AtOhsckcLjYgVBm2C/ZwfTJAioQi2R1LzGNSXVsIpmvsMWvsDPuRYj7QsPDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5oKj1sj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF53606A31A
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5oKj1sj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEE31F01825;
	Fri, 23 Oct 2026 18:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792780356;
	bh=9iKbTwadZLj5Rvv7AiGUBhAIMjcsz9TCdgNM2HRsWQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G5oKj1sjWdkv1rCS9OolQeniri3lv9UOoRjlsDAuCMFcxm+KFlB3GnNyhcqxxYswP
	 bWhILaWi31zeVVB+SmD5xX7dPMTXjWdzhdZkYgR1aDqkgKvnkiXSL9M9qy9Xdcsa27
	 HsnLl0gyJI1Eiph66ry8QeaXpwm1UdQdjO0SdKdQoWUL5U7ErTELjceS5e1v3+t+6y
	 6E7D+m6fdPxMfrosEEI5UDmGtNtXzxXeyqiDJk7jgRBj4v+RZ0/N9KWQM5Cr4ZRLRp
	 gpr4BCTOrq11/yLC/h+My8FJ0kI8+r25zRPGOx/A+dGiOqsv6Icz8bdtd0Kl+bos5W
	 Y4EMxhDyYH14g==
Message-ID: <sashiko-outbox-183066@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023-submit-serial-8250-dma-cancel-v1-v3-4-d78f9e4c4932@gmail.com>
References: <20261023-submit-serial-8250-dma-cancel-v1-v3-0-d78f9e4c4932@gmail.com>
 <20261023-submit-serial-8250-dma-cancel-v1-v3-4-d78f9e4c4932@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 18:32:35 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] serial: 8250: serial8250_rx_dma_flush() returns -ESHUTDOWN when DM=
A is stopped
- [High] serial: 8250: serial8250_rx_dma_flush() drops data when pause fail=
s on complete
- [High] serial: 8250_dw: DLAB write failure in dw8250_set_divisor() corrup=
ts UART_IER
--

commit f21a925e2ab02b4a2962f22b9f5a07f563e44794
Author: James Hilliard <james.hilliard1@gmail.com>

serial: 8250: retire canceled RX DMA before reusing the receive buffer

This commit retires canceled RX DMA callbacks via a work item before
allowing the receive buffer to be reused, separates FIFO ownership from
callback retirement, and adds recovery and shutdown handling for RX DMA
failures.

> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250=
/8250_dma.c
> index 611e4dee98297..2485029b989c4 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
[ ... ]
> @@ -262,16 +308,49 @@ int serial8250_rx_dma(struct uart_8250_port *p)
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
> +	if (!dma)
> +		return 0;
> +	/* A late interrupt must not hand a still-active receiver to PIO. */
> +	if (dma->shutting_down)
> +		return -ESHUTDOWN;
> +	if (!dma->rx_running)
> +		return 0;

[Severity: High]
Because serial8250_rx_dma_flush() checks dma->shutting_down before
!dma->rx_running, it returns -ESHUTDOWN even when RX DMA is not running.

During port shutdown in serial8250_do_shutdown(), up->dma->shutting_down is
set to true and serial8250_release_dma() releases the DMA channels and sets
dma->rx_running =3D 0, but leaves up->dma non-NULL and dma->shutting_down s=
et
to true until serial8250_request_dma() runs near the end of a subsequent
serial8250_do_startup():

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
	...
	/* Disable break condition */
	lcr =3D serial_port_in(port, UART_LCR);
	lcr &=3D ~UART_LCR_SBC;
	serial_port_out(port, UART_LCR, lcr);
}

On DesignWare UARTs, if DW_UART_USR_BUSY is asserted during that UART_LCR
write in serial8250_do_shutdown(), or during serial8250_initialize() in
serial8250_do_startup() before serial8250_request_dma() clears
dma->shutting_down, the call chain
dw8250_serial_out() -> dw8250_check_lcr() -> dw8250_idle_enter() calls
serial8250_rx_dma_flush(up), which returns -ESHUTDOWN and aborts the LCR
write even though DMA is already stopped and released.

Similarly, on port reopen in serial8250_do_startup(), up->ops->setup_irq()
and serial8250_initialize() run while dma->shutting_down is still true, so
any interrupt firing before serial8250_request_dma() hits the
up->dma->shutting_down early return in dw8250_handle_irq() and
serial8250_handle_irq_locked() without reading status registers to clear the
interrupt.

Should dma->shutting_down be cleared once serial8250_release_dma() finishes
releasing the channels (or at the start of serial8250_do_startup()), and
should serial8250_rx_dma_flush() check !dma->rx_running before
dma->shutting_down?

> +	if (dma->rx_terminating)
> +		return -EIO;
> +
> +	ret =3D dmaengine_pause(dma->rxchan);
> +	if (ret)
> +		goto recover;
> +
> +	status =3D dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
> +	if (status =3D=3D DMA_ERROR) {
> +		ret =3D -EIO;
> +		goto recover;
> +	}
> +	/* Some providers still report IN_PROGRESS after a successful pause. */
> +	serial8250_rx_dma_copy(p, &state);

[Severity: High]
Can calling dmaengine_pause() before checking dmaengine_tx_status() drop a
completed RX DMA buffer?

dma_rx_complete() runs asynchronously (for example in a vchan tasklet) and
must acquire p->port.lock before copying dma->rx_buf and clearing
dma->rx_running. If a full dma->rx_size transfer completes in hardware and a
UART interrupt (UART_IIR_RDI, UART_IIR_RX_TIMEOUT, or UART_IIR_RLSI in
serial8250_handle_irq_locked() -> handle_rx_dma()) or dw8250_idle_enter()
calls serial8250_rx_dma_flush() before dma_rx_complete() acquires
p->port.lock, dma->rx_running is still 1 while the descriptor status is
already DMA_COMPLETE.

Several DMA engine drivers that advertise cmd_pause return an error from
device_pause when the transfer has already completed in hardware: for
example, dw-axi-dmac's dma_chan_pause() polls for DWAXIDMAC_IRQ_SUSPENDED on
a channel already disabled by axi_chan_block_xfer_complete() and returns
-EAGAIN, while stm32_dma_pause() and dw_edma_device_pause() return -EPERM
and edma_dma_pause() and omap_dma_pause() return -EINVAL when the channel is
not currently active.

When dmaengine_pause() returns an error here, serial8250_rx_dma_flush()
jumps to recover, where serial8250_rx_dma_recover() sets dma->rx_err =3D tr=
ue
and dma->rx_terminating =3D true without calling serial8250_rx_dma_copy().
When the pending dma_rx_complete() callback then acquires p->port.lock, it
sees dma->rx_terminating and returns early without copying dma->rx_buf
either, losing the completed buffer and disabling RX DMA until reopen.

> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
> index eca02e8bd6d13..3880ec6a9368e 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
[ ... ]
> @@ -147,7 +148,12 @@ static int dw8250_idle_enter(struct uart_port *p)
>  	serial_port_out(p, UART_IER, 0);
> =20
>  	if (up->dma) {
> -		serial8250_rx_dma_flush(up);
> +		ret =3D serial8250_rx_dma_flush(up);
> +		if (ret) {
> +			serial8250_out_IER(up, up->ier);
> +			d->in_idle =3D 0;
> +			return ret;
> +		}
>  		if (serial8250_tx_dma_running(up))
>  			serial8250_tx_dma_pause(up);
>  	}

[Severity: High]
When dw8250_idle_enter() returns an error here, dw8250_check_lcr() aborts
without writing UART_LCR:

drivers/tty/serial/8250/8250_dw.c:dw8250_check_lcr() {
	...
	ret =3D dw8250_idle_enter(p);
	if (ret < 0)
		goto write_err;

	serial_port_out(p, UART_LCR, value);
	dw8250_idle_exit(p);
	return;
}

On DesignWare UARTs with fractional divisor support (where DW_UART_DLF is
non-zero), dw8250_setup_port() in 8250_dwlib.c overrides p->set_divisor with
its own dw8250_set_divisor(), which calls serial8250_do_set_divisor():

drivers/tty/serial/8250/8250_dwlib.c:dw8250_set_divisor() {
	dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
	serial8250_do_set_divisor(p, baud, quot);
}

drivers/tty/serial/8250/8250_port.c:serial8250_do_set_divisor() {
	if (!(up->capabilities & UART_CAP_MINI))
		serial_port_out(port, UART_LCR, up->lcr | UART_LCR_DLAB);

	serial_dl_write(up, quot);
}

If serial8250_do_set_termios() runs while the UART is busy and
serial8250_rx_dma_flush() returns an error in dw8250_idle_enter() (for
example, while RX DMA recovery is active with dma->rx_running &&
dma->rx_terminating, or when pausing/terminating RX DMA fails), the write to
set UART_LCR_DLAB fails in dw8250_check_lcr() and DLAB remains 0 in
hardware.

serial8250_do_set_divisor() then unconditionally calls serial_dl_write() ->
default_serial_dl_write(), which writes quot & 0xff to offset 0 (UART_TX
when DLAB is 0) and (quot >> 8) & 0xff to offset 1 (UART_IER when DLAB is 0)
via raw serial_out(). Can this corrupt UART_IER and bypass
serial8250_out_IER() to unmask receive interrupts in hardware during RX DMA
recovery?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-submit-ser=
ial-8250-dma-cancel-v1-v3-0-d78f9e4c4932@gmail.com?part=3D4
