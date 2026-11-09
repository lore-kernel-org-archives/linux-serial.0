Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794235485;
	b=pNuGQYx+BE44SxpA68csQLChFEDPwdf6bu9TqKs+qRiQJ1jdLI7iRb3+9ptb9kjAxthq
	 JZXKt3Q16QBsmJkbob37P+PBn3sUgg9m0K/DxmhVBbs+bCQ+A+y61s90EdvRZ0jjvQ0Md
	 M6nJtZFwkn3ByTbZrL5o1K3E/bJ/dU+Z89UEzj+HykVSAHQM47G3KREjM86LRjLVJgywO
	 8AQKtcZmfiQfk6zHqOUkr06/7RNRt5D2dP1vlrOmMiWFRSdVcL11L9QW9cN02YexV3SM8
	 5Y7bdw4Hi40wFpSMUVyO2NMkil557lBmfqDnbpEBa2u6nwOofOOOHUT0vqQehk013sQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235485;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AKdT6PBhwwgO3uVwYjRcHd7Do76RgrQ21RM3FwKVSII=;
	b=BvOWnWWlg7qpfsil1YBhCqhxEfuy459GtYcvH6FRIYa1l8tBckjRU6NXTSq0JhOfq6pb
	 3nZWJxJ4LbhXelJWtZupstt1ZXcXK53bs1lssVZRLyrCGJG7fUs0AQXNVsT6jizmINxj2
	 s0KLkXGtRV1MGTp8R1554nVD1u1m9HDclF229A3rdutbgwwEwgZdDj63c8QTT8XpY64NG
	 Ngv1LASZfODY994/7zDMvY7ZOwjNH/MuO9aj5IkOKZesaobikLEu1s4m/H5HXanIPIw6h
	 Cf/RJDbv50M+iQgqBV62HWTkeSm488hCXl1hDZKWmgTxpZ4kl7zlysvlIJEDWr0n4aQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLkNmxdq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B73606A31C;
	Mon,  9 Nov 2026 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLkNmxdq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794235484;
	b=cVTSP+B6qvFTuEX+LPOkwCD/oWaJRE/hVTwT5/aEf939IiLoirpLEICdy0V4juPT8mN9
	 lmshGPrxZTZY01G3Fx+YangVw0+V8Izc8/izb3vM/iiWT1nTJSL3fXwqhLS0vdNpwRqE+
	 a9S2OEDBPURrFMspFSWXJLd6PDEgIzkaQ1PTSpHrotdLNmKGUnbxzDxd095P3j0sCtCkf
	 dUF8hGwFPWl0ylTG9bP6UbexKs/dNJlruSvi6n+sswkYhJZaKKIgTkg2DPaHdaDOgmLMp
	 Vnuw25xKb4S/jgczdcTkC1RtHKC+n93kNVuDOhVFkGHJeQN28HYLX83uDesImJKxXgQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794235484;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AKdT6PBhwwgO3uVwYjRcHd7Do76RgrQ21RM3FwKVSII=;
	b=yco4Qqyu7UsNJJ+DHKquk7IkMxpSK0JOXpMkB9n8QKhHDUjJQJZtvjiQMB30CIlM0pR7
	 CFi9W1haAgVDVoC9qloyqkztl+QUYHWsrv8qd9cV2xys1rsJGhwyHz8kxb/1ITY/k62MC
	 HjwTOJw687c9D8KW+3pDYyIcyfPZC3QxeXn9AWbDj5dUS3DjwZ2OX31ecwwc40xRjfYb+
	 befvhXkYoumd3xde4meRzxF6QxUdEoJ4F28clFqAHlhLAbtImcIZx+Y/B35JDmdrW5mII
	 cmtZcoMZhYwJAnwhix4hRJCqUDBeykZ/Pe+9R2UI9JJ9pu9tWAgEhmQfcMqPYCCO+dA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D89C71F0089F;
	Mon,  9 Nov 2026 14:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235484;
	bh=AKdT6PBhwwgO3uVwYjRcHd7Do76RgrQ21RM3FwKVSII=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=eLkNmxdqajHiQvMguKF+V5/x3eoq8mklbeBk9imxmRJLChaMKdqTIt32c+ttnT+Va
	 2unB2DFgkO/H6JI+WSQAR9Px1L6FeYH48G1SvdtzSJCWwWwbYL2gLHPJz3m8/s/TKb
	 cInu4xVJofbyyNdU9yCHbq/PTdg5Qjo0csKjsawPtsMcQ20Zw9SFV4tV5tSGfFzhQQ
	 UZJqu2k8hgG/AyBrpFVePOsQxePhHNg6DjHz37z0TLZq5lFVI1t/0e7SE2rcUaMlEN
	 WboeZt+F+UXQ8sDBYr9KQpx8uZE87Gpc3apg5Fb0YXNhw9jM/vv8A+BMdfZPiFTo2M
	 c8aszJfqrntUg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 49363484FA;
	Mon,  9 Nov 2026 14:44:43 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Mon, 09 Nov 2026 15:40:59 +0100
Subject: [PATCH 1/2] serial: 8250: Add RX trigger levels for U6_16550A
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-8250-select-u6-64bit-v1-1-04bc8332fa34@gmail.com>
References: <20261109-8250-select-u6-64bit-v1-0-04bc8332fa34@gmail.com>
In-Reply-To: <20261109-8250-select-u6-64bit-v1-0-04bc8332fa34@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>, 
 Miroslav Ondra <ondra@faster.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794235482; l=1531;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=E2kYgvRVI0V5zzIOIvpSYf52Ap3eD6IiSUx3X0nJA5k=;
 b=jsgvGiHnVICw6dgfxc/096xFpMKcmxhqMsvH9BwAP3EVWtbpO5GUy+crvHVGKALOOIYISpI9w
 hq3zVeDbMF4CkXIGBTXJcdjmPkBQtjxz4/02QofLJS/6QYbDfkcwUuJ
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=EJoEbw03UiRORQuCiEyNA8gH1Q6fIpEWnn/MyaWOWX0=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20241112 with
 auth_id=275
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com
Content-Transfer-Encoding: 8bit

From: Kryštof Černý <cleverline1mc@gmail.com>

PORT_U6_16550A has a 64-byte FIFO but no rxtrig_bytes table, so the
rx_trig_bytes sysfs attribute is not registered for ports of this type
and the RX trigger level cannot be read or changed from userspace.

Add a table with 1, 16, 32 and 62 bytes, i.e. 1 character, FIFO 1/4
full, FIFO 1/2 full and FIFO 2 less than full. These are the levels the
Synopsys DesignWare UART uses for a 64-byte FIFO, and they match the
existing PORT_ALTR_16550_F64 table.

The default FCR value of the type is unchanged, so the trigger level a
port starts with stays at 1/2 full. The only visible change for ports
already detected as U6_16550A by autoconfig is the new sysfs attribute.

This prepares for 8250_dw selecting PORT_U6_16550A for DesignWare UARTs
with a 64-byte FIFO.

Co-developed-by: Miroslav Ondra <ondra@faster.cz>
Signed-off-by: Miroslav Ondra <ondra@faster.cz>
Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
 drivers/tty/serial/8250/8250_port.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 36b2b0a2c05c..a7acede62f40 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -163,6 +163,7 @@ static const struct serial8250_config uart_config[] = {
 		.fifo_size	= 64,
 		.tx_loadsz	= 64,
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
+		.rxtrig_bytes	= {1, 16, 32, 62},
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
 	},
 	[PORT_TEGRA] = {

-- 
2.47.3


