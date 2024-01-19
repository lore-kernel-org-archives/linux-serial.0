Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169933C460
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.6.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705664474; cv=none; b=Q1lSrApLwrXslq0JiLTv1WozXHyJu7Fvkodo72D/BkK0pEHGnq85PeIo01mEQXHNl0htLKJ2b4xZp7pOAfUax2xk4ANf+dmR+yvNdm5bMB69/eZCICQnV4njYqUciNiwLaC2S9wiuORmPr40IE4CZRobSMYdf/YLL7/LD3UdgAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705664474; c=relaxed/simple;
	bh=Pjg+YILiLLoxV/S0pONXGEBLlg7JZww5FyMFng+r+20=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cH+bw5e6G8/cRw4m8LbOXTD7US4/qXkfw+kamWWiJ7LFefvPWGnt28OEhGPTXZnv2kzbrqFq4Ly8TAVWxctU6J4po/TA5aDxcjStQotDWLo8OTvtJqntayLHwLB8oqjsD6JvV4FwL3HGbDWKjqveY0eTsD1eoaeF3Iw7rB4CQro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com; spf=pass smtp.mailfrom=dh-electronics.com; dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b=ALZNMtop; arc=none smtp.client-ip=178.254.6.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="ALZNMtop"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1705664436;
	bh=7myNZ3RCwcag+XwWnSm1WHpr+kXN5+I3yuwLlfOLSws=;
	h=From:To:CC:Subject:Date:From;
	b=ALZNMtopR2X8qc3C7Ffonr54ZyT/Yqr3iZpEbbSQ/VYuUHLt/qx/waPqO6exC0lVr
	 Ir7DJKmfateOHbSX9DOSNoXXugnJWNEcB6q/MMNCTwcHEch1eu9o/pWVgJiJmfnQJA
	 u7eAT1KQw5dUzpRBn1bipm7GhIBYCrXHXKQWQMVIfj4iKZBl5daMy2SKzvdvpa3Ml+
	 nxgMCdpqwHnu0vzE7ktMm0JnwExAaBNBbCpH33B+Fzz+8co0hLeYoOyeX4nZ/z9atA
	 okgWW+ZB5YrWYzIZe5HIzhw13YZHvNJkZ1/GV26PmrUs8ejIvuoSQX3Id+huAk+mKK
	 yqwVTCglMrf1Q==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <linux-serial@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Crescent CY Hsieh
	<crescentcy.hsieh@moxa.com>, Jiri Slaby <jirislaby@kernel.org>, Lukas Wunner
	<lukas@wunner.de>, Lino Sanfilippo <l.sanfilippo@kunbus.com>, Hugo Villeneuve
	<hugo@hugovil.com>
Subject: [PATCH V3] tty: serial: Fix bit order in RS485 flag definitions
Date: Fri, 19 Jan 2024 12:35:16 +0100
Message-ID: <20240119113516.2944-1-cniedermaier@dh-electronics.com>
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
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc: Hugo Villeneuve <hugo@hugovil.com>
---
V2: - Fix typo
    - Add Fixes tags
V3: - Add Reviewed-by tag
    - Remove triple dash after the last Fixes tag
    - Remove all "To:"s after "Cc:"
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

