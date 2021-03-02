Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B315BC4161F
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE8D64E7A
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240683AbhCCCQu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:16:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:39914 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835889AbhCBGYp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:24:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 146BCB02D;
        Tue,  2 Mar 2021 06:22:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH 27/44] tty: vcc, use name strings directly
Date:   Tue,  2 Mar 2021 07:21:57 +0100
Message-Id: <20210302062214.29627-27-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Do not define global variables for driver/device names, use the strings
directly.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 drivers/tty/vcc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 31b8a9a77375..a6cdbd170a61 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -52,8 +52,6 @@ struct vcc_port {
 #define VCC_CTL_BREAK		-1
 #define VCC_CTL_HUP		-2
 
-static const char vcc_driver_name[] = "vcc";
-static const char vcc_device_node[] = "vcc";
 static struct tty_driver *vcc_tty_driver;
 
 static struct vcc_port *vcc_table[VCC_MAX_PORTS];
@@ -1065,8 +1063,8 @@ static int vcc_tty_init(void)
 		return PTR_ERR(vcc_tty_driver);
 	}
 
-	vcc_tty_driver->driver_name = vcc_driver_name;
-	vcc_tty_driver->name = vcc_device_node;
+	vcc_tty_driver->driver_name = "vcc";
+	vcc_tty_driver->name = "vcc";
 
 	vcc_tty_driver->minor_start = VCC_MINOR_START;
 	vcc_tty_driver->type = TTY_DRIVER_TYPE_SYSTEM;
-- 
2.30.1

