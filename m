Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10968C433DB
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 17:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B381022CE3
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 17:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbhAERCr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Jan 2021 12:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730185AbhAERCr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Jan 2021 12:02:47 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA6BC061574;
        Tue,  5 Jan 2021 09:02:06 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b73so1161584edf.13;
        Tue, 05 Jan 2021 09:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nXr5ak/ayXG0mLNUO+7vuO7bjdOSjjDtr/aQD9ygt94=;
        b=UwfxheqcSiLFAO91/TjnnIkUrkB6PT/YCmY7jZlQU1agpQXOc4Lgx0mjoaWIonFNm9
         NwSOwSKa/6cNJBSYGuHlskmt+jsZGbOrKs42zEqMaKZngfCwrPwSmmps69qOExcTKA+r
         HROEOg6T4QQlkx2GNhyvajHaF/YFKD0amleuLP8xL1ovnE8PaOBHg275uRsGPb8CRx6g
         70y01GVqGmEXhGe4W1CzFvJ0z4O+216TS3lsA4HUtIDxiymtCjc8VeQNzrvia4wBw8Q6
         LAU0gZ0Nh/FZ46C6Mnry1LONCCVo3MoTxY+dGSACqNAQoqZD4mRssNHuxksJkMI9KLH8
         ugSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nXr5ak/ayXG0mLNUO+7vuO7bjdOSjjDtr/aQD9ygt94=;
        b=K9wLS6P9ThjMwjUF9I9v/I/brNWErdcvRl/McYc6uGvgHKs+gZURslyraJyVybHFRV
         25HEzxgv3INILImmuooV1zE49SN6tBrJuB8MuMmgjs0JG+NsY4g3y6qCWfYkptCpL5R8
         oueE+EwL1BiV27N0hXh1Yo0ANdhw93r16GJZs0ZuOt6jh1XifFLi2ylcZ5MTNJlfi2zD
         kvIAk0LGnjZczduIDB+ccme+hITNagcq+Q4yv62E0EClgzI0hSxXCKPWLoz6w5x7qgH9
         uNtG8iJ0tjLRXIalpZ39rQ7NAm5pyDfMs62ZbHMiUfIJmWVrqip0wXkWt7SrcdTQP9IU
         PTMg==
X-Gm-Message-State: AOAM531WHFu7OHXovtIfVsgVZlyK7AEXKb5/FsSO47SQn2MKKmtFYYcG
        T7C7ZvXqPcTTI+39VzT0qek=
X-Google-Smtp-Source: ABdhPJxTHWpX5TO4IyFPB3yzCKjStI6pzZednGNDFCMMLEcZkJn1sMxbR0ie6QI0LnZd5NB+IZyBmA==
X-Received: by 2002:a50:8a90:: with SMTP id j16mr687135edj.334.1609866125260;
        Tue, 05 Jan 2021 09:02:05 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id u2sm99711ejb.65.2021.01.05.09.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 09:02:04 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] tty: serial: owl: Add support for kernel debugger
Date:   Tue,  5 Jan 2021 19:02:02 +0200
Message-Id: <036c09732183a30eaab230884114f65ca42ca3b9.1609865007.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Implement 'poll_put_char' and 'poll_get_char' callbacks in struct
'owl_uart_ops' that enables OWL UART to be used for kernel debugging
over serial line.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
Changes in v2:
 - Reverted unnecessary changes per Andreas feedback
 - Optimized implementation for 'owl_uart_poll_get_char()'
   and 'owl_uart_poll_put_char()' callbacks

 drivers/tty/serial/owl-uart.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index c149f8c30007..54b24669ebc5 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -12,6 +12,7 @@
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -461,6 +462,26 @@ static void owl_uart_config_port(struct uart_port *port, int flags)
 	}
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+
+static int owl_uart_poll_get_char(struct uart_port *port)
+{
+	if (owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_RFEM)
+		return NO_POLL_CHAR;
+
+	return owl_uart_read(port, OWL_UART_RXDAT);
+}
+
+static void owl_uart_poll_put_char(struct uart_port *port, unsigned char ch)
+{
+	while (owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TFFU)
+		cpu_relax();
+
+	owl_uart_write(port, ch, OWL_UART_TXDAT);
+}
+
+#endif /* CONFIG_CONSOLE_POLL */
+
 static const struct uart_ops owl_uart_ops = {
 	.set_mctrl = owl_uart_set_mctrl,
 	.get_mctrl = owl_uart_get_mctrl,
@@ -476,6 +497,10 @@ static const struct uart_ops owl_uart_ops = {
 	.request_port = owl_uart_request_port,
 	.release_port = owl_uart_release_port,
 	.verify_port = owl_uart_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char = owl_uart_poll_get_char,
+	.poll_put_char = owl_uart_poll_put_char,
+#endif
 };
 
 #ifdef CONFIG_SERIAL_OWL_CONSOLE
-- 
2.30.0

