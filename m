Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649505;
	b=ViawVqhCTUplVyW64n2bynce8debQbOA6g4ZFK8JL3l404F4+kC3dzfcId1n/yn2VGSW
	 l2H4zHLRZLAzjFoO2ElYlYTgfk/WsASP4DiAEj5JhRYrzli2vJ+gsCRxaUB4/xQZmSKrI
	 aYwVUsWLAiHE32yM7ENZbW85NJbTyurLrnqRneTKXHj5x64zD3nMzkGHrN3RwrdZICLMQ
	 MzgnEw9X2lrU784JyaaHIgDfj+DbZjBu5Rde/n2SLSWCmrC9fJtDCfbcf4AoI64cJhb7W
	 TmLNFxHiyeLSRJQZ2YOoAMu61XxkvxiDAOaKn8QXrtJy2j+zzy6olpUgGtMq5WDibFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LYw5GBAdPj90q6NncpK72EIMG1Zgi7jH/SYXlLevmww=;
	b=4jv2LhEAP2gSa2n96cGgYoPZxtm0alMcKjUhLKYPUt1v+2SWV3VBMEPNLzt9JMXYik2k
	 TwCeEv4Kj/dYUiaAdUJ+57hrpMif+KKdoYBVX1bApofCoX2rUNk0FegIT03F0LrU43ijs
	 kgNsQ3jIKR55cCI8ypDF/wMS4QapQzVqfnMQnq3YCdb1lMv/9rc0mR5KQxqHYSMRwho4a
	 cclGGyK/Nt7fi4ZNE23i/TvzZXPpBWfNZHiZi2xTZPSFarWBnpEEjm+xpDRxh0ro7lJU9
	 mlO2wJZc8kIgRGv1KGYhmeT0El7CyI0IGLEmpCY0ZE6kXtrSiV7Ot0lTnwuDbPzJ0WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IspnHSro;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EBF606A331
	for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 23:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65EBF606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IspnHSro
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so51444005e9.3
        for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 15:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795649504; x=1796254304; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LYw5GBAdPj90q6NncpK72EIMG1Zgi7jH/SYXlLevmww=;
        b=IspnHSroOfZdrf8oMXJQi+UqbqhITZQIa4296wB5r+k/WGVn0u9xhHA7z5rkSosbac
         NpluHrJuqpmEM8xUeJUfYzQwC2UBULp8VKywufzKF1WEAkbDHZP7lWoqlPOkPt/YcCT5
         lqxLiqVgazKrFtPiJnejlGLPtm1iJRjdPyUBne6+AjpsV/AkJvhcMveZL4gLsqea2qKN
         PM55Md3oPkS4+Xc8eNENqdZhQjlFkckr9qWKDP6aC4PeosDOyPQ8X+b18i9FpPlfRPNW
         mMNjN6tc0RLnUmcdyYjITz5nq4erDqcAbODtvjKf3ZlwTihgIi6LRVhbQeos5XUtuhw8
         qkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795649504; x=1796254304;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LYw5GBAdPj90q6NncpK72EIMG1Zgi7jH/SYXlLevmww=;
        b=EWwyeRMj3ewFr5HlJIX3+AFb25k4aHm+EVt4H0QCfRrVcq0EBry8YW6QQZmwDuL31P
         0Los4wLqjcwO1NX4G79OxINSel0KAABTFqPjP128XGVpRtLyn6vx3ayEdAR7kGAiWoei
         appvquXMZ8mLnLI/FS7JThNewF2ata0DQYeLXY8GjMSzxAnMXqNmHEcaJt1/C0OfTz6d
         ktVl2x3EWGZig6nsVANQjAbCQ8PiNZweiIvQhvrxO+iuiWSbfRfzszQhwKfOh81Vv4sl
         uHSNzELSBRszvXrUd/flQRQ1ZkZp4G44OKHqGZFOjzB/Osnxe0ox8CgQn+QF2nxuDZEp
         TO8A==
X-Forwarded-Encrypted: i=1; AL+hErEINzn8rvpAaO9P0nT5h4xpIAnLXpbnW9nhAFy1eGAnrIBvx0scQH4fwXlxtzUBpkxfKKnuzTjZ6L3AM8o=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RuLUr6MwZLP/KAIjUlVRfHI5Yg9hQoUYPTx7sOxEMnF9i7gxb
	BDBmJBxPc9e3kPG8JqB8Qm6j382OpdxuVQXRkL1d8yQtTR5/Yk5fFg71
