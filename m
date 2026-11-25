Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649487;
	b=0P1T8baslH4+l1KgzP9czGmLIKP9lPIUmY8PZFJrpuph+8SQCGNzXPWptWVLvrwAyqYN
	 6E78Kxn1Ye5iXdKjsdX09GGnXNf67GfobtckJ13vUkO7l9Zj2HayEEOrXIkiZGg3mMMKJ
	 q3/73HSuy0CSgFSYrkyNiJ1Po+O7aE3h1O4F5yGUw17F7l8ngjNn8U4EfaUHjSqKzBvxH
	 G0V5pKSkYprHVDhEemGiqsqfFYXBQFkcF4SoHU6PitXzNynbFHwDb1aRM0yAhXgpJqHIf
	 M8HyCBDzGn5DUaUeSYgrYcp01Ewcw9nMMNI0cjNji3Vey6NSC7bpQIHCK+L02IYTZPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+L7beDK9IObD+BXMTkdZR/1GOkfRKiL5pe9seyDyKJY=;
	b=Vdo0QHXEutqsL/oAm84XPXmLgGuMAzLUxLmBE5RtShTs2Eeq4VklbGgNw8LmRRwfvJzW
	 DxjzHKJRg/adiwQdaH82QJ9VGxUYKGh0YqMaOcOGNe2KvIeSkk1giXHGbkL58WVDKRZeh
	 ZNo1gWGaSeMYUM2hFl0+3OZ6hGPyqiHgZRFRdXGkwXwV3X5WMwxBP/AhV8ojnw+5Ghev4
	 GJ/WyNlRe4aeBCqan7B32zdWkCqIoPsMfM4necMY0AQVRoNbCZKcPmgT4D6/T0tPgBTmJ
	 HUCGna9VHAJWH1wNzoQcGIpOzn0nJSYem9fPaVsKqeqGkrXgHT2RrpyqW1H6P+E/nTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IBhiTN7e;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447EB606A33C
	for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 23:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 447EB606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IBhiTN7e
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e46e449e8so4127433f8f.3
        for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 15:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795649485; x=1796254285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+L7beDK9IObD+BXMTkdZR/1GOkfRKiL5pe9seyDyKJY=;
        b=IBhiTN7e3Jxj95QDskmyT5mTWPOE/Xp1Gxw7IraEqLj+0ERLlBQtW9YcBgEPRzo+b5
         Cbfnu3cTDrDGwEqlK3AImJudYgeKskXADMEMdjhJxuYHCiLD1Ebov09Y81+L/ZsEZsoL
         XMlMveM/M+slx7q5q1fE7PMIoXB8TKGcgnsgmnD5MLovtSD/X3HveEtsGEZCy0RyGWWP
         XM7w653K3feu4awuTIs6KQ1vs329dKspklErXuBW8BLr9p/AtFm9r8jVvDD/iAmt83J/
         PoTxmz+JG1ec5QgukpNlF6zXDQnBFbYtcsQSS/F0y+/dzCb0X0T0/kuLfzvihPabwxGN
         F9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795649485; x=1796254285;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+L7beDK9IObD+BXMTkdZR/1GOkfRKiL5pe9seyDyKJY=;
        b=MPPP9AO0Wc1E0mMvCd3eZb3elclFrFiwQXIxsV5J8lYtZ88FsRLprqHLOr7q25dfFZ
         BQvxV1h4V09owgS3zOGct9sxcn6O2HLxKqQSr0/sxHe9JUQW+x8BGgCDRMnmZlJMQUyP
         s//j2pvz6vdJNBaU4fFy3qB5SEYTp/xp3ct08nUk+FkAZu32Uf95OFRUW7fG7Zmul1LF
         DKBQ1dclU35rBNo0o7ev2XlZItpKB+m/CQjfzeQa7+tjRahXl1uLvduIvTucQfZVRA3X
         +GpQuaSkZJd9B9Bj/1Jyi6HNYCE0X02zAvZEzPCzbC38jZbpjx95rB1xGhEUJBLpI5hR
         4Ptg==
X-Forwarded-Encrypted: i=1; AL+hErHdZ+clxHPbW2cs2YHTFiWH7hpi6aNaQis26OinyHfb+1S6HlL4XdFVbjaPZJGEL03qm5F/WnbjG44TYcg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9oBSVHp3Xh1F0xiasXUj8mIr53/EaoaZXz5bbR18qXyHdz33/i
	4Bx4f9a6zB1XzFA5dfEQ+atxtn4v6Nx7GQgHLbECvupNVJHq3Q7QBytJ
