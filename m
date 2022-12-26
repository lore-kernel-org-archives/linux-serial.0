Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998F1C4167B
	for <linux-serial@archiver.kernel.org>; Mon, 26 Dec 2022 17:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiLZRRt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Dec 2022 12:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiLZRRs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Dec 2022 12:17:48 -0500
Received: from mail.someserver.de (mail2.someserver.de [IPv6:2001:4d88:3503:c001:56b7:8a99:4a7f:4e4b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B286C75
        for <linux-serial@vger.kernel.org>; Mon, 26 Dec 2022 09:17:47 -0800 (PST)
Received: from localhost (unknown [46.128.84.4])
        by mail.someserver.de (Postfix) with ESMTPSA id 5DF628014D;
        Mon, 26 Dec 2022 18:17:46 +0100 (CET)
From:   Christina Quast <contact@christina-quast.de>
To:     linux-serial@vger.kernel.org
Cc:     Christina Quast <contact@christina-quast.de>,
        ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org,
        daniel.beer@igorinstitute.com
Subject: [PATCH tty-next v2 1/3] hid-ft260: Cleanup macro formatting
Date:   Mon, 26 Dec 2022 18:15:47 +0100
Message-Id: <20221226171549.73645-2-contact@christina-quast.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221226171549.73645-1-contact@christina-quast.de>
References: <20221226171549.73645-1-contact@christina-quast.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Wrap macro arguments in braces.

Signed-off-by: Christina Quast <contact@christina-quast.de>
---
 drivers/hid/hid-ft260.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 333341e80b0e..52a63b966ebc 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -29,7 +29,7 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
 	} while (0)
 
 #define FT260_REPORT_MAX_LENGTH (64)
-#define FT260_I2C_DATA_REPORT_ID(len) (FT260_I2C_REPORT_MIN + (len - 1) / 4)
+#define FT260_I2C_DATA_REPORT_ID(len) (FT260_I2C_REPORT_MIN + ((len) - 1) / 4)
 
 #define FT260_WAKEUP_NEEDED_AFTER_MS (4800) /* 5s minus 200ms margin */
 
@@ -132,7 +132,7 @@ enum {
 	FT260_FLAG_START_STOP_REPEATED	= 0x07,
 };
 
-#define FT260_SET_REQUEST_VALUE(report_id) ((FT260_FEATURE << 8) | report_id)
+#define FT260_SET_REQUEST_VALUE(report_id) ((FT260_FEATURE << 8) | (report_id))
 
 /* Feature In reports */
 
-- 
2.35.1

