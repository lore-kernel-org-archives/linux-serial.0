Return-Path: <SRS0=T9rn=2D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF7AC3F68F
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029332464B
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LVR+txnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbfLMAHY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:07:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38916 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731326AbfLMAHX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:07:23 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so385769pfx.6
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4b6/yjzi5Wqvr2AKScUxOfFqYlv/RC0JhB1xD4j/o58=;
        b=LVR+txnMVMqv2G6nuSfSSpznJ/8g8tRKsMrLWyfEjOUEgh2zQn/WymLY7ZIG16I0nx
         31x97ux2TYsjCrPxzvw+Qpg+q3Oht//rBVQth8qaBr/sv8SgJUQs9Mj5a44x+Q9qzvWt
         vI6dkGHe1rVh7OkNunVSxGSCMWWVKsp1yqxM0cvXq+6ucVlFfkbfuNoTMVG2dEUVkcE+
         B8q8nbYihcxOK2qaXzbBKBMwSb4AGF3q+ogZSJ+ikYjxDRlYO4/WD3eJWJbGf94D3WW3
         nYmPi2ItEs0B46dlVbGGVsHcPXGfyNMR3VYTZZlQugFCq5L5ARJuU/d9F0HeJiqVpbJR
         bWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4b6/yjzi5Wqvr2AKScUxOfFqYlv/RC0JhB1xD4j/o58=;
        b=ri+oHI34xGAZJNkeUOepRlsKs7q+pb/ZVkf0R/+n7LsVietWlI79bln92V5p725Puh
         pfpFWwKEGJTSNveJyj6d5Uhm8l3eE6cgdHjZkb70EaudNj0uK+jZsRxSdDgkQURv4j4k
         XzMWuqD6iATsuea4K+YsIChDIUaqC9dqBrAQfEl5bX0jMBWepTaBJvz5LVUr3tvVcChy
         Lg+3Fq4oWsbsudTv1JnHDZ5bSIYKVsA4CwZpH4Q1jlNErN+zK7ScCfnxaiaGZGYum+0z
         KWwIekCw0s5IU1D5vTaC8I2B+ns0w1m2Y2ERrs7dmKAUh6FObuWOnDalafwlejVCbhut
         kFew==
X-Gm-Message-State: APjAAAXvsyfLteWA7xUcbcXBIDxe5gowQRrw79NwFaFHPcMUk+fwanfI
        /3xqIG4rOVsvM80lJWl0HgN28Q==
X-Google-Smtp-Source: APXvYqxFYCiciNaM1IW9YxK6CCYex9S4oZ0u9ws733zfIsf+2UJFfvlc3t5MmD9AJ/w/SaTjIi0LwQ==
X-Received: by 2002:a63:696:: with SMTP id 144mr14269710pgg.260.1576195642697;
        Thu, 12 Dec 2019 16:07:22 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:07:21 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 03/58] serial_core: Un-ifdef sysrq SUPPORT_SYSRQ
Date:   Fri, 13 Dec 2019 00:06:02 +0000
Message-Id: <20191213000657.931618-4-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The SUPPORT_SYSRQ is messy: every .c source should define it before
including "serial_core.h" if sysrq is supported or struct uart_port will
differ in sizes. Also this prevents moving to serial_core.c functions:
uart_handle_sysrq_char(), uart_prepare_sysrq_char(),
uart_unlock_and_check_sysrq().

It doesn't save many bytes in the structure, and a better way to reduce
it's size would be making rs485 and iso7816 pointers.

