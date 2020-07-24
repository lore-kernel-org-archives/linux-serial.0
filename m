Return-Path: <SRS0=jxo+=BD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4E5C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jul 2020 10:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 566F620768
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jul 2020 10:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgGXKOb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:14:31 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:37382 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgGXKOa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Jul 2020 06:14:30 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4BClRm3zKHz1qs1D;
        Fri, 24 Jul 2020 12:14:28 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4BClRm3Tybz1qw01;
        Fri, 24 Jul 2020 12:14:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 87fnsT7Pg0NO; Fri, 24 Jul 2020 12:14:27 +0200 (CEST)
X-Auth-Info: hzU1vpd35gOw0RHXeU2I4iOH4556K9t894Kqcy1luQQ=
Received: from desktop.lan (ip-86-49-101-166.net.upcbroadband.cz [86.49.101.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 24 Jul 2020 12:14:27 +0200 (CEST)
From:   Marek Vasut <marex@denx.de>
To:     linux-serial@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] tty: serial: Add RS485 RTS GPIO control
Date:   Fri, 24 Jul 2020 12:14:18 +0200
Message-Id: <20200724101418.146234-1-marex@denx.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

While the STM32 does support RS485 drive-enable control within the
UART IP itself, some systems have the drive-enable line connected
to a pin which cannot be pinmuxed as RTS. Add support for toggling
the RTS GPIO line using the modem control GPIOs to provide at least
some sort of emulation.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/stm32-usart.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index d1c5e536a167..22c8477571ce 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -34,6 +34,7 @@
 #include "serial_mctrl_gpio.h"
 #include "stm32-usart.h"
 
+static void stm32_set_mctrl(struct uart_port *port, unsigned int mctrl);
 static void stm32_stop_tx(struct uart_port *port);
 static void stm32_transmit_chars(struct uart_port *port);
 
@@ -129,9 +130,13 @@ static int stm32_config_rs485(struct uart_port *port,
 		if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
 			cr3 &= ~USART_CR3_DEP;
 			rs485conf->flags &= ~SER_RS485_RTS_AFTER_SEND;
+			stm32_set_mctrl(port,
+					stm32_port->port.mctrl & ~TIOCM_RTS);
 		} else {
 			cr3 |= USART_CR3_DEP;
 			rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
+			stm32_set_mctrl(port,
+					stm32_port->port.mctrl | TIOCM_RTS);
 		}
 
 		writel_relaxed(cr3, port->membase + ofs->cr3);
@@ -847,9 +852,13 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 		if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
 			cr3 &= ~USART_CR3_DEP;
 			rs485conf->flags &= ~SER_RS485_RTS_AFTER_SEND;
+			stm32_set_mctrl(port,
+					stm32_port->port.mctrl & ~TIOCM_RTS);
 		} else {
 			cr3 |= USART_CR3_DEP;
 			rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
+			stm32_set_mctrl(port,
+					stm32_port->port.mctrl | TIOCM_RTS);
 		}
 
 	} else {
-- 
2.27.0