X-Gm-Gg: AZFdTZdwtKTz/MhA2Lg2kUxGxZhHqXSURaDWh8h7utxoWNCWSroHZRjzYlRSGZr4MYm
	vPK22ryWCF77JSQ9OszDu6zwe6lYG2znJAn9f0F1vwmPpubfj0YKD9ObQ6DjAmz9OsAKowpE814
	wnWRtScVyZhWn3RjbzSivxsrXV072RuGO6XzmrTUgTPU1q/im4hDZRbSYJisgg09cEDvOxFTdBQ
	6rTWrbCMBpPIhlp0lQVf3TLpATWmszfIUcc76txP4NMjU1u7hsZ37OIltdN4teKr7cvhNz6p5gI
	LYtalHN0SVM9RtGlSzEHwuyz0PH3zg58hlTOKMYsaWrqvAGnSk45hdtuDj1NxwNmtRndyWixqdI
	ZOXhcYul8kvTcl8zXNrKoYNpIl4kR/uKt03+6YgnfMsES3bsuM2p/TR5ziwuD3++2+1ofQ3maAx
	uIvFnf+7OeaGVCWqu9VqZBO2/thDc0ceMm3JBWddSBnbghTQgWuToJglppyFnWZ+a5SHjlWWHGE
	lJRMN6vZW1t1Y8ihvuGgT6NdG4YP6cvisNaE8JLlsZGNZyQvirpWcd7rISUo7PJAu2pXuYShht5
	Pi6XHlRssnxi0tseILNFFb1ox/zW24AOu91ICr8/pENL3RJkpKxk8tKCfQa5mqSbXubun3FSHV+
	q1mCh6hZ70A==
X-Received: by 2002:a05:6000:1861:b0:48d:f99d:a0d3 with SMTP id ffacd0b85a97d-4abb8f8bfaamr40412327f8f.46.1795649484655;
        Wed, 25 Nov 2026 15:31:24 -0800 (PST)
