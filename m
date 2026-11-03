Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793664700;
	b=HT3Cg8FnJJ4xMY7D53nid/WGwAmGkOzK28RZThSslhMq1IitT0cmLBMcN7Zs8E5MFmo2
	 +++ALa+jhTkTIhbfZAZEVvkXmJ/a7eV9LJ53+xS/qWatW+50BdT5VWV/rQoQwcTOJ383K
	 GV3MHP0tYQKbGP5FkTvuSs+fx5QLiAnWrXXoHuKFBBPbNXLG1WRT9iLkBKAoGJ8DdOr+g
	 IupIzp03Uzf78VxhJzZTR6uws10hz7i8p8TEPotQbqPmDqVbwgyj/HM4KL2zyPOcl2GCQ
	 8OActFjkuAJQ8L6+k3r2DYbR23+JybSgWMVcdNFJmvi+g1SQ+LsPMigebwymFz85jig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664700;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IiWBWsYR5E7muXgvdHXi9q+MaBzNdnhsukAFteSamOg=;
	b=HgHiTikVQLoTlv/zWxWHMEob7tn56BJBo4RJDO0JeNmXSMeyd6V7BlJ+gFrSAVthHwMm
	 xjwxOMxaHRDXrNRs+wyEcCxXDrCDOi0Ia6MHLVCHTf3pkk3likEVs+/TcB7TaMjFwnPIu
	 YVegvwlP2ngrQYk3mDhtj28eq061kQLIugBIzEWbt5cL8Clu869hUdUh/Tp4zbB0Ksaie
	 pDrzEBIR7/3R5nvOP/CWWSixSlTPoskaXjZeQsaeyiiQm3GGjZ8U4ILWWXssm435APQpJ
	 UxCc+JrVA7rUQZwqBEwAvgeaTK1aBuv+ku3fvfSpNFUIcHE4IgXBLjoe7iJ8XzqSrTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRL0bWxP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCAF606A327;
	Tue,  3 Nov 2026 00:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRL0bWxP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793664699;
	b=b3+J4c4QFbZi8X5vK/9yjvfyu9LfxXmWWBCkyinZXIk2cLIfSA+O4b5bxYBrunX3pBtr
	 jAgPfs/0E4yeJHQnHkuNMttF+SV/o7tqCpM+sKHGpngwG9dEWk9/+hKhsIyHJlIC08169
	 NQ4tkAOJSkZgpeZHPOk4UTIZVKuEWMml63JSc3Tmbv7uBhEbK0R/89psEYjJW/4RW7W7I
	 lF++O2VPwyEHtxDcUqqeSH8YyF9HOgyTG04w/qeaQse+NJ3yKipKEn7XsYYfI8jlyiSqn
	 Aou4xFewTgcLmZ72ysIjC7J2yFaBaGneac1XztVdfO9FtYO0rVtm3xyfi6wX9Hed/2A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793664699;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IiWBWsYR5E7muXgvdHXi9q+MaBzNdnhsukAFteSamOg=;
	b=Fw6wgFQtgHzH9tPjiP9dEUyKJgYhtilCGV3Efv7Ce6JJoqoJyj6mDe3Wyukj0NWejEya
	 Xh21BLwbzCRL7/AVZpcdMXiYie6k4kArKt02rsTxwPpmUsMlL3g72jMfmaOOiGqiJ52e/
	 i66OrZMwiXEPha3NvL/UVrhgmjHVQe0wMlUcfu26AByorkd3YufOyfpqaoWeJTxr9EayG
	 mxvZUL/G0SYlLwB31iFqGeI+SaKnnOZ8n/DCk2C1NL2wOsy2LDaWg9KfiPX4WPzghNx+P
	 EmkJ7EqTLav5q0ssIHDI86sH0dG+ZA5Jhm0wrkuIgP2q0GZtk57hlNt0oJzPCIcwf5A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8CB2D1F0093A;
	Tue,  3 Nov 2026 00:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793664699;
	bh=IiWBWsYR5E7muXgvdHXi9q+MaBzNdnhsukAFteSamOg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=JRL0bWxPCr3zqnNj6e0VPffaaZNS98ifTSwyedxpVREUiRUY4Cxkh91/RXhAOHI28
	 Eg8RRE3OPiiJICUFgK9mKzA6kLy1KvDX9KcxH9PZd6BXw0oAGLiq+qZtkm2E5DN7Jy
	 virHjkcXVjEMZXHfxWU+Eb5Hb+RivMJ0l/wBrVqvltvwFUtXpWwI8yLZd81fr6J2AO
	 gnIzbsqs8vSNXgJTnK5uYMvu1AG16C3RwysC0LRAvfHxL8B1UhHIA9rwL0QPBiA1C5
	 cvacgxPx/msHIN50yC0mW6b2AEeBzsBHuK2A81DAiAwbcjv0yLxwSeZHUldU0FXU0D
	 cxaWV1FimeMGw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2009846707;
	Tue,  3 Nov 2026 00:11:38 +0000 (UTC)
