Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649493;
	b=zgqy9zyuua+1ip7xL4qPUxQVbFdUTmVXNsBC4x7Qq5ZXFzCryUmbCah2Rdup/bYQ5dHf
	 IrhoX6d1PBHzvqYfRf5KW5IDQHohyUAuiIavny4BoKZykdiblyit2x+B8k8MzQdXyCTs4
	 Jx/Foouy2OcOx78f4qXvXSZXG1yyDTO5wP2F384YQPZfCs5fhluyLJSqoQkCdLY0Le+7z
	 L7ZWR2Nd7Wl5Qv/FdHBLMezsZE9y55DR3s057hXJHnHauJJqCsPI5BBGEX+oX7HCrH2FE
	 AIMJNLjtEyf59GVlYt2Potq3OeTCtcz00vTgkj2+9pY4XR5TMYkPW5JUsF8ALoHs4Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Cf6MiC9aLyREtPGRrWON9xR4Ztcj11+KcwsAovolrF4=;
	b=bPWAEgGuW9soS6g4WcFptzlZSXR0g643nISufiUd0D7Nz0tKHh4pwGbz7D61L6pR5aPW
	 JSwFNTRGkZ1pST8z5MtwRFdEoWzAeP6pQdAVM0ogkibKd0mXoI+hji6+DYHJ9IlpqgWuj
	 JnJGujCbTfZh22P7r1sCNAeXKaxwh19JoVs6wHBfYb+txBVhY+2t7zVUWCtWMgYXRVuD7
	 G/b5yW5FIVb0trfnLHWIkTtZKpAZaYhS7ywczFTT1aQB51ZmMPHIrLd/xL9UpNKqkuEKO
	 LKd+sNCVnIMqKxOZDX6KtJ/yaO1hz8O+relvMRaguW54bAAux2ULBD8u/iQvlVAmAbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C+vnIwqv;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0EE606A338
	for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 23:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD0EE606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C+vnIwqv
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso63511595e9.1
        for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 15:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795649491; x=1796254291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cf6MiC9aLyREtPGRrWON9xR4Ztcj11+KcwsAovolrF4=;
        b=C+vnIwqvpAaoW/uXMhp8CY0+imCU6UwOUhGFZYFg442ZvilS4WqYNnZiTKq5FyemRD
         bq/MfOUMDdo/cL7nlm4wBHO8XVIpxrgg1LiIol1lMm24V/zUElaT+BDyWwFATjIH+wjf
         PIJNQADzUk0O3+21jna9dhKOQaZGs/soErqSYaaNoC9wzTwjwbiJL9FSlA/rVHoihlbp
         YI7bTndzjHrRAJuxN+t2hgSVV8ghhRJ16eoHauZob198fVGLGO/HJTa4OdicdmcS9/CP
         bAHFcobo+Z/b0Wr1o60pOa4orUZTyhOvy19WZyotvVCcCxoMxWTvFBBQyuZJ0md4FjoK
         ci9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795649491; x=1796254291;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cf6MiC9aLyREtPGRrWON9xR4Ztcj11+KcwsAovolrF4=;
        b=veduzhakb1ZjgEtQP2Yk1i1gwkyFXeBO2unUYr1VAOWn3fjaI4QDWksKDUp7UACYaB
         UGhg1EfX3KdoevmuPaw20qZQGf2FJp3dUa/w4VwsVObhCQaVLOslX5FsaOx48aE0Oijz
         BohA2aG2EXpwbrgqzUN7z/BRY9Dqe41yvj5nQo1FWfUfzygiH7gN/yDRvXomqBd/yqNA
         uDrz1tdex6PxNR85B/frHkmMWLQQl6sAZX+EBGUFK6iojka7W5Hq7pqX3jVXKVFklg2g
         xXGX5uqX851IwVAlWv+QyXiuKq8nbf0eZHe4nwczwUmYYVyy9k9NIliq/eaPROxdqLg4
         NHSQ==
X-Forwarded-Encrypted: i=1; AL+hErHVKo04Tiv/kC1GkIyiqhumvSQ2MNuUCdRLr7UhrVcL+O3VWgYv8h7RVNfvlxjBeMf6BD05Lw1p1p9vGt0=@vger.kernel.org
X-Gm-Message-State: APuU4Z867++xkKaGnq7b/eOFiF1gERJPRB/dO8IN0+ir/qatOPULco+S
	2dUZbHAka1YII5sEt0RiB1PNFt5/9CPDHLvGVnod/aQFzHSsBR2VpHTo
