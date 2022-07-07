Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B6FCCA481
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 14:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbiGGOze (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 10:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbiGGOzO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 10:55:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0E65725D
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 07:54:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1E1862310
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 14:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE57C3411E;
        Thu,  7 Jul 2022 14:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657205643;
        bh=ooNu3g/Bqa+92vxf36VNfXzg8EOr/Jw9TZyZRWAs2j8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rVf4OLDnUc4C2v0KRBsULmMAhW6TUZSvnc9fy7i1Vv3dqEt3LF9e1McIKvawOx0uq
         JdysN/2HuyGqofeMkyXK9usrAHTAcfDCvrjIZ9alvZPqMq3LjMI80UmmuRbBgc8Ynb
         f/C1PgOW+YTzTE5at/KToDEsnhgb07Lk7JYLl2Rn4lu1URFb9lPkN+Y5gPHKFG1GpI
         gY6wGLGC4mBAFRV3A0Sj3NZNyCoLgVd32LbTq/tZylvYpORjw3WYnxv/nIHN6kwKTx
         uPWJWFnJgGj2MrS7A49p739hxZgarXGdJINvu3rpdDi18ia1I2HFjZJ0wADYRqR0Uz
         rXIUHBnGpI0KQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 3/7] USB: serial: ftdi_sio: Extract SIO divisor code to function
Date:   Thu,  7 Jul 2022 16:53:50 +0200
Message-Id: <20220707145354.29705-4-kabel@kernel.org>
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

As a code cleanup for future changes, extract divisor code for SIO chip
into new function ftdi_sio_baud_to_divisor().

No functional change.

Signed-off-by: Pali Rohár <pali@kernel.org>
Tested-by: Marek Behún <kabel@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 717b97f4e094..45a4eeb1fc70 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1150,6 +1150,23 @@ static struct usb_serial_driver * const serial_drivers[] = {
  * ***************************************************************************
  */
 
+static u32 ftdi_sio_baud_to_divisor(int baud)
+{
+	switch (baud) {
+	case 300: return ftdi_sio_b300;
+	case 600: return ftdi_sio_b600;
+	case 1200: return ftdi_sio_b1200;
+	case 2400: return ftdi_sio_b2400;
+	case 4800: return ftdi_sio_b4800;
+	case 9600: return ftdi_sio_b9600;
+	case 19200: return ftdi_sio_b19200;
+	case 38400: return ftdi_sio_b38400;
+	case 57600: return ftdi_sio_b57600;
+	case 115200: return ftdi_sio_b115200;
+	default: return -1;
+	}
+}
+
 static unsigned short int ftdi_232am_baud_base_to_divisor(int baud, int base)
 {
 	unsigned short int divisor;
@@ -1309,23 +1326,12 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 		baud = 9600;
 	switch (priv->chip_type) {
 	case SIO: /* SIO chip */
-		switch (baud) {
-		case 300: div_value = ftdi_sio_b300; break;
-		case 600: div_value = ftdi_sio_b600; break;
-		case 1200: div_value = ftdi_sio_b1200; break;
-		case 2400: div_value = ftdi_sio_b2400; break;
-		case 4800: div_value = ftdi_sio_b4800; break;
-		case 9600: div_value = ftdi_sio_b9600; break;
-		case 19200: div_value = ftdi_sio_b19200; break;
-		case 38400: div_value = ftdi_sio_b38400; break;
-		case 57600: div_value = ftdi_sio_b57600;  break;
-		case 115200: div_value = ftdi_sio_b115200; break;
-		} /* baud */
-		if (div_value == 0) {
+		div_value = ftdi_sio_baud_to_divisor(baud);
+		if (div_value == (u32)-1) {
 			dev_dbg(dev, "%s - Baudrate (%d) requested is not supported\n",
 				__func__,  baud);
-			div_value = ftdi_sio_b9600;
 			baud = 9600;
+			div_value = ftdi_sio_baud_to_divisor(baud);
 			div_okay = 0;
 		}
 		break;
-- 
2.35.1

