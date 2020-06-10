Return-Path: <SRS0=uqjK=7X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A18C433E1
	for <linux-serial@archiver.kernel.org>; Wed, 10 Jun 2020 15:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832C32078C
	for <linux-serial@archiver.kernel.org>; Wed, 10 Jun 2020 15:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591802598;
	bh=J4EvuNZRQaDKsUZAoTH53JBy6+I7msCWFXurR8eu5kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ux78cJEIh4klbdTfop0vle+PztMuY2Njm0HHI8lK+w46DlixUH36FNnTZ0LVO0zHu
	 mq8xhTwLAO5FX5p6PRlRAhih2VX/GE9yUkFXHm8zQNvcbkT7o483gMRMzUKEd96xEy
	 VBPryqmqGq2iGYg4N+/t36ygUtVmknfULJ+tfosM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgFJPXH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:23:07 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43451 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgFJPXG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Jun 2020 11:23:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id n24so2952205lji.10;
        Wed, 10 Jun 2020 08:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7FcHqQvQ4AdT99/MIssZEpanZF2+KdKV6/Bn+69RA6A=;
        b=grfqaIKWJ9ffNc2u+YNAlY/Wp28Nts/WhEQWidj7eHiqLtmgE6TBAwT5A9F0ARfauS
         ztmNe5tyvbXHFy7+PpMvmSdviLyUja2uUpFIIyoYeQtIkDTSrottGxrd30z4OdcqWQqR
         2GBdRdtVNfvu8DF4QHWtGNveYPNGVl66e3MQ9L9N1aM7rwX+hGQDte/rAx/3QkQN2lX+
         XvpPMKB1fFe/V/9mETGtmLIbbtnYacwldtCE65KljNxeP0xx99PxAJWwkYfORbf0/gVW
         C61UsQcuKnJX323GCApwWFwqOWxLloxOwa/OpsiZLZOcd1t5yOzPx2N9zDNMOYncUdgr
         +xgQ==
X-Gm-Message-State: AOAM530wZfdHH/X4ohF9wPwSYODrSslxZ0EsrfYrFRfduuDeNkBupmxX
        E7Whu4UjdipLuB+YCPDs/iE=
X-Google-Smtp-Source: ABdhPJy1oyYPF41FDNYRpv14sU2nbP4vwtZWaMcVwsv2zKf2pwJvhCLKtB+itc/+P94ngy0pAPg0mQ==
X-Received: by 2002:a05:651c:54e:: with SMTP id q14mr1858612ljp.279.1591802582556;
        Wed, 10 Jun 2020 08:23:02 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id l16sm7083lji.138.2020.06.10.08.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 08:23:01 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1jj2Z8-0004Pr-9h; Wed, 10 Jun 2020 17:22:58 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 1/3] Revert "serial: core: Refactor uart_unlock_and_check_sysrq()"
Date:   Wed, 10 Jun 2020 17:22:30 +0200
Message-Id: <20200610152232.16925-2-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610152232.16925-1-johan@kernel.org>
References: <20200610152232.16925-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit da9a5aa3402db0ff3b57216d8dbf2478e1046cae.

In order to ease backporting a fix for a sysrq regression, revert this
rewrite which was since added on top.

The other sysrq helpers now bail out early when sysrq is not enabled;
it's better to keep that pattern here as well.

Note that the __releases() attribute won't be needed after the follow-on
fix either.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/serial_core.c | 23 +++++++++++++----------
 include/linux/serial_core.h      |  3 ++-
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 57840cf90388..296b9f6fa9cd 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3239,19 +3239,22 @@ int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
 }
 EXPORT_SYMBOL_GPL(uart_prepare_sysrq_char);
 
-void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long flags)
-__releases(&port->lock)
+void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
 {
-	if (port->has_sysrq) {
-		int sysrq_ch = port->sysrq_ch;
+	int sysrq_ch;
 
-		port->sysrq_ch = 0;
-		spin_unlock_irqrestore(&port->lock, flags);
-		if (sysrq_ch)
-			handle_sysrq(sysrq_ch);
-	} else {
-		spin_unlock_irqrestore(&port->lock, flags);
+	if (!port->has_sysrq) {
+		spin_unlock_irqrestore(&port->lock, irqflags);
+		return;
 	}
+
+	sysrq_ch = port->sysrq_ch;
+	port->sysrq_ch = 0;
+
+	spin_unlock_irqrestore(&port->lock, irqflags);
+
+	if (sysrq_ch)
+		handle_sysrq(sysrq_ch);
 }
 EXPORT_SYMBOL_GPL(uart_unlock_and_check_sysrq);
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 9fd550e7946a..ef4921ddbe97 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -464,7 +464,8 @@ extern void uart_insert_char(struct uart_port *port, unsigned int status,
 
 extern int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch);
 extern int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch);
-extern void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long flags);
+extern void uart_unlock_and_check_sysrq(struct uart_port *port,
+					unsigned long irqflags);
 extern int uart_handle_break(struct uart_port *port);
 
 /*
-- 
2.26.2