X-Gm-Gg: AZFdTZdJ+ugxgwVQwLvvL0jNUfY/B0ktKrUBYgAdV2HJpE1+osziidVUYT4+xd/q3I6
	rD6ZwF22s/ZmhkOfoYA3Ax3UBg8Mzk8OKrx+o5TJ0/77tajz+dxuBKnZ9F+ouBzEUMYW7+36vqM
	c2i8/Q4jrJMkm049xPDKgBcHg+jDXXa8pj11s9v5STbeaR64LOdzb7CrDVGBGJWos3/z+Lfu1xO
	p0GzZwUcP4+Fv8sjS0iwTpeyeWFM8JNgnlZvRUude2BI6mh/xYVIkv8vucUJBtwuIQrcnptIZFD
	Bap0OU6iqoT5lt52+0wQz3+TngOGx6iMF6v3NVKWGHpPP0s9gAKF8BmtQEFJjlSKEBgQVsENtr2
	YK+mAkme8Zb8ZNkOV1aHjHgV0Ig0M2b+Yf+UKuW0XgBs3ocpQ5TDWKsVkP2G17i6CPuzxd4Ryo5
	YWWMBfTOBfXOpaAHwvn4ieO/A3mUZz87KMncvvojOSy7KpTwf9IuLVbPRIoswWO+f6nWQoh596E
	VgugaiQSXyLuyj6bMhbmSLt/Ax0RF78D4oMP1jM37kjADvzBy4hH11929Ks3/8hnxaYp7VfmZJt
	Y+ygja9nTxybuhRm2tzwBPYqbaj24NH3e7Cz9HXuGuk9SeuYZY9Hvn1TdqhXK4iiMjY6B98mefq
	PwuBeMjhxgGv7YxpvmbCba43a/s2kl18=
X-Received: by 2002:a05:600c:3b83:b0:4b7:6b96:e431 with SMTP id 5b1f17b1804b1-4bb88822242mr450476545e9.28.1795649491157;
        Wed, 25 Nov 2026 15:31:31 -0800 (PST)
