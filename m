Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE83C43334
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 14:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbiGGOzn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 10:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbiGGOzS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 10:55:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A3B57276
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 07:54:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08F7A6227E
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 14:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A778C341C6;
        Thu,  7 Jul 2022 14:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657205644;
        bh=GosXkyU+RKWrEueHayW7P4B6h1HDSto/WcbQ+LXCXug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PECPignRMiLwxr7dpezvfrMAMx0+yk7x9LmFhomubXoT4+uBYy2Pga8xmNavCNpCB
         5IlvdeNT0J3ZTFevPVogHOribPyyR2PUPGcsfaOt+amNQOhdH4KfXB5FyczJfRDErP
         vG2xh4/2BdqGh/9Egq3YwX2MBVIEkNBX+UoyIVl8dxmeYbu72noB1C90pDOM4oN8re
         YiItesJ29KMIZ3X8/Z86aw6REwozTT5ezuuXOK08x4Hvwj5YiQRQswkQyxk3ynZjcr
         a17bCZalQIp4mzb+dfDGOGJXlJy0KNf43pLAh4JNgBwSFmzJNuCEblW47DgD0kHubs
         p06hmOq0hqLzw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 4/7] USB: serial: ftdi_sio: Do not reset baudrate to 9600 on error
Date:   Thu,  7 Jul 2022 16:53:51 +0200
Message-Id: <20220707145354.29705-5-kabel@kernel.org>
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

On failure to set new baudrate, reset baudrate to the previous value
(as is done by other serial drivers) instead of resetting to 9600.

Signed-off-by: Pali Rohár <pali@kernel.org>
Tested-by: Marek Behún <kabel@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 38 ++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 45a4eeb1fc70..30744d5779e2 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1299,7 +1299,7 @@ static int update_mctrl(struct usb_serial_port *port, unsigned int set,
 
 
 static u32 get_ftdi_divisor(struct tty_struct *tty,
-						struct usb_serial_port *port)
+			    struct usb_serial_port *port, speed_t old_baud)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 	struct device *dev = &port->dev;
@@ -1322,6 +1322,8 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 			__func__, priv->custom_divisor, baud);
 	}
 
+	if (!baud)
+		baud = old_baud;
 	if (!baud)
 		baud = 9600;
 	switch (priv->chip_type) {
@@ -1330,8 +1332,12 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 		if (div_value == (u32)-1) {
 			dev_dbg(dev, "%s - Baudrate (%d) requested is not supported\n",
 				__func__,  baud);
-			baud = 9600;
+			baud = old_baud ? old_baud : 9600;
 			div_value = ftdi_sio_baud_to_divisor(baud);
+			if (div_value == (u32)-1) {
+				baud = 9600;
+				div_value = ftdi_sio_baud_to_divisor(baud);
+			}
 			div_okay = 0;
 		}
 		break;
@@ -1340,8 +1346,8 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 			div_value = ftdi_232am_baud_to_divisor(baud);
 		} else {
 			dev_dbg(dev, "%s - Baud rate too high!\n", __func__);
-			baud = 9600;
-			div_value = ftdi_232am_baud_to_divisor(9600);
+			baud = (old_baud >= 183 && old_baud <= 3000000) ? old_baud : 9600;
+			div_value = ftdi_232am_baud_to_divisor(baud);
 			div_okay = 0;
 		}
 		break;
@@ -1363,9 +1369,9 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 			div_value = ftdi_232bm_baud_to_divisor(baud);
 		} else {
 			dev_dbg(dev, "%s - Baud rate too high!\n", __func__);
-			div_value = ftdi_232bm_baud_to_divisor(9600);
+			baud = (old_baud >= 183 && old_baud <= 3000000) ? old_baud : 9600;
+			div_value = ftdi_232bm_baud_to_divisor(baud);
 			div_okay = 0;
-			baud = 9600;
 		}
 		break;
 	case FT2232H: /* FT2232H chip */
@@ -1377,9 +1383,14 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 			div_value = ftdi_232bm_baud_to_divisor(baud);
 		} else {
 			dev_dbg(dev, "%s - Baud rate too high!\n", __func__);
-			div_value = ftdi_232bm_baud_to_divisor(9600);
+			if (old_baud >= 183 && old_baud < 1200) {
+				baud = old_baud;
+				div_value = ftdi_232bm_baud_to_divisor(baud);
+			} else {
+				baud = (old_baud >= 1200 && old_baud <= 12000000) ? old_baud : 9600;
+				div_value = ftdi_2232h_baud_to_divisor(baud);
+			}
 			div_okay = 0;
-			baud = 9600;
 		}
 		break;
 	} /* priv->chip_type */
@@ -1394,7 +1405,7 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 	return div_value;
 }
 
-static int change_speed(struct tty_struct *tty, struct usb_serial_port *port)
+static int change_speed(struct tty_struct *tty, struct usb_serial_port *port, speed_t old_baud)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 	u16 value;
@@ -1402,7 +1413,7 @@ static int change_speed(struct tty_struct *tty, struct usb_serial_port *port)
 	u32 index_value;
 	int rv;
 
-	index_value = get_ftdi_divisor(tty, port);
+	index_value = get_ftdi_divisor(tty, port, old_baud);
 	value = (u16)index_value;
 	index = (u16)(index_value >> 16);
 	if (priv->chip_type == FT2232C || priv->chip_type == FT2232H ||
@@ -1525,7 +1536,7 @@ static int set_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 		if (priv->flags & ASYNC_SPD_MASK)
 			dev_warn_ratelimited(&port->dev, "use of SPD flags is deprecated\n");
 
-		change_speed(tty, port);
+		change_speed(tty, port, 0);
 	}
 	mutex_unlock(&priv->cfg_lock);
 	return 0;
@@ -2774,9 +2785,12 @@ static void ftdi_set_termios(struct tty_struct *tty,
 		/* Drop RTS and DTR */
 		clear_mctrl(port, TIOCM_DTR | TIOCM_RTS);
 	} else {
+		speed_t old_baud =
+			old_termios ? tty_termios_baud_rate(old_termios) : 0;
+
 		/* set the baudrate determined before */
 		mutex_lock(&priv->cfg_lock);
-		if (change_speed(tty, port))
+		if (change_speed(tty, port, old_baud))
 			dev_err(ddev, "%s urb failed to set baudrate\n", __func__);
 		mutex_unlock(&priv->cfg_lock);
 		/* Ensure RTS and DTR are raised when baudrate changed from 0 */
-- 
2.35.1

