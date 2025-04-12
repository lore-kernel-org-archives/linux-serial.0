Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E477BA53;
	Sat, 12 Apr 2025 00:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744417566; cv=none; b=oUSBuwwmmfxMcPrYBVxgXDlBkFQkheQ4A1F7OWh0OWr5rSC5YrJuCtahuweGuEEspPsdbeG6r+yiFSKAc/znpYFNcO4Esmvqd3zy9rBKK0Wvkr9aghMO9xYruiELFIWC9JUheSMjPKJLHqujcBO4yo8dzU96+Nh5wSA60YmTNx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744417566; c=relaxed/simple;
	bh=PM+FXBeTiSrq40QjWHzwr/A/N/KtBXnSLnr4+GjbAQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Khk7bllOkr2YXT75gWPpW7qcRERI9mZxnahamMNP88+1n4gDYG6z5yCMBsXypmDcU8+6+YIsK8BcCd5pGX5izctPsS60R/ezBPYM0xfhD1nL12s7fMV4feM9LoptMepACUq7cRGSqEkX7J2QiyvVY/BwpKNe+/W4vcAxK0dvo/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8nuYI3q; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8nuYI3q"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-224191d92e4so26280515ad.3;
        Fri, 11 Apr 2025 17:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744417563; x=1745022363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WPh3Lw9dyl7oBJ7A7OStIjrcHnhiJHHTBrQQ+YXhdeo=;
        b=Q8nuYI3qCY4L5OpsXxECsKDthPe2NgVrj8wSY3FlyNvjhPb1EmHtofpr7C2h/gjCI3
         9tVvQW4Ek/tm1rgSE2Vlpj8eXnKxRwcM0Ofxk1vyi8wQmNT5jLM8UHpQLOPgQcn5CRNX
         pgcTf6UzTSiqh/pTxJOH8kxTVyKEyDteqma9UrA/sNRYUPuq1It75WIewvO0PL6PkugC
         wec5F4HqUDR0T2qZ7WGm/uQ50wXepucMpVccYyowhUk72FvJvRGNnP1H2JAoG/5Z/8na
         9GdaODf1zEGmqt4o2wmBnlT0POciA6DN4BgX4rn6JmGEa5wyipK5fwu2VCB2j3KKuv5s
         JTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744417563; x=1745022363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPh3Lw9dyl7oBJ7A7OStIjrcHnhiJHHTBrQQ+YXhdeo=;
        b=j/tJ2fo60PJ6Gignnu/TgdEHkyJBNwdxKqz0u93CxBKoSwdBhGY7KNe1vvj5Wv34mV
         nhEkKjuPKp8G2WwfwNikoPfxn/f/oVGCGsobL52pXLR+qPcQLTsFWAOxmC9XBLNJFDrP
         C8+mPOrkC4HYnMuaLdrlX+oDUDn89tV8AQ0b8eQCIFJtiNyAqyupeV2PC6VezWN+Rtpk
         bEau81EkI4J9fvo7dJR7ePQbOzTNYk6GfTC6uPvP8IN/whSznygcrgb1MW6Pincdpxdm
         MkXP2Xrx4/oKPUKzoVkbip73oQ4GozXydgmBQ/mbkZC6A+otXVld9q63GUryOcpllp7Y
         Qddg==
X-Forwarded-Encrypted: i=1; AJvYcCXJbT5NG1Iyz4AWJXw1iU1YHMzGglnG9Eyw30I9r/WG6xoPWThyJGX73yhqZqiLDmC5WsN+cxEb22AHoZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyghw4CPO9QVTFmVqWwym+StHOcltrW/d8Y7ItPODUU+b5cOEfc
	MjDt8O9/JIRb+Yg0tcgHmaMh6P6u4MMvVybcqdUjV435KHLl66OG
