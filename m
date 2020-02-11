Return-Path: <SRS0=2Nu8=37=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5A5C352A3
	for <linux-serial@archiver.kernel.org>; Tue, 11 Feb 2020 10:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D04A20848
	for <linux-serial@archiver.kernel.org>; Tue, 11 Feb 2020 10:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgBKKNV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:13:21 -0500
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:49315 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727561AbgBKKNV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Feb 2020 05:13:21 -0500
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 11 Feb 2020 15:43:18 +0530
Received: from c-skakit-linux.qualcomm.com ([10.242.50.210])
  by ironmsg02-blr.qualcomm.com with ESMTP; 11 Feb 2020 15:43:05 +0530
Received: by c-skakit-linux.qualcomm.com (Postfix, from userid 2344709)
        id 58D592294; Tue, 11 Feb 2020 15:43:04 +0530 (IST)
From:   satya priya <skakit@codeaurora.org>
To:     gregkh@linuxfoundation.org
Cc:     swboyd@chromium.org, mgautam@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        akashast@codeaurora.org, satya priya <skakit@codeaurora.org>
Subject: [PATCH] tty: serial: qcom_geni_serial: Fix RX cancel command failure
Date:   Tue, 11 Feb 2020 15:43:02 +0530
Message-Id: <1581415982-8793-1-git-send-email-skakit@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RX cancel command fails when BT is switched on and off multiple times.

To handle this, poll for the cancel bit in SE_GENI_S_IRQ_STATUS register
instead of SE_GENI_S_CMD_CTRL_REG.

As per the HPG update, handle the RX last bit after cancel command
and flush out the RX FIFO buffer.

Signed-off-by: satya priya <skakit@codeaurora.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 191abb1..0bd1684 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -129,6 +129,7 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop);
 static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop);
 static unsigned int qcom_geni_serial_tx_empty(struct uart_port *port);
 static void qcom_geni_serial_stop_rx(struct uart_port *uport);
+static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop);
 
 static const unsigned long root_freq[] = {7372800, 14745600, 19200000, 29491200,
 					32000000, 48000000, 64000000, 80000000,
@@ -599,7 +600,7 @@ static void qcom_geni_serial_stop_rx(struct uart_port *uport)
 	u32 irq_en;
 	u32 status;
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
-	u32 irq_clear = S_CMD_DONE_EN;
+	u32 s_irq_status;
 
 	irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
 	irq_en &= ~(S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN);
@@ -615,10 +616,19 @@ static void qcom_geni_serial_stop_rx(struct uart_port *uport)
 		return;
 
 	geni_se_cancel_s_cmd(&port->se);
-	qcom_geni_serial_poll_bit(uport, SE_GENI_S_CMD_CTRL_REG,
-					S_GENI_CMD_CANCEL, false);
+	qcom_geni_serial_poll_bit(uport, SE_GENI_S_IRQ_STATUS,
+					S_CMD_CANCEL_EN, true);
+	/*
+	 * If timeout occurs secondary engine remains active
+	 * and Abort sequence is executed.
+	 */
+	s_irq_status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
+	/* Flush the Rx buffer */
+	if (s_irq_status & S_RX_FIFO_LAST_EN)
+		qcom_geni_serial_handle_rx(uport, true);
+	writel(s_irq_status, uport->membase + SE_GENI_S_IRQ_CLEAR);
+
 	status = readl(uport->membase + SE_GENI_STATUS);
-	writel(irq_clear, uport->membase + SE_GENI_S_IRQ_CLEAR);
 	if (status & S_GENI_CMD_ACTIVE)
 		qcom_geni_serial_abort_rx(uport);
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

