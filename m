Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A59C433F5
	for <linux-serial@archiver.kernel.org>; Thu,  7 Oct 2021 11:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4BCD60F59
	for <linux-serial@archiver.kernel.org>; Thu,  7 Oct 2021 11:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhJGLWO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:22:14 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:38201 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbhJGLWN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Oct 2021 07:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633605620; x=1665141620;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vlqZaYyQczlIggc+IIbpxWrZThEF742WAz3RkstZe4s=;
  b=0+R8783Fsh5UnDKSC6ov2xOeRylhNSMHjm/aB5B59zfiygju1bSlgu8q
   ELbqqvnmeT8mg1XBdKbUVzXa/l33YCMGeTjxnCFoqXOG4kBsofyJNxr1U
   ox/i34Rsb4Er2AnsaXadY1Gzr0jvpMlZugB2NlW1Gst4O0CWyCrhyJCYt
   XENF1y80iWGdHs6MA3mkwl1VSj0zUm+pgfQojnnRTc0CnRdSp8CqfFv7r
   mLHRZ66jsFqlLHUP8hilBAhOVhfxa+tEqI9qWS1AEjvDPfTup4xbwPdQa
   6YDjlJ6YBZ2If5Nc1E0dfNyM5iwU150AWdfARoGfidbAUltMHWDZ8ATvO
   w==;
IronPort-SDR: qmE5LOvtPqMIrGH4sECEK1B7k05SsbM6YvNxX6qhNBM+3Ed2EiSukUXOLG+FusinGfhKCjIR8u
 bHqnpyaJF2QbujJCTY1kYJiHETbzMqdXEfPz/4qe7jOfIstxef26cwkp8ZwMynSjm8B8gskZE/
 dRUWirNrcB94Z87vyFpZ3zObiLcOgusTgzhqbuEI6VNbFlDXs/JzAD+4WpOB5T5HI6Kx/n1Og8
 wcJh51OLwoWVUsTJnTVTF3sGPwJec9Jy7bfA5w7juJzaRlCxlwr0zoJWXghpeG1H6AuQ3pAiOH
 bX9pUsSSetbwBW5JLqZ5+T53
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="147121102"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Oct 2021 04:20:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 7 Oct 2021 04:20:19 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 7 Oct 2021 04:20:17 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] tty: serial: atmel: use macros instead of hardcoded values
Date:   Thu, 7 Oct 2021 14:20:14 +0300
Message-ID: <20211007112014.2332019-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use UART_PM_STATE_ON, UART_PM_STATE_OFF instead of hardcoded values.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/tty/serial/atmel_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 249ea35088d2..2c99a47a2535 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2084,7 +2084,7 @@ static void atmel_serial_pm(struct uart_port *port, unsigned int state,
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
 	switch (state) {
-	case 0:
+	case UART_PM_STATE_ON:
 		/*
 		 * Enable the peripheral clock for this serial port.
 		 * This is called on uart_open() or a resume event.
@@ -2094,7 +2094,7 @@ static void atmel_serial_pm(struct uart_port *port, unsigned int state,
 		/* re-enable interrupts if we disabled some on suspend */
 		atmel_uart_writel(port, ATMEL_US_IER, atmel_port->backup_imr);
 		break;
-	case 3:
+	case UART_PM_STATE_OFF:
 		/* Back up the interrupt mask and disable all interrupts */
 		atmel_port->backup_imr = atmel_uart_readl(port, ATMEL_US_IMR);
 		atmel_uart_writel(port, ATMEL_US_IDR, -1);
-- 
2.25.1

