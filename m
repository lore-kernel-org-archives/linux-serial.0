Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795242930;
	b=WtCYnGfL4qj83UVXI9celmP68xify0VCMvXwJnkScsdCgM2Pv2G0BLVSH9srI7IJW9m7
	 sAJOWUwfMArh0jRrNJgtIXzLhX+FsHhu9gK6PESYravdehadA6gRrcrrITX3YD8FmZzrP
	 EzFq0Kkdg+QXDYQIoLwd/Oy9eVUbNP2KB/zTUaqE+jaL6vdScXWZ71ecG7O9wdvISgi5a
	 +cRl5d4+CMG6O2dK3DqbWhWrgYKyF6WH5DHCPq3T5dJh2/SPo/YKs5diXWiczEkSwdnCw
	 OhZEvXoJpfyEbl9W2UEZb+JKM/zXMn1I8cTUrWesmUBccUA5gy0fGjuwcdc/DhW6QQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795242930;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=TuiyLAKZEvQwfukYNp4fOV5+cnoySxg2Xk/+x0BUTFs=;
	b=J9U7YqZQtruj+i7bgzX0u7l4eSPdKnrICsrvJ2QSHpqZH/whnJk8egfOJjvYw9RSLUBI
	 zkTEI6UcWzGEUPa1NYlvnGM6hiAAFFUEDY9kW+BhmGcBa/PuIfssveM5f3A8Fx8B3HTq3
	 bHyEqu+e3PUuWz7zlFyD74vkpdeCS3IIXtRSecgeyT2nGXOImI0oy+ZgSy5hfwBK1N3IF
	 EUA9bXcBLf3az7uwmvwHZKVYsE02WIDrWQt3rckiICYfEmmdHd1sZvrkJ5AjGukwTann/
	 UVI/9mzptq4O6To9Uc116W8HEca/apLeSv3HBtI93/lAkk3IsDgJX3DeWJ4x+NAGaFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sjterm.com;
	spf=pass smtp.mailfrom=sjterm.com;
	arc=none smtp.remote-ip=115.124.28.43
Received: from out28-43.mail.aliyun.com (out28-43.mail.aliyun.com [115.124.28.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11211606A33A;
	Sat, 21 Nov 2026 06:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11211606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sjterm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjterm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07442638|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0204295-0.000480235-0.97909;FP=16645005566030868333|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032065030;MF=fuyao@sjterm.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.k6zA2dx_1795242915;
Received: from localhost(mailfrom:fuyao@sjterm.com fp:SMTPD_---.k6zA2dx_1795242915 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 21 Nov 2026 14:35:15 +0800
Date: Sat, 21 Nov 2026 14:35:15 +0800
From: Fuyao Kashizuku <fuyao@sjterm.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250_dwlib: Restore NOTEMT for em485
Message-ID: <awE7o4z1DMGb-YMg@debian.cyg>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

From: Fuyao Kashizuku <fuyao@sjterm.com>

A DesignWare UART using software RS485 can transmit one byte and then
leave the next write queued indefinitely.

dw8250_setup_port() sets UART_CAP_NOTEMT because the UART does not
interrupt when the shift register becomes empty. If neither hardware
nor platform data supplies a component parameter register (CPR) value,
the driver leaves UPF_FIXED_TYPE clear. When autoconfig() identifies
a 16550A, it replaces the capabilities with the type defaults and drops
UART_CAP_NOTEMT.

If the TX FIFO empties while the shift register is still busy, __stop_tx()
then returns without arming the stop timer or clearing THRI. With no
further interrupt when the last bit leaves the wire, em485 can stay in
transmit mode and a subsequent write can remain queued.

Restore UART_CAP_NOTEMT in the DW software RS485 configuration callback.
This lets the existing em485 timer finish the transmission and release
RTS after the last character.

Fixes: 5ff33917faca ("serial: 8250_dwlib: Implement SW half duplex support")
Assisted-by: Codex:gpt-6
Signed-off-by: Fuyao Kashizuku <fuyao@sjterm.com>
---
Tested on UART1 of an Allwinner T113 board running a 6.12.60-based BSP.
The board uses a GPIO for direction. The BSP forces the DW software RS485
path for this wiring. Both runs used 115200 baud and a 1 ms RTS delay
before and after transmission.

Two one-byte writes ('V', then '7' about 300 ms later) each returned 1.
Before the fix the peer received only 'V', the TX counter stayed at 1,
and TIOCOUTQ still reported 1. With the fix the peer received 'V7',
TIOCOUTQ returned 0, and the board received the peer's six-byte reply.

The change was built and run on the BSP. It was checked for clean
application to the mainline base below.
Codex assisted with diagnosis, the code change and the test runs.

 drivers/tty/serial/8250/8250_dwlib.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 9bb02a4ab11f..5a6ba9e921b0 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -170,6 +170,21 @@ static int dw8250_rs485_config(struct uart_port *p, struct ktermios *termios,
 	return 0;
 }
 
+static int dw8250_em485_config(struct uart_port *p, struct ktermios *termios,
+			       struct serial_rs485 *rs485)
+{
+
+	struct uart_8250_port *up = up_to_u8250p(p);
+
+	/*
+	 * Without CPR, 8250 autoconfiguration can overwrite capabilities.
+	 * Restore NOTEMT before enabling emulation: DW has no TEMT interrupt.
+	 */
+	up->capabilities |= UART_CAP_NOTEMT;
+
+	return serial8250_em485_config(p, termios, rs485);
+}
+
 /*
  * Tests if RE_EN register can have non-zero value to see if RS-485 HW support
  * is present.
@@ -202,7 +217,7 @@ void dw8250_setup_port(struct uart_port *p)
 		up->lsr_save_mask = LSR_SAVE_FLAGS | DW_UART_LSR_ADDR_RCVD;
 		p->rs485_supported = dw8250_rs485_supported;
 	} else {
-		p->rs485_config = serial8250_em485_config;
+		p->rs485_config = dw8250_em485_config;
 		p->rs485_supported = serial8250_em485_supported;
 		up->rs485_start_tx = serial8250_em485_start_tx;
 		up->rs485_stop_tx = serial8250_em485_stop_tx;

base-commit: c44104f3642da720164042623e4832836aefdd8e
