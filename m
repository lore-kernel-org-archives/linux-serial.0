Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03526C63709
	for <linux-serial@archiver.kernel.org>; Wed,  7 Dec 2022 22:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiLGWFg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Dec 2022 17:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiLGWFP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Dec 2022 17:05:15 -0500
X-Greylist: delayed 484 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Dec 2022 14:04:15 PST
Received: from mail.someserver.de (mail2.someserver.de [IPv6:2001:4d88:3503:c001:56b7:8a99:4a7f:4e4b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6AA585674
        for <linux-serial@vger.kernel.org>; Wed,  7 Dec 2022 14:04:15 -0800 (PST)
Received: from localhost (unknown [213.55.243.226])
        by mail.someserver.de (Postfix) with ESMTPSA id B8998801C7;
        Wed,  7 Dec 2022 22:56:23 +0100 (CET)
From:   Christina Quast <contact@christina-quast.de>
To:     linux-serial@vger.kernel.org
Cc:     Christina Quast <contact@christina-quast.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH tty-next 2/3] hid-ft260: Rename struct ft260_i2c_input_report
Date:   Wed,  7 Dec 2022 22:55:39 +0100
Message-Id: <20221207215540.114920-3-contact@christina-quast.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221207215540.114920-1-contact@christina-quast.de>
References: <20221207215540.114920-1-contact@christina-quast.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Signed-off-by: Christina Quast <contact@christina-quast.de>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Daniel Beer <daniel.beer@igorinstitute.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-ft260.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 7edba9aaff43..59b6cab13946 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -212,8 +212,8 @@ struct ft260_i2c_read_request_report {
 	__le16 length;		/* data payload length */
 } __packed;
 
-struct ft260_i2c_input_report {
-	u8 report;		/* FT260_I2C_REPORT */
+struct ft260_input_report {
+	u8 report;		/* FT260_I2C_REPORT or FT260_UART_REPORT */
 	u8 length;		/* data payload length */
 	u8 data[2];		/* data payload */
 } __packed;
@@ -1016,7 +1016,7 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 			   u8 *data, int size)
 {
 	struct ft260_device *dev = hid_get_drvdata(hdev);
-	struct ft260_i2c_input_report *xfer = (void *)data;
+	struct ft260_input_report *xfer = (void *)data;
 
 	if (xfer->report >= FT260_I2C_REPORT_MIN &&
 	    xfer->report <= FT260_I2C_REPORT_MAX) {
-- 
2.35.1