From: Kohei Otsuka via B4 Relay <devnull+kohei.spacemachines.com@kernel.org>
Date: Tue, 03 Nov 2026 11:11:32 +1100
Subject: [PATCH 2/2] serial: 8250_of: drop RS-485 RTS on Microchip
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
Message-Id: <20261103-core16550-rs485-v1-2-6d15ebe1e5b9@spacemachines.com>
References: <20261103-core16550-rs485-v1-0-6d15ebe1e5b9@spacemachines.com>
In-Reply-To: <20261103-core16550-rs485-v1-0-6d15ebe1e5b9@spacemachines.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 conor.dooley@microchip.com, Kohei Otsuka <kohei@spacemachines.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793664697; l=2108;
 i=kohei@spacemachines.com; s=20261103; h=from:subject:message-id;
 bh=pUGC6KsYj2Vq9mX7f4htRLLVNc2OLm78QJDAJj/EEIw=;
 b=SOZsHbxjVHhtvOAxWm/5ie1jSZyqibBbtTO8KauS4N9ybYX3pM37QIw+++Brrh6+jV03PUFPq
 jPXmi+ScU6UDUhEIw6LlcdnBBE4Jq5kG2U77ux8j07NF8zRfODtsvzA
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

Set UART_CAP_NOTEMT for nodes compatible with "microchip,core16550",
so em485 drops RTS from its stop timer one frame time (plus 1/7) after
THRE, as it does for DesignWare UARTs.

Set UART_CAP_FIFO as well: with the capabilities already non-zero,
serial8250_do_startup() no longer fills in the PORT_16550A default,
and without UART_CAP_FIFO serial8250_clear_fifos() does nothing, so
the RX FIFO is not flushed at the end of a half-duplex transmission.

Link: https://github.com/linux4microchip/meta-mchp/issues/5
Signed-off-by: Kohei Otsuka <kohei@spacemachines.com>
---
 drivers/tty/serial/8250/8250_of.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index b41ca604083f..2f1f505501a2 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -278,6 +278,15 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 	if (port8250.port.fifosize)
 		port8250.capabilities = UART_CAP_FIFO;
 
+	/*
+	 * Core16550 has no TEMT interrupt: without UART_CAP_NOTEMT the em485
+	 * code waits for one after the last THRE interrupt and never drops RTS.
+	 * Set UART_CAP_FIFO too, because a non-zero value stops
+	 * serial8250_do_startup() filling in the PORT_16550A default.
+	 */
+	if (of_device_is_compatible(ofdev->dev.of_node, "microchip,core16550"))
+		port8250.capabilities |= UART_CAP_FIFO | UART_CAP_NOTEMT;
+
 	/* Check for TX FIFO threshold & set tx_loadsz */
 	if ((of_property_read_u32(ofdev->dev.of_node, "tx-threshold",
 				  &tx_threshold) == 0) &&

-- 
2.53.0


