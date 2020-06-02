Return-Path: <SRS0=qx80=7P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6F7C433DF
	for <linux-serial@archiver.kernel.org>; Tue,  2 Jun 2020 14:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7DB2074B
	for <linux-serial@archiver.kernel.org>; Tue,  2 Jun 2020 14:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591106498;
	bh=LELkd2k1drB3tpfUFVU+WqSSFB49gF/5QGsuR0Q39bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e9y9egNgUbe5UfwM1xB8MvWtjFuWioSRSJ5pf95eZZA3mGA0Qjc2e482Xc/Yj8ExD
	 yjDW+BFkrlKvkeWdfQ4Pw3z2dEZQKYKEkdrbYn0QkTmUqQtXx/5RRnkmrEFSJGeAq5
	 +iReSODZUrsGYTvVU1IEXoKR+s1zxOvezQHeLX08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgFBOBa (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:01:30 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40062 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgFBOB3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Jun 2020 10:01:29 -0400
Received: by mail-lf1-f68.google.com with SMTP id h188so6241063lfd.7;
        Tue, 02 Jun 2020 07:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+5dZP0N/KgDL7qVQ3zwXE0knmk7QfVhwRTSDP7yoBRg=;
        b=uXyCNCO01ANz+qsL0pborVqx4nQodt81b7VcEmr38v+u4QLCZBKGWeKjNanVCr+Huy
         GbAni8jwQDLqJNJZyCc9MaV9MXXyq7H1GVJ9qc/H+CsfO5xlvTztE/AXkpnUzmrP58jq
         FzoUo44yipuz0RE4JwBwDHQuDFg5zyRlRqG29eGX/3w01/uialdjIH3hQH9YbrZ/BmgQ
         /V1Cz30R+k8g+pmUbxs1joqZmVxf9FAT9FTLvW0pvznX5nYDIj5wFaKeN6J5iQ9Ob/8P
         JP5w1INbY5b7iefnQMomosLCFdDDJjQb7mXiPg4Uaiy+sEwTLBXjr9b7zpS/RMiS/NH3
         mIqA==
X-Gm-Message-State: AOAM531KNZK5SRNtAdoDDunVi9I3zTA5P/iCTSWF9ems/KMeZDIyywRM
        zNtgOjbbrYQfPC09NqNzVRo=
X-Google-Smtp-Source: ABdhPJzTu2D2xukFgnpHMkNtIMjVXh6v886y7DkRebAKFvTJa6dQUU1GWSTrmvEg2r3bVuIBMP6jTw==
X-Received: by 2002:ac2:5ecc:: with SMTP id d12mr14150849lfq.165.1591106486810;
        Tue, 02 Jun 2020 07:01:26 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id a12sm559097ljb.92.2020.06.02.07.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 07:01:25 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1jg7Ti-0000xu-Of; Tue, 02 Jun 2020 16:01:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/4] Revert "serial: core: Refactor uart_unlock_and_check_sysrq()"
Date:   Tue,  2 Jun 2020 16:00:55 +0200
Message-Id: <20200602140058.3656-2-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602140058.3656-1-johan@kernel.org>
References: <20200602140058.3656-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit da9a5aa3402db0ff3b57216d8dbf2478e1046cae.

In order to ease backporting a fix for broken port unlock, revert this
rewrite which was since added on top.

The other sysrq helpers bail out early when sysrq is not enabled; it's
better to keep that pattern here as well.

Note that the __releases() attribute won't be needed after the follow-on
fix either.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/serial_core.c | 23 +++++++++++++----------
 include/linux/serial_core.h      |  3 ++-
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 66a5e2faf57e..edfb7bc14bbf 100644
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
index 92f5eba86052..1f4443db5474 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -462,7 +462,8 @@ extern void uart_insert_char(struct uart_port *port, unsigned int status,
 
 extern int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch);
 extern int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch);
-extern void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long flags);
+extern void uart_unlock_and_check_sysrq(struct uart_port *port,
+					unsigned long irqflags);
 extern int uart_handle_break(struct uart_port *port);
 
 /*
-- 
2.26.2

