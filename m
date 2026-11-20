Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160502;
	b=cG0WNEEdiyMsZOa5p+fnEgE7JrOTsGlgNQMuB/k8t09o/i/XDpHjJxtFTbacxOcWfR7Z
	 yl2MyorFBkLKH1/JAJ1W7hmujVhD/PTV+UGGUy1Q4/WboIh6QqpwLAA9CH1bWdqlqTjnd
	 omqaunO8j+mF3/r2PD0rrkv+qLMo9LVgb+wO6/YXagjLeKK+RLuLLaWH5FMJ/Jvjyb73N
	 jVtjSCN6ImPMLDQ/W80FfdsOb2yP1B8FD4cGJkR4NR3p1SvRBaEwklKQfkjb47FPZs0+1
	 m7GMMAEKjAXp4b1/sMIiRgNUE0xS5dvXJJz6BX3ssxfH+trNgjLDf2MN8w4nHe7WiHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160502;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KX53g1pTPx98BMSqCX2tj3H81PAr6auAN08B+m9nouc=;
	b=4UylfSXxvNEY6c4/2xGvM31aAHi5S7GuyJrJ6Qn9ftEl2V8Hc6qJhsPZYsW4y3sv2fUW
	 xSOu1WbtIKNK13UPXeh7pQCdkoWxCIVfOdaeZADL9FDueYNwhgMzLq+ST38HyvNmKatt1
	 TXnCKAU7TEDmAK8tc7ghgp6Do0qrU9noqSgV1bR4OrW0MjNnz+n3NenaIQ/J9cvTu0nts
	 W3dLW4dL5Xr5zQAVE6a3Nr2v8bC4L37ePnqPo5/WtnHW2F/PCWSe3Sp5Usrl8QbB1kFBH
	 iAleZAa1ooAYhGf+ryk0nmpLq1yWfWniPr99OPyLFxfFd450Yjp21z9uju2R6E5KAeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eF8t8+lv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC206606A320
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eF8t8+lv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B1C1F000CA;
	Fri, 20 Nov 2026 07:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795160501;
	bh=KX53g1pTPx98BMSqCX2tj3H81PAr6auAN08B+m9nouc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eF8t8+lvokQfObraV7GlCNRlklqTN1CgIc2Ue6p/G28IvDFsKJlck2LhkRMsCOJgp
	 IxRztn74gTaKPQC9j+hVS2i5MWkANaNQDek7pkoC7qwjSgkWyF5JGBUh6/2d8W8iEb
	 7JKdyLsspOjBWtiaZEHKpR3HTwN9bMjMDSplMusoURgxmNatC16w1f/4Nz7XsQWSlG
	 yQDCbUEIF6gCZOrSBENw+PM5z2lWA9K56OmQnp2uNkC/jVbVW07/NNNwRE/mWjZdcz
	 T7Kqk9Nyq/9dAIwrb2CXljUxABwkhIwzIs5GUBpIj0R2pF5D/UDxhSUZPvMqsw9OC6
	 WF1DeKkfiLlag==
Message-ID: <sashiko-outbox-224646@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] serial: max310x: hold the port lock around the CTS
 change
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261120-max310x-teardown-fixes-v1-3-eb52c8b612df@vaisala.com>
References: <20261120-max310x-teardown-fixes-v1-0-eb52c8b612df@vaisala.com>
 <20261120-max310x-teardown-fixes-v1-3-eb52c8b612df@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 07:41:40 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] serial: max310x: lockless access to xmit_fifo in
  max310x_handle_tx() [1]
--

commit b6f9f6d1c6352edbe4d9493e77cb10be6d1f66a0
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

serial: max310x: hold the port lock around the CTS change

This commit acquires the UART port lock around uart_handle_cts_change() in
max310x_port_irq().

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 179f5f4cc7b2f..b2d887316957c 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -1043,7 +1043,8 @@ static irqreturn_t max310x_port_irq(struct max310x_=
port *s, int portno)
> =20
>  		if (ists & MAX310X_IRQ_CTS_BIT) {
>  			lsr =3D max310x_port_read(port, MAX310X_LSR_IRQSTS_REG);
> -			uart_handle_cts_change(port, lsr & MAX310X_LSR_CTS_BIT);
> +			scoped_guard(uart_port_lock_irqsave, port)
> +				uart_handle_cts_change(port, lsr & MAX310X_LSR_CTS_BIT);
>  		}
>  		if (rxlen)
>  			max310x_handle_rx(port, rxlen);

[Severity: High]
This problem wasn't introduced by this patch, but does max310x_handle_tx()
also race on tport->xmit_fifo and port->icount.tx without holding port->lock
[1]?

drivers/tty/serial/max310x.c:max310x_handle_tx() {
	...
	while (!kfifo_is_empty(&tport->xmit_fifo)) {
		...
		to_send =3D kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
		max310x_batch_write(port, tail, to_send);
		uart_xmit_advance(port, to_send);
	}

	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
		uart_write_wakeup(port);
}

Callers such as uart_write() modify tport->xmit_fifo under port->lock, while
the tx_work worker drains it and calls uart_xmit_advance() and
uart_write_wakeup() locklessly, which can corrupt the transmit FIFO state
and send garbage or drop characters.

[1] https://sashiko.dev/#/bug/linux-10a0ea86-42c1-439b-aa6f-385dd9c88f23

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-max310x-te=
ardown-fixes-v1-0-eb52c8b612df@vaisala.com?part=3D3