X-Gm-Gg: ASbGnctAxVXHlQZHN239jErWzwS3NpeGAUxN5lud0ZndlrpJa4/WyMaRIS0fs9UINYB
	lC0Gw0LNqgbAzIy9M4nHJ7N8qBHIO3RlkqYSKDLeGHZYAvl6zNe5Euz1LOy+kYLKJK5jFn16Tgz
	Iswl8vIzXD53rMYw5LaLhCJ6EVR/a23dquyyw57BjwCd1j5vVEFMG88BO2uw5EbuD1w6nSbhGdD
	EedVhe5dW5n7rrBcpv0ucGN1rjBiIwZsSPKIc19nRWa3jpaIYRJsMyfHme7ATe2xWzFK6cBH7hm
	BbRCAN+ahr2Omhq6MxfX56HTR0+GGLyWrXGEA3MXKQ8o3EhebBNVnSAkljrwcax8D7iN+OTIPUh
	FvJzz6OfepET44m4xxzhjZW5HNQIRh9XQ6H60tQ==
X-Google-Smtp-Source: AGHT+IHNMCmo/zYLdO9QUIUBBdZzNR4oWzDbUlcg7z8C3X1JbFehjejVr9yom0CX0KeOdepN99ml8g==
X-Received: by 2002:a17:903:2f8e:b0:224:160d:3f5b with SMTP id d9443c01a7336-22bea502b47mr58301375ad.49.1744417563376;
        Fri, 11 Apr 2025 17:26:03 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cc9202sm56878125ad.211.2025.04.11.17.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 17:26:03 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	bigeasy@linutronix.de,
	conor.dooley@microchip.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pmladek@suse.com,
	samuel.holland@sifive.com,
	u.kleine-koenig@baylibre.com
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH v3] serial: sifive: Switch to nbcon console
Date: Sat, 12 Apr 2025 09:25:44 +0900
Message-Id: <20250412002544.185038-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the necessary callbacks(write_atomic, write_thread, device_lock
and device_unlock) and CON_NBCON flag to switch the sifive console
driver to perform as nbcon console.

Both ->write_atomic() and ->write_thread() will check for console
ownership whenever they are accessing registers.

The ->device_lock()/unlock() will provide the additional serilization
necessary for ->write_thread() which is called from dedicated printing
thread.

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---

Changes since v1:
https://lore.kernel.org/all/20250405043833.397020-1-ryotkkr98@gmail.com/

- It was sent as part of series but resent as a single patch.

Changes since v2:
https://lore.kernel.org/linux-serial/20250405145915.493173-1-ryotkkr98@gmail.com/

- Add description for @console_line_ended.
- Add Reviewed-by by Petr. Thanks Petr for the review!

---
 drivers/tty/serial/sifive.c | 88 +++++++++++++++++++++++++++++++------
 1 file changed, 75 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 054a8e630..110d67613 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -141,6 +141,7 @@
  * @baud_rate: UART serial line rate (e.g., 115200 baud)
  * @clk: reference to this device's clock
  * @clk_notifier: clock rate change notifier for upstream clock changes
+ * @console_line_ended: indicate that the console line is fully written
  *
  * Configuration data specific to this SiFive UART.
  */
