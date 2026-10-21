Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585143;
	b=u1ivo4hNhrD8AKzSkpNpLxOtl38/crUT58Gfjw0RaNOn4Mn3XtuK7dJ27eldiFflW8Pf
	 Gk+JtZoQFA6ngPF254y3eOolKnKzQ0ZRB1OsgtDKyvt0ksZJ/9CcWIUzqG2fbmZjgkLEQ
	 y6qFfYX7TZUG48bR5G6WR6EDtp4CPVknql5tcEFp4pf/sLDg6CA99nDnBTvZyWlI6eEGL
	 y/jNAA5bmBquGSHLvQy+x6Neh/RZg3SbYQ499YasgrGXT8Il/lk6fsI3XdviQlgk3pQZ/
	 iK/OmeMPV+Pq3XUu22rsdAVqiYMjWMVSCnzK2MQuewWDfD5EsWi4OBLQUni0pAb4HIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585143;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=frBNHnaShBpKBfGt5CfA9NjARSyc3ANb0Toqoc8qco8=;
	b=zW3flvTrzVsuKtUszmdKHSMhTGSpGTrKj1WL1gQG/fR6XDnri5zNFNF21zwbHSsP+13K
	 9gOkiBEODJ4L00kHXxNmsELsl3b/pTdw/RkBEboyC9pnU8eZJ0aRC4XsIpa9y/4HnvO2Y
	 3Tjq59YTB6OopB9/AZxLyKBX8sGx6LFqOcuLuScO0igBiDeWAZjj4DhEPamiXCTQPIJFT
	 imgzyyPItM9UyZ2MNrD88CyMIArKx9DdclQPG1KZqY8ajjr9wgOyUgAcBEQ6T/uvMAGol
	 NUXPrfEHZg8AqkVHzqrPO9ixHo54K3d+CLBoHOlWz6yRjjiG4+bdhQl/sNj2WOFBa1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b="kgn7ca//";
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BE0606A31E
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 12:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9BE0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=kgn7ca//
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A5DC7A012B;
	Wed, 21 Oct 2026 14:19:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792585140; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=frBNHnaShBpKBfGt5CfA9NjARSyc3ANb0Toqoc8qco8=;
	b=kgn7ca//hKhEcLiABnVUHqmt9qy3ycBfsf6Svzt5Y7r0YRMvCPcm8hLDdY4l00dxENcKiV
	o5sladjqHUa8dYT2lXxBx8DkVyL2AxdcWg6RkYOWd+HN4ca0VvYWr0mnFUxQeSbt6TYNcr
	C6ICUQf4hLD7/g1nGIkjAJ6wBl44BYv0DtvGxk0Xw8KUT+GC/CCwosObwnaWwzK4bVC7Uu
	a2aRE7I1FrInz9mBRWARVAU04isGia8gZvhXcbN3mcb3zQsPAEm9OkX1nObYBKT+6Fxowi
	+hus2Ge96fapJhJRVsnXKa9/nDFiiv/C0K3dIYX+k6Tl6F4oiQsHtnge8wy0yg==
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 14:19:00 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 2/2] serial: amba-pl011: keep RS485 transmission
 running on reconfiguration
In-Reply-To: <sashiko-outbox-180213@kernel.org>
References: <20261021-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-0-ed10e219159a@tipi-net.de>
 <20261021-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-2-ed10e219159a@tipi-net.de>
 <sashiko-outbox-180213@kernel.org>
Message-ID: <a61f86ea6bec868c75753e3ddc1ff242@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 21.10.2026 14:12, sashiko-bot@kernel.org wrote:

> [...]

> [Severity: Medium]
> During a TIOCSRS485 ioctl, uart_set_rs485_config() invokes
> port->rs485_config() before assigning the new configuration to 
> port->rs485:
> 
> drivers/tty/serial/serial_core.c:uart_set_rs485_config() {
> 	...
> 	scoped_guard(uart_port_lock_irqsave, port) {
> 		ret = port->rs485_config(port, &tty->termios, &rs485);
> 		if (!ret) {
> 			port->rs485 = rs485;
> 	...
> }
> 
> In drivers/tty/serial/amba-pl011.c, pl011_rs485_config() calls
> pl011_rs485_tx_stop() -> pl011_rs485_tx_stop_now(), which reads
> port->rs485.flags rather than the new rs485->flags:
> 
> drivers/tty/serial/amba-pl011.c:pl011_rs485_tx_stop_now() {
> 	...
> 	if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
> 		cr &= ~UART011_CR_RTS;
> 	else
> 		cr |= UART011_CR_RTS;
> 	...
> }
> 
> Doesn't this cause three regressions when configuring RS485 via 
> TIOCSRS485?
> 
> First, when RS485 is already enabled and idle (uap->rs485_tx_state == 
> OFF)
> and userspace changes SER_RS485_RTS_AFTER_SEND, 
> pl011_rs485_tx_stop_now()
> programs UART011_CR_RTS using the old port->rs485.flags instead of the 
> new
> rs485->flags.
> 
> Second, because the else-if condition in pl011_rs485_config() checks
> port->rs485.flags & SER_RS485_ENABLED instead of
> rs485->flags & SER_RS485_ENABLED, newly enabling RS485 on an open, idle 
> port
> (where pl011_tx_active(uap) is false and pl011_tx_empty(port) is true) 
> skips
> both pl011_rs485_tx_resume() and pl011_rs485_tx_stop(), leaving
> UART011_CR_TXE enabled and UART011_CR_RTS at its previous non-RS485 
> level.
> 
> Third, when RS485 is reconfigured while a transmission or break is 
> active
> (uap->rs485_tx_state != OFF), all branches in pl011_rs485_config() are
> skipped, so changes to SER_RS485_RTS_ON_SEND or SER_RS485_RX_DURING_TX 
> in
> rs485->flags are not applied to REG_CR for the ongoing transmission.
> 
> Should pl011_rs485_config() check rs485->flags & SER_RS485_ENABLED and 
> apply
> the new rs485->flags when setting the idle or active REG_CR state?

All three predate this series, the branch read port->rs485 the same way 
before.
The cover letter lists them as left for the RS485 rework, which fixes 
them by
applying the new settings in pl011_rs485_config().

IMHO that's too big for these stable fixes.

Thanks,
Nicolai
