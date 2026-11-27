Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795808369;
	b=TczohelnJ/lHNt2AX+jOJzgST5pl4JIFUI/fZ0iEokU9n3ybvGC3ija+TQyenmlDXmno
	 B63mZsumuVFGRZgDsMnbrBr8IDMTcsvGH+xmeEaZrwRqPf84/Mwob0aFrLFRZBplM7rSv
	 xSDarW4WYEN7h53X+EPcM2A7njeOIybf3FbbwRoTGInp7l2d9cUveaCI+WctDOv/loK1D
	 cg+oAnIazkqZOpnuviJ+5RFa/bAH8O+rE9FPgBsvXZvmgfaJj8TIArhDs1dQ/yOtGlgFY
	 qI5OuGG9Sfez/eZ2u8I4yA1Te6r1Xxh9CIqD+xXPGDUCVihb0/KcqBsRIQ7bdRdw/4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795808369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=MM2MNnyxl9D846ZGaHkuqg5jtRzhYh+OqM1NyeJs/HE=;
	b=MMXv5ujJRIa3dv9pNEUQt1iCeADRpo8TLo5RE094FfuoPz0qtidgUjrH2I669rO5s1OC
	 K3iUvuCLIXaj8GTgpUSP6A4zIujMUuG4qIkn3Q32u9VwURLa6LhRo+AUAnbYu+CzZG1zu
	 456tLTXRQwB6z67+qozNacxsWjNWSiUaFZlMr6TirSjIfn4bRVTb/0kPkh+RGRy+VGnEA
	 nrs27iiIXVr1iciIwPBNHhKyi0PEEhyjwVZ2T9Ev+nk1x1asGy1wm/uEuZPqBhaJL5pfS
	 QAtrl8GhySy2HSFlwM3SSBrc/qQUonH1uAGf/I8hKOgPIC4ZoUSXnGlPWI0+xIidQCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NV5kd05X;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABD5606A31F
	for <linux-serial@vger.kernel.org>; Fri, 27 Nov 2026 19:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AABD5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NV5kd05X
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so72764335e9.0
        for <linux-serial@vger.kernel.org>; Fri, 27 Nov 2026 11:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795808367; x=1796413167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MM2MNnyxl9D846ZGaHkuqg5jtRzhYh+OqM1NyeJs/HE=;
        b=NV5kd05XjTpmJhqs8d6BgOFT/cc+m9+bvr7drRg68fhKapWZCQIieYMddEZxHd0goG
         yIk7swGCvgbMoviHUgKlO/3aZky95FhcKiSztbtItwMCirlbGSzvJCs/3LRyFGP2CWRx
         XLswxvYhAngUbTE9rPIBjE0SHDOBhZU12qQdVndLlZRWBjGwaC6+bgNFHRexjvq/n1hm
         oEagRL95z/uLxolLn33n8oDp4mwrhBYf8MQqlea80ctlpLz8PR13yS4LJNYPE0qxorBb
         sYQjx+EAsWYQQPy3clOi9KXmXrl6w9CKaV6TTibX16aeW6dv2x1dDOEqMFo5J2/PTAWj
         rSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795808367; x=1796413167;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MM2MNnyxl9D846ZGaHkuqg5jtRzhYh+OqM1NyeJs/HE=;
        b=Lp37Xb9//Rtu5ur9MiWmnntLE2jyA+l8oUllUcRMN5zTdYG7XPcLQjZLl5Ksze2l6n
         KCF/31ylIVnmQXyWH9gMNUaT5L+Q27s63EMH71sJ2vPJD4xCgL/Q4GElzVqMy8QWF1WL
         FoGwkZfuAzpLhG+nmRjc744it/OuO97n2FPKQVLD5a5agweKQikTU4Crxigs27Ve1dYT
         H8ZGsmQq7cWtd49WImvbQcM0avZ2q1vqd45AKEKrVtAM/8WW9ATSQUubbzr+4kc1IExl
         Ahri0tRvRlUMU/SQw7XqQOWtkEuoc6lTRxJyuQrkZ8qWppZJvl+dktjWPsv0VgWsTI0n
         vwqg==
