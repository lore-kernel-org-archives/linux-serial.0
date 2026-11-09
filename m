Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794192909;
	b=ouDr1+walAUZw5JFWN/p1IJkI6MU1zt304HxcJSc52/mqY8dCaS2NIGkzidD7a22rxwT
	 eGi291sXtWfjWhFFJ15mb+AZXF6kGr1MjY9+RmP3m467RhLff0hkZ1PnCu0ei/Fl1t8UZ
	 5kGX2EGTTaRtoHN396dqk4aQeM5qTyfj8IZOsa8rmx0n4N0AXqyOm3v5b9PBPpxKbL4Ra
	 RuOEmkZ9vklWJeQ1lD299gHmQRjAItd6mspcUPLb0iu9l8Q7nm2SsXP5ZpW1g+O0PaJcp
	 ncrOpy/YEOlY9J1ZO3b/s6PRpuxN/Zw4Sn14VJCQUvH8bYHqMOVl2IWa1zEsHRamdAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192909;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=v0dZEvGHVJY0R9uWYe8/mOz/5B0p+NtTR15YHC7b/7E=;
	b=YQ/I7p+6TPHpsFMGvXEdW0hmsC2ObzHKujgFXioybx8ziVez33XX2iFBE2+AwkQ3uF6N
	 NOQAulIMhSUTtM7dFpNviF3RjNJR+6Tj6seyQKAFfDDQyLLd6wd8RgmKf3ax6Yj6VeAvY
	 7Kyhx/XEEWTkZe+NPkp/1HTw6qmyO99vbaoB4RUwoWq3EHTS2PrPidYxTd5jpSl63TUlU
	 jw/W1I+CJI4ssJnvNUgQ9KxbJPxss1qtFLPHmBGRxlxVpbjN+B3Cin6hEgFlOLDF5tDaX
	 I2y7gNsKBPiXg0wwuKixJs1F+KgS6HQ6nGK/1YjACURX5YHXPdpOTTb7HvWLTEbPhxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OFY3xNiF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20D9606A32A;
	Mon,  9 Nov 2026 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OFY3xNiF
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794192908;
	b=NVni0Q+Dg/0T5AQ+IorIMXr/VwFJsDCBVAzfJuVd+s146hCqUQKgAxfQ7gxI7je9sFjk
	 xFz/g+g+UjPWQ7qwVtBQjiFY7tlKR4tt6nUyARI3RgaUl+k0FOijUMmP3GpHyjyDTcMOX
	 Cd0SiQUzJDNKSr4ofNB1vMbaZcQqi0CeCjmjm3Dt3G3GOQ37v9PWFuLNtdkwPorQg/w5A
	 pCyPs1GNkD92R0RyZygVLCjgnBtGznuPjE1Sh8xn5s85lInhf3DemEElapYxI6sA2qGAv
	 x6Y0CsREUzeZ1ZVUUSw7GJbaD4OJ0Mba/fQ39oXct9ObQmPeQM36PC+FwDnCT4RCVeQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794192908;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=v0dZEvGHVJY0R9uWYe8/mOz/5B0p+NtTR15YHC7b/7E=;
	b=DOd0OCp1ROban3TLQFp1RdyHFXorMLOip99oERp5E6mnT7vJ4UYrQxxTIsNuhm1N3tD+
	 OhCa+TBQdVKMAI+YPJVgB4ztUF1UuAw4MneoS1CoFNJH+iANd6e2iBuAMUNd6TZo+yjHu
	 7+NovemF7VMmcMEPuOYsFQN29UaGPHDnX3sxvH2qCtJP+mAZUq1+uaUtf5smHpFpirdpj
	 eoiG9qWNAeeuJzcsL4ybqCJn5TAdP3TGnpQiUq0h+xOgak+1NHskh5eXcUPkkdmXE58rI
	 /khB7DKPzoV4Q89rTOChweKkG1UCWEU0Ib4h4PQv63lR03PoPnX2rS/rnOWIgFR1imA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 880091F008A2;
	Mon,  9 Nov 2026 02:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794192908;
	bh=v0dZEvGHVJY0R9uWYe8/mOz/5B0p+NtTR15YHC7b/7E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OFY3xNiFVpzUo7Hax9OsqusU4FRbHqcBufYXDb/rtFfwV8JFm8E/j78ENBSTO9zm7
	 3ToEXz8f19F3gRLIS/XDil5H3RmpEdokQyl91ZRlnq1e/WSaTz9AhJRdeUb4YNfLrt
	 TpKisNql9k8zHN61mbsLTGDEi3QLlY+SNsyQpZA20TU4DgrKWt4IkOEQoUbqci7aNb
	 wIpRWqLbEpzOEVqN5VEghnhse97knnErz7xVankIT7efgU/aWQBwMUTDd3ZRuTneQP
	 pRvoIgo8WIl96TYa4XuuYWq2EjuEfqFDr0FlzaggkB9zbotvAPVTZUeDumO4JyT5b5
	 rFo5QLe+p/g0w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 155EA48243;
	Mon,  9 Nov 2026 02:55:07 +0000 (UTC)
