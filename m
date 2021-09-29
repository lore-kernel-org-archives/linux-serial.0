Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8FBC4332F
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 11:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 887016135E
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 11:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245672AbhI2LdM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Sep 2021 07:33:12 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:24830 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245695AbhI2LdF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Sep 2021 07:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632915083; x=1664451083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Thys1hq+rERb+tM7qaFCO5chssyMvJDh42SgNV7O7CI=;
  b=QZ0/na4HCMTPbc1GizXH92RK8BwFyo92gXL99A4lkwA1xLaB48rFsPD0
   6XCkrGHFW19IsJEbIUTe66og1zCl80RO7Ec0lOWFCNjg4gXHgEHa/JzEe
   HUXa6DvCTqq3dYIOH6Wbchmu5L0aqXTieNtJO3TC0HZI5YyjNeTbXm7M5
   Xqz34KkN+MlYRN1HujDsHjyQoWMoue9/UsIdOOrjnTnfarJ/Nsr1M2PyU
   Ctz9oxNqRlYHt2vCpikFwJkfiAXzum7Zn7Lg54uZRST0vrlYlXvtdWH+k
   hesH3W+LO0Gf6rNvqHe5p1BVQkgmb8q7vZsCg6+HxvSzBfQdKSxYU1XRL
   Q==;
IronPort-SDR: n9xBoexsVBodZ2MYVpjSpK7q58aue2UmHXXcJ5+Etn2HZXGm/aDS5bHfDlW9KK71KkGBGouC5l
 uTBaOvmSFhVihVo6ZfphkMWvASqHDOFk5Uh+TX/bbC7xQfu3pzC8RPvcscyIZKqbwWTihBJ65B
 me4rurPajfpAdSCqcccEY5o3W9mCymmBwUQwLasvniJ/H+JZVgJYGKv6NHw43IDGD2EX9m5ZrP
 JrLNPp7j+MCEB2P2Wj2UK9YR70G1dcms6dtgGSia1xRcakjeCmhlJBCKe0dUxM2w5TUtHsqYd4
 Ip5wWaim52o8lV9z8qqeB5pA
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="138399138"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2021 04:31:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 29 Sep 2021 04:31:23 -0700
Received: from CHE-LT-I17972LX.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 29 Sep 2021 04:31:17 -0700
From:   LakshmiPraveen Kopparthi <LakshmiPraveen.Kopparthi@microchip.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <macro@orcam.me.uk>,
        <zev@bewilderbeest.net>, <vigneshr@ti.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <UNGLinuxDriver@microchip.com>
Subject: [PATCH v1 3/3] serial:8250: Add non standard baudrate support for MCHP PCI1XXXX UART
Date:   Wed, 29 Sep 2021 17:00:49 +0530
Message-ID: <20210929113049.64557-4-LakshmiPraveen.Kopparthi@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210929113049.64557-1-LakshmiPraveen.Kopparthi@microchip.com>
References: <20210929113049.64557-1-LakshmiPraveen.Kopparthi@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch adds support to exercise all the baud rates.Only few
standard baud rates can be achieved by writing the standard
baud rate registers(DLL, DLM).To achieve  all the baud rates,
additional register writes are needed.

Signed-off-by: LakshmiPraveen Kopparthi <LakshmiPraveen.Kopparthi@microchip.com>
---
 drivers/tty/serial/8250/8250_pci.c | 57 ++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index b06374fc6212..cacb8b03f5db 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1888,6 +1888,8 @@ pci_moxa_setup(struct serial_private *priv,
 
 #define UART_ACTV_REG 0x11
 #define ADC_CFG_REG 0x40
+#define CLK_SEL_REG 0x50
+#define CLK_DIVISOR_REG 0x54
 #define UART_PCI_CTRL_REG 0x80
 #define UART_WAKE_REG 0x8C
 #define UART_WAKE_MASK_REG 0x90
@@ -1896,6 +1898,11 @@ pci_moxa_setup(struct serial_private *priv,
 #define ADC_EN BIT(0)
 #define ADC_PIN_SEL BIT(1)
 #define ADC_POLARITY BIT(2)
+#define UART_BIT_SAMPLE_CNT 16
+
+#define CLK_SEL_MASK 0x03
+#define CLK_SEL_500MHZ 0x01
+#define CLK_SEL_166MHZ 0x02
 
 static int mchp_pci1xxxx_rs485_config(struct uart_port *port,
 				      struct serial_rs485 *rs485)
@@ -1920,6 +1927,55 @@ static int mchp_pci1xxxx_rs485_config(struct uart_port *port,
 	return 0;
 }
 
+static void mchp_pci1xxxx_set_termios(struct uart_port *port,
+				      struct ktermios *termios,
+				      struct ktermios *old)
+{
+	unsigned int standard_baud_list[] = {50, 75, 110, 134, 150, 300,
+				600, 1200, 1800, 2000, 2400, 3600,
+				4800, 7200, 9600, 19200, 38400, 57600,
+				115200, 125000, 136400, 150000, 166700,
+				187500, 214300, 250000, 300000, 375000,
+				500000, 750000, 1000000, 1500000};
+	unsigned int baud = tty_termios_baud_rate(termios);
+	unsigned int quot;
+	unsigned int frac;
+	unsigned int i;
+	unsigned int baud_clock;
+
+	baud = tty_termios_baud_rate(termios);
+	serial8250_do_set_termios(port, termios, NULL);
+
+	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST) {
+		writel((port->custom_divisor & 0x3FFFFFFF),
+		       (port->membase + CLK_DIVISOR_REG));
+	} else {
+		for (i = 0; i < ARRAY_SIZE(standard_baud_list); i++) {
+			if (baud == standard_baud_list[i])
+				return;
+		}
+		tty_termios_encode_baud_rate(termios, baud, baud);
+		baud_clock = readb(port->membase + CLK_SEL_REG);
+
+		if ((baud_clock & CLK_SEL_MASK) == CLK_SEL_500MHZ) {
+			quot = 500000000 / (16 * baud);
+			writel(quot, (port->membase + CLK_DIVISOR_REG));
+		} else if ((baud_clock & CLK_SEL_MASK) == CLK_SEL_166MHZ) {
+			quot = (166667 * 1000) / (16 * baud);
+			writel(quot, (port->membase + CLK_DIVISOR_REG));
+		} else {
+			baud = uart_get_baud_rate(port, termios, old,
+						  50, 1500000);
+			quot = ((1000000000) / (baud * UART_BIT_SAMPLE_CNT));
+			frac = (((1000000000 - (quot * baud *
+				UART_BIT_SAMPLE_CNT)) / UART_BIT_SAMPLE_CNT)
+				* 255) / baud;
+			writel(frac | (quot << 8),
+			       (port->membase + CLK_DIVISOR_REG));
+		}
+	}
+}
+
 static char pci1xxxx_port_suspend(int line)
 {
 	struct uart_8250_port *up = serial8250_get_port(line);
@@ -2102,6 +2158,7 @@ static int mchp_pci1xxxx_setup(struct serial_private *priv,
 	port->port.flags |= UPF_FIXED_TYPE | UPF_SKIP_TEST;
 	port->port.type = PORT_MCHP16550A;
 	port->port.rs485_config = mchp_pci1xxxx_rs485_config;
+	port->port.set_termios = mchp_pci1xxxx_set_termios;
 	ret = setup_port(priv, port, bar, offset, board->reg_shift);
 	if (ret < 0)
 		return ret;
-- 
2.25.1