X-Gm-Gg: AZFdTZd6dkv+9arK6fb01T7JvDkBobPsQZ6BvBIpalcgygzrEQ+Py8OIABZ5IwarY52
	lyiEzhZIaH3uML88dcr5K+jvDyY4DGCovAmKrcY97FLg8XExyIezb0X652wN42iwiJcww+LJ1fJ
	Ml8QyXybAYvcCGhD4qv3ZLn0jt0CrYIJ2IKQ+R6NrBTF8UC6njoFqR0SR+NsG5hGFfwg8RrMiTe
	n51v7adaBFdJs+AIT71/GW5yV7DrMHl/8zAAaKuyNbFlz+VbESd1hFil310WXCnZKbd5HXF6eMM
	aYFqDkhDJF+aqpsbzzcO6Y1HyfRhJYIALSUtjOYpLFgi2sqYNnVmIVYCvOYUbHN6JGUbgsZvKlu
	hXpyQp4kQhh1p01fITuJrgj5dW8Xqouoe/lRRoZPDRuTS3SNwXMikbNJgW2zjOJDrkca7D6vLrV
	lPXwjK18+I9o4iMh6tI/LLeVa8yrfHrfLQH9/4soVZnyfIN3bl0T3YcnB0hzmn4WGGqXKXfrdDj
	AeB54nGHSyq592jSf9k8gvpaU/2fP/WQYvMY9PjyoOXueJtdPlitAbHO7xuPg1ppkQFnsv4pKqe
	GmlOcNW4h0FH83dpKHdGM6nAgmPMlEb+RDrCkO5J3tyhLdxipw6JIsR/UFmmjyTw5Y4yYpuWhBY
	47HfWFpEDng==
X-Received: by 2002:a05:600c:6749:b0:4bb:71c1:3ca6 with SMTP id 5b1f17b1804b1-4bb88819d15mr373167565e9.21.1795649503790;
        Wed, 25 Nov 2026 15:31:43 -0800 (PST)