Received: from localhost (bl20-90-91.dsl.telepac.pt. [2.81.90.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm44086160f8f.21.2026.11.25.15.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 15:31:24 -0800 (PST)
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
Subject: [PATCH RFC 10/19] serial: esp32: Restore the ESP32 UART driver
Date: Wed, 25 Nov 2026 23:30:11 +0000
Message-ID: <20261125233020.1380594-11-vitorhg20080@gmail.com>
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

Restore the UART driver originally added by Max Filippov in commit
8cc89a229aac ("drivers/tty/serial: add driver for the ESP32 UART").
Use the driver source from the parent of commit 2dccde6f5f2f
("serial: remove drivers for espressif esp32").

Keep esp32_uart_console_setup() in regular text because a late probe
can register the console after init memory has been freed.

Make the restored driver available under COMPILE_TEST in preparation
for ESP32-P4 support.

AI assisted with preparing and validating the restoration.

Signed-off-by: Vítor Hugo Silva <vitorhg20080@gmail.com>
---
 drivers/tty/serial/Kconfig      |  13 +
 drivers/tty/serial/Makefile     |   1 +
 drivers/tty/serial/esp32_uart.c | 779 ++++++++++++++++++++++++++++++++
 3 files changed, 793 insertions(+)
 create mode 100644 drivers/tty/serial/esp32_uart.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 3864cef711a6..83a37922fb07 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -97,6 +97,19 @@ config SERIAL_EARLYCON_RISCV_SBI
 	  with "earlycon=sbi" on the kernel command line. The console is
 	  enabled when early_param is processed.
 
+config SERIAL_ESP32
+	tristate "Espressif ESP32 UART support"
+	depends on COMPILE_TEST && OF && HAS_IOMEM
+	select SERIAL_CORE
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+	help
+	  Driver for the UART controllers of the Espressif ESP32xx SoCs.
+	  When earlycon option is enabled the following kernel command line
+	  snippets may be used:
+	    earlycon=esp32s3uart,mmio32,0x60000000,115200n8,40000000
+	    earlycon=esp32uart,mmio32,0x3ff40000,115200n8
+
 config SERIAL_SB1250_DUART
 	tristate "BCM1xxx on-chip DUART serial support"
 	depends on SIBYTE_SB1xxx_SOC=y
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index d63b126f40ca..11cb7e3a0f37 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -9,6 +9,7 @@ serial_base-y := serial_core.o serial_base_bus.o serial_ctrl.o serial_port.o
 obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
 obj-$(CONFIG_SERIAL_EARLYCON_SEMIHOST) += earlycon-semihost.o
 obj-$(CONFIG_SERIAL_EARLYCON_RISCV_SBI) += earlycon-riscv-sbi.o
+obj-$(CONFIG_SERIAL_ESP32) += esp32_uart.o
 
 # These Sparc drivers have to appear before others such as 8250
 # which share ttySx minor node space.  Otherwise console device
diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/tty/serial/esp32_uart.c
new file mode 100644
index 000000000000..8f257cf0d290
--- /dev/null
+++ b/drivers/tty/serial/esp32_uart.c
@@ -0,0 +1,779 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/tty_flip.h>
+#include <asm/serial.h>
+
+#define DRIVER_NAME	"esp32-uart"
+#define DEV_NAME	"ttyS"
+#define UART_NR		3
+
+#define ESP32_UART_TX_FIFO_SIZE	127
+#define ESP32_UART_RX_FIFO_SIZE	127
+
+#define UART_FIFO_REG			0x00
+#define UART_INT_RAW_REG		0x04
+#define UART_INT_ST_REG			0x08
+#define UART_INT_ENA_REG		0x0c
+#define UART_INT_CLR_REG		0x10
+#define UART_RXFIFO_FULL_INT			BIT(0)
+#define UART_TXFIFO_EMPTY_INT			BIT(1)
+#define UART_BRK_DET_INT			BIT(7)
+#define UART_CLKDIV_REG			0x14
+#define ESP32_UART_CLKDIV			GENMASK(19, 0)
+#define ESP32S3_UART_CLKDIV			GENMASK(11, 0)
+#define UART_CLKDIV_SHIFT			0
+#define UART_CLKDIV_FRAG			GENMASK(23, 20)
+#define UART_STATUS_REG			0x1c
+#define ESP32_UART_RXFIFO_CNT			GENMASK(7, 0)
+#define ESP32S3_UART_RXFIFO_CNT			GENMASK(9, 0)
+#define UART_RXFIFO_CNT_SHIFT			0
+#define UART_DSRN				BIT(13)
+#define UART_CTSN				BIT(14)
+#define ESP32_UART_TXFIFO_CNT			GENMASK(23, 16)
+#define ESP32S3_UART_TXFIFO_CNT			GENMASK(25, 16)
+#define UART_TXFIFO_CNT_SHIFT			16
+#define UART_CONF0_REG			0x20
+#define UART_PARITY				BIT(0)
+#define UART_PARITY_EN				BIT(1)
+#define UART_BIT_NUM				GENMASK(3, 2)
+#define UART_BIT_NUM_5				0
+#define UART_BIT_NUM_6				1
+#define UART_BIT_NUM_7				2
+#define UART_BIT_NUM_8				3
+#define UART_STOP_BIT_NUM			GENMASK(5, 4)
+#define UART_STOP_BIT_NUM_1			1
+#define UART_STOP_BIT_NUM_2			3
+#define UART_SW_RTS				BIT(6)
+#define UART_SW_DTR				BIT(7)
+#define UART_LOOPBACK				BIT(14)
+#define UART_TX_FLOW_EN				BIT(15)
+#define UART_RTS_INV				BIT(23)
+#define UART_DTR_INV				BIT(24)
+#define UART_CONF1_REG			0x24
+#define UART_RXFIFO_FULL_THRHD_SHIFT		0
+#define ESP32_UART_TXFIFO_EMPTY_THRHD_SHIFT	8
+#define ESP32S3_UART_TXFIFO_EMPTY_THRHD_SHIFT	10
+#define ESP32_UART_RX_FLOW_EN			BIT(23)
+#define ESP32S3_UART_RX_FLOW_EN			BIT(22)
+#define ESP32S3_UART_CLK_CONF_REG	0x78
+#define ESP32S3_UART_SCLK_DIV_B			GENMASK(5, 0)
+#define ESP32S3_UART_SCLK_DIV_A			GENMASK(11, 6)
+#define ESP32S3_UART_SCLK_DIV_NUM		GENMASK(19, 12)
+#define ESP32S3_UART_SCLK_SEL			GENMASK(21, 20)
+#define APB_CLK					1
+#define RC_FAST_CLK				2
+#define XTAL_CLK				3
+#define ESP32S3_UART_SCLK_EN			BIT(22)
+#define ESP32S3_UART_RST_CORE			BIT(23)
+#define ESP32S3_UART_TX_SCLK_EN			BIT(24)
+#define ESP32S3_UART_RX_SCLK_EN			BIT(25)
+#define ESP32S3_UART_TX_RST_CORE		BIT(26)
+#define ESP32S3_UART_RX_RST_CORE		BIT(27)
+
+#define ESP32S3_UART_CLK_CONF_DEFAULT \
+	(ESP32S3_UART_RX_SCLK_EN | \
+	 ESP32S3_UART_TX_SCLK_EN | \
+	 ESP32S3_UART_SCLK_EN | \
+	 FIELD_PREP(ESP32S3_UART_SCLK_SEL, XTAL_CLK))
+
+struct esp32_port {
+	struct uart_port port;
+	struct clk *clk;
+};
+
+struct esp32_uart_variant {
+	u32 clkdiv_mask;
+	u32 rxfifo_cnt_mask;
+	u32 txfifo_cnt_mask;
+	u32 txfifo_empty_thrhd_shift;
+	u32 rx_flow_en;
+	const char *type;
+	bool has_clkconf;
+};
+
+static const struct esp32_uart_variant esp32_variant = {
+	.clkdiv_mask = ESP32_UART_CLKDIV,
+	.rxfifo_cnt_mask = ESP32_UART_RXFIFO_CNT,
+	.txfifo_cnt_mask = ESP32_UART_TXFIFO_CNT,
+	.txfifo_empty_thrhd_shift = ESP32_UART_TXFIFO_EMPTY_THRHD_SHIFT,
+	.rx_flow_en = ESP32_UART_RX_FLOW_EN,
+	.type = "ESP32 UART",
+};
+
+static const struct esp32_uart_variant esp32s3_variant = {
+	.clkdiv_mask = ESP32S3_UART_CLKDIV,
+	.rxfifo_cnt_mask = ESP32S3_UART_RXFIFO_CNT,
+	.txfifo_cnt_mask = ESP32S3_UART_TXFIFO_CNT,
+	.txfifo_empty_thrhd_shift = ESP32S3_UART_TXFIFO_EMPTY_THRHD_SHIFT,
+	.rx_flow_en = ESP32S3_UART_RX_FLOW_EN,
+	.type = "ESP32S3 UART",
+	.has_clkconf = true,
+};
+
+static const struct of_device_id esp32_uart_dt_ids[] = {
+	{
+		.compatible = "esp,esp32-uart",
+		.data = &esp32_variant,
+	}, {
+		.compatible = "esp,esp32s3-uart",
+		.data = &esp32s3_variant,
+	}, { /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, esp32_uart_dt_ids);
+
+static struct esp32_port *esp32_uart_ports[UART_NR];
+
+static const struct esp32_uart_variant *port_variant(struct uart_port *port)
+{
+	return port->private_data;
+}
+
+static void esp32_uart_write(struct uart_port *port, unsigned long reg, u32 v)
+{
+	writel(v, port->membase + reg);
+}
+
+static u32 esp32_uart_read(struct uart_port *port, unsigned long reg)
+{
+	return readl(port->membase + reg);
+}
+
+static u32 esp32_uart_tx_fifo_cnt(struct uart_port *port)
+{
+	u32 status = esp32_uart_read(port, UART_STATUS_REG);
+
+	return (status & port_variant(port)->txfifo_cnt_mask) >> UART_TXFIFO_CNT_SHIFT;
+}
+
+static u32 esp32_uart_rx_fifo_cnt(struct uart_port *port)
+{
+	u32 status = esp32_uart_read(port, UART_STATUS_REG);
+
+	return (status & port_variant(port)->rxfifo_cnt_mask) >> UART_RXFIFO_CNT_SHIFT;
+}
+
+/* return TIOCSER_TEMT when transmitter is not busy */
+static unsigned int esp32_uart_tx_empty(struct uart_port *port)
+{
+	return esp32_uart_tx_fifo_cnt(port) ? 0 : TIOCSER_TEMT;
+}
+
+static void esp32_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	u32 conf0 = esp32_uart_read(port, UART_CONF0_REG);
+
+	conf0 &= ~(UART_LOOPBACK |
+		   UART_SW_RTS | UART_RTS_INV |
+		   UART_SW_DTR | UART_DTR_INV);
+
+	if (mctrl & TIOCM_RTS)
+		conf0 |= UART_SW_RTS;
+	if (mctrl & TIOCM_DTR)
+		conf0 |= UART_SW_DTR;
+	if (mctrl & TIOCM_LOOP)
+		conf0 |= UART_LOOPBACK;
+
+	esp32_uart_write(port, UART_CONF0_REG, conf0);
+}
+
+static unsigned int esp32_uart_get_mctrl(struct uart_port *port)
+{
+	u32 status = esp32_uart_read(port, UART_STATUS_REG);
+	unsigned int ret = TIOCM_CAR;
+
+	if (status & UART_DSRN)
+		ret |= TIOCM_DSR;
+	if (status & UART_CTSN)
+		ret |= TIOCM_CTS;
+
+	return ret;
+}
+
+static void esp32_uart_stop_tx(struct uart_port *port)
+{
+	u32 int_ena;
+
+	int_ena = esp32_uart_read(port, UART_INT_ENA_REG);
+	int_ena &= ~UART_TXFIFO_EMPTY_INT;
+	esp32_uart_write(port, UART_INT_ENA_REG, int_ena);
+}
+
+static void esp32_uart_rxint(struct uart_port *port)
+{
+	struct tty_port *tty_port = &port->state->port;
+	u32 rx_fifo_cnt = esp32_uart_rx_fifo_cnt(port);
+	unsigned long flags;
+	u32 i;
+
+	if (!rx_fifo_cnt)
+		return;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	for (i = 0; i < rx_fifo_cnt; ++i) {
+		u32 rx = esp32_uart_read(port, UART_FIFO_REG);
+
+		if (!rx &&
+		    (esp32_uart_read(port, UART_INT_ST_REG) & UART_BRK_DET_INT)) {
+			esp32_uart_write(port, UART_INT_CLR_REG, UART_BRK_DET_INT);
+			++port->icount.brk;
+			uart_handle_break(port);
+		} else {
+			if (uart_handle_sysrq_char(port, (unsigned char)rx))
+				continue;
+			tty_insert_flip_char(tty_port, rx, TTY_NORMAL);
+			++port->icount.rx;
+		}
+	}
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	tty_flip_buffer_push(tty_port);
+}
+
+static void esp32_uart_put_char(struct uart_port *port, u8 c)
+{
+	esp32_uart_write(port, UART_FIFO_REG, c);
+}
+
+static void esp32_uart_put_char_sync(struct uart_port *port, u8 c)
+{
+	unsigned long timeout = jiffies + HZ;
+
+	while (esp32_uart_tx_fifo_cnt(port) >= ESP32_UART_TX_FIFO_SIZE) {
+		if (time_after(jiffies, timeout)) {
+			dev_warn(port->dev, "timeout waiting for TX FIFO\n");
+			return;
+		}
+		cpu_relax();
+	}
+	esp32_uart_put_char(port, c);
+}
+
+static void esp32_uart_transmit_buffer(struct uart_port *port)
+{
+	u32 tx_fifo_used = esp32_uart_tx_fifo_cnt(port);
+	unsigned int pending;
+	u8 ch;
+
+	if (tx_fifo_used >= ESP32_UART_TX_FIFO_SIZE)
+		return;
+
+	pending = uart_port_tx_limited(port, ch,
+				       ESP32_UART_TX_FIFO_SIZE - tx_fifo_used,
+				       true, esp32_uart_put_char(port, ch),
+				       ({}));
+	if (pending) {
+		u32 int_ena;
+
+		int_ena = esp32_uart_read(port, UART_INT_ENA_REG);
+		int_ena |= UART_TXFIFO_EMPTY_INT;
+		esp32_uart_write(port, UART_INT_ENA_REG, int_ena);
+	}
+}
+
+static void esp32_uart_txint(struct uart_port *port)
+{
+	esp32_uart_transmit_buffer(port);
+}
+
+static irqreturn_t esp32_uart_int(int irq, void *dev_id)
+{
+	struct uart_port *port = dev_id;
+	u32 status;
+
+	status = esp32_uart_read(port, UART_INT_ST_REG);
+
+	if (status & (UART_RXFIFO_FULL_INT | UART_BRK_DET_INT))
+		esp32_uart_rxint(port);
+	if (status & UART_TXFIFO_EMPTY_INT)
+		esp32_uart_txint(port);
+
+	esp32_uart_write(port, UART_INT_CLR_REG, status);
+
+	return IRQ_RETVAL(status);
+}
+
+static void esp32_uart_start_tx(struct uart_port *port)
+{
+	esp32_uart_transmit_buffer(port);
+}
+
+static void esp32_uart_stop_rx(struct uart_port *port)
+{
+	u32 int_ena;
+
+	int_ena = esp32_uart_read(port, UART_INT_ENA_REG);
+	int_ena &= ~UART_RXFIFO_FULL_INT;
+	esp32_uart_write(port, UART_INT_ENA_REG, int_ena);
+}
+
+static int esp32_uart_startup(struct uart_port *port)
+{
+	int ret = 0;
+	unsigned long flags;
+	struct esp32_port *sport = container_of(port, struct esp32_port, port);
+
+	ret = clk_prepare_enable(sport->clk);
+	if (ret)
+		return ret;
+
+	ret = request_irq(port->irq, esp32_uart_int, 0, DRIVER_NAME, port);
+	if (ret) {
+		clk_disable_unprepare(sport->clk);
+		return ret;
+	}
+
+	spin_lock_irqsave(&port->lock, flags);
+	if (port_variant(port)->has_clkconf)
+		esp32_uart_write(port, ESP32S3_UART_CLK_CONF_REG,
+				 ESP32S3_UART_CLK_CONF_DEFAULT);
+	esp32_uart_write(port, UART_CONF1_REG,
+			 (1 << UART_RXFIFO_FULL_THRHD_SHIFT) |
+			 (1 << port_variant(port)->txfifo_empty_thrhd_shift));
+	esp32_uart_write(port, UART_INT_CLR_REG, UART_RXFIFO_FULL_INT | UART_BRK_DET_INT);
+	esp32_uart_write(port, UART_INT_ENA_REG, UART_RXFIFO_FULL_INT | UART_BRK_DET_INT);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return ret;
+}
+
+static void esp32_uart_shutdown(struct uart_port *port)
+{
+	struct esp32_port *sport = container_of(port, struct esp32_port, port);
+
+	esp32_uart_write(port, UART_INT_ENA_REG, 0);
+	free_irq(port->irq, port);
+	clk_disable_unprepare(sport->clk);
+}
+
+static bool esp32_uart_set_baud(struct uart_port *port, u32 baud)
+{
+	u32 sclk = port->uartclk;
+	u32 div = sclk / baud;
+
+	if (port_variant(port)->has_clkconf) {
+		u32 sclk_div = div / port_variant(port)->clkdiv_mask;
+
+		if (div > port_variant(port)->clkdiv_mask) {
+			sclk /= (sclk_div + 1);
+			div = sclk / baud;
+		}
+		esp32_uart_write(port, ESP32S3_UART_CLK_CONF_REG,
+				 FIELD_PREP(ESP32S3_UART_SCLK_DIV_NUM, sclk_div) |
+				 ESP32S3_UART_CLK_CONF_DEFAULT);
+	}
+
+	if (div <= port_variant(port)->clkdiv_mask) {
+		u32 frag = (sclk * 16) / baud - div * 16;
+
+		esp32_uart_write(port, UART_CLKDIV_REG,
+				 div | FIELD_PREP(UART_CLKDIV_FRAG, frag));
+		return true;
+	}
+
+	return false;
+}
+
+static void esp32_uart_set_termios(struct uart_port *port,
+				   struct ktermios *termios,
+				   const struct ktermios *old)
+{
+	unsigned long flags;
+	u32 conf0, conf1;
+	u32 baud;
+	const u32 rx_flow_en = port_variant(port)->rx_flow_en;
+	u32 max_div = port_variant(port)->clkdiv_mask;
+
+	termios->c_cflag &= ~CMSPAR;
+
+	if (port_variant(port)->has_clkconf)
+		max_div *= FIELD_MAX(ESP32S3_UART_SCLK_DIV_NUM);
+
+	baud = uart_get_baud_rate(port, termios, old,
+				  port->uartclk / max_div,
+				  port->uartclk / 16);
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	conf0 = esp32_uart_read(port, UART_CONF0_REG);
+	conf0 &= ~(UART_PARITY_EN | UART_PARITY | UART_BIT_NUM | UART_STOP_BIT_NUM);
+
+	conf1 = esp32_uart_read(port, UART_CONF1_REG);
+	conf1 &= ~rx_flow_en;
+
+	if (termios->c_cflag & PARENB) {
+		conf0 |= UART_PARITY_EN;
+		if (termios->c_cflag & PARODD)
+			conf0 |= UART_PARITY;
+	}
+
+	switch (termios->c_cflag & CSIZE) {
+	case CS5:
+		conf0 |= FIELD_PREP(UART_BIT_NUM, UART_BIT_NUM_5);
+		break;
+	case CS6:
+		conf0 |= FIELD_PREP(UART_BIT_NUM, UART_BIT_NUM_6);
+		break;
+	case CS7:
+		conf0 |= FIELD_PREP(UART_BIT_NUM, UART_BIT_NUM_7);
+		break;
+	case CS8:
+		conf0 |= FIELD_PREP(UART_BIT_NUM, UART_BIT_NUM_8);
+		break;
+	}
+
+	if (termios->c_cflag & CSTOPB)
+		conf0 |= FIELD_PREP(UART_STOP_BIT_NUM, UART_STOP_BIT_NUM_2);
+	else
+		conf0 |= FIELD_PREP(UART_STOP_BIT_NUM, UART_STOP_BIT_NUM_1);
+
+	if (termios->c_cflag & CRTSCTS)
+		conf1 |= rx_flow_en;
+
+	esp32_uart_write(port, UART_CONF0_REG, conf0);
+	esp32_uart_write(port, UART_CONF1_REG, conf1);
+
+	if (baud) {
+		esp32_uart_set_baud(port, baud);
+		uart_update_timeout(port, termios->c_cflag, baud);
+	} else {
+		if (esp32_uart_set_baud(port, 115200)) {
+			baud = 115200;
+			tty_termios_encode_baud_rate(termios, baud, baud);
+			uart_update_timeout(port, termios->c_cflag, baud);
+		} else {
+			dev_warn(port->dev,
+				 "unable to set speed to %d baud or the default 115200\n",
+				 baud);
+		}
+	}
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static const char *esp32_uart_type(struct uart_port *port)
+{
+	return port_variant(port)->type;
+}
+
+/* configure/auto-configure the port */
+static void esp32_uart_config_port(struct uart_port *port, int flags)
+{
+	if (flags & UART_CONFIG_TYPE)
+		port->type = PORT_GENERIC;
+}
+
+#ifdef CONFIG_CONSOLE_POLL
+static int esp32_uart_poll_init(struct uart_port *port)
+{
+	struct esp32_port *sport = container_of(port, struct esp32_port, port);
+
+	return clk_prepare_enable(sport->clk);
+}
+
+static void esp32_uart_poll_put_char(struct uart_port *port, unsigned char c)
+{
+	esp32_uart_put_char_sync(port, c);
+}
+
+static int esp32_uart_poll_get_char(struct uart_port *port)
+{
+	if (esp32_uart_rx_fifo_cnt(port))
+		return esp32_uart_read(port, UART_FIFO_REG);
+	else
+		return NO_POLL_CHAR;
+
+}
+#endif
+
+static const struct uart_ops esp32_uart_pops = {
+	.tx_empty	= esp32_uart_tx_empty,
+	.set_mctrl	= esp32_uart_set_mctrl,
+	.get_mctrl	= esp32_uart_get_mctrl,
+	.stop_tx	= esp32_uart_stop_tx,
+	.start_tx	= esp32_uart_start_tx,
+	.stop_rx	= esp32_uart_stop_rx,
+	.startup	= esp32_uart_startup,
+	.shutdown	= esp32_uart_shutdown,
+	.set_termios	= esp32_uart_set_termios,
+	.type		= esp32_uart_type,
+	.config_port	= esp32_uart_config_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_init	= esp32_uart_poll_init,
+	.poll_put_char	= esp32_uart_poll_put_char,
+	.poll_get_char	= esp32_uart_poll_get_char,
+#endif
+};
+
+static void esp32_uart_console_putchar(struct uart_port *port, u8 c)
+{
+	esp32_uart_put_char_sync(port, c);
+}
+
+static void esp32_uart_string_write(struct uart_port *port, const char *s,
+				    unsigned int count)
+{
+	uart_console_write(port, s, count, esp32_uart_console_putchar);
+}
+
+static void
+esp32_uart_console_write(struct console *co, const char *s, unsigned int count)
+{
+	struct esp32_port *sport = esp32_uart_ports[co->index];
+	struct uart_port *port = &sport->port;
+	unsigned long flags;
+	bool locked = true;
+
+	if (port->sysrq)
+		locked = false;
+	else if (oops_in_progress)
+		locked = spin_trylock_irqsave(&port->lock, flags);
+	else
+		spin_lock_irqsave(&port->lock, flags);
+
+	esp32_uart_string_write(port, s, count);
+
+	if (locked)
+		spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static int esp32_uart_console_setup(struct console *co, char *options)
+{
+	struct esp32_port *sport;
+	int baud = 115200;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+	int ret;
+
+	/*
+	 * check whether an invalid uart number has been specified, and
+	 * if so, search for the first available port that does have
+	 * console support.
+	 */
+	if (co->index == -1 || co->index >= ARRAY_SIZE(esp32_uart_ports))
+		co->index = 0;
+
+	sport = esp32_uart_ports[co->index];
+	if (!sport)
+		return -ENODEV;
+
+	ret = clk_prepare_enable(sport->clk);
+	if (ret)
+		return ret;
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+
+	return uart_set_options(&sport->port, co, baud, parity, bits, flow);
+}
+
+static int esp32_uart_console_exit(struct console *co)
+{
+	struct esp32_port *sport = esp32_uart_ports[co->index];
+
+	clk_disable_unprepare(sport->clk);
+	return 0;
+}
+
+static struct uart_driver esp32_uart_reg;
+static struct console esp32_uart_console = {
+	.name		= DEV_NAME,
+	.write		= esp32_uart_console_write,
+	.device		= uart_console_device,
+	.setup		= esp32_uart_console_setup,
+	.exit		= esp32_uart_console_exit,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+	.data		= &esp32_uart_reg,
+};
+
+static void esp32_uart_earlycon_putchar(struct uart_port *port, u8 c)
+{
+	esp32_uart_put_char_sync(port, c);
+}
+
+static void esp32_uart_earlycon_write(struct console *con, const char *s,
+				      unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, esp32_uart_earlycon_putchar);
+}
+
+#ifdef CONFIG_CONSOLE_POLL
+static int esp32_uart_earlycon_read(struct console *con, char *s, unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+	unsigned int num_read = 0;
+
+	while (num_read < n) {
+		int c = esp32_uart_poll_get_char(&dev->port);
+
+		if (c == NO_POLL_CHAR)
+			break;
+		s[num_read++] = c;
+	}
+	return num_read;
+}
+#endif
+
+static int __init esp32xx_uart_early_console_setup(struct earlycon_device *device,
+						   const char *options)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = esp32_uart_earlycon_write;
+#ifdef CONFIG_CONSOLE_POLL
+	device->con->read = esp32_uart_earlycon_read;
+#endif
+	if (device->port.uartclk != BASE_BAUD * 16)
+		esp32_uart_set_baud(&device->port, device->baud);
+
+	return 0;
+}
+
+static int __init esp32_uart_early_console_setup(struct earlycon_device *device,
+						 const char *options)
+{
+	device->port.private_data = (void *)&esp32_variant;
+
+	return esp32xx_uart_early_console_setup(device, options);
+}
+
+OF_EARLYCON_DECLARE(esp32uart, "esp,esp32-uart",
+		    esp32_uart_early_console_setup);
+
+static int __init esp32s3_uart_early_console_setup(struct earlycon_device *device,
+						   const char *options)
+{
+	device->port.private_data = (void *)&esp32s3_variant;
+
+	return esp32xx_uart_early_console_setup(device, options);
+}
+
+OF_EARLYCON_DECLARE(esp32s3uart, "esp,esp32s3-uart",
+		    esp32s3_uart_early_console_setup);
+
+static struct uart_driver esp32_uart_reg = {
+	.owner		= THIS_MODULE,
+	.driver_name	= DRIVER_NAME,
+	.dev_name	= DEV_NAME,
+	.nr		= ARRAY_SIZE(esp32_uart_ports),
+	.cons		= &esp32_uart_console,
+};
+
+static int esp32_uart_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct uart_port *port;
+	struct esp32_port *sport;
+	struct resource *res;
+	int ret;
+
+	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
+	if (!sport)
+		return -ENOMEM;
+
+	port = &sport->port;
+
+	ret = of_alias_get_id(np, "serial");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
+		return ret;
+	}
+	if (ret >= UART_NR) {
+		dev_err(&pdev->dev, "driver limited to %d serial ports\n", UART_NR);
+		return -ENOMEM;
+	}
+
+	port->line = ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	port->mapbase = res->start;
+	port->membase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(port->membase))
+		return PTR_ERR(port->membase);
+
+	sport->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(sport->clk))
+		return PTR_ERR(sport->clk);
+
+	port->uartclk = clk_get_rate(sport->clk);
+	port->dev = &pdev->dev;
+	port->type = PORT_GENERIC;
+	port->iotype = UPIO_MEM;
+	port->irq = platform_get_irq(pdev, 0);
+	port->ops = &esp32_uart_pops;
+	port->flags = UPF_BOOT_AUTOCONF;
+	port->has_sysrq = 1;
+	port->fifosize = ESP32_UART_TX_FIFO_SIZE;
+	port->private_data = (void *)device_get_match_data(&pdev->dev);
+
+	esp32_uart_ports[port->line] = sport;
+
+	platform_set_drvdata(pdev, port);
+
+	return uart_add_one_port(&esp32_uart_reg, port);
+}
+
+static void esp32_uart_remove(struct platform_device *pdev)
+{
+	struct uart_port *port = platform_get_drvdata(pdev);
+
+	uart_remove_one_port(&esp32_uart_reg, port);
+}
+
+
+static struct platform_driver esp32_uart_driver = {
+	.probe		= esp32_uart_probe,
+	.remove		= esp32_uart_remove,
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.of_match_table	= esp32_uart_dt_ids,
+	},
+};
+
+static int __init esp32_uart_init(void)
+{
+	int ret;
+
+	ret = uart_register_driver(&esp32_uart_reg);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&esp32_uart_driver);
+	if (ret)
+		uart_unregister_driver(&esp32_uart_reg);
+
+	return ret;
+}
+
+static void __exit esp32_uart_exit(void)
+{
+	platform_driver_unregister(&esp32_uart_driver);
+	uart_unregister_driver(&esp32_uart_reg);
+}
+
+module_init(esp32_uart_init);
+module_exit(esp32_uart_exit);
+
+MODULE_AUTHOR("Max Filippov <jcmvbkbc@gmail.com>");
+MODULE_DESCRIPTION("Espressif ESP32 UART support");
+MODULE_LICENSE("GPL");
-- 
2.56.1

