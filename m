Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9D3CCA479
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 14:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbiGGOzd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 10:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbiGGOzM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 10:55:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C374257238
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 07:54:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E92B62311
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 14:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94FAC341CF;
        Thu,  7 Jul 2022 14:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657205641;
        bh=+AOZMG0lq8uk7YAirx7jHjJosu+nCe5BtTI4k2V1/NU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJ6pFhVBRViKWRxGmUsJWHphdBU+ZrFhGW4mGCcaC1VEDz3s9GtSCmoujux/966oE
         HpX+kX2+aUdZklVJOW6KQ4MlsuGAlnLxLgzN1jw1JIbfePuYl34axuyy/TJqXCqM8U
         iPmyhpvqJUeZo7ZepG90mwPod1mab1hGowL9+YBxMEdXb5Cj8Vfnlg7riI6AptvnBj
         aE7EmhBy/T/kNoCnRrKWlHBwKyuvLAz+K+g32RPz/TtV++zjSi/HQ68+s3uaxPP5Aw
         dP/v1C1xNhePUMCYc+eu8TzC0wJZFkBYkmg4fiOdUExYI+NP6P+PiKHoDZKbzUvoXT
         xsY/CTZWl9FYQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 2/7] USB: serial: ftdi_sio: Add missing baudrate validation
Date:   Thu,  7 Jul 2022 16:53:49 +0200
Message-Id: <20220707145354.29705-3-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220707145354.29705-1-kabel@kernel.org>
References: <20220707145354.29705-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

More FTDI variants limit the minimal baudrate value. Add lower bound
checks.

Signed-off-by: Pali Rohár <pali@kernel.org>
Tested-by: Marek Behún <kabel@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index ea40f367e70c..717b97f4e094 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1330,7 +1330,7 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 		}
 		break;
 	case FT8U232AM: /* 8U232AM chip */
-		if (baud <= 3000000) {
+		if (baud >= 183 && baud <= 3000000) {
 			div_value = ftdi_232am_baud_to_divisor(baud);
 		} else {
 			dev_dbg(dev, "%s - Baud rate too high!\n", __func__);
@@ -1343,7 +1343,7 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 	case FT2232C: /* FT2232C chip */
 	case FT232RL: /* FT232RL chip */
 	case FTX:     /* FT-X series */
-		if (baud <= 3000000) {
+		if (baud >= 183 && baud <= 3000000) {
 			u16 product_id = le16_to_cpu(
 				port->serial->dev->descriptor.idProduct);
 			if (((product_id == FTDI_NDI_HUC_PID)		||
@@ -1367,7 +1367,7 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 	case FT232H:  /* FT232H chip */
 		if ((baud <= 12000000) && (baud >= 1200)) {
 			div_value = ftdi_2232h_baud_to_divisor(baud);
-		} else if (baud < 1200) {
+		} else if (baud >= 183 && baud < 1200) {
 			div_value = ftdi_232bm_baud_to_divisor(baud);
 		} else {
 			dev_dbg(dev, "%s - Baud rate too high!\n", __func__);
-- 
2.35.1

