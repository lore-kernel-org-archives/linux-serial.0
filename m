Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D07C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 23 May 2022 15:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238143AbiEWPvI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 May 2022 11:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238186AbiEWPvH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 May 2022 11:51:07 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59AC12A9;
        Mon, 23 May 2022 08:51:01 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 0D3BD80C2;
        Mon, 23 May 2022 15:47:00 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Starke <daniel.starke@siemens.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] tty: n_gsm: Debug output allocation must use GFP_ATOMIC
Date:   Mon, 23 May 2022 18:50:52 +0300
Message-Id: <20220523155052.57129-1-tony@atomide.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> reported the following Smatch
warning:

drivers/tty/n_gsm.c:720 gsm_data_kick()
warn: sleeping in atomic context

This is because gsm_control_message() is holding a spin lock so
gsm_hex_dump_bytes() needs to use GFP_ATOMIC instead of GFP_KERNEL.

Fixes: 925ea0fa5277 ("tty: n_gsm: Fix packet data hex dump output")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -459,7 +459,7 @@ static void gsm_hex_dump_bytes(const char *fname, const u8 *data,
 		return;
 	}
 
-	prefix = kasprintf(GFP_KERNEL, "%s: ", fname);
+	prefix = kasprintf(GFP_ATOMIC, "%s: ", fname);
 	if (!prefix)
 		return;
 	print_hex_dump(KERN_INFO, prefix, DUMP_PREFIX_OFFSET, 16, 1, data, len,
-- 
2.36.1
