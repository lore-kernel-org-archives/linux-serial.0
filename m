Return-Path: <SRS0=aY4b=7G=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD72C433E0
	for <linux-serial@archiver.kernel.org>; Sun, 24 May 2020 16:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D2A20787
	for <linux-serial@archiver.kernel.org>; Sun, 24 May 2020 16:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgEXQbu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 24 May 2020 12:31:50 -0400
Received: from mail.h3q.com ([213.73.89.199]:60410 "EHLO mail.h3q.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbgEXQbu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 24 May 2020 12:31:50 -0400
Received: (qmail 22943 invoked from network); 24 May 2020 16:31:48 -0000
Received: from mail.h3q.com (HELO mail.h3q.com) (mail.h3q.com)
  by mail.h3q.com with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 24 May 2020 16:31:48 -0000
From:   Denis Ahrens <denis@h3q.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: [PATCH] 16C950 UART enable Hardware Flow Control
Message-Id: <BACA4F76-3D51-4854-894B-2E69272B5676@h3q.com>
Date:   Sun, 24 May 2020 18:31:44 +0200
Cc:     gregkh@linuxfoundation.org
To:     linux-serial@vger.kernel.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Denis Ahrens <denis@h3q.com>

Enable Automatic RTS/CTS flow control for the 16C950 UART in Enhanced Mode
like described in the Data Sheet Revision 1.2 page 28 and 29.

Without this change normal console output works, but everything putting
a little more pressure on the UART simply overruns the FIFO.

Signed-off-by: Denis Ahrens <denis@h3q.com>
---

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f77bf820b7a3..024235946f4d 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2168,7 +2168,9 @@ int serial8250_do_startup(struct uart_port *port)
                serial_port_out(port, UART_LCR, 0);
                serial_icr_write(up, UART_CSR, 0); /* Reset the UART */
                serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
-               serial_port_out(port, UART_EFR, UART_EFR_ECB);
+               serial_port_out(port, UART_EFR, UART_EFR_ECB |
+                                               UART_EFR_RTS |
+                                               UART_EFR_CTS);
                serial_port_out(port, UART_LCR, 0);
        }

