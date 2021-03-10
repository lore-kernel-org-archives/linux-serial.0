Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AA9C433E0
	for <linux-serial@archiver.kernel.org>; Wed, 10 Mar 2021 03:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FEC364FE9
	for <linux-serial@archiver.kernel.org>; Wed, 10 Mar 2021 03:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhCJDR2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 9 Mar 2021 22:17:28 -0500
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:37568 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbhCJDRD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 9 Mar 2021 22:17:03 -0500
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Mar 2021 22:17:03 EST
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 51D074001A9;
        Wed, 10 Mar 2021 11:07:07 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] drivers: tty: serial: fix spelling typo of 'wheter'
Date:   Wed, 10 Mar 2021 11:07:02 +0800
Message-Id: <1615345622-2015-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTB4eTEsfHR5DGk5KVkpNSk5IT05NSUxOQ0lVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ogg6Dyo5DT8LOQ0pDy43LjxJ
        OTwaFDNVSlVKTUpOSE9OTUlMQkJNVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKT0NONwY+
X-HM-Tid: 0a781a1a316ed991kuws51d074001a9
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

wheter -> whether

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e1179e7..e3af97a
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2124,7 +2124,7 @@ static void sci_break_ctl(struct uart_port *port, int break_state)
 	unsigned short scscr, scsptr;
 	unsigned long flags;
 
-	/* check wheter the port has SCSPTR */
+	/* check whether the port has SCSPTR */
 	if (!sci_getreg(port, SCSPTR)->size) {
 		/*
 		 * Not supported by hardware. Most parts couple break and rx
-- 
2.7.4