@@ -151,6 +152,7 @@ struct sifive_serial_port {
 	unsigned long		baud_rate;
 	struct clk		*clk;
 	struct notifier_block	clk_notifier;
+	bool			console_line_ended;
 };
 
 /*
@@ -785,33 +787,88 @@ static void sifive_serial_console_putchar(struct uart_port *port, unsigned char
 
 	__ssp_wait_for_xmitr(ssp);
 	__ssp_transmit_char(ssp, ch);
+
+	ssp->console_line_ended = (ch == '\n');
+}
+
+static void sifive_serial_device_lock(struct console *co, unsigned long *flags)
+{
+	struct uart_port *up = &sifive_serial_console_ports[co->index]->port;
+
+	__uart_port_lock_irqsave(up, flags);
+}
+
+static void sifive_serial_device_unlock(struct console *co, unsigned long flags)
+{
+	struct uart_port *up = &sifive_serial_console_ports[co->index]->port;
+
+	__uart_port_unlock_irqrestore(up, flags);
 }
 
-static void sifive_serial_console_write(struct console *co, const char *s,
-					unsigned int count)
+static void sifive_serial_console_write_atomic(struct console *co,
+					       struct nbcon_write_context *wctxt)
 {
 	struct sifive_serial_port *ssp = sifive_serial_console_ports[co->index];
-	unsigned long flags;
+	struct uart_port *port = &ssp->port;
 	unsigned int ier;
-	int locked = 1;
 
 	if (!ssp)
 		return;
 
-	if (oops_in_progress)
-		locked = uart_port_trylock_irqsave(&ssp->port, &flags);
-	else
-		uart_port_lock_irqsave(&ssp->port, &flags);
+	if (!nbcon_enter_unsafe(wctxt))
+		return;
 
 	ier = __ssp_readl(ssp, SIFIVE_SERIAL_IE_OFFS);
 	__ssp_writel(0, SIFIVE_SERIAL_IE_OFFS, ssp);
 
-	uart_console_write(&ssp->port, s, count, sifive_serial_console_putchar);
+	if (!ssp->console_line_ended)
+		uart_console_write(port, "\n", 1, sifive_serial_console_putchar);
+	uart_console_write(port, wctxt->outbuf, wctxt->len,
+			   sifive_serial_console_putchar);
 
 	__ssp_writel(ier, SIFIVE_SERIAL_IE_OFFS, ssp);
 
-	if (locked)
-		uart_port_unlock_irqrestore(&ssp->port, flags);
+	nbcon_exit_unsafe(wctxt);
+}
+
+static void sifive_serial_console_write_thread(struct console *co,
+					       struct nbcon_write_context *wctxt)
+{
+	struct sifive_serial_port *ssp = sifive_serial_console_ports[co->index];
+	struct uart_port *port = &ssp->port;
+	unsigned int ier;
+
+	if (!ssp)
+		return;
+
+	if (!nbcon_enter_unsafe(wctxt))
+		return;
+
+	ier = __ssp_readl(ssp, SIFIVE_SERIAL_IE_OFFS);
+	__ssp_writel(0, SIFIVE_SERIAL_IE_OFFS, ssp);
+
+	if (nbcon_exit_unsafe(wctxt)) {
+		int len = READ_ONCE(wctxt->len);
+		int i;
+
+		for (i = 0; i < len; i++) {
+			if (!nbcon_enter_unsafe(wctxt))
+				break;
+
+			uart_console_write(port, wctxt->outbuf + i, 1,
+					   sifive_serial_console_putchar);
+
+			if (!nbcon_exit_unsafe(wctxt))
+				break;
+		}
+	}
+
+	while (!nbcon_enter_unsafe(wctxt))
+		nbcon_reacquire_nobuf(wctxt);
+
+	__ssp_writel(ier, SIFIVE_SERIAL_IE_OFFS, ssp);
+
+	nbcon_exit_unsafe(wctxt);
 }
 
 static int sifive_serial_console_setup(struct console *co, char *options)
@@ -829,6 +886,8 @@ static int sifive_serial_console_setup(struct console *co, char *options)
 	if (!ssp)
 		return -ENODEV;
 
+	ssp->console_line_ended = true;
+
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 
@@ -839,10 +898,13 @@ static struct uart_driver sifive_serial_uart_driver;
 
 static struct console sifive_serial_console = {
 	.name		= SIFIVE_TTY_PREFIX,
-	.write		= sifive_serial_console_write,
+	.write_atomic	= sifive_serial_console_write_atomic,
+	.write_thread	= sifive_serial_console_write_thread,
+	.device_lock	= sifive_serial_device_lock,
+	.device_unlock	= sifive_serial_device_unlock,
 	.device		= uart_console_device,
 	.setup		= sifive_serial_console_setup,
-	.flags		= CON_PRINTBUFFER,
+	.flags		= CON_PRINTBUFFER | CON_NBCON,
 	.index		= -1,
 	.data		= &sifive_serial_uart_driver,
 };
-- 
2.34.1

