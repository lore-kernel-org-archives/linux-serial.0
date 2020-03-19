Return-Path: <SRS0=NQQO=5E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91584C4332B
	for <linux-serial@archiver.kernel.org>; Thu, 19 Mar 2020 10:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696A820767
	for <linux-serial@archiver.kernel.org>; Thu, 19 Mar 2020 10:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qa/Au4AX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgCSKcQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:32:16 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:32886 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbgCSKcP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Mar 2020 06:32:15 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02JAWB19036930;
        Thu, 19 Mar 2020 05:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584613931;
        bh=BVGKTiirTLIjZ0K4jp3Zl0h64gzTg8mOGxuj0krFr1U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qa/Au4AXJCqlim+uSASu6klw19xN49VQHsmI8+PmIFiKiUYrzGZeUxYp2yZCWUEe5
         +dIDKI25r2D7N/QlzN0/VfWjdAFhAfx7D0y+qZN7vEX4uzaXdk4UdN5SjpvvPJIV0E
         +9GotQYJU+QjqbOMQ6kdx/cEJbyjeUzYEapPkqRY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02JAWB4B099016
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Mar 2020 05:32:11 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Mar 2020 05:32:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Mar 2020 05:32:10 -0500
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02JAW6Ai068234;
        Thu, 19 Mar 2020 05:32:09 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Oliver Barta <o.barta89@gmail.com>
Subject: [PATCH 1/2] serial: 8250_port: Don't service RX FIFO if throttled
Date:   Thu, 19 Mar 2020 16:02:29 +0530
Message-ID: <20200319103230.16867-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319103230.16867-1-vigneshr@ti.com>
References: <20200319103230.16867-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When port's throttle callback is called, it should stop pushing any more
data into TTY buffer to avoid buffer overflow. This means driver has to
stop HW from receiving more data and assert the HW flow control. For
UARTs with auto HW flow control (such as 8250_omap) manual assertion of
flow control line is not possible and only way is to allow RX FIFO to
fill up, thus trigger auto HW flow control logic.

Therefore make sure that 8250 generic IRQ handler does not drain data
when port is stopped (i.e UART_LSR_DR is unset in read_status_mask). Not
servicing, RX FIFO would trigger auto HW flow control when FIFO
occupancy reaches preset threshold, thus halting RX.
Since, error conditions in UART_LSR register are cleared just by reading
the register, data has to be drained in case there are FIFO errors, else
error information will lost.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/tty/serial/8250/8250_port.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 4440867b7d20..2f973280c34a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1883,6 +1883,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	unsigned char status;
 	unsigned long flags;
 	struct uart_8250_port *up = up_to_u8250p(port);
+	bool skip_rx = false;
 
 	if (iir & UART_IIR_NO_INT)
 		return 0;
@@ -1891,7 +1892,20 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 
 	status = serial_port_in(port, UART_LSR);
 
-	if (status & (UART_LSR_DR | UART_LSR_BI)) {
+	/*
+	 * If port is stopped and there are no error conditions in the
+	 * FIFO, then don't drain the FIFO, as this may lead to TTY buffer
+	 * overflow. Not servicing, RX FIFO would trigger auto HW flow
+	 * control when FIFO occupancy reaches preset threshold, thus
+	 * halting RX. This only works when auto HW flow control is
+	 * available.
+	 */
+	if (!(status & (UART_LSR_FIFOE | UART_LSR_BRK_ERROR_BITS)) &&
+	    (port->status & (UPSTAT_AUTOCTS | UPSTAT_AUTORTS)) &&
+	    !(port->read_status_mask & UART_LSR_DR))
+		skip_rx = true;
+
+	if (status & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);
 	}
-- 
2.25.2

