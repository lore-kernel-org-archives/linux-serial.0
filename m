Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8A313AFB
	for <linux-serial@vger.kernel.org>; Thu, 18 Jan 2024 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.39.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705582518; cv=none; b=fCPGWR77Mq3n3rp68yTgCLNOnmbavsxQ/3XnTovmksI0OSi8Po7S96qQR5hxPrLcq/PuZVjI/qd5zH+Jo62o8P/HLsjsHD0wDN8hTZC7e+A6BnYjwjE4g8AmyHaM2jRDxbNR+3yiiT1YFMOXwakuw9hzx896YJaA61/NIywuuAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705582518; c=relaxed/simple;
	bh=vBqvodgdBU5LO+HsYBu5OYd9IthRRxr7fD0awaBDdcU=;
	h=DKIM-Signature:From:To:CC:Subject:Date:Message-ID:X-klartext:
	 MIME-Version:Content-Type; b=NKxRj73us0Z9q7pQd8g+FplhjE68W35NGWqlO83qXUV5QZZc4y3xfV7gcCWh3zwOx/EqhTb45LYGfcpNSWrZ4VDVKCRB1JbERnoDqEnj8cDc3ICnfnFXvIpfuaZ7pv6iYPaMNAvPMHkLz7QInH2blQB5tGcdB6kUPL3w8bQG71w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com; spf=pass smtp.mailfrom=dh-electronics.com; dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b=M745w9AJ; arc=none smtp.client-ip=188.68.39.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="M745w9AJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1705581868;
	bh=Cvsf1PsKgB1xMQ27fbc6IgM0URoxwKPHzx8AByXg2/A=;
	h=From:To:CC:Subject:Date:From;
	b=M745w9AJ/5+KrSlMj2cF9ullsOkOJwXVJoayaAMX/Lr44n61PwKYuYA1YWEfBZQaA
	 PyabsIVqKnZLc8otAH3ICtAeOtQ/P5cOqJBtQ3HoDY37cUqESrtiZrB62KI4P/p74e
	 GE66ymS765jwUQfvGEZeeQu5O//frEwISN3+0wQ0iFig6Ulh02lXkHkisVuZqGfe+C
	 CUqMDjReNd4pmrO2qoNmMjyuniHU8h3TFd/cb3pTUlKV6cnGTkx2YQge7ut2N8A1Sh
	 cx/cZhko0YDBVeQaFqhsPo8AhkTf/wrPj83fBy/CBLWVNctmp403hUp3y1Y1Q6zDO8
	 9r8nulhn7rPMQ==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <linux-serial@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Crescent CY Hsieh
	<crescentcy.hsieh@moxa.com>, Jiri Slaby <jirislaby@kernel.org>, Lukas Wunner
	<lukas@wunner.de>, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH] tty: serial: Fix bit order in RS485 flag definitions
Date: Thu, 18 Jan 2024 13:43:50 +0100
Message-ID: <20240118124350.3772-1-cniedermaier@dh-electronics.com>
X-klartext: yes
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Since the commit 93f3350c46fa ("RS485: fix inconsistencies in the
meaning of some variables"), the definition for bit 3 has been removed.
But with the switch to bit shift marcos in commit 76ac8e29855b ("tty:
serial: Cleanup the bit shift with macro"), this gap wasn't preserved.
To avoid a break in user/kernel api of the system skip bit 3 again and
add a placeholder comment.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
To: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 include/uapi/linux/serial.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
index 9086367db043..de9b4733607e 100644
--- a/include/uapi/linux/serial.h
+++ b/include/uapi/linux/serial.h
@@ -145,12 +145,13 @@ struct serial_rs485 {
 #define SER_RS485_ENABLED		_BITUL(0)
 #define SER_RS485_RTS_ON_SEND		_BITUL(1)
 #define SER_RS485_RTS_AFTER_SEND	_BITUL(2)
-#define SER_RS485_RX_DURING_TX		_BITUL(3)
-#define SER_RS485_TERMINATE_BUS		_BITUL(4)
-#define SER_RS485_ADDRB			_BITUL(5)
-#define SER_RS485_ADDR_RECV		_BITUL(6)
-#define SER_RS485_ADDR_DEST		_BITUL(7)
-#define SER_RS485_MODE_RS422		_BITUL(8)
+/* Placeholder for bit 3: SER_RS485_RTS_BEFORE_SEND, which isn't used anymore */
+#define SER_RS485_RX_DURING_TX		_BITUL(4)
+#define SER_RS485_TERMINATE_BUS		_BITUL(5)
+#define SER_RS485_ADDRB			_BITUL(6)
+#define SER_RS485_ADDR_RECV		_BITUL(7)
+#define SER_RS485_ADDR_DEST		_BITUL(8)
+#define SER_RS485_MODE_RS422		_BITUL(9)
 
 	__u32	delay_rts_before_send;
 	__u32	delay_rts_after_send;
-- 
2.11.0

