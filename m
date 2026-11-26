Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735940;
	b=X385aOS6KC/n9ROdrTOCz0zF+kuerxk9vLYk5hpG3ZydhtVeGnwrJa32pziyHlunbooz
	 lE9NqWFwGUIca4hnSItE2KkpgLn6en+J9WWj+vV72uiy29adM9dRznX/A1tgFZyGi9KcK
	 tIFOhjagmVD8mWSDgCyKP4g9bjjK4f+itDI2Kbc70gg/n9b3vfP15e/MXkzXyxHR9oywU
	 fRf3Z2wxFT7ZeM8ueMcm/q/1U9s9GSFHy23efbW28cDa/DmvgTe2uM46y79sMDw0HMN1X
	 Qr56PET62lvOyp/K9afwMNDGwskznFtBkVsb3lYCweHSN3sxdoPP3MUXfjzh19AC+mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735940;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JW+TPR9AnXVCxUHwDPBwGu4R1MleZfoNPK9S3UNxJvw=;
	b=E8rhFw9NBci3vlAI9fhRBvnaCfRgEZQjZqitj/EX2qpB96ih0f6wXtdfatyLSNpaFO8j
	 39WY4FgEnXtMgn6BI3hEYq0+p8PEHv7GcH6EeJUcv8F7mHh3/HsxjzWs1Z2Rh+WbfBBVB
	 A1H9/NZB0HL26N3Yw/hCNemWdRN4kY6h07YL8toFdXqKSOS1Oh5+BvU5rmSRrcaZoeF/S
	 vXGmc2lo1Hmg2n5GK9Jw3fC4/8VE2/L0umJhw1js+B/5i4gI3A1/iMpNsTn4uFNcjSXfh
	 rC0F5aSy9bAM1kR0fRTCSA/QGVnEIny+KEiKoJ+LJ/7n8CRHVYydbiu1gboXlwAk+eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GG049K0o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9781606A31C;
	Thu, 26 Nov 2026 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GG049K0o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70C61F000C1;
	Thu, 26 Nov 2026 23:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795735939;
	bh=JW+TPR9AnXVCxUHwDPBwGu4R1MleZfoNPK9S3UNxJvw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GG049K0o97TGoDWCOJFUB/m3pg3vUilt3eLEk0PE88+JrsIKriHQTqb75tZLvEAOE
	 0VD7s27g4OXFBCH2EyLnv0MJIKEHyl2KlxI+JahvkaFa+j+nuFOGDMhIZMk26jFbad
	 9Ee+Mqh5xKFLoTIyyg9RRPD+Lf10M4HgMbIBqFs5Ugx9iw4hPNNVXw1a6yatOp2vZn
	 7uQK9OOCha466anzqkOXww1QFJLOdVd8iuYJG2RS/66+oS3WdRxvBiyXf5FWfajDhF
	 ZrKvfkV1ZByWxoHN24/dbBbzvuyWO+CBmLnsekt4u8moSkz3dJ690lGs3k31DIUHot
	 iaUUqHfYbjBlA==
Message-ID: <sashiko-outbox-236334@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 12/19] serial: esp32: Rearm TX interrupts when the
 FIFO is full
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VsOtdG9yIEh1Z28gU2lsdmE=?= <vitorhg20080@gmail.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261125233020.1380594-13-vitorhg20080@gmail.com>
References: <20261125233020.1380594-1-vitorhg20080@gmail.com>
 <20261125233020.1380594-13-vitorhg20080@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 23:32:18 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] serial: esp32: TX IRQ storm in esp32_uart_transmit_buffer()
  after x_char
--

commit dad4b1d831af0fbc408461f76bacc91b367f0e67
Author: V=C3=ADtor Hugo Silva <vitorhg20080@gmail.com>

serial: esp32: Rearm TX interrupts when the FIFO is full

This commit rearms the TX FIFO empty interrupt in
esp32_uart_transmit_buffer() whenever data or x_char is waiting to be sent
even if the TX FIFO is full, and acquires the port lock in
esp32_uart_txint().

> diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/tty/serial/esp32_u=
art.c
> index 304e1345518bd..002d6fdbd875f 100644
> --- a/drivers/tty/serial/esp32_uart.c
> +++ b/drivers/tty/serial/esp32_uart.c
> @@ -354,14 +354,14 @@ static void esp32_uart_transmit_buffer(struct uart_=
port *port)
>  	unsigned int pending;
>  	u8 ch;
> =20
> -	if (tx_fifo_used >=3D ESP32_UART_TX_FIFO_SIZE)
> -		return;
> -
> +	tx_fifo_used =3D min_t(u32, tx_fifo_used, ESP32_UART_TX_FIFO_SIZE);
>  	pending =3D uart_port_tx_limited(port, ch,
>  				       ESP32_UART_TX_FIFO_SIZE - tx_fifo_used,
>  				       true, esp32_uart_put_char(port, ch),
>  				       ({}));
> -	if (pending) {
> +
> +	/* Rearm TX even if the FIFO had no room for queued data. */
> +	if (port->x_char || (pending && !uart_tx_stopped(port))) {
>  		u32 int_ena;
> =20
>  		int_ena =3D esp32_uart_read(port, UART_INT_ENA_REG);

[Severity: Medium]
Can this cause a UART_TXFIFO_EMPTY_INT interrupt storm after a deferred
port->x_char is sent while TX flow is stopped?

If uart_send_xchar() runs when the hardware TX FIFO is full,
uart_tx_stopped(port) is true, and xmit_fifo is non-empty (pending > 0),
uart_port_tx_limited() runs with count =3D=3D 0 and leaves port->x_char set=
, so
this check enables UART_TXFIFO_EMPTY_INT.

When the FIFO drains below the empty threshold, esp32_uart_txint() calls
uart_port_tx_limited(), which transmits port->x_char, clears port->x_char
to 0, and breaks out of its loop because uart_tx_stopped(port) is true.
Because pending > 0, __uart_port_tx() does not call port->ops->stop_tx():

include/linux/serial_core.h:__uart_port_tx() {
    ...
	pending =3D kfifo_len(&__tport->xmit_fifo);
	if (pending < WAKEUP_CHARS) {
		uart_write_wakeup(__port);

		if (!((flags) & UART_TX_NOSTOP) && pending =3D=3D 0)
			__port->ops->stop_tx(__port);
	}
    ...
}

Back in esp32_uart_transmit_buffer(), port->x_char is now 0 and
uart_tx_stopped(port) is true, so nothing disables UART_TXFIFO_EMPTY_INT.
Once that x_char shifts out, UART_TXFIFO_EMPTY_INT fires continuously in a
hardirq storm until TX flow resumes or the port is shut down.  Adding an
else branch that calls esp32_uart_stop_tx(port) would ensure the interrupt
is disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125233020.1380=
594-1-vitorhg20080@gmail.com?part=3D12