Received: from localhost (bl20-90-91.dsl.telepac.pt. [2.81.90.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b216esm611586845e9.12.2026.11.25.15.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 15:31:43 -0800 (PST)
From: =?UTF-8?q?V=C3=ADtor=20Hugo=20Silva?= <vitorhg20080@gmail.com>
To: linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH RFC 13/19] serial: esp32: Add early console support for ESP32-P4
Date: Wed, 25 Nov 2026 23:30:14 +0000
Message-ID: <20261125233020.1380594-14-vitorhg20080@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125233020.1380594-1-vitorhg20080@gmail.com>
References: <20261125233020.1380594-1-vitorhg20080@gmail.com>
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

Register an early console for the ESP32-P4 UART using the UART
configuration left by firmware.

Early console writes can run before timer initialization, and
normal console writes can run with local interrupts disabled. Use
a shared polling routine that bounds the wait for TX FIFO space by
a fixed number of reads.

Allow 10,000 reads per character for the ESP32-P4 early console and
1,000,000 for the other callers. Drop the character if the FIFO
remains full for the entire polling budget.

Verified early boot output and a working UART shell on the Waveshare
ESP32-P4-Module-DEV-KIT with the driver built into an RV32 NOMMU kernel.
With a simulated FIFO, both limits dropped the character when the
FIFO stayed full and wrote it when space became available on the
last read.

AI assisted with integrating the early console and checking
its registration in the linked kernel.

Signed-off-by: Vítor Hugo Silva <vitorhg20080@gmail.com>
---
 drivers/tty/serial/esp32_uart.c | 50 ++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/tty/serial/esp32_uart.c
index 002d6fdbd875..451caeb406fe 100644
--- a/drivers/tty/serial/esp32_uart.c
+++ b/drivers/tty/serial/esp32_uart.c
@@ -25,6 +25,7 @@
 
 #define ESP32_UART_TX_FIFO_SIZE	127
 #define ESP32_UART_RX_FIFO_SIZE	127
+#define ESP32_UART_TX_POLLS		1000000
 
 #define UART_FIFO_REG			0x00
 #define UART_INT_RAW_REG		0x04
@@ -107,6 +108,7 @@
 #define ESP32P4_UART_SW_DTR			BIT(20)
 #define ESP32P4_UART_RTS_INV			BIT(18)
 #define ESP32P4_UART_DTR_INV			BIT(19)
+#define ESP32P4_EARLYCON_TX_POLLS	10000
 
 struct esp32_port {
 	struct uart_port port;
@@ -334,18 +336,18 @@ static void esp32_uart_put_char(struct uart_port *port, u8 c)
 	esp32_uart_write(port, UART_FIFO_REG, c);
 }
 
-static void esp32_uart_put_char_sync(struct uart_port *port, u8 c)
+static void esp32_uart_put_char_sync(struct uart_port *port, u8 c,
+				     unsigned int polls)
 {
-	unsigned long timeout = jiffies + HZ;
-
-	while (esp32_uart_tx_fifo_cnt(port) >= ESP32_UART_TX_FIFO_SIZE) {
-		if (time_after(jiffies, timeout)) {
-			dev_warn(port->dev, "timeout waiting for TX FIFO\n");
+	/* Console writes can run before timer init or with interrupts disabled. */
+	while (polls--) {
+		if (esp32_uart_tx_fifo_cnt(port) < ESP32_UART_TX_FIFO_SIZE) {
+			esp32_uart_put_char(port, c);
 			return;
 		}
+
 		cpu_relax();
 	}
-	esp32_uart_put_char(port, c);
 }
 
 static void esp32_uart_transmit_buffer(struct uart_port *port)
@@ -601,7 +603,7 @@ static int esp32_uart_poll_init(struct uart_port *port)
 
 static void esp32_uart_poll_put_char(struct uart_port *port, unsigned char c)
 {
-	esp32_uart_put_char_sync(port, c);
+	esp32_uart_put_char_sync(port, c, ESP32_UART_TX_POLLS);
 }
 
 static int esp32_uart_poll_get_char(struct uart_port *port)
@@ -635,7 +637,7 @@ static const struct uart_ops esp32_uart_pops = {
 
 static void esp32_uart_console_putchar(struct uart_port *port, u8 c)
 {
-	esp32_uart_put_char_sync(port, c);
+	esp32_uart_put_char_sync(port, c, ESP32_UART_TX_POLLS);
 }
 
 static void esp32_uart_string_write(struct uart_port *port, const char *s,
@@ -718,7 +720,7 @@ static struct console esp32_uart_console = {
 
 static void esp32_uart_earlycon_putchar(struct uart_port *port, u8 c)
 {
-	esp32_uart_put_char_sync(port, c);
+	esp32_uart_put_char_sync(port, c, ESP32_UART_TX_POLLS);
 }
 
 static void esp32_uart_earlycon_write(struct console *con, const char *s,
@@ -784,6 +786,34 @@ static int __init esp32s3_uart_early_console_setup(struct earlycon_device *devic
 OF_EARLYCON_DECLARE(esp32s3uart, "esp,esp32s3-uart",
 		    esp32s3_uart_early_console_setup);
 
+static void esp32p4_uart_earlycon_putchar(struct uart_port *port, u8 c)
+{
+	esp32_uart_put_char_sync(port, c, ESP32P4_EARLYCON_TX_POLLS);
+}
+
+static void esp32p4_uart_earlycon_write(struct console *con, const char *s,
+					unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, esp32p4_uart_earlycon_putchar);
+}
+
+static int __init esp32p4_uart_early_console_setup(struct earlycon_device *device,
+						   const char *options)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	/* Use the UART configuration left by firmware. */
+	device->port.private_data = (void *)&esp32p4_variant;
+	device->con->write = esp32p4_uart_earlycon_write;
+
+	return 0;
+}
+OF_EARLYCON_DECLARE(esp32p4, "esp,esp32p4-uart",
+		    esp32p4_uart_early_console_setup);
+
 static struct uart_driver esp32_uart_reg = {
 	.owner		= THIS_MODULE,
 	.driver_name	= DRIVER_NAME,
-- 
2.56.1

