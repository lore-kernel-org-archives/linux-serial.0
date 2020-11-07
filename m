Return-Path: <SRS0=t3fu=EN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B29C55179
	for <linux-serial@archiver.kernel.org>; Sat,  7 Nov 2020 03:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE4620882
	for <linux-serial@archiver.kernel.org>; Sat,  7 Nov 2020 03:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgKGDjI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Nov 2020 22:39:08 -0500
Received: from mail-m1271.qiye.163.com ([115.236.127.1]:55931 "EHLO
        mail-m1271.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgKGDjH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Nov 2020 22:39:07 -0500
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Nov 2020 22:39:06 EST
Received: from ubuntu.localdomain (unknown [58.213.83.157])
        by mail-m1271.qiye.163.com (Hmail) with ESMTPA id 1DB295820CE;
        Sat,  7 Nov 2020 11:29:43 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH 2/2] drivers/tty: delete break after goto/return
Date:   Fri,  6 Nov 2020 19:29:24 -0800
Message-Id: <20201107032924.25044-3-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201107032924.25044-1-bernard@vivo.com>
References: <20201107032924.25044-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGEhMGEhIGRlLQ0IaVkpNS09MSkJMQ0hPSUtVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRw6Qxw4Dj8tIxwvCktLTTkW
        Kk4KCglVSlVKTUtPTEpCTENPSk5OVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlOQ1VJ
        SkhVQ0hVSk5MWVdZCAFZQUlMS083Bg++
X-HM-Tid: 0a75a0c0ad9798b6kuuu1db295820ce
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Delete break after goto/return, which will never run.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/tty/nozomi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index d42b854cb7df..946cc16827aa 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -414,11 +414,9 @@ static void read_mem32(u32 *buf, const void __iomem *mem_addr_start,
 		buf16 = (u16 *) buf;
 		*buf16 = __le16_to_cpu(readw(ptr));
 		goto out;
-		break;
 	case 4:	/* 4 bytes */
 		*(buf) = __le32_to_cpu(readl(ptr));
 		goto out;
-		break;
 	}
 
 	while (i < size_bytes) {
@@ -460,7 +458,6 @@ static u32 write_mem32(void __iomem *mem_addr_start, const u32 *buf,
 		buf16 = (const u16 *)buf;
 		writew(__cpu_to_le16(*buf16), ptr);
 		return 2;
-		break;
 	case 1: /*
 		 * also needs to write 4 bytes in this case
 		 * so falling through..
@@ -468,7 +465,6 @@ static u32 write_mem32(void __iomem *mem_addr_start, const u32 *buf,
 	case 4: /* 4 bytes */
 		writel(__cpu_to_le32(*buf), ptr);
 		return 4;
-		break;
 	}
 
 	while (i < size_bytes) {
-- 
2.29.0

