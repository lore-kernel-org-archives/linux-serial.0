Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79EDC55178
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 10:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79DA3223BD
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 10:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgKDKxw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 05:53:52 -0500
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:35682 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbgKDKxv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 05:53:51 -0500
Received: from ubuntu.localdomain (unknown [58.213.83.156])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 73C70482CF2;
        Wed,  4 Nov 2020 18:53:48 +0800 (CST)
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
Subject: [PATCH 1/2] drivers/tty: delete break after goto
Date:   Wed,  4 Nov 2020 02:53:30 -0800
Message-Id: <20201104105331.16654-2-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201104105331.16654-1-bernard@vivo.com>
References: <20201104105331.16654-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGh4eTEtPHUxIGUxLVkpNS09PQ0xJSUNMSU9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTo6Qjo5Dj8fNx8QA0MYCAwU
        SDYKCU1VSlVKTUtPT0NMSUlCSk5OVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlOQ1VJ
        SkhVQ0hVSk5NWVdZCAFZQUlNQ0g3Bg++
X-HM-Tid: 0a7592e42cfa93bakuws73c70482cf2
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Delete break after goto, which will never run.

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

