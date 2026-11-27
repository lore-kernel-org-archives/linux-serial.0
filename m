Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798570;
	b=PKtxyvHhF168E06fDUSdYIhipl02Nf2NVqKvHF7INznj0ggreHAwreLJF1wjS5CQBsYS
	 fgs5GlAIdq7sPWxTMgINBWgvEnTnwA3gQNLPWgrK01fW7Yln1z7D1kXc2bkhGQIBt/RAe
	 g+0QQ5XdOms3KEx6jcBA78sXRtMZ0PkDWbArzw9isV0/s0uc2IbQ7prWj2nVKTi3hjnzv
	 fi2dGgATYuZfY99VkJV+aKVcfTHHmUF7RIsOIJWO07AZEk6RZgOzL++bHMQB3NzzmNDhx
	 GUlvAPhLb/Vit0YmXY78qrvy42oGb3DLsSEd/dSLmCLu0YABr73aWtzyOkUDLvKgFyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=tBQuv6Lhdi7fEtiV2oM4BKslPIEAViTQUedU+aiaIxU=;
	b=cNLWi/fWrnr+rnhcAZhmKpKucK2RuS0cxAiJXrWmUerRij4PJOmmB6BCPt6REHV101H6
	 xBHTqLd4qDMVoQ1LEaH2ufJ+REHfaLP7cWtcmBcGcUyUdqKpDZhaSfXlwwdyGPzpn3NHj
	 tGGp4xilv4CjuB97Nnysn5cb1ZyfeETDOMwlim9IQ2HVBpGRYoQ1lDlhn7YUhKC8/QPUR
	 PRHiAZuRhBj5Pq7NqZagPONmjntglTrrTBw+Bj6D/SC3am93fSB2rUfNlZmYJ48BTDLxN
	 WpUe4EYpeVrD4YhaN3ntpB1Fyh06erfN9VbJe72JU5mJZ0h1pM96K8P/ohK8eANbdDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z2OMStry;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13D7606A321
	for <linux-serial@vger.kernel.org>; Fri, 27 Nov 2026 16:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F13D7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z2OMStry
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so76508505e9.1
        for <linux-serial@vger.kernel.org>; Fri, 27 Nov 2026 08:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795798568; x=1796403368; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tBQuv6Lhdi7fEtiV2oM4BKslPIEAViTQUedU+aiaIxU=;
        b=z2OMStry22xjvmqtMZfosvTIIHex7Z8dR0SfoP6Xm4Xw4DJEjYYLCZAPfn6AiJC9Sr
         vn7MKGI3Nel3020LDgQVa1ZITUYnlIi/X/4VatHzHxMknrsSEYHF03AeHSxyPXo1BFMT
         IRwm97uZCHX5SqPZmVuDc8kjbvEadRCTotBVUOge/2N3Q+zle3i0cjhKAK6z5AkTDdnk
         fVxITI0uUTZXnm7AoFCauZ5SZuCBjrOXR55CsHjpBv68R05H/MeRMug8TbxW6dOw0sdo
         ObY8OArgd3J2sJmMf/1TE/yqFeItbKfMfsUHHjiMZ5n81YmdIOQQV+Q/cg7Sp9Z8lGZr
         GktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795798568; x=1796403368;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tBQuv6Lhdi7fEtiV2oM4BKslPIEAViTQUedU+aiaIxU=;
        b=Irlk2mlWK/zpt6Xc46vveUuLxUgE3Fpg5Oe+izpVy0+0c4T9wzWn9siu+FNdh910Q8
         OWomHv3zBCJUHCc6q+pyjkndGoWa4A5jN+FzLdLU2IpPLqnwoIQ84jfPzwIB3kTJTM6o
         N9Zt6PPC9OXlNo2Dbgcq0hNrWpqlUFE10EZ/t71WQYXMttfV7WxxWqghxz6vMTAm5dz4
         dVHMEmJ06iBkfmxe/TKf+GBuGt+zwcbmFl/mQyk44Qv7yZC9jQG9Ort9MkSnvMASE29j
         4iQfFSsql8bFTbILgY1Td18GBfjevpnSoJxza3+b90gLJ5UVqLzaqzjh9MlO7e6LniKZ
         XCCA==
X-Gm-Message-State: APuU4Z+JEsniDuXf+nW4BeNb7BxhO81w1PA56rXuGoec/BYh6UbENOJZ
	Adgeeom5opvrh74i2qZj0PRPwynRTlIeInX4IrK+OOq5NI22b7gh+nd4FyOmpBoB4w8=
X-Gm-Gg: AZFdTZcG0xYvApKp24wbVjDKEEvGIXCy3MzKa6Scjt0SI6sqp1nm5sTb5oQeH+B4zby
	HWjsdjW5bhPwsziTgIkeg0oXJ0npdXDLHAhDomMbT4YHt31ieyFUj/0R1kYfqANuuguBiirlt4Q
	0ljtmmx/dV4THh+zKPXZyzVyOXwptkiq80Ofgoy+yBnisbLFn29mNqMtlauBQ97LEhJ2BqlpBTr
	zPk+8PNRyVpLVSogiPTSYWVTb0+a1dZYk5KndoLNj8TLz2aB7fAvQVodI6FRBD9QIksHmfNX5sT
	spu4UvFMuTtp+PTevmR2s0Kqi5oHcMPH7I5KZh92xuFPqUCKgas0Hz/NjhFSMwJUugdXF0dazBD
	q7chTYekDZWihbF4pKWFxo+lcd1Y1yKCbCPuej1CtbtcBtpzLVv/UnNkRgXFr1HzJJNZF/lVUjL
	abMZBKS4zeRpFhPRHNFdluxezJxH/SA8EraRdbdriL54ev6s0q9Z0CAG7EQWUhmt9vRAfzTEovI
	9g6rP3LTtO25FK1s3pSu02av3m85lVULRqZZ6kw0P1uTrv8ZixeU36WrcGx+1RFvHdr1fMPPRDL
	d/MZPXssDpTSNQ0EBuRtkv/WqDy8xdQ6v9u3nf+yp91bS1I0MX3nIlRpXTvEmyUzElEHO/bf3my
	ywEfLebg=
