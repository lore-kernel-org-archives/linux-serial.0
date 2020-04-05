Return-Path: <SRS0=ea9B=5V=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A30C2D0F4
	for <linux-serial@archiver.kernel.org>; Sun,  5 Apr 2020 13:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67AE206B8
	for <linux-serial@archiver.kernel.org>; Sun,  5 Apr 2020 13:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgDENaR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 5 Apr 2020 09:30:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56794 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgDENaQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 5 Apr 2020 09:30:16 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jL5Lp-0002QS-V8; Sun, 05 Apr 2020 13:30:14 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/tty: emove redundant assignment to variable i and rename it to ret
Date:   Sun,  5 Apr 2020 14:30:13 +0100
Message-Id: <20200405133013.380080-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable i is being assigned a value that is never read
and it is being updated later with a new value. The assignment
is redundant and can be removed.  Also rename i to ret as this new
name makes makes more sense.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/serial/8250/serial_cs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/serial_cs.c
index c8186a05a453..e3d10794dbba 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -440,7 +440,7 @@ static int simple_config_check_notpicky(struct pcmcia_device *p_dev,
 static int simple_config(struct pcmcia_device *link)
 {
 	struct serial_info *info = link->priv;
-	int i = -ENODEV, try;
+	int ret, try;
 
 	/*
 	 * First pass: look for a config entry that looks normal.
@@ -472,8 +472,8 @@ static int simple_config(struct pcmcia_device *link)
 	if (info->quirk && info->quirk->config)
 		info->quirk->config(link);
 
-	i = pcmcia_enable_device(link);
-	if (i != 0)
+	ret = pcmcia_enable_device(link);
+	if (ret != 0)
 		return -1;
 	return setup_serial(link, info, link->resource[0]->start, link->irq);
 }
-- 
2.25.1

