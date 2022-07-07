Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C6DCCA479
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 14:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbiGGOzt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 10:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbiGGOzU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 10:55:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6877A5924A
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 07:54:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A142B8223A
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 14:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50BFC341C8;
        Thu,  7 Jul 2022 14:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657205645;
        bh=e4yNCA65F/u5rUuCfZO2HKJkssrI2IxMxU45th8cI7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vq77853iGMvHQHChsQYlEVUPzklMhlNM39LB49VatIHgReAz9VD1tDuMoI4geOYo+
         EuTBUW3WfY/HX1l6ZUpQzDhab3TJii5M7qKukPlvv9lcoOM5YSTC0LsAjYBHipwFso
         +T65wM6vnnKdop/aKdBSykWAs9F1ylhwBBhMvmA2TQEAjYg4kEkNkNl3/00g5AfFR3
         9J6eS+2ia8lp7Kq/8XbyEQUEtI73zkzJzxiYUP2aDFhsH5i6nwE1m8A8lSMEvh3R5z
         FodNFc1CC+X7XKt9W1ulNNRiK2SDdFO20cYQzik2VAIiN35nDfKUbiFkRF6mHbdH4C
         WkoU4rRb56wUw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 5/7] USB: serial: ftdi_sio: Fix baudrate rounding for ASYNC_SPD_CUST
Date:   Thu,  7 Jul 2022 16:53:52 +0200
Message-Id: <20220707145354.29705-6-kabel@kernel.org>
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

Use DIV_ROUND_CLOSEST() for more accurate baudrate calculation for
ASYNC_SPD_CUST instead of rounding it just down.

Signed-off-by: Pali Rohár <pali@kernel.org>
Tested-by: Marek Behún <kabel@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 30744d5779e2..ac84d5779966 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1317,7 +1317,7 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 	if (baud == 38400 &&
 	    ((priv->flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST) &&
 	     (priv->custom_divisor)) {
-		baud = priv->baud_base / priv->custom_divisor;
+		baud = DIV_ROUND_CLOSEST(priv->baud_base, priv->custom_divisor);
 		dev_dbg(dev, "%s - custom divisor %d sets baud rate to %d\n",
 			__func__, priv->custom_divisor, baud);
 	}
-- 
2.35.1

