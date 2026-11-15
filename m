Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794766918;
	b=MTfEU6fBJ1wEhK+nJ0zeSY+jfadngzJ2ZYlekd8waUMQyhSNm0I9dfgUP0bmfT9yqOEV
	 FhMRXV8BSx3La6hXRyOTASC/iSWy++yOcd3/kC6cq/XC3uFPMepnEQX61pOKhkpvmlLQP
	 Vp3OEsXRLVDWZUtNb7ybk864grtSS+g3wcDNDrxDeIxMIFqbA8Zjb//pAohSJMyQAWjKG
	 IJcWcNrxbkMOdCm1AQrYSm2cWdkyytUZBVv3u/gKypx4icn5NcFeF8KHaysIu6luIgckC
	 rG/L4QuUXIKzqqw7r0TU40cQuJdoujgweIzNwqIvnopZd0Na/NTisUfUtOdI0zl+ZFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794766918;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/KtRSnRxcwxjiYk2lhSOwFirttb+T7tQJSggYd1ysJI=;
	b=pKYwICxBh/KMGwsoChWZVzeTA+fX2JFwxvSyFbH+WaqwtSVlfmQwohIMal0vlRqyFG8U
	 Stn2jriplYNprIx3IVTFRxVDvBZgCH+z3Ykwb3goghoGTIH+M84yu5pb7qPw4jHrFKlgC
	 sZvpZUb+eK3WL1lYtuPDnQN+NefB+RAL4nYiS/0gMf+S/YTGuvBAGJGnlDajDN1afFCbw
	 HeuDVMkhm9Etsx0d86yCrFkjjpzxGRVt2Ex/GG+MbeFkn7i7rJpGOcZxPAfPHi+s3tTiZ
	 EwE9/MNlb/XRSqqd8TusqLGtFqL+p9wXaqTqeIFkYhClslTHGv4Q40LOMWkLZtv9ILw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSi1B6OX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F00D606A323
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSi1B6OX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2251F000C4;
	Sun, 15 Nov 2026 18:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794766917;
	bh=/KtRSnRxcwxjiYk2lhSOwFirttb+T7tQJSggYd1ysJI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eSi1B6OXZfxjD4xsh0WLomZr4OYlm1/VLBbsgWenCKPIrxubzd2TsQExtmmGn+vfn
	 raASQeE4wvQuAxcT7N52osGAry6VlKXu8RCiWPOt/sp6spxQN6acN9WVQthDj48TIJ
	 WrhhRGakH4pMIgfokLXASRd8mst28mJJE8z48JwAukaOSvMM/akkyXx9GzE6zrbw3i
	 ijpNPtp2C1Y8Jo6baRt95nOHUiRUxN2po4UUB0CcpzjDnvUmAPDYdFWicPtZBZ8X3E
	 sz5hCvgZGj+c1oxuTRUCXgvNL6ITsIUBhdPhuYcTooOxn9QqJS4KfojndKg9wGqU2r
	 GKV8OX3PMUgcg==
Message-ID: <sashiko-outbox-215709@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] serial: fsl_lpuart: Enable DMA for TX in console
 mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jonas Juffinger" <jonas.juffinger@liebherr.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261115-fsl_lpuart_8_bit_break_detection-v1-2-b7ac2307dd55@liebherr.com>
References: <20261115-fsl_lpuart_8_bit_break_detection-v1-0-b7ac2307dd55@liebherr.com>
 <20261115-fsl_lpuart_8_bit_break_detection-v1-2-b7ac2307dd55@liebherr.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 18:21:57 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] serial: fsl_lpuart: TX DMA race with lpuart32_console_write()
  on 32-bit LPUART
- [High] serial: fsl_lpuart: UAF of dma_tx_chan in
  lpuart_tx_dma_startup() on resume
- [Medium] serial: fsl_lpuart: console port.lock deadlock via dev_err()
  in TX DMA paths
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] tty: serial: fsl_lpuart: double dma_release_channel() in
  lpuart_remove() [1]
--

commit bca86d1a502b49317e75f113fc0d208cb42b275f
Author: Jonas Juffinger <jonas.juffinger@liebherr.com>

serial: fsl_lpuart: Enable DMA for TX in console mode

This commit removes the console port check in lpuart_tx_dma_startup() so
that TX DMA can be used on LPUART ports operating as a serial console.

> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c
> index 5817c47e4db3f..e569e2c6ffe9c 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1765,9 +1765,6 @@ static void lpuart_tx_dma_startup(struct lpuart_por=
t *sport)
>  	u32 uartbaud;
>  	int ret;
> =20
> -	if (uart_console(&sport->port))
> -		goto err;
> -
>  	if (!sport->dma_tx_chan)
>  		goto err;
> =20

[Severity: High]
Can enabling TX DMA on a console port cause concurrent DMA and polled CPU
writes to the TX FIFO during console output?

