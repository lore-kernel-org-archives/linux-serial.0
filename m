Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DB4C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 11:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E51D5613D3
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 11:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245652AbhI2LdB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Sep 2021 07:33:01 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:23984 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245675AbhI2Lc6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Sep 2021 07:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632915078; x=1664451078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6pVL/oHd85tHpO0tUTv51sBq8KO5dmryXZk8h4M/54Q=;
  b=EqCc+niO7FbeFHXOJ6iO22K7dALIUsEVcc5pZHu9d1pjkPCgTi/mZrUe
   JGI8AyWB8m/zSoFa8Bpt0R/sEJNbAZ+4AdranT/PBDwZHo0X3z6JONmdT
   sakO3pLewTQ6FDdnm1rnqtfB8YDU2Dojuo+zMXHGcWVnTl+goH6zfZxDd
   UmoYG/AYyQQnkdcfB3BssSxhFN/evV86JS2Br1eq4J+GuE3wZHXnlyxGo
   LryDBvymsffTcqkr9sYsG/KGmW7dSwtCKYF5P6pQQFzD31dgmt5XgDD5y
   zw+fejhrjN66VwY8nFSmDKgkkYn77rFo3fs1SlkJ5NdkOPuujv75ViNiq
   w==;
IronPort-SDR: 1oCyLCW8TIWB07XDDSZsiODM3wnfJ4zC7w3NUswcdMkYUnD0mpaAgrDM3+FwUtftA/OtAlk7SF
 ghaLCcVl3sInLjYAUEPv5APcOoI1sJGp4M7oohFKKAMST6Ly+umAqOW7qwF4iEjFWByiVp9OmC
 2roIgwHSPuy74M9E0vHWOeF3RHZYwh7WTOHq0myWxspoeshhyunjp5P7LMzFPR4//sZ32gbxG+
 ZMtKR8sE+3SRr9izbiVt4pJYBYVHxebh3xoxgBDftGUUglhtmA1LMlbGZB3LH0lTD2zGyOt3VE
 3ho3FEMe0hZidIgLjmirMjEA
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="131081554"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2021 04:31:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 29 Sep 2021 04:31:16 -0700
Received: from CHE-LT-I17972LX.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 29 Sep 2021 04:31:10 -0700
From:   LakshmiPraveen Kopparthi <LakshmiPraveen.Kopparthi@microchip.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <macro@orcam.me.uk>,
        <zev@bewilderbeest.net>, <vigneshr@ti.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <UNGLinuxDriver@microchip.com>
Subject: [PATCH v1 2/3] serial:8250:Add RS485 support for MCHP PCI1XXXX UART
Date:   Wed, 29 Sep 2021 17:00:48 +0530
Message-ID: <20210929113049.64557-3-LakshmiPraveen.Kopparthi@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210929113049.64557-1-LakshmiPraveen.Kopparthi@microchip.com>
References: <20210929113049.64557-1-LakshmiPraveen.Kopparthi@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

UART module has built in support to control the RTS line. This patch 
adds the support to configure the HW control of RTS.

Signed-off-by: LakshmiPraveen Kopparthi <LakshmiPraveen.Kopparthi@microchip.com>
---
 drivers/tty/serial/8250/8250_pci.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 12a3e0bd50aa..b06374fc6212 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1887,11 +1887,39 @@ pci_moxa_setup(struct serial_private *priv,
 #define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1P3	0x000F
 
 #define UART_ACTV_REG 0x11
+#define ADC_CFG_REG 0x40
 #define UART_PCI_CTRL_REG 0x80
 #define UART_WAKE_REG 0x8C
 #define UART_WAKE_MASK_REG 0x90
 #define UART_RESET_REG 0x94
 
+#define ADC_EN BIT(0)
+#define ADC_PIN_SEL BIT(1)
+#define ADC_POLARITY BIT(2)
+
+static int mchp_pci1xxxx_rs485_config(struct uart_port *port,
+				      struct serial_rs485 *rs485)
+{
+	u8 data = 0;
+
+	memset(rs485->padding, 0, sizeof(rs485->padding));
+	rs485->flags &= SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		data = ADC_EN | ADC_PIN_SEL;
+		if (!(rs485->flags & SER_RS485_RTS_ON_SEND)) {
+			data |= ADC_POLARITY;
+			rs485->flags |=  SER_RS485_RTS_AFTER_SEND;
+		}
+	}
+
+	rs485->delay_rts_after_send = 0;
+	rs485->delay_rts_before_send = 0;
+	writeb(data, (port->membase + ADC_CFG_REG));
+	port->rs485 = *rs485;
+	return 0;
+}
+
 static char pci1xxxx_port_suspend(int line)
 {
 	struct uart_8250_port *up = serial8250_get_port(line);
@@ -2073,6 +2101,7 @@ static int mchp_pci1xxxx_setup(struct serial_private *priv,
 	offset = first_offset + idx * board->uart_offset;
 	port->port.flags |= UPF_FIXED_TYPE | UPF_SKIP_TEST;
 	port->port.type = PORT_MCHP16550A;
+	port->port.rs485_config = mchp_pci1xxxx_rs485_config;
 	ret = setup_port(priv, port, bar, offset, board->reg_shift);
 	if (ret < 0)
 		return ret;
-- 
2.25.1