Introduce `has_sysrq` member to be used by serial line drivers further.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/serial_core.h | 77 +++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 34 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index bbbe57bf5163..5f761c399282 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -240,14 +240,13 @@ struct uart_port {
 	resource_size_t		mapsize;
 	struct device		*dev;			/* parent device */
 
-#if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(SUPPORT_SYSRQ)
 	unsigned long		sysrq;			/* sysrq timeout */
 	unsigned int		sysrq_ch;		/* char for sysrq */
-#endif
+	unsigned char		has_sysrq;
 
 	unsigned char		hub6;			/* this should be in the 8250 driver */
 	unsigned char		suspended;
-	unsigned char		unused[2];
+	unsigned char		unused;
 	const char		*name;			/* port name */
 	struct attribute_group	*attr_group;		/* port specific attributes */
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
@@ -461,31 +460,46 @@ extern void uart_handle_cts_change(struct uart_port *uport,
 extern void uart_insert_char(struct uart_port *port, unsigned int status,
 		 unsigned int overrun, unsigned int ch, unsigned int flag);
 
-#if defined(SUPPORT_SYSRQ) && defined(CONFIG_MAGIC_SYSRQ_SERIAL)
 static inline int
 uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
 {
-	if (port->sysrq) {
-		if (ch && time_before(jiffies, port->sysrq)) {
-			handle_sysrq(ch);
-			port->sysrq = 0;
-			return 1;
-		}
+	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
+		return 0;
+
+	if (!port->has_sysrq && !IS_ENABLED(SUPPORT_SYSRQ))
+		return 0;
+
+	if (!port->sysrq)
+		return 0;
+
+	if (ch && time_before(jiffies, port->sysrq)) {
+		handle_sysrq(ch);
 		port->sysrq = 0;
+		return 1;
 	}
+	port->sysrq = 0;
+
 	return 0;
 }
 static inline int
 uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
 {
-	if (port->sysrq) {
-		if (ch && time_before(jiffies, port->sysrq)) {
-			port->sysrq_ch = ch;
-			port->sysrq = 0;
-			return 1;
-		}
+	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
+		return 0;
+
+	if (!port->has_sysrq && !IS_ENABLED(SUPPORT_SYSRQ))
+		return 0;
+
+	if (!port->sysrq)
+		return 0;
+
+	if (ch && time_before(jiffies, port->sysrq)) {
+		port->sysrq_ch = ch;
 		port->sysrq = 0;
+		return 1;
 	}
+	port->sysrq = 0;
+
 	return 0;
 }
 static inline void
@@ -493,6 +507,11 @@ uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
 {
 	int sysrq_ch;
 
+	if (!port->has_sysrq && !IS_ENABLED(SUPPORT_SYSRQ)) {
+		spin_unlock_irqrestore(&port->lock, irqflags);
+		return;
+	}
+
 	sysrq_ch = port->sysrq_ch;
 	port->sysrq_ch = 0;
 
@@ -501,17 +520,6 @@ uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
 	if (sysrq_ch)
 		handle_sysrq(sysrq_ch);
 }
-#else
-static inline int
-uart_handle_sysrq_char(struct uart_port *port, unsigned int ch) { return 0; }
-static inline int
-uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch) { return 0; }
-static inline void
-uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
-{
-	spin_unlock_irqrestore(&port->lock, irqflags);
-}
-#endif
 
 /*
  * We do the SysRQ and SAK checking like this...
@@ -523,15 +531,16 @@ static inline int uart_handle_break(struct uart_port *port)
 	if (port->handle_break)
 		port->handle_break(port);
 
-#ifdef SUPPORT_SYSRQ
-	if (port->cons && port->cons->index == port->line) {
-		if (!port->sysrq) {
-			port->sysrq = jiffies + HZ*5;
-			return 1;
+	if (port->has_sysrq || IS_ENABLED(SUPPORT_SYSRQ)) {
+		if (port->cons && port->cons->index == port->line) {
+			if (!port->sysrq) {
+				port->sysrq = jiffies + HZ*5;
+				return 1;
+			}
+			port->sysrq = 0;
 		}
-		port->sysrq = 0;
 	}
-#endif
+
 	if (port->flags & UPF_SAK)
 		do_SAK(state->port.tty);
 	return 0;
-- 
2.24.0