Received: from localhost (bl20-90-91.dsl.telepac.pt. [2.81.90.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9687sm618034375e9.10.2026.11.25.15.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 15:31:30 -0800 (PST)
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
Subject: [PATCH RFC 11/19] serial: esp32: Add support for the ESP32-P4 UART
Date: Wed, 25 Nov 2026 23:30:12 +0000
Message-ID: <20261125233020.1380594-12-vitorhg20080@gmail.com>
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

Enable the ESP32 UART driver on ESP32-P4 and describe the SoC's
register layout in the variant data. Synchronize configuration
writes to the UART clock domain and keep baud rate requests within
the limits of the ESP32-P4 divider.

Propagate IRQ lookup errors, including deferred probe. Serialize UART
port registration and removal, and clear the port table entry when
registration fails or the port is removed. Keep the console setup
callback available for probes after init memory is freed.

Tested on a Waveshare ESP32-P4-Module-DEV-KIT with the transmit
interrupt fix applied. Verified UART receive interrupts and serial
console operation.

AI assisted with driver development.

Signed-off-by: Vítor Hugo Silva <vitorhg20080@gmail.com>
---
 drivers/tty/serial/Kconfig      |   6 +-
 drivers/tty/serial/esp32_uart.c | 167 ++++++++++++++++++++++++++++----
 2 files changed, 151 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 83a37922fb07..6d3d3a342101 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -99,12 +99,14 @@ config SERIAL_EARLYCON_RISCV_SBI
 
 config SERIAL_ESP32
 	tristate "Espressif ESP32 UART support"
-	depends on COMPILE_TEST && OF && HAS_IOMEM
+	depends on OF && HAS_IOMEM
+	depends on RISCV_ESP32P4_CLIC || COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 	help
-	  Driver for the UART controllers of the Espressif ESP32xx SoCs.
+	  Driver for the UART controllers of the Espressif ESP32xx SoCs,
+	  including the ESP32-P4.
 	  When earlycon option is enabled the following kernel command line
 	  snippets may be used:
 	    earlycon=esp32s3uart,mmio32,0x60000000,115200n8,40000000
diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/tty/serial/esp32_uart.c
index 8f257cf0d290..304e1345518b 100644
--- a/drivers/tty/serial/esp32_uart.c
+++ b/drivers/tty/serial/esp32_uart.c
@@ -6,10 +6,13 @@
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/printk.h>
 #include <linux/property.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
@@ -89,6 +92,22 @@
 	 ESP32S3_UART_SCLK_EN | \
 	 FIELD_PREP(ESP32S3_UART_SCLK_SEL, XTAL_CLK))
 
+#define ESP32P4_UART_CLKDIV			GENMASK(11, 0)
+#define ESP32P4_UART_RXFIFO_CNT			GENMASK(7, 0)
+#define ESP32P4_UART_TXFIFO_CNT			GENMASK(23, 16)
+#define ESP32P4_UART_TXFIFO_EMPTY_THRHD_SHIFT	8
+
+/* ESP32-P4 uses a dedicated register for RX flow control. */
+#define ESP32P4_UART_HWFC_CONF_REG		0x2c
+#define ESP32P4_UART_RX_FLOW_EN			BIT(8)
+#define ESP32P4_UART_REG_UPDATE_REG		0x98
+#define ESP32P4_UART_REG_UPDATE			BIT(0)
+#define ESP32P4_UART_LOOPBACK			BIT(12)
+#define ESP32P4_UART_SW_RTS			BIT(21)
+#define ESP32P4_UART_SW_DTR			BIT(20)
+#define ESP32P4_UART_RTS_INV			BIT(18)
+#define ESP32P4_UART_DTR_INV			BIT(19)
+
 struct esp32_port {
 	struct uart_port port;
 	struct clk *clk;
@@ -99,9 +118,16 @@ struct esp32_uart_variant {
 	u32 rxfifo_cnt_mask;
 	u32 txfifo_cnt_mask;
 	u32 txfifo_empty_thrhd_shift;
+	u32 rx_flow_reg;
 	u32 rx_flow_en;
+	u32 loopback_mask;
+	u32 sw_rts_mask;
+	u32 sw_dtr_reg;
+	u32 sw_dtr_mask;
+	u32 mctrl_inv_mask;
 	const char *type;
 	bool has_clkconf;
+	bool needs_reg_update;
 };
 
 static const struct esp32_uart_variant esp32_variant = {
@@ -109,8 +135,14 @@ static const struct esp32_uart_variant esp32_variant = {
 	.rxfifo_cnt_mask = ESP32_UART_RXFIFO_CNT,
 	.txfifo_cnt_mask = ESP32_UART_TXFIFO_CNT,
 	.txfifo_empty_thrhd_shift = ESP32_UART_TXFIFO_EMPTY_THRHD_SHIFT,
+	.rx_flow_reg = UART_CONF1_REG,
 	.rx_flow_en = ESP32_UART_RX_FLOW_EN,
 	.type = "ESP32 UART",
+	.loopback_mask = UART_LOOPBACK,
+	.sw_rts_mask = UART_SW_RTS,
+	.sw_dtr_reg = UART_CONF0_REG,
+	.sw_dtr_mask = UART_SW_DTR,
+	.mctrl_inv_mask = UART_RTS_INV | UART_DTR_INV,
 };
 
 static const struct esp32_uart_variant esp32s3_variant = {
@@ -118,9 +150,31 @@ static const struct esp32_uart_variant esp32s3_variant = {
 	.rxfifo_cnt_mask = ESP32S3_UART_RXFIFO_CNT,
 	.txfifo_cnt_mask = ESP32S3_UART_TXFIFO_CNT,
 	.txfifo_empty_thrhd_shift = ESP32S3_UART_TXFIFO_EMPTY_THRHD_SHIFT,
+	.rx_flow_reg = UART_CONF1_REG,
 	.rx_flow_en = ESP32S3_UART_RX_FLOW_EN,
 	.type = "ESP32S3 UART",
 	.has_clkconf = true,
+	.loopback_mask = UART_LOOPBACK,
+	.sw_rts_mask = UART_SW_RTS,
+	.sw_dtr_reg = UART_CONF0_REG,
+	.sw_dtr_mask = UART_SW_DTR,
+	.mctrl_inv_mask = UART_RTS_INV | UART_DTR_INV,
+};
+
+static const struct esp32_uart_variant esp32p4_variant = {
+	.clkdiv_mask = ESP32P4_UART_CLKDIV,
+	.rxfifo_cnt_mask = ESP32P4_UART_RXFIFO_CNT,
+	.txfifo_cnt_mask = ESP32P4_UART_TXFIFO_CNT,
+	.txfifo_empty_thrhd_shift = ESP32P4_UART_TXFIFO_EMPTY_THRHD_SHIFT,
+	.rx_flow_reg = ESP32P4_UART_HWFC_CONF_REG,
+	.rx_flow_en = ESP32P4_UART_RX_FLOW_EN,
+	.type = "ESP32-P4 UART",
+	.needs_reg_update = true,
+	.loopback_mask = ESP32P4_UART_LOOPBACK,
+	.sw_rts_mask = ESP32P4_UART_SW_RTS,
+	.sw_dtr_reg = UART_CONF1_REG,
+	.sw_dtr_mask = ESP32P4_UART_SW_DTR,
+	.mctrl_inv_mask = ESP32P4_UART_RTS_INV | ESP32P4_UART_DTR_INV,
 };
 
 static const struct of_device_id esp32_uart_dt_ids[] = {
@@ -130,10 +184,14 @@ static const struct of_device_id esp32_uart_dt_ids[] = {
 	}, {
 		.compatible = "esp,esp32s3-uart",
 		.data = &esp32s3_variant,
+	}, {
+		.compatible = "esp,esp32p4-uart",
+		.data = &esp32p4_variant,
 	}, { /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, esp32_uart_dt_ids);
 
+static DEFINE_MUTEX(esp32_uart_ports_lock);
 static struct esp32_port *esp32_uart_ports[UART_NR];
 
 static const struct esp32_uart_variant *port_variant(struct uart_port *port)
@@ -143,7 +201,24 @@ static const struct esp32_uart_variant *port_variant(struct uart_port *port)
 
 static void esp32_uart_write(struct uart_port *port, unsigned long reg, u32 v)
 {
+	void __iomem *update = port->membase + ESP32P4_UART_REG_UPDATE_REG;
+	u32 status;
+
 	writel(v, port->membase + reg);
+
+	if (reg != UART_CLKDIV_REG && reg != UART_CONF0_REG &&
+	    reg != ESP32P4_UART_HWFC_CONF_REG)
+		return;
+
+	if (!port_variant(port)->needs_reg_update)
+		return;
+
+	/* Commit configuration to UART core clock domain. */
+	writel(ESP32P4_UART_REG_UPDATE, update);
+	if (readl_poll_timeout_atomic(update, status,
+				      !(status & ESP32P4_UART_REG_UPDATE),
+				      1, 100))
+		printk_deferred_once(DRIVER_NAME ": UART register update timed out\n");
 }
 
 static u32 esp32_uart_read(struct uart_port *port, unsigned long reg)
@@ -173,18 +248,29 @@ static unsigned int esp32_uart_tx_empty(struct uart_port *port)
 
 static void esp32_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	u32 conf0 = esp32_uart_read(port, UART_CONF0_REG);
+	const struct esp32_uart_variant *variant = port_variant(port);
+	bool dtr_in_conf0 = variant->sw_dtr_reg == UART_CONF0_REG;
+	u32 conf0, dtr_conf;
 
-	conf0 &= ~(UART_LOOPBACK |
-		   UART_SW_RTS | UART_RTS_INV |
-		   UART_SW_DTR | UART_DTR_INV);
+	conf0 = esp32_uart_read(port, UART_CONF0_REG);
+	conf0 &= ~(variant->loopback_mask | variant->sw_rts_mask);
 
 	if (mctrl & TIOCM_RTS)
-		conf0 |= UART_SW_RTS;
-	if (mctrl & TIOCM_DTR)
-		conf0 |= UART_SW_DTR;
+		conf0 |= variant->sw_rts_mask;
 	if (mctrl & TIOCM_LOOP)
-		conf0 |= UART_LOOPBACK;
+		conf0 |= variant->loopback_mask;
+
+	/* Software DTR and RTS/DTR inversion share a register. */
+	dtr_conf = dtr_in_conf0 ? conf0 : esp32_uart_read(port, variant->sw_dtr_reg);
+	dtr_conf &= ~(variant->sw_dtr_mask | variant->mctrl_inv_mask);
+
+	if (mctrl & TIOCM_DTR)
+		dtr_conf |= variant->sw_dtr_mask;
+
+	if (dtr_in_conf0)
+		conf0 = dtr_conf;
+	else
+		esp32_uart_write(port, variant->sw_dtr_reg, dtr_conf);
 
 	esp32_uart_write(port, UART_CONF0_REG, conf0);
 }
@@ -387,13 +473,37 @@ static bool esp32_uart_set_baud(struct uart_port *port, u32 baud)
 	return false;
 }
 
+static void esp32p4_uart_limit_baud_rate(struct ktermios *termios,
+					 const struct ktermios *old,
+					 u32 min_baud, u32 max_baud)
+{
+	u32 baud = tty_termios_baud_rate(termios);
+
+	if (!baud || (baud >= min_baud && baud <= max_baud))
+		return;
+
+	if (old) {
+		u32 old_baud = tty_termios_baud_rate(old);
+
+		if (old_baud && old_baud >= min_baud && old_baud <= max_baud)
+			baud = old_baud;
+	}
+
+	baud = clamp(baud, min_baud, max_baud);
+	/* Keep the fallback exact near a standard rate outside the range. */
+	termios->c_cflag &= ~(CBAUD | (CBAUD << IBSHIFT));
+	termios->c_cflag |= BOTHER;
+	tty_termios_encode_baud_rate(termios, baud, baud);
+}
+
 static void esp32_uart_set_termios(struct uart_port *port,
 				   struct ktermios *termios,
 				   const struct ktermios *old)
 {
 	unsigned long flags;
-	u32 conf0, conf1;
-	u32 baud;
+	u32 conf0, flow;
+	u32 baud, min_baud, max_baud;
+	const u32 rx_flow_reg = port_variant(port)->rx_flow_reg;
 	const u32 rx_flow_en = port_variant(port)->rx_flow_en;
 	u32 max_div = port_variant(port)->clkdiv_mask;
 
@@ -402,17 +512,19 @@ static void esp32_uart_set_termios(struct uart_port *port,
 	if (port_variant(port)->has_clkconf)
 		max_div *= FIELD_MAX(ESP32S3_UART_SCLK_DIV_NUM);
 
-	baud = uart_get_baud_rate(port, termios, old,
-				  port->uartclk / max_div,
-				  port->uartclk / 16);
+	min_baud = port->uartclk / max_div;
+	max_baud = port->uartclk / 16;
+	if (port_variant(port) == &esp32p4_variant)
+		esp32p4_uart_limit_baud_rate(termios, old, min_baud, max_baud);
+	baud = uart_get_baud_rate(port, termios, old, min_baud, max_baud);
 
 	spin_lock_irqsave(&port->lock, flags);
 
 	conf0 = esp32_uart_read(port, UART_CONF0_REG);
 	conf0 &= ~(UART_PARITY_EN | UART_PARITY | UART_BIT_NUM | UART_STOP_BIT_NUM);
 
-	conf1 = esp32_uart_read(port, UART_CONF1_REG);
-	conf1 &= ~rx_flow_en;
+	flow = esp32_uart_read(port, rx_flow_reg);
+	flow &= ~rx_flow_en;
 
 	if (termios->c_cflag & PARENB) {
 		conf0 |= UART_PARITY_EN;
@@ -441,10 +553,10 @@ static void esp32_uart_set_termios(struct uart_port *port,
 		conf0 |= FIELD_PREP(UART_STOP_BIT_NUM, UART_STOP_BIT_NUM_1);
 
 	if (termios->c_cflag & CRTSCTS)
-		conf1 |= rx_flow_en;
+		flow |= rx_flow_en;
 
 	esp32_uart_write(port, UART_CONF0_REG, conf0);
-	esp32_uart_write(port, UART_CONF1_REG, conf1);
+	esp32_uart_write(port, rx_flow_reg, flow);
 
 	if (baud) {
 		esp32_uart_set_baud(port, baud);
@@ -715,29 +827,44 @@ static int esp32_uart_probe(struct platform_device *pdev)
 	if (IS_ERR(sport->clk))
 		return PTR_ERR(sport->clk);
 
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
+
 	port->uartclk = clk_get_rate(sport->clk);
 	port->dev = &pdev->dev;
 	port->type = PORT_GENERIC;
 	port->iotype = UPIO_MEM;
-	port->irq = platform_get_irq(pdev, 0);
+	port->irq = ret;
 	port->ops = &esp32_uart_pops;
 	port->flags = UPF_BOOT_AUTOCONF;
 	port->has_sysrq = 1;
 	port->fifosize = ESP32_UART_TX_FIFO_SIZE;
 	port->private_data = (void *)device_get_match_data(&pdev->dev);
 
+	guard(mutex)(&esp32_uart_ports_lock);
+	if (esp32_uart_ports[port->line])
+		return -EBUSY;
+
+	/* Console setup can look up the port during registration. */
 	esp32_uart_ports[port->line] = sport;
+	ret = uart_add_one_port(&esp32_uart_reg, port);
+	if (ret) {
+		esp32_uart_ports[port->line] = NULL;
+		return ret;
+	}
 
 	platform_set_drvdata(pdev, port);
-
-	return uart_add_one_port(&esp32_uart_reg, port);
+	return 0;
 }
 
 static void esp32_uart_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 
+	guard(mutex)(&esp32_uart_ports_lock);
 	uart_remove_one_port(&esp32_uart_reg, port);
+	esp32_uart_ports[port->line] = NULL;
 }
 
 
-- 
2.56.1