On 32-bit LPUART, lpuart_tx_dma_startup() enables hardware TX DMA requests
by setting UARTBAUD_TDMAE in UARTBAUD.  When printk() invokes
lpuart32_console_write(), it only masks interrupt bits in UARTCTRL and
never clears UARTBAUD_TDMAE:

drivers/tty/serial/fsl_lpuart.c:lpuart32_console_write() {
    ...
	cr =3D old_cr =3D lpuart32_read(&sport->port, UARTCTRL);
	cr |=3D UARTCTRL_TE | UARTCTRL_RE;
	cr &=3D ~(UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE);
	lpuart32_write(&sport->port, cr, UARTCTRL);

	uart_console_write(&sport->port, s, count, lpuart32_console_putchar);
    ...
}

If a TTY TX DMA transfer is in progress when console output runs, both the
DMA engine and lpuart32_console_putchar() respond to UARTSTAT_TDRE and
write to UARTDATA concurrently, corrupting serial output and potentially
overflowing the TX FIFO.  On 8-bit LPUART, lpuart_console_write() clears
UARTCR2_TIE without waiting for in-flight DMA beats to finish, which
pauses active multi-byte DMA transfers mid-stream and interleaves console
characters into the TTY stream.

[Severity: High]
Does removing this check cause a use-after-free of sport->dma_tx_chan on
system resume when no_console_suspend is enabled?

When a TTY port is opened and then closed, lpuart_startup() /
lpuart32_startup() allocates sport->dma_tx_chan via lpuart_request_dma(),
and lpuart_shutdown() / lpuart32_shutdown() releases it in
lpuart_dma_shutdown() without clearing the pointer:

drivers/tty/serial/fsl_lpuart.c:lpuart_dma_shutdown() {
    ...
	if (sport->dma_tx_chan)
		dma_release_channel(sport->dma_tx_chan);
	if (sport->dma_rx_chan)
		dma_release_channel(sport->dma_rx_chan);
}

When console_suspend_enabled is false, lpuart_uport_is_active() returns
true for the console port even while the TTY port is closed.  On resume,
lpuart_resume() calls lpuart_hw_setup() / lpuart32_hw_setup() ->
lpuart_tx_dma_startup() without calling lpuart_request_dma().  Without the
uart_console() guard, lpuart_tx_dma_startup() sees the non-NULL dangling
sport->dma_tx_chan pointer, passes it to lpuart_dma_tx_request() ->
dmaengine_slave_config(), and sets sport->lpuart_dma_tx_use =3D true on a
freed channel.

In addition, if the console port is open with an active TX DMA transfer
when lpuart_suspend() runs under no_console_suspend, uart_suspend_port()
returns early without draining TX, and lpuart_suspend() terminates
sport->dma_tx_chan and clears sport->dma_tx_in_progress without unmapping
sport->tx_sgl, leaking the DMA mapping.

[Severity: Medium]
Can calling dev_err() in the TX DMA error paths deadlock on
sport->port.lock when the port is a console?

lpuart_tx_dma_startup() -> lpuart_dma_tx_request() and lpuart_start_tx() /
lpuart32_start_tx() -> lpuart_dma_tx() all run under sport->port.lock:

lpuart_start_tx()
  uart_port_lock_irqsave(&sport->port, &flags)
  lpuart_dma_tx()
    dev_err(dev, "DMA mapping error for TX.\n")
      ...
        lpuart_console_write()
          uart_port_lock_irqsave(&sport->port, &flags)  <-- spins forever

If dmaengine_slave_config() fails in lpuart_dma_tx_request(), or if
dma_map_sg() or dmaengine_prep_slave_sg() fails in lpuart_dma_tx(),
dev_err() synchronously calls into the console write path and deadlocks on
sport->port.lock.

[Severity: Critical]
This problem wasn't introduced by this patch, but can lpuart_remove() call
dma_release_channel() a second time on sport->dma_tx_chan and
sport->dma_rx_chan [1]?

As noted above, lpuart_dma_shutdown() releases sport->dma_tx_chan and
sport->dma_rx_chan on port close without setting either pointer to NULL.
If the device is later unbound or the driver is unloaded, lpuart_remove()
checks those still non-NULL pointers and calls dma_release_channel() again
on the freed channels:

drivers/tty/serial/fsl_lpuart.c:lpuart_remove() {
    ...
	if (sport->dma_tx_chan)
		dma_release_channel(sport->dma_tx_chan);

	if (sport->dma_rx_chan)
		dma_release_channel(sport->dma_rx_chan);
    ...
}

Clearing sport->dma_tx_chan and sport->dma_rx_chan to NULL in
lpuart_dma_shutdown() would avoid both the double release in
lpuart_remove() and the dangling channel pointer across port close.

[1] https://sashiko.dev/#/bug/linux-4b237987-ed3a-4504-92ea-6f92bae6e727

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-fsl_lpuart=
_8_bit_break_detection-v1-0-b7ac2307dd55@liebherr.com?part=3D2
