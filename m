Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50D8C07E96
	for <linux-serial@archiver.kernel.org>; Thu, 15 Jul 2021 14:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECD261380
	for <linux-serial@archiver.kernel.org>; Thu, 15 Jul 2021 14:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238550AbhGOOKy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Jul 2021 10:10:54 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:44920
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236086AbhGOOKx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Jul 2021 10:10:53 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 781DD40667;
        Thu, 15 Jul 2021 14:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626358079;
        bh=APYp9urHojI4rl75uCY+A2+u3xV4Ds1D+plCvqGn2Yc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=WMIzLRLteGXuLOd8xT/W78DY+T3u7OT60sfvJmCM0P41ukI1kOyHja8wkMCgoPklT
         GSNYkR+8ey9HEqC5Ked5p+enhc9XGAvc0OR36LaDqcBMnviX4cLJLD4Ccd5SvMcu1d
         PcIqfqvTrJqBDXXWmjFVnFWsOqD1ZjqBoSKQTV9LTJ0iNLFlqTrWIHZTAFWTHUFCC6
         hT9RY5wJEgBoc5zWBdwRZJO3WGtny2q5OsA9xcJcilgy6KGFhZKr++hwSa0Lm9I1Kg
         caDLOYDqC81I4tJfkGX+Ft+8CWkEwe7v1Sd+7oAmRypxVfNwuBB4LhrIMU2NMfXPII
         V8Wjie/Q38OrQ==
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH] serial: 8250: 8250_omap: make a const array static, makes object smaller
Date:   Thu, 15 Jul 2021 15:07:59 +0100
Message-Id: <20210715140759.27244-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const array k3_soc_devices on the stack but instead it
static. Makes the object code smaller by 44 bytes:

Before:
   text    data     bss     dec     hex filename
  31628    5609     128   37365    91f5 drivers/tty/serial/8250/8250_omap.o

After:
   text    data     bss     dec     hex filename
  31520    5673     128   37321    91c9 drivers/tty/serial/8250/8250_omap.o
Reduction of 44 bytes

(gcc version 10.3.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/serial/8250/8250_omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 79418d4beb48..b81d1bdc7b88 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -538,7 +538,7 @@ static void omap_8250_pm(struct uart_port *port, unsigned int state,
 static void omap_serial_fill_features_erratas(struct uart_8250_port *up,
 					      struct omap8250_priv *priv)
 {
-	const struct soc_device_attribute k3_soc_devices[] = {
+	static const struct soc_device_attribute k3_soc_devices[] = {
 		{ .family = "AM65X",  },
 		{ .family = "J721E", .revision = "SR1.0" },
 		{ /* sentinel */ }
-- 
2.31.1