X-Received: by 2002:a05:600c:1d86:b0:4bb:6a5a:7824 with SMTP id 5b1f17b1804b1-4bb8892099amr546093415e9.30.1795798568353;
        Fri, 27 Nov 2026 08:56:08 -0800 (PST)
Received: from localhost (bl20-90-91.dsl.telepac.pt. [2.81.90.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399d52sm677062805e9.6.2026.11.27.08.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 08:56:08 -0800 (PST)
From: =?UTF-8?q?V=C3=ADtor=20Hugo=20Silva?= <vitorhg20080@gmail.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-riscv@lists.infradead.org,
	sashiko-reviews@lists.linux.dev,
	=?UTF-8?q?V=C3=ADtor=20Hugo=20Silva?= <vitorhg20080@gmail.com>
Subject: [PATCH RFC 2/4] serial: esp32: Fix ESP32-S3 baud rate prescaler calculation
Date: Fri, 27 Nov 2026 16:55:50 +0000
Message-ID: <20261127165552.133713-2-vitorhg20080@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127165552.133713-1-vitorhg20080@gmail.com>
References: <20261125233020.1380594-11-vitorhg20080@gmail.com>
 <20261127165552.133713-1-vitorhg20080@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ESP32-S3 encodes the SCLK prescaler as divisor minus one. At the
maximum unscaled integer UART divider, the driver can program a
prescaler it did not use in the baud calculation. At lower rates the
prescaler can also exceed its register field.

Select the smallest prescaler that fits the UART divider, including
its fractional part, and reject an out-of-range prescaler before
programming the registers. Round up the minimum baud rate to avoid
advertising a rate the hardware cannot generate.

A mocked register test covered the divider boundary and rejected
38 baud while accepting 39 baud with a 40 MHz reference clock.

Signed-off-by: Vítor Hugo Silva <vitorhg20080@gmail.com>
---
 drivers/tty/serial/esp32_uart.c | 40 ++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/tty/serial/esp32_uart.c
index 895d0ec..0e7128a 100644
--- a/drivers/tty/serial/esp32_uart.c
+++ b/drivers/tty/serial/esp32_uart.c
@@ -8,6 +8,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/irq.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
@@ -447,35 +448,35 @@ static void esp32_uart_shutdown(struct uart_port *port)
 
 static bool esp32_uart_set_baud(struct uart_port *port, u32 baud)
 {
+	u32 div_mask = port_variant(port)->clkdiv_mask;
 	u32 sclk = port->uartclk;
-	u32 div;
+	u32 div, frag;
 
 	if (!baud || baud > sclk)
 		return false;
 
 	div = sclk / baud;
-
 	if (port_variant(port)->has_clkconf) {
-		u32 sclk_div = div / port_variant(port)->clkdiv_mask;
+		/* The SCLK field encodes the divisor minus one. */
+		u32 sclk_div = div / (div_mask + 1);
 
-		if (div > port_variant(port)->clkdiv_mask) {
-			sclk /= (sclk_div + 1);
-			div = sclk / baud;
-		}
+		if (sclk_div > FIELD_MAX(ESP32S3_UART_SCLK_DIV_NUM))
+			return false;
+
+		sclk /= sclk_div + 1;
+		div = sclk / baud;
 		esp32_uart_write(port, ESP32S3_UART_CLK_CONF_REG,
 				 FIELD_PREP(ESP32S3_UART_SCLK_DIV_NUM, sclk_div) |
 				 ESP32S3_UART_CLK_CONF_DEFAULT);
 	}
 
-	if (div <= port_variant(port)->clkdiv_mask) {
-		u32 frag = (sclk * 16) / baud - div * 16;
-
-		esp32_uart_write(port, UART_CLKDIV_REG,
-				 div | FIELD_PREP(UART_CLKDIV_FRAG, frag));
-		return true;
-	}
+	if (div > div_mask)
+		return false;
 
-	return false;
+	frag = (sclk * 16) / baud - div * 16;
+	esp32_uart_write(port, UART_CLKDIV_REG,
+			 div | FIELD_PREP(UART_CLKDIV_FRAG, frag));
+	return true;
 }
 
 static void esp32p4_uart_limit_baud_rate(struct ktermios *termios,
@@ -514,10 +515,13 @@ static void esp32_uart_set_termios(struct uart_port *port,
 
 	termios->c_cflag &= ~CMSPAR;
 
-	if (port_variant(port)->has_clkconf)
-		max_div *= FIELD_MAX(ESP32S3_UART_SCLK_DIV_NUM);
+	if (port_variant(port)->has_clkconf) {
+		max_div *= FIELD_MAX(ESP32S3_UART_SCLK_DIV_NUM) + 1;
+		min_baud = DIV_ROUND_UP(port->uartclk, max_div);
+	} else {
+		min_baud = port->uartclk / max_div;
+	}
 
-	min_baud = port->uartclk / max_div;
 	max_baud = port->uartclk / 16;
 	if (port_variant(port) == &esp32p4_variant)
 		esp32p4_uart_limit_baud_rate(termios, old, min_baud, max_baud);
