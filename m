Return-Path: <SRS0=liNn=C3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438BEC43463
	for <linux-serial@archiver.kernel.org>; Fri, 18 Sep 2020 02:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D13A235F7
	for <linux-serial@archiver.kernel.org>; Fri, 18 Sep 2020 02:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600395994;
	bh=FvoK/XHYIkx7IHIbNpADDdi/rjGeGDRz2RbObrT221Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OR1zRbBmH6/bLxIflRQ6qh0t63vZ3KCo3d9eUmT2BsXxDNGlMIkb/mDAN9MAWDhQM
	 8yjXQ2YMdnsqt9tWzjxVLjNHyHHZZGP8i5NqgdfucfvGV+sDojuW3XZ/G1LqfDysvt
	 5tNaArGhYBdKtairHJ4eY1XsME6qlwozubQMY0bE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgIRCQC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbgIRCQA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Sep 2020 22:16:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D6BC239EE;
        Fri, 18 Sep 2020 02:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600395359;
        bh=FvoK/XHYIkx7IHIbNpADDdi/rjGeGDRz2RbObrT221Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cBzEOQz8AWVgfryhKtv8evuil5+/DzPQs6UOtI0dfjLlIZgp03eAbjOA288WLRFjC
         PSgHrl4ZV+uSTSIh5P13eBswb+3nRzZlBjZbIZn3YdlCLiOvYu45A+WwuMOBbnFbur
         4cSEQ12M1Wx8Zmru1etWpb6JHTkp60Q698oXmNgo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 53/90] serial: 8250_port: Don't service RX FIFO if throttled
Date:   Thu, 17 Sep 2020 22:14:18 -0400
Message-Id: <20200918021455.2067301-53-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918021455.2067301-1-sashal@kernel.org>
References: <20200918021455.2067301-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Vignesh Raghavendra <vigneshr@ti.com>

[ Upstream commit f19c3f6c8109b8bab000afd35580929958e087a9 ]

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
Link: https://lore.kernel.org/r/20200319103230.16867-2-vigneshr@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 5641b877dca53..827a641ac336e 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1806,6 +1806,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	unsigned char status;
 	unsigned long flags;
 	struct uart_8250_port *up = up_to_u8250p(port);
+	bool skip_rx = false;
 
 	if (iir & UART_IIR_NO_INT)
 		return 0;
@@ -1814,7 +1815,20 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 
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
2.25.1

