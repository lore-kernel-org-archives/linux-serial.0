Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4884028DB9
	for <linux-serial@vger.kernel.org>; Thu, 18 Jan 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.6.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705592846; cv=none; b=KIyOok2lacH3L2tS4z9gnU9z9rxjFgKnG6bT6pfIi9D0RaQMqdBXlT4bYANqAwdhFc8nEGOBwWxBpby9lKxdNqXf4V/kld/ry7gEZJpzL5HJeYPFPqxB6QzIs2Ssp+VyBIBdy6t9szHm4ke6WaYR/REwMmrIjXNuaW2hiOR4nFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705592846; c=relaxed/simple;
	bh=054fydTRRTa7ihKhW6HUBsLupgtgVmavNXtOz6rfg8Q=;
	h=DKIM-Signature:From:To:CC:Subject:Date:Message-ID:X-klartext:
	 MIME-Version:Content-Type; b=uz5iYVMrzdziWGP8FPM0exU/cLjOPil3fprYmcVh9woWyq4CQk8BZe+ToabXZNHv6PS/AMu1TyGGrJ/Y860MdCXprfMqebPfxfaxEniqnvAYW5n91j97DFU06fL1HPHG8chPvtfNakantdyFC5ZlwXXzqVFdHp9Jsw95Z/Natz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com; spf=pass smtp.mailfrom=dh-electronics.com; dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b=Y4dFegwV; arc=none smtp.client-ip=178.254.6.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="Y4dFegwV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1705592807;
	bh=upvN6szEOm7tmfaGe0dW7qQ3Hu0oZMv45sMxsy/e33E=;
	h=From:To:CC:Subject:Date:From;
	b=Y4dFegwV3mS58uQTQt2URdE1+yca1cJ5jMppf4xj/u2M+VqZFvm7D4s+wXBCG8rkB
	 VlMHjYibRsWYZqUBlu/h5Z1Il80d79YbMoWF5EmLaoC17YNd0MxdyApOVHgd1ry6yM
	 XHfRWcp73REWO64voasqLe4HpC95EHrPXUeUqAHVkLA14NPPMdkeJHBC7QoDloy/Cc
	 xjr9Nbfni56RVZCO96R2XPtkvbqU9zEugoIYD0Lya4UHQ3hVhfiAglLK5aRzKdT+VE
	 GCyEOfghEd99/Gu2woresoiHwlFLIuf9gLtfUaR06YWLESHb0PyIYaznH6PtbOvSxz
	 UuXHHmJaKqWoQ==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <linux-serial@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Crescent CY Hsieh
	<crescentcy.hsieh@moxa.com>, Jiri Slaby <jirislaby@kernel.org>, Lukas Wunner
	<lukas@wunner.de>, Lino Sanfilippo <l.sanfilippo@kunbus.com>, Hugo Villeneuve
	<hugo@hugovil.com>
Subject: [PATCH V2] tty: serial: Fix bit order in RS485 flag definitions
Date: Thu, 18 Jan 2024 16:46:24 +0100
Message-ID: <20240118154624.5340-1-cniedermaier@dh-electronics.com>
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
But with the switch to bit shift macros in commit 76ac8e29855b ("tty:
serial: Cleanup the bit shift with macro"), this gap wasn't preserved.
To avoid a break in user/kernel api of the system skip bit 3 again and
add a placeholder comment.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Fixes: 76ac8e29855b ("tty: serial: Cleanup the bit shift with macro")
Fixes: 6056f20f27e9 ("tty: serial: Add RS422 flag to struct serial_rs485")
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc: Hugo Villeneuve <hugo@hugovil.com>
To: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
V2: - Fix typo
    - Add Fixes tags
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