X-Gm-Message-State: APuU4Z+WNX1Mc1ZKCEr/CzfyHgdJSuj8oG0LsWzGRWMzHhXCakfwFikL
	9+3X4/iou8Pi10p/FmjDbPfeKMJZPOVKTYMOiJa1KgOM9V6Qy5GGDdSmaXVW8FMcQoc=
X-Gm-Gg: AZFdTZfIW6p3oP0JMqZF2QQmY2jaAO2KvYV8PVnt0GjkFYmthUr5S98Pjzn4aFl9k2x
	V14Xq8rpGIGDEg63wVYBq0IaCGBZOsKqslPzOH45abPm6qtWXnIunC+T/3hxldHq4mYuSa3RtmH
	Lex2T4cKads3stC/iYMff8PL8568wUirDi8ys9Q2zWo1dtHNlfDfmoHGELj2GdMl1JNaZpAIADr
	DVtNAk4tV0041stqPA1WHfbc12KxWELxkQkzW/SNJ6gYo108ep3G+k6pAJ+y9yZWJgscTplE7Ly
	ulba9EDDVOhKGDH0u2n0XTNWkAHnHFH1rbXtBUisWDUltd3q6jGlGyu5+bbAYKRAD1toCicI3vz
	8zNo8shGPhL33Gtzj+x9ZymQbgXgOozCcIWDcp8NrAPltLhmW6nitTp2mkpsPTWoFfrMlnY4+mP
	jrqa6nFRY+QK4FTTaf5lGbDyW35VvkqjAbtkBz4cI31PftuHl7TSL6hKHDgGxPjVq/Gh06HYL5d
	4bCfbnpjCuKY1F/5uWSk+6LRqgPYYzciOsAhSbXDoKp8bX252jyu1l/NOdL5g8ie4PoJ3Cl6qSA
	hcC9Q45t+HcE29ohzJzOxYhNl5j3KExZkzGouXMVoHNJufcmZ2L9pLfkjLriJr/dS/IQoYsyRsr
	bCaj0Jwk=
X-Received: by 2002:a05:600c:820d:b0:4bb:5de1:e923 with SMTP id 5b1f17b1804b1-4bb887c33f7mr491159125e9.4.1795808366926;
        Fri, 27 Nov 2026 11:39:26 -0800 (PST)
Received: from localhost (bl20-90-91.dsl.telepac.pt. [2.81.90.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9846sm839858545e9.11.2026.11.27.11.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:39:26 -0800 (PST)
From: =?UTF-8?q?V=C3=ADtor=20Hugo=20Silva?= <vitorhg20080@gmail.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	=?UTF-8?q?V=C3=ADtor=20Hugo=20Silva?= <vitorhg20080@gmail.com>
Subject: [PATCH RFC v2] serial: esp32: Add support for the ESP32-P4 UART
Date: Fri, 27 Nov 2026 19:39:14 +0000
Message-ID: <20261127193914.176120-1-vitorhg20080@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125233020.1380594-12-vitorhg20080@gmail.com>
References: <20261125233020.1380594-12-vitorhg20080@gmail.com>
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
registration fails or the port is removed.

Tested on a Waveshare ESP32-P4-Module-DEV-KIT with the transmit
interrupt fix applied. Verified UART receive interrupts and serial
console operation.

AI assisted with driver development.

Signed-off-by: Vítor Hugo Silva <vitorhg20080@gmail.com>
---
Changes in v2:
- Remove the console setup sentence from the commit message. Patch 10/19
  already keeps the console setup callback in regular text.

This replaces patch 11/19 and applies after patch 10/19 of the RFC.
v1: https://lore.kernel.org/linux-serial/20261125233020.1380594-12-vitorhg20080@gmail.com/

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

