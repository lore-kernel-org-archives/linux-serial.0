Return-Path: <SRS0=O7Uh=46=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DF3C10DCE
	for <linux-serial@archiver.kernel.org>; Fri, 13 Mar 2020 06:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA4320746
	for <linux-serial@archiver.kernel.org>; Fri, 13 Mar 2020 06:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgCMG4r (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Mar 2020 02:56:47 -0400
Received: from m177134.mail.qiye.163.com ([123.58.177.134]:30947 "EHLO
        m177134.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgCMG4r (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Mar 2020 02:56:47 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.227])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 0024B261A5B;
        Fri, 13 Mar 2020 14:56:40 +0800 (CST)
From:   WANG Wenhu <wenhu.wang@vivo.com>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org, WANG Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH] serial: pl011: format long message string into lines
Date:   Thu, 12 Mar 2020 23:56:18 -0700
Message-Id: <20200313065618.60196-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUlXWQgYFAkeWUFZQ1VLTkxLS0tKTUtJSkxJQllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mkk6FAw4Ejg8PDEVKx0qGjM2
        LA8wFCFVSlVKTkNPS0NJTUtISEhJVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlMWVdZCAFZQUpCSU43Bg++
X-HM-Tid: 0a70d2ae45139375kuws0024b261a5b
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Separate the message string into lines for pl011_probe_dt_alias()
to make it better comply with kernel coding style, and also, make
it more readable.

It would still be grep friendly for the separated format.

Signed-off-by: WANG Wenhu <wenhu.wang@vivo.com>
---
 drivers/tty/serial/amba-pl011.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 2296bb0f9578..e693b7ac5a3a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2523,7 +2523,8 @@ static int pl011_probe_dt_alias(int index, struct device *dev)
 	}
 
 	if (seen_dev_with_alias && seen_dev_without_alias)
-		dev_warn(dev, "aliased and non-aliased serial devices found in device tree. Serial port enumeration may be unpredictable.\n");
+		dev_warn(dev, "aliased and non-aliased serial devices found in device tree." \
+			"Serial port enumeration may be unpredictable.\n");
 
 	return ret;
 }
-- 
2.17.1

