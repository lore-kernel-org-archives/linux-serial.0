Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B234C4167B
	for <linux-serial@archiver.kernel.org>; Mon, 26 Dec 2022 17:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiLZRRz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Dec 2022 12:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiLZRRy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Dec 2022 12:17:54 -0500
Received: from mail.someserver.de (mail2.someserver.de [31.15.66.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C657BC3
        for <linux-serial@vger.kernel.org>; Mon, 26 Dec 2022 09:17:53 -0800 (PST)
Received: from localhost (unknown [46.128.84.4])
        by mail.someserver.de (Postfix) with ESMTPSA id BDCD38014D;
        Mon, 26 Dec 2022 18:17:51 +0100 (CET)
From:   Christina Quast <contact@christina-quast.de>
To:     linux-serial@vger.kernel.org
Cc:     Christina Quast <contact@christina-quast.de>,
        ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org,
        daniel.beer@igorinstitute.com
Subject: [PATCH tty-next v2 2/3] hid-ft260: Rename struct ft260_i2c_input_report
Date:   Mon, 26 Dec 2022 18:15:48 +0100
Message-Id: <20221226171549.73645-3-contact@christina-quast.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221226171549.73645-1-contact@christina-quast.de>
References: <20221226171549.73645-1-contact@christina-quast.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Rename ft260_i2c_input_report to ft260_input_report, because depending
on the ft260 device configuration, this device can implement a UART or
I2C functionality.

Signed-off-by: Christina Quast <contact@christina-quast.de>
---
 drivers/hid/hid-ft260.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 52a63b966ebc..a67051f379a3 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -220,8 +220,8 @@ struct ft260_i2c_read_request_report {
 	__le16 length;		/* data payload length */
 } __packed;
 
-struct ft260_i2c_input_report {
-	u8 report;		/* FT260_I2C_REPORT */
+struct ft260_input_report {
+	u8 report;		/* FT260_I2C_REPORT or FT260_UART_REPORT */
 	u8 length;		/* data payload length */
 	u8 data[2];		/* data payload */
 } __packed;
@@ -1066,7 +1066,7 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 			   u8 *data, int size)
 {
 	struct ft260_device *dev = hid_get_drvdata(hdev);
-	struct ft260_i2c_input_report *xfer = (void *)data;
+	struct ft260_input_report *xfer = (void *)data;
 
 	if (xfer->report >= FT260_I2C_REPORT_MIN &&
 	    xfer->report <= FT260_I2C_REPORT_MAX) {
-- 
2.35.1

