Return-Path: <SRS0=T9rn=2D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98156C43603
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681752073B
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fm7lZwBP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbfLMAJz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:09:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46824 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731920AbfLMAJz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:55 -0500
Received: by mail-pl1-f196.google.com with SMTP id k20so372339pll.13
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+19+gHR9cQtzG0SbAxxpoIQN5hIivcDHXKstCXTe0SU=;
        b=fm7lZwBPfVm4Q9dAyUTsSOublHXDGdvf8myJOTPvONC2UZG03EWhvZAORYa6np0Yji
         Mtgjo9OqliSsL7PXfDBN1Nw9koZt1vVvtB6SyRrOAtnXqVBUcXniPkQsiXRnhzKniwhO
         2d/2Ji1LwcwTyMq9y+WbFnyUcroFEf2neE0SyqyA/oDGrn+vtmDhpJjSoXuzJ2L6woDY
         OROvM/HbbT+NAeEOA+8qgZ5lGAG+buqiKaasYc/89Kld8071U1q1+ArZ+Gnh+tqAKL1s
         TDQUraO5ODxMK9lI1jvDB4dSDEXc0OXlU+msB+fvFdMtPwpHntAXs8Hc1IN5WvghnEOS
         IHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+19+gHR9cQtzG0SbAxxpoIQN5hIivcDHXKstCXTe0SU=;
        b=BqqxrGIeMdRYkZoAIAcA9EPQIAZhwnrwEH4TWH6DrQYHpriw5mmE996B5PHYPc9IKC
         MJJn7abiCLikdy4tFewK60V9Wnx/zgNUHqB3rJvHrr8tIgbvWMplgHYs/wexvgFDX9eB
         hgfV9DZslrsize2yjc6yT3Jnw/EFHgzKuiMBs8zm1aTd6Ox/4P9+SMt1lZ1+evx1BLAx
         6YTPmibYQqHlFOVYAYsPJu8nTatrbTHlbC7jhWmTt7qgYs2lJrvHRK2Yqnen75Tfx0J/
         xAb2QSgmQkNtppZi1MUsEHxlMOu9nHEuhsTaKjorRaRJ3Pw0GfRtOlI7zERy5svUK7Z2
         DGGA==
X-Gm-Message-State: APjAAAWz+jcgwsbLy8l+BtvM1GfwsLWJgJ1GsYqRjkG2yv8ioe0geMx8
        YHy06+in0xTFUybePysmIOvDlA==
X-Google-Smtp-Source: APXvYqyj2L1MOlbvvhInw0zzC+wmgjjo1MCSXcvzEW3SDiVgj0bmeMP0/UR2W5z8JzFr+HTm7Kwrqg==
X-Received: by 2002:a17:902:be02:: with SMTP id r2mr12205174pls.76.1576195794481;
        Thu, 12 Dec 2019 16:09:54 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:53 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 54/58] serial_core: Remove SUPPORT_SYSRQ ifdeffery
Date:   Fri, 13 Dec 2019 00:06:53 +0000
Message-Id: <20191213000657.931618-55-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

No one defines it anymore.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/serial_core.h | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 5f761c399282..9cf1682dc580 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -466,10 +466,7 @@ uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
 	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
 		return 0;
 
-	if (!port->has_sysrq && !IS_ENABLED(SUPPORT_SYSRQ))
-		return 0;
-
-	if (!port->sysrq)
+	if (!port->has_sysrq || !port->sysrq)
 		return 0;
 
 	if (ch && time_before(jiffies, port->sysrq)) {
@@ -487,10 +484,7 @@ uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
 	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
 		return 0;
 
-	if (!port->has_sysrq && !IS_ENABLED(SUPPORT_SYSRQ))
-		return 0;
-
-	if (!port->sysrq)
+	if (!port->has_sysrq || !port->sysrq)
 		return 0;
 
 	if (ch && time_before(jiffies, port->sysrq)) {
@@ -507,7 +501,7 @@ uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
 {
 	int sysrq_ch;
 
-	if (!port->has_sysrq && !IS_ENABLED(SUPPORT_SYSRQ)) {
+	if (!port->has_sysrq) {
 		spin_unlock_irqrestore(&port->lock, irqflags);
 		return;
 	}
@@ -531,7 +525,7 @@ static inline int uart_handle_break(struct uart_port *port)
 	if (port->handle_break)
 		port->handle_break(port);
 
-	if (port->has_sysrq || IS_ENABLED(SUPPORT_SYSRQ)) {
+	if (port->has_sysrq) {
 		if (port->cons && port->cons->index == port->line) {
 			if (!port->sysrq) {
 				port->sysrq = jiffies + HZ*5;
-- 
2.24.0

