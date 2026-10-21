Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792555880;
	b=E+s4Yw7mDxT5EFSJNb72bTutg/B64zqR9zyVio2Xqrv8BL7KoC97y8t6ygKEy1/2qS2p
	 2Fyj+j/uTGt6UloN1iLptZmn6vVjybs35aDYvKnM84QfTNvkyHDu7rSxDch2Mhsz7iM9o
	 qDf3Eukjl5M9D3iKlbuyCt9olNuZGsGr0jrhuBdW5zu07+VmlhIG+KtBiTQSCCnJzsfE5
	 ufSsDJHKf/havyL0YuswT4Z0VKYZKr3gxCub9Zvakqx2hzTJU/6cr4XOObZzK3N9nG/TC
	 CPlSCrWLYHyl8MhKXbY8ayl2LJXmflD7/0D5UZdzoEPBUnyVHTVz0FvcpiDuLte2MFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792555880;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Pg+916tB0X+07dOXrn+JJg7jb2R1XyA+D7YN7NF7mN8=;
	b=JZRYa6Mpp6cIDSjhcSq+Bd9SwuAiPG5imuGTPs/klHrlN9RmNqGqZNYVkpL2KJ91hyf0
	 IY1yR4KbGqFPhx5jIWNajH/EPEUjG37CWm8+SugPOVboAQZ4MANAoLhaKk1VfqSSkV//U
	 XWclKCxJf7vOzzAIcBjNfMijREnZwfdcHFNpI/vmbcY87pdUcR0DSuFAbTsXlOoIt5sdx
	 e1BcAjeQeZcwgL+xi21hBLLCZculQzlkLT1K1/Q0JJ/NXeEHpGJFINs1vaR6zlip9Ayns
	 tYllvr1f+0PAW1prKus42upDn2PN58D+axE8EnqPmFBpayhHLiozeWcQJ1aCKCB8oZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IqiU38o7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7E660A2615
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 04:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IqiU38o7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B5B1F000CF;
	Wed, 21 Oct 2026 04:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792555879;
	bh=Pg+916tB0X+07dOXrn+JJg7jb2R1XyA+D7YN7NF7mN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IqiU38o7erPu8E4bIepEYbtowhgXoUS3IJkR44o7oehYBFUjYACmFeWB9Zq2AL8SY
	 9N/aibDQimINh5S3fWwVKlNH2EvErqC5sa2fmMn0HippWMN4qBzh3ZeQhX0mCuQQTY
	 IVZTV4wsvNOWYNLfNoiXTDCr8+8cKFr0MBDwQCKa/BfFbrbkQaRsyY2r9HO4bjARTK
	 yJ1fWrrRavhPRFLWOQs8q1tNLWcYtoWE91Sk7AsI9DODDvnj17yQs661+DEewy82YN
	 rOgOUEp3sxGjwTw4mMNUyKX7feh25V7ldgdBPmbWp0Z5JbCWUPgTA6X1HZJ/K1ikV7
	 5SgLQFPYwr0iw==
Message-ID: <sashiko-outbox-179767@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: qcom-geni: Clear pending IRQs while suspended
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261021-ack-interrupts-on-suspended-port-v1-1-2747a58ca7cb@oss.qualcomm.com>
References: <20261021-ack-interrupts-on-suspended-port-v1-1-2747a58ca7cb@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 04:11:19 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] serial: qcom-geni: interrupt storm in qcom_geni_serial_isr() on su=
spend
- [Medium] serial: qcom-geni: clearing DMA IRQs when suspended desynchroniz=
es DMA state
--

commit 80a526c2aa218ac3d5d987a8838881b22d009fa9
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

serial: qcom-geni: Clear pending IRQs while suspended

This commit moves the interrupt status register reads and clears to the sta=
rt
of qcom_geni_serial_isr() under the UART port lock before checking
uport->suspended. When the port is suspended, the handler now clears the
interrupt status bits, jumps to out_unlock, and returns IRQ_HANDLED.

> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index bfdc155c128da..d8323d6b52869 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1210,16 +1210,26 @@ static irqreturn_t qcom_geni_serial_isr(int isr, =
void *dev)
>  	struct tty_port *tport =3D &uport->state->port;
>  	struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> =20
> -	if (uport->suspended)
> -		return IRQ_NONE;
> -
>  	uart_port_lock(uport);
> =20
> +	m_irq_status =3D readl(uport->membase + SE_GENI_M_IRQ_STATUS);
>  	s_irq_status =3D readl(uport->membase + SE_GENI_S_IRQ_STATUS);
> +	dma_tx_status =3D readl(uport->membase + SE_DMA_TX_IRQ_STAT);
>  	dma_rx_status =3D readl(uport->membase + SE_DMA_RX_IRQ_STAT);
> +	geni_status =3D readl(uport->membase + SE_GENI_STATUS);
> +	dma =3D readl(uport->membase + SE_GENI_DMA_MODE_EN);
> +	m_irq_en =3D readl(uport->membase + SE_GENI_M_IRQ_EN);
> +	writel(m_irq_status, uport->membase + SE_GENI_M_IRQ_CLEAR);
>  	writel(s_irq_status, uport->membase + SE_GENI_S_IRQ_CLEAR);
> +	writel(dma_tx_status, uport->membase + SE_DMA_TX_IRQ_CLR);
>  	writel(dma_rx_status, uport->membase + SE_DMA_RX_IRQ_CLR);
> =20
> +	trace_geni_serial_irq(uport->dev, m_irq_status, s_irq_status,
> +			      dma_tx_status, dma_rx_status);
> +
> +	if (uport->suspended)
> +		goto out_unlock;

