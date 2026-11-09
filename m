Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794262011;
	b=nQlqSXcImDk0keuKxxgxszNavKs3DqA7DWKJuNH+KDFfgerDQz041lR7xHJ4t8UfT1AU
	 VRezeLlqX/x8SbtfB2NnJWyLgHVuMQ8NBQlStVXcSRjV7+PtKWT9rW3e8cM+XQ7EXVsEc
	 2grUHbiSS5OU0fODfioUOfMg/g87v42J7ZZvesZsiKu2dQx9OIi+Asq3wT9Qdv2gRmYpY
	 p17UtVRC9CYYgb/HpBU+DKPscW5NGXgaWa68BT9AWbWRp4dIEJY3Ffkfo0OJLl7f1u32C
	 iAF5vXK5xHZyiOQPjfeWzkRU75iErE9YnxP2DixeP3XfcCqmbPYZJ8MTj5L9Y8M1ydA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262011;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Wegtyj5/0XsVp//nG3j7+eO99zr7IL8N5hkH4sjxGo0=;
	b=Y6akDeysnq2lYj4bABXzEX7dJEe6dH1zOHn4nNn4K4WW2t2c40yXHXS6iaaHYyxJ8buF
	 sqwGESlPZ2/DJzg+sPYZvQrM4sB1xXQwguDrc1lKG7JUrIkdWJwUy8XonbO8ucshvBXX/
	 fMn/utBvll/7siskQdLp5CMluyZjBF1ygKqb8bbaBnqnNqAYE1MPtFlHbPpEs7l6wu84Y
	 Xp+pu35myJ9yDuQXoRAEUOO2cDAqw9sQL1UVqqW21PRRLbWhlMdUOE3zm99TXY1PtrEph
	 cDKyiD8V3wk0Wex0ZDKIzpGN5S2itsSeHBrIzr/hI95pJmUexZfMksFgWsgKSDdmEUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGkXw5jW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C404606A31C;
	Mon,  9 Nov 2026 22:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGkXw5jW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794262011;
	b=ik8xgZ9OU8cNT7sXvTF1Fowiipi3WKAGVvj5cZpV8ng1HOBlO41JcazVFo3VT/TId1Je
	 avIFI0AdJJ8jdoeZadrK36/zfepo/ETqHrzvL6qHCFP4IEH9pAFiisb+7W16ANGlri1ql
	 m1l+Te9i+diQdmtn9vhp+fTz40Ww1BR0EAjDMz6nWE/YfE0bFtr+EBwB9X0SdCyfBRd/M
	 ljH5Vd/WkXN9LHJS4DbdwtgH6T4oBYV/PQKpzs6jUQfuYpUhlnhbm4MscISl8Ta2icpSr
	 C3bPoSKtu1DpfAc9D5/EvOr0v4i/63e4ZlvDmqaLsc50WcyLRXCnHaVHuUW7RiNu9ZQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794262011;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Wegtyj5/0XsVp//nG3j7+eO99zr7IL8N5hkH4sjxGo0=;
	b=Ohh7YeELuF5Q+kaW++LQhDYm0jw0Y6JufzIv4RLH0/tIhx+JUCG1HY3A/oNwVwD2F7ua
	 LuXdwrc81exGs4jgInJxqrnA8Pq1gTrJZU3BqCiOZwRX/hN0hZj9y5JuOeYZ/dD/BGbhE
	 etC6EHxa2bm6r201fxSRP/cvWyEKq31iFW9wtKCYm+5R1KoYQWTKr5d5ESbnbVM4akLJI
	 YMX98HaI+uaYFLwV9PjeG88EDsNckEhtpZxvA9gkB01k/G0FrBUdhilHJJ07NTRk0j4vW
	 YWB8wQPgxbz89ZHkZp2rz6WnZdqrFZ2YQ60OvhSK+ySU67bUwMNX/00dJeEfVXrtaFg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 04FCD1F008A2;
	Mon,  9 Nov 2026 22:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262011;
	bh=Wegtyj5/0XsVp//nG3j7+eO99zr7IL8N5hkH4sjxGo0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XGkXw5jWkMM8RKc1YV7ONRqZYpYukw+7lMFu3RBkPFcyQ4tFsT7ktTZcCsSLbf/Tf
	 C7UWHpIzlvrtGmAiRSpFoozRXcOSCleVL6O5wojhrsJqpwWVFsoBB7gtBS6Nywgzoy
	 LnOw5dMdqSDxrr6tH3yCvbwbJJayKkUDMlURnIbRC/AaEnwaQHk+nhZhMhT7aHZCbI
	 ItJVBaLfRVe5Y61TOXPg+80JaKMlIag2ID6Vz4HTAnsRzC0H2pk501iJ4cTj4+9OXJ
	 ZshjMYhGVec9ldVGxn9dJfREng3voxxu+FH+qB+Vuhk6vNPYTTBBGw7Vr49Hak3riC
	 oSjlyFYk4YKXg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8A8DF486A2;
	Mon,  9 Nov 2026 22:06:49 +0000 (UTC)
From: Kohei Otsuka via B4 Relay <devnull+kohei.spacemachines.com@kernel.org>
Date: Tue, 10 Nov 2026 09:06:49 +1100
Subject: [PATCH v3 2/2] serial: 8250_of: add Microchip Core16550
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
Message-Id: <20261110-core16550-rs485-v3-2-4294334243fa@spacemachines.com>
References: <20261110-core16550-rs485-v3-0-4294334243fa@spacemachines.com>
In-Reply-To: <20261110-core16550-rs485-v3-0-4294334243fa@spacemachines.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 conor.dooley@microchip.com, Kohei Otsuka <kohei@spacemachines.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794262008; l=2575;
 i=kohei@spacemachines.com; s=20261103; h=from:subject:message-id;
 bh=zw6B/PavfryyAkr5F76dLB1vCpTk6rfbRbKI/quiOS4=;
 b=Q5KAvlN1aGWnoanfzyUKb6886RNpVg3+PVf36DX2HSFw3ULoRJ5czTEAnA3SBRQhq5H3Mj/ln
 ciajBlIn1snCtnHDmWEmw3nOtNbLvcxsLpRkQQ1Ba+yEBl1gJmRbvcm
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

Match "microchip,core16550-rtl-v3" as a PORT_16550A, and set
UART_CAP_NOTEMT for it, so em485 drops RTS from its stop timer one
frame time (plus 1/7) after THRE, as it does for DesignWare UARTs.

Set UART_CAP_FIFO as well: with the capabilities already non-zero,
serial8250_do_startup() no longer fills in the PORT_16550A default,
and without UART_CAP_FIFO serial8250_clear_fifos() does nothing, so
the RX FIFO is not flushed at the end of a half-duplex transmission.

Link: https://github.com/linux4microchip/meta-mchp/issues/5
Signed-off-by: Kohei Otsuka <kohei@spacemachines.com>
---
 drivers/tty/serial/8250/8250_of.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index b41ca604083f..9d92668d7772 100644
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
@@ -398,6 +408,8 @@ static const struct of_device_id of_platform_serial_table[] = {
 		.data = (void *)PORT_16550A_FSL64, },
 	{ .compatible = "mediatek,mtk-btif",
 		.data = (void *)PORT_MTK_BTIF, },
+	{ .compatible = "microchip,core16550-rtl-v3",
+		.data = (void *)PORT_16550A, },
 	{ .compatible = "mrvl,mmp-uart",
 		.data = (void *)PORT_XSCALE, },
 	{ .compatible = "ti,da830-uart", .data = (void *)PORT_DA830, },

-- 
2.53.0