From: Kohei Otsuka via B4 Relay <devnull+kohei.spacemachines.com@kernel.org>
Date: Mon, 09 Nov 2026 13:55:06 +1100
Subject: [PATCH v2 2/2] serial: 8250_of: drop RS-485 RTS on Microchip
 Core16550
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
Message-Id: <20261109-core16550-rs485-v2-2-a15933c7b907@spacemachines.com>
References: <20261109-core16550-rs485-v2-0-a15933c7b907@spacemachines.com>
In-Reply-To: <20261109-core16550-rs485-v2-0-a15933c7b907@spacemachines.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 conor.dooley@microchip.com, Kohei Otsuka <kohei@spacemachines.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794192905; l=2135;
 i=kohei@spacemachines.com; s=20261103; h=from:subject:message-id;
 bh=zB2zzCjY5jGdBW3bz8SbL+SIiy1mkD1eN/4HcK9U8ig=;
 b=ikHWkWqXRfD6U4iTaFAtEZY2wJSVCDiHhxCGbkCs0FjWMkuRay/J+3i1gyFsThiAEzWWoDevG
 ZTYnB7S2hdYCfgm7NuIAq/SiYzTjpYUqggc+E3W/3EEnjZKWRiG6v6C
X-Developer-Key: i=kohei@spacemachines.com; a=ed25519;
 pk=1kit/vmX5JiLGH9NPcqlvT55ISWaLmNipdL5VrriRt0=
X-Endpoint-Received: by B4 Relay for kohei@spacemachines.com/20261103 with
 auth_id=1385
X-Original-From: Kohei Otsuka <kohei@spacemachines.com>
Reply-To: kohei@spacemachines.com
Content-Transfer-Encoding: 7bit

From: Kohei Otsuka <kohei@spacemachines.com>

Core16550, a 16550-compatible UART for Microchip FPGAs, interrupts on
THRE but not on TEMT. When the last character moves from the FIFO into
the shift register, the THRE interrupt calls __stop_tx(), which finds
TEMT clear and, without UART_CAP_NOTEMT, returns to wait for a TEMT
interrupt that never comes. RTS, and with it the RS-485 driver enable,
then stays asserted after the frame, and receive interrupts, disabled
for the half-duplex transmission, stay off.

Set UART_CAP_NOTEMT for nodes compatible with
"microchip,core16550-rtl-v3", so em485 drops RTS from its stop timer
one frame time (plus 1/7) after THRE, as it does for DesignWare UARTs.

Set UART_CAP_FIFO as well: with the capabilities already non-zero,
serial8250_do_startup() no longer fills in the PORT_16550A default,
and without UART_CAP_FIFO serial8250_clear_fifos() does nothing, so
the RX FIFO is not flushed at the end of a half-duplex transmission.

Link: https://github.com/linux4microchip/meta-mchp/issues/5
Signed-off-by: Kohei Otsuka <kohei@spacemachines.com>
---
 drivers/tty/serial/8250/8250_of.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index b41ca604083f..e23539b2fda3 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -278,6 +278,16 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 	if (port8250.port.fifosize)
 		port8250.capabilities = UART_CAP_FIFO;
 
+	/*
+	 * Core16550 has no TEMT interrupt: without UART_CAP_NOTEMT the em485
+	 * code waits for one after the last THRE interrupt and never drops RTS.
+	 * Set UART_CAP_FIFO too, because a non-zero value stops
+	 * serial8250_do_startup() filling in the PORT_16550A default.
+	 */
+	if (of_device_is_compatible(ofdev->dev.of_node,
+				    "microchip,core16550-rtl-v3"))
+		port8250.capabilities |= UART_CAP_FIFO | UART_CAP_NOTEMT;
+
 	/* Check for TX FIFO threshold & set tx_loadsz */
 	if ((of_property_read_u32(ofdev->dev.of_node, "tx-threshold",
 				  &tx_threshold) == 0) &&

-- 
2.53.0


