Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C59C4332D
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 03:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7FF164E6B
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 03:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbhCCCLK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:11:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:39622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835864AbhCBGXv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:23:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92E86AFCC;
        Tue,  2 Mar 2021 06:22:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 13/44] tty: 8250/serial_cs, propagate errors in simple_config
Date:   Tue,  2 Mar 2021 07:21:43 +0100
Message-Id: <20210302062214.29627-13-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The caller expects from the others (pfc_config and multi_config) to
return standard error values. So do the same for simple_config too.

We invert the if condition to handle the error case.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/8250/serial_cs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/serial_cs.c
index 35ff6627c61b..63ea9c4da3d5 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -456,11 +456,11 @@ static int simple_config(struct pcmcia_device *link)
 	 * its base address, then try to grab any standard serial port
 	 * address, and finally try to get any free port.
 	 */
-	if (!pcmcia_loop_config(link, simple_config_check_notpicky, NULL))
-		goto found_port;
-
-	dev_warn(&link->dev, "no usable port range found, giving up\n");
-	return -1;
+	ret = pcmcia_loop_config(link, simple_config_check_notpicky, NULL);
+	if (ret) {
+		dev_warn(&link->dev, "no usable port range found, giving up\n");
+		return ret;
+	}
 
 found_port:
 	if (info->multi && (info->manfid == MANFID_3COM))
@@ -474,7 +474,7 @@ static int simple_config(struct pcmcia_device *link)
 
 	ret = pcmcia_enable_device(link);
 	if (ret != 0)
-		return -1;
+		return ret;
 	return setup_serial(link, info, link->resource[0]->start, link->irq);
 }
 
-- 
2.30.1

