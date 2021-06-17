Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769C1C2B9F4
	for <linux-serial@archiver.kernel.org>; Thu, 17 Jun 2021 11:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 508C76113C
	for <linux-serial@archiver.kernel.org>; Thu, 17 Jun 2021 11:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhFQLIg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Jun 2021 07:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbhFQLIK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Jun 2021 07:08:10 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A57C0617A6;
        Thu, 17 Jun 2021 04:06:01 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a127so4706485pfa.10;
        Thu, 17 Jun 2021 04:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HtAONl3gdZy0MSt9rHJt7WYPa//OF0XRpVJvSnGcmgU=;
        b=giJZ0vdAd+XM6JT6MohRbQc9SzObMOe70tLHMVdqRfspZummlknNhdlgpDSZrMm6AL
         WjrlN8IRbrXCjI5IIIoa9tE1DlUlAeLfzvJAXM9GAi3aiKpMb6ijQFrLkCFHaQzzUnsQ
         HJrAFKHCH8BuslHscKMHqKlZIjMS81fKJWgLhg5JEvvd4MFVbyKeVNt/l7aHQ4QX53QL
         Kj/R13QA5525o5I3U1go/ctlHB0TALNXOJjNk4tjaNEhzS7PUD163I3jFNffLqf3eAXr
         gDZfpA+KPaRVH8juCeerT1YifOwI/0KFe7BDvGvhVCJa7D+r1F8L2TC8CXSPRkPhY+u+
         Qt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HtAONl3gdZy0MSt9rHJt7WYPa//OF0XRpVJvSnGcmgU=;
        b=LSvLS3OYMyI7L7Fisthoz6KSR5mE9hos+3ynpZJk5kjby5zkrFxJ3gbZNtT/tg7oRz
         ny/r2+aLevadjEjrW6vGQWf9pc2KuSYObbMPxxkrSgkVFB+ikAVrZ6IuPtyIpkFUwfyc
         AKUucgvzPHS2oQeIs95K0UePwnlNTBgEgtt1PkdjOly7BeaSvVML1x8Zq/gV/lDLwzWT
         ZAUnAkDiR4Qi7fMVIyKtPc83zCOrjCfveQeOYo2msn0PL49waRSJrwF/rRK2m28zIFTE
         gTkjwcjpqN7IiGCGn3pBfa4fSWNH2z/eAD/Bt5OT/WrJWYLOYrpAKlhxDK0lFQMKaFDG
         dRvQ==
X-Gm-Message-State: AOAM532RhZavCCtT6TgCtP7WIAs6PcadfFnkkmtPpWGvk0Pb5iRux4AE
        8hgJY9RxgXfIq/ZVmvDQ7vg=
X-Google-Smtp-Source: ABdhPJyiHYgAHO3enfuF5YVS/MyGlZn8jXvb6w+MrVkXXVRtlTLuuJ2qJ6BMOgLyxnRlaiQhgt+UtA==
X-Received: by 2002:a63:e44e:: with SMTP id i14mr4530000pgk.80.1623927961206;
        Thu, 17 Jun 2021 04:06:01 -0700 (PDT)
Received: from vessel.. ([103.242.196.232])
        by smtp.gmail.com with ESMTPSA id mg22sm4762073pjb.26.2021.06.17.04.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:06:00 -0700 (PDT)
From:   Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     Saubhik Mukherjee <saubhik.mukherjee@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, andrianov@ispras.ru
Subject: [PATCH] tty: serial: owl: Fix data race in owl_uart_remove
Date:   Thu, 17 Jun 2021 16:34:43 +0530
Message-Id: <20210617110443.6526-1-saubhik.mukherjee@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Suppose the driver is registered and a UART port is added. Once an
application opens the port, owl_uart_startup is called which registers
the interrupt handler owl_uart_irq.

We could have the following race condition:

When device is removed, owl_uart_remove is called, which calls
uart_remove_one_port, which calls owl_uart_release_port, which writes
NULL to port->membase. At this point parallely, an interrupt could be
handled by owl_uart_irq which reads port->membase.

This is because it is possible to remove device without closing a port.
Thus, we need to check it and call owl_uart_shutdown in owl_uart_remove.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
---
 drivers/tty/serial/owl-uart.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index 91f1eb0058d7..ac4e3aae2719 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -751,8 +751,15 @@ static int owl_uart_probe(struct platform_device *pdev)
 static int owl_uart_remove(struct platform_device *pdev)
 {
 	struct owl_uart_port *owl_port = platform_get_drvdata(pdev);
+	struct uart_port *port = &owl_port->port;
 
-	uart_remove_one_port(&owl_uart_driver, &owl_port->port);
+	/* It is possible to release device without closing a port.
+	 * Thus, need to check it and call shutdown.
+	 */
+	if (owl_uart_read(port, OWL_UART_CTL) & OWL_UART_CTL_EN)
+		owl_uart_shutdown(port);
+
+	uart_remove_one_port(&owl_uart_driver, port);
 	owl_uart_ports[pdev->id] = NULL;
 	clk_disable_unprepare(owl_port->clk);
 
-- 
2.30.2

