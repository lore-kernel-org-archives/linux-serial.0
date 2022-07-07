Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2C7C43334
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 14:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbiGGOzs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 10:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbiGGOzU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 10:55:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3009359248
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 07:54:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE80762305
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 14:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B922C3411E;
        Thu,  7 Jul 2022 14:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657205647;
        bh=wO5Z8TVIPCt4aD3Vytr0Et/jlS7dzxpF2zIuARMfYfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iw3PVl41vvcNYSb169CfZ3A3jGPe0Nh0gxP95hRet1x8zfn0Wr9jKoWKw5fJEDPMQ
         pfmKotKS3LDrJSph1PDDBmD0XiluGPYGYFMEnThkI/FOZtSFkC+lEF02ESh75l9sJ4
         Py3Y4lQqUUbfFArryPka3AUJdlxZ9DPcvBv951Y3f1oyKuzaL8/ogJHONuhMwjha8W
         /asuQYMbUGUJkepxkgZvuTlYdAGtQN5/kzk28qYQ5fCiaFdcx8ypcXUYBcWX/5H6vA
         cpaqoP/ZcAbefM6cbj2YgPJNjDJpKHddSrdLJMIaRxV1I+NX9ABFqCxQaoJ1w2lx3v
         37ZtkYgSDGE+g==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 6/7] USB: serial: ftdi_sio: Fix custom_divisor and c_*speed for ASYNC_SPD_CUST
Date:   Thu,  7 Jul 2022 16:53:53 +0200
Message-Id: <20220707145354.29705-7-kabel@kernel.org>
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

When ASYNC_SPD_CUST is used, update and recalculate custom_divisor and
c_*speed fields from newly set baudrate value, so that userspace GET
functions can see current configuration.

Signed-off-by: Pali Rohár <pali@kernel.org>
Tested-by: Marek Behún <kabel@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index ac84d5779966..3bf5750e76de 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1303,6 +1303,7 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 	struct device *dev = &port->dev;
+	int fix_custom_divisor = 0;
 	u32 div_value = 0;
 	int div_okay = 1;
 	int baud;
@@ -1317,6 +1318,7 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 	if (baud == 38400 &&
 	    ((priv->flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST) &&
 	     (priv->custom_divisor)) {
+		fix_custom_divisor = 1;
 		baud = DIV_ROUND_CLOSEST(priv->baud_base, priv->custom_divisor);
 		dev_dbg(dev, "%s - custom divisor %d sets baud rate to %d\n",
 			__func__, priv->custom_divisor, baud);
@@ -1401,7 +1403,19 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 			ftdi_chip_name[priv->chip_type]);
 	}
 
+	/* Fix deprecated async-compatible custom_divisor hack and update tty baudrate */
+	if (fix_custom_divisor) {
+		priv->custom_divisor = DIV_ROUND_CLOSEST(priv->baud_base, baud);
+		old_baud = baud;
+		baud = 38400;
+	}
+
 	tty_encode_baud_rate(tty, baud, baud);
+
+	/* For async-compatible custom_divisor store into TCGETS2 c_*speed fields real baudrate */
+	if (fix_custom_divisor)
+		tty->termios.c_ispeed = tty->termios.c_ospeed = old_baud;
+
 	return div_value;
 }
 
@@ -2674,6 +2688,8 @@ static void ftdi_set_termios(struct tty_struct *tty,
 		dev_dbg(ddev, "%s: forcing baud rate for this device\n", __func__);
 		tty_encode_baud_rate(tty, priv->force_baud,
 					priv->force_baud);
+		termios->c_ispeed = termios->c_ospeed =
+			DIV_ROUND_CLOSEST(priv->baud_base, priv->custom_divisor);
 	}
 
 	/* Force RTS-CTS if this device requires it. */
-- 
2.35.1