[Severity: High]
Can this cause a hardirq storm and CPU livelock during system suspend on
FIFO-mode UART ports?

In drivers/tty/serial/serial_core.c:uart_suspend_port(), uport->suspended is
set with local interrupts enabled and without holding uport->lock before
acquiring the port lock to stop TX and RX:

drivers/tty/serial/serial_core.c:uart_suspend_port() {
	uport->suspended =3D 1;

	if (tty_port_initialized(port)) {
		...
		scoped_guard(uart_port_lock_irq, uport) {
			ops->stop_tx(uport);
			...
			ops->stop_rx(uport);
		}
}

If a FIFO watermark interrupt (M_TX_FIFO_WATERMARK_EN or
S_RX_FIFO_WATERMARK_EN) fires in that window before uart_port_lock_irq() is
reached, the watermark interrupts are still enabled in SE_GENI_M_IRQ_EN and
SE_GENI_S_IRQ_EN.

As noted in drivers/tty/serial/qcom_geni_serial.c:
qcom_geni_serial_handle_tx_fifo(), the GENI FIFO watermark interrupts are
level-triggered and latched in hardware:

	/*
	 * The tx fifo watermark is level triggered and latched. Though we had
	 * cleared it in qcom_geni_serial_isr it will have already reasserted
	 * so we must clear it again here after our writes.
	 */
	writel(M_TX_FIFO_WATERMARK_EN,
			uport->membase + SE_GENI_M_IRQ_CLEAR);

When qcom_geni_serial_isr() writes SE_GENI_M_IRQ_CLEAR and
SE_GENI_S_IRQ_CLEAR and immediately jumps to out_unlock without servicing t=
he
FIFOs, clearing SE_GENI_TX_WATERMARK_REG, or masking the watermark bits in
SE_GENI_M_IRQ_EN and SE_GENI_S_IRQ_EN, the status bit immediately re-latches
while the FIFO level still satisfies the watermark threshold. Because
qcom_geni_serial_isr() returns IRQ_HANDLED, won't the CPU immediately
re-enter the ISR on IRQ exit and starve uart_suspend_port() before it can
call ops->stop_tx() and ops->stop_rx()?

[Severity: Medium]
What happens on DMA-mode UART ports if a TX or RX DMA completion interrupt
fires in this same suspend window after uport->suspended is set and before
ops->stop_tx() and ops->stop_rx() acquire uport->lock?

In drivers/tty/serial/qcom_geni_serial.c:qcom_geni_serial_isr(), clearing
SE_DMA_TX_IRQ_CLR and SE_DMA_RX_IRQ_CLR and jumping to out_unlock skips
qcom_geni_serial_handle_tx_dma() and qcom_geni_serial_handle_rx_dma().

For TX DMA, qcom_geni_serial_handle_tx_dma() normally advances the xmit FIFO
and clears port->tx_dma_addr upon TX_DMA_DONE:

drivers/tty/serial/qcom_geni_serial.c:qcom_geni_serial_handle_tx_dma() {
	...
	if (!tx_dma_stale && fifo_len >=3D port->tx_remaining)
		uart_xmit_advance(uport, port->tx_remaining);

	geni_se_tx_dma_unprep(&port->se, port->tx_dma_addr, port->tx_remaining);
	port->tx_dma_addr =3D 0;
	port->tx_remaining =3D 0;
	port->tx_dma_stale =3D false;
}

When TX_DMA_DONE is cleared without running qcom_geni_serial_handle_tx_dma(=
),
port->tx_dma_addr remains non-zero. Later in suspend,
qcom_geni_serial_stop_tx_dma() resets the TX DMA FSM and unmaps
port->tx_dma_addr without advancing tport->xmit_fifo, which will cause
uart_resume_port() -> qcom_geni_serial_start_tx_dma() to re-transmit the
already-sent port->tx_remaining bytes.

Similarly, for RX DMA, clearing RX_EOT or RX_DMA_DONE in SE_DMA_RX_IRQ_CLR
without calling qcom_geni_serial_handle_rx_dma() drops the received buffer
and skips re-arming RX DMA via geni_se_rx_init_dma() while S_GENI_CMD_ACTIVE
remains asserted. When qcom_geni_serial_stop_rx_dma() then runs:

drivers/tty/serial/qcom_geni_serial.c:qcom_geni_serial_stop_rx_dma() {
	...
	if (!qcom_geni_serial_secondary_active(uport))
		return;

	geni_se_cancel_s_cmd(&port->se);
	done =3D qcom_geni_serial_poll_bit(uport, SE_DMA_RX_IRQ_STAT,
			RX_EOT, true);
}

won't polling SE_DMA_RX_IRQ_STAT for RX_EOT busy-wait with interrupts
disabled until poll_timeout_us expires before falling back to an RX abort a=
nd
FSM reset?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-ack-interr=
upts-on-suspended-port-v1-1-2747a58ca7cb@oss.qualcomm.com?part=3D1
