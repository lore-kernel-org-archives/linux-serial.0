Return-Path: <SRS0=aNI9=ZO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A4DC432C0
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 14:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5751F20706
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 14:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mI7ttV16";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="IUbQLO1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfKVOSZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:18:25 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:36514
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbfKVOSY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Nov 2019 09:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574432304;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=qJH+yx4Hn/VtzKH5j0VbwhaJKVdEHt0pS4CwQiE53d4=;
        b=mI7ttV16qTlS2OyQ5IEebaD2H5Ifl1zgg9yvFQjF+ClB98jRCjBBcIoc6ewu+Hd0
        f2ak2EMQ/v8dstkUcIzFnTSOx8LJbAyvoDDyKVyhrGpb7oABFA0FwOaZajHTXpObL0S
        hkX93wNuws0JXARQaT3aEiJHbWEY2CNBUtEdEPsk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574432304;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=qJH+yx4Hn/VtzKH5j0VbwhaJKVdEHt0pS4CwQiE53d4=;
        b=IUbQLO1eI1f/Etq+4ALFYBTUJyRT9C60FosPZ8TUPVSlN+S73R5A9MIXlzEQO9ur
        BousNefHrtONZVCLYD2QUGC/DVmoFDQ0SwnG5FUCvfckgoTcBIMy5zKBlXmnKLY1QzK
        8PfY6udnJMaF0wFUeL+/GR+8RpnO6KRW3PSUpLcE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA80AC76F54
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
From:   Akash Asthana <akashast@codeaurora.org>
To:     gregkh@linuxfoundation.org
Cc:     swboyd@chromium.org, mgautam@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH v6 5/5] tty: serial: qcom_geni_serial: Move loopback support to TIOCM_LOOP
Date:   Fri, 22 Nov 2019 14:18:24 +0000
Message-ID: <0101016e937a6c00-b8cf45e5-aedf-4e03-bf23-47d7810a0b23-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574432266-20732-1-git-send-email-akashast@codeaurora.org>
References: <1574432266-20732-1-git-send-email-akashast@codeaurora.org>
X-SES-Outgoing: 2019.11.22-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Remove code from the driver that create and maintain loopback sysfs node.
Instead use the ioctl TIOCMSET with TIOCM_LOOP argument to set HW to
loopback mode.

Signed-off-by: Akash Asthana <akashast@codeaurora.org>
---
Change in V6:
 - As per stephen's comment corrected commit subject.
 - As per stephen's comment defined new macros for different loopback mode.

 drivers/tty/serial/qcom_geni_serial.c | 36 +++++++++--------------------------
 1 file changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index b952509..3e84192 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -93,7 +93,11 @@
 #define DEF_TX_WM		2
 #define DEF_FIFO_WIDTH_BITS	32
 #define UART_RX_WM		2
-#define MAX_LOOPBACK_CFG	3
+
+/* SE_UART_LOOPBACK_CFG */
+#define RX_TX_SORTED	BIT(0)
+#define CTS_RTS_SORTED	BIT(1)
+#define RX_TX_CTS_RTS_SORTED	(RX_TX_SORTED | CTS_RTS_SORTED)
 
 #ifdef CONFIG_CONSOLE_POLL
 #define CONSOLE_RX_BYTES_PW 1
@@ -165,30 +169,6 @@ static struct qcom_geni_serial_port qcom_geni_uart_ports[GENI_UART_PORTS] = {
 	},
 };
 
-static ssize_t loopback_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
-
-	return snprintf(buf, sizeof(u32), "%d\n", port->loopback);
-}
-
-static ssize_t loopback_store(struct device *dev,
-				struct device_attribute *attr, const char *buf,
-				size_t size)
-{
-	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
-	u32 loopback;
-
-	if (kstrtoint(buf, 0, &loopback) || loopback > MAX_LOOPBACK_CFG) {
-		dev_err(dev, "Invalid input\n");
-		return -EINVAL;
-	}
-	port->loopback = loopback;
-	return size;
-}
-static DEVICE_ATTR_RW(loopback);
-
 static struct qcom_geni_serial_port qcom_geni_console_port = {
 	.uport = {
 		.iotype = UPIO_MEM,
@@ -238,10 +218,14 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
 							unsigned int mctrl)
 {
 	u32 uart_manual_rfr = 0;
+	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 
 	if (uart_console(uport))
 		return;
 
+	if (mctrl & TIOCM_LOOP)
+		port->loopback = RX_TX_CTS_RTS_SORTED;
+
 	if (!(mctrl & TIOCM_RTS))
 		uart_manual_rfr = UART_MANUAL_RFR_EN | UART_RFR_NOT_READY;
 	writel(uart_manual_rfr, uport->membase + SE_UART_MANUAL_RFR);
@@ -1311,8 +1295,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	uport->private_data = drv;
 	platform_set_drvdata(pdev, port);
 	port->handle_rx = console ? handle_rx_console : handle_rx_uart;
-	if (!console)
-		device_create_file(uport->dev, &dev_attr_loopback);
 
 	ret = uart_add_one_port(drv, uport);
 	if (ret)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

