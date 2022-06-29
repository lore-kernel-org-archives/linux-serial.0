Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97E1C43334
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jun 2022 16:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiF2QDC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Jun 2022 12:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbiF2QCq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Jun 2022 12:02:46 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84223DA7E;
        Wed, 29 Jun 2022 09:02:12 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x20so8926440plx.6;
        Wed, 29 Jun 2022 09:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CJJp/edqE0VYgT5YcDxPOCod4r5mz+4cDG6Mur+0wZ0=;
        b=eAMuXAe3tt7zQK9Shz6RhA9+QatycoVFaICI3RUh92p1GFeBS58Our6URt2U37z2nV
         cK2Fxzkqo3t0oJSQesaEAP/fe3IXtVUNswdOSnbhg15eBnsMauzO2MOux6OsW29tyCPZ
         3pDsOBxArG/JmuwkPrGj+vpTPTdHnZVGvPdzBkSYeGA7m+rvaP1GW3PowrhmzgGys3kZ
         FhvxFXG0KYQYDhv/wqo8grM6blhLoujtRrg8q5WX5Z+N6NBzsYAdR1w/ROxNyeazBQir
         6tq9f3fpb+JQAl5VtuAh/NjQ8zNSAIMhAUVR45QVxPmbhMsz+7iV1c0AmZzk88eGTlX6
         p2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CJJp/edqE0VYgT5YcDxPOCod4r5mz+4cDG6Mur+0wZ0=;
        b=1/RkqLhJ8mfo8bmRjhvpN47IdMskPm2KiKAc39pi5iu0F6XkiG4ka474qL6Y13yJvx
         YbfJP3xQmgh7Yl12sj+vf7qenhpOi8ebOOZZwdkBGbg9IzADpKpM3AvBUXmCmZd3FOOi
         CVjnYH1rq6efKOWrNfDJATXlvd4i1LtOAM3pOybuX0F85NFhOajPdeWDHRU6FWXHwAoT
         Si+Xrd8xJfvgrsprFK+0S4PjDI5TW888+11nGCSxOUoSPtp0msWeOzPhNYWly7ERDUPa
         dsI5C7U6juEdMr0PAhVT0pLMit9PUSemYVKpEKVkMJqEU6q4UPzVJQ194PBPUV7jQ2SS
         dkYw==
X-Gm-Message-State: AJIora/wv3K9G8hIHgHFO1zguQEV3qKXOzp+5uCWqfJ952ZoMufG7Zih
        O4/iKB3yrX6SrO5rvTptzq9cE86NZUc=
X-Google-Smtp-Source: AGRyM1tSJxC6R/UM0vzZklgGWPbjZlgFQK5p80MIJ7MVda9lemJhRUssh8I6sldln5/r+P20CbGqIg==
X-Received: by 2002:a17:90b:4b4c:b0:1ec:a857:46bb with SMTP id mi12-20020a17090b4b4c00b001eca85746bbmr6502053pjb.108.1656518532066;
        Wed, 29 Jun 2022 09:02:12 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902b58f00b001677d4a9654sm11591881pls.265.2022.06.29.09.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 09:02:10 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2] serial: 8250_bcm7271: Save/restore RTS in suspend/resume
Date:   Wed, 29 Jun 2022 09:02:08 -0700
Message-Id: <20220629160208.3167955-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

Commit 9cabe26e65a8 ("serial: 8250_bcm7271: UART errors after resuming
from S2") prevented an early enabling of RTS during resume, but it did
not actively restore the RTS state after resume.

Fixes: 9cabe26e65a8 ("serial: 8250_bcm7271: UART errors after resuming from S2")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 9b878d023dac..b9cea38c8aff 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1139,16 +1139,19 @@ static int __maybe_unused brcmuart_suspend(struct device *dev)
 	struct brcmuart_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up = serial8250_get_port(priv->line);
 	struct uart_port *port = &up->port;
-
-	serial8250_suspend_port(priv->line);
-	clk_disable_unprepare(priv->baud_mux_clk);
+	unsigned long flags;
 
 	/*
 	 * This will prevent resume from enabling RTS before the
-	 *  baud rate has been resored.
+	 *  baud rate has been restored.
 	 */
+	spin_lock_irqsave(&port->lock, flags);
 	priv->saved_mctrl = port->mctrl;
-	port->mctrl = 0;
+	port->mctrl &= ~TIOCM_RTS;
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	serial8250_suspend_port(priv->line);
+	clk_disable_unprepare(priv->baud_mux_clk);
 
 	return 0;
 }
@@ -1158,6 +1161,7 @@ static int __maybe_unused brcmuart_resume(struct device *dev)
 	struct brcmuart_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up = serial8250_get_port(priv->line);
 	struct uart_port *port = &up->port;
+	unsigned long flags;
 	int ret;
 
 	ret = clk_prepare_enable(priv->baud_mux_clk);
@@ -1180,7 +1184,15 @@ static int __maybe_unused brcmuart_resume(struct device *dev)
 		start_rx_dma(serial8250_get_port(priv->line));
 	}
 	serial8250_resume_port(priv->line);
-	port->mctrl = priv->saved_mctrl;
+
+	if (priv->saved_mctrl & TIOCM_RTS) {
+		/* Restore RTS */
+		spin_lock_irqsave(&port->lock, flags);
+		port->mctrl |= TIOCM_RTS;
+		spin_unlock_irqrestore(&port->lock, flags);
+		port->ops->set_mctrl(port, port->mctrl);
+	}
+
 	return 0;
 }
 
-- 
2.25.1

