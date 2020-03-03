Return-Path: <SRS0=YTEb=4U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EF1C3F2C6
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 08:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B3720873
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 08:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PlfocTB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgCCIlr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:41:47 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43838 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgCCIlr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Mar 2020 03:41:47 -0500
Received: by mail-pf1-f196.google.com with SMTP id s1so1100952pfh.10
        for <linux-serial@vger.kernel.org>; Tue, 03 Mar 2020 00:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GBGaVFv72Sp1W1LNbEFYJKmbIaNqJLypah697nIc7FI=;
        b=PlfocTB65f3kMVxlBezmGu8298dq5HxScUCdgPyq+IyEf2GFvCrGtSc668gDuWCAk9
         0bYZDX5nOAk30B4WC4sbhXxtywRrywa6i4W94tmeMFsSAIbu5m1ChrpND9hOVUXH3XJU
         lQK7g5sFq+tmyzcj9WuQVJ50sCdvyYig6sbwcMDFnotbTAIDOM4oEWQmUc46Q03TkdQb
         2HACWks+E49TSt8gy47yfjPRklSHPK0DczVcW+UMDK9TVVogJhKJVlC/5PyaHC5nFHq0
         9L/b/Now6GTXZZ99Mf/KNaT9dXyIfOgRPJSoztfwGClYCYK+/5venpbqFpJuq412QoiU
         inDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GBGaVFv72Sp1W1LNbEFYJKmbIaNqJLypah697nIc7FI=;
        b=GRCiBRZpyMz+W3GsSYZ4BKKHQ+ZWUlMeMIEmEYOuykYYDNi+EmJxwUaN6N++DRRdhw
         wzQ6XgTpvgw+f73mLytddROa2xM0xsZ4lymhwuH+PnZmkXS1If3r6dAagdFdBJWHMyUJ
         ABrgGyAx7uXNI1SluVJmOzHHwFu6BJjludiUjKUlirSzo+OGNwJRmkcZRmmgDg+RwxVW
         9t/LMF04ngQ5kBCZinU7VW6QYVAiZvefxxmUPqaYX/bE/oLQ8CJ1WfrDe8Ra5cQlXQ7z
         +e6xXmV1wCOqK0g4xrjUEgEAgDFPKRMzIAiwM9G9dLzGAgw8s4tOaQS/ZOR8CJ1KQ8XK
         14XQ==
X-Gm-Message-State: ANhLgQ19XL25ESn+Rh9gaQbA2v6Zx1fW1+q2vqXmteIxSEnj0MophVbC
        ZfNBawK1KSO8t/Ihu9v/fJaVHw==
X-Google-Smtp-Source: ADFU+vvUwLa29j5IXu4Q/p6wzklfB56+HzOeMxhhhDDeN2It6QgE+fpfQSE5q3+WrOBvskoD/znU0Q==
X-Received: by 2002:a63:155c:: with SMTP id 28mr3010394pgv.176.1583224905988;
        Tue, 03 Mar 2020 00:41:45 -0800 (PST)
Received: from VincentChen-ThinkPad-T480s.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id c3sm25076512pfj.159.2020.03.03.00.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Mar 2020 00:41:45 -0800 (PST)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Cc:     linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH] tty: serial: Add CONSOLE_POLL support to SiFive UART
Date:   Tue,  3 Mar 2020 16:41:40 +0800
Message-Id: <1583224900-25824-1-git-send-email-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add CONSOLE_POLL support for future KGDB porting.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 drivers/tty/serial/sifive.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index d5f81b98e4d7..acdbaca4de36 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -818,6 +818,29 @@ static int __init sifive_serial_console_setup(struct console *co, char *options)
 	return uart_set_options(&ssp->port, co, baud, parity, bits, flow);
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+static int sifive_serial_poll_get_char(struct uart_port *port)
+{
+	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
+	char is_empty, ch;
+
+	ch = __ssp_receive_char(ssp, &is_empty);
+	if (is_empty)
+		return NO_POLL_CHAR;
+
+	return ch;
+}
+
+static void sifive_serial_poll_put_char(struct uart_port *port,
+					unsigned char c)
+{
+	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
+
+	sifive_serial_console_putchar(port, c);
+	__ssp_wait_for_xmitr(ssp);
+}
+#endif /* CONFIG_CONSOLE_POLL */
+
 static struct uart_driver sifive_serial_uart_driver;
 
 static struct console sifive_serial_console = {
@@ -877,6 +900,10 @@ static const struct uart_ops sifive_serial_uops = {
 	.request_port	= sifive_serial_request_port,
 	.config_port	= sifive_serial_config_port,
 	.verify_port	= sifive_serial_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char	= sifive_serial_poll_get_char,
+	.poll_put_char	= sifive_serial_poll_put_char,
+#endif
 };
 
 static struct uart_driver sifive_serial_uart_driver = {
-- 
2.7.4

