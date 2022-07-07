Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42498CCA479
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 14:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbiGGO4C (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 10:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbiGGOzb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 10:55:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731CB599C5
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 07:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 231F66231C
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 14:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DC3C341C6;
        Thu,  7 Jul 2022 14:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657205648;
        bh=Gh4TMbEzSAw1heyKyberRUJl4zTh6HNwlmdrtbBQWvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rfl2WPbW+snl+geQy/d2Ow8r/2TBMbi98doPGBuK9Wl1XzUXsxf6oZQSSvE8cO06O
         7/iszhlSwToEyVVWdbrDB7IBu2Kl5p+TXu3nroiFDLcf4L/pR7No9jOs81AstpGJ+L
         +Ki0YU58TObyn7bVYWSI8F3Z7FbmUtoL2xXSI64NYV0z7HWosxb6eiG9wRZNaI8w/z
         czGsDrUV/l7VeB3pMFyITNIC7Zq8/PDgXUikc/fy/bxC15AQLYVHGG1FaO/MKh7rQd
         cS6lMYnvUFjrnN7j8BpnMVj6IKleEStEcD+v1X8pyRf/VTcK47S+qzh4Rj7c+eqvD3
         zW+1aFiKhf1SA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 7/7] USB: serial: ftdi_sio: Fill c_*speed fields with real baudrate
Date:   Thu,  7 Jul 2022 16:53:54 +0200
Message-Id: <20220707145354.29705-8-kabel@kernel.org>
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

Calculate baudrate value in c_*speed fields to the real value which was set
to hardware. For this operation add a new set of functions divisor_to_baud
for each chip and use it for calculating the real baudrate value.

Each divisor_to_baud function is constructed as an inverse function of
corresponding baud_to_divisor function.

Signed-off-by: Pali Rohár <pali@kernel.org>
Tested-by: Marek Behún <kabel@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 79 +++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 3bf5750e76de..1f78ae695a1b 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1167,6 +1167,23 @@ static u32 ftdi_sio_baud_to_divisor(int baud)
 	}
 }
 
+static int ftdi_sdio_divisor_to_baud(u32 divisor)
+{
+	switch (divisor) {
+	case ftdi_sio_b300: return 300;
+	case ftdi_sio_b600: return 600;
+	case ftdi_sio_b1200: return 1200;
+	case ftdi_sio_b2400: return 2400;
+	case ftdi_sio_b4800: return 4800;
+	case ftdi_sio_b9600: return 9600;
+	case ftdi_sio_b19200: return 19200;
+	case ftdi_sio_b38400: return 38400;
+	case ftdi_sio_b57600: return 57600;
+	case ftdi_sio_b115200: return 115200;
+	default: return 9600;
+	}
+}
+
 static unsigned short int ftdi_232am_baud_base_to_divisor(int baud, int base)
 {
 	unsigned short int divisor;
@@ -1189,11 +1206,27 @@ static unsigned short int ftdi_232am_baud_base_to_divisor(int baud, int base)
 	return divisor;
 }
 
+static int ftdi_232am_divisor_base_to_baud(unsigned short int divisor, int base)
+{
+	static const unsigned char divfrac_inv[4] = { 0, 4, 2, 1 };
+	unsigned int divisor3;
+	if (divisor == 0)
+		divisor = 1;
+	divisor3 = (GENMASK(13, 0) & divisor) << 3;
+	divisor3 |= divfrac_inv[(divisor >> 14) & 0x3];
+	return DIV_ROUND_CLOSEST(base, 2 * divisor3);
+}
+
 static unsigned short int ftdi_232am_baud_to_divisor(int baud)
 {
 	 return ftdi_232am_baud_base_to_divisor(baud, 48000000);
 }
 
+static int ftdi_232am_divisor_to_baud(unsigned short int divisor)
+{
+	return ftdi_232am_divisor_base_to_baud(divisor, 48000000);
+}
+
 static u32 ftdi_232bm_baud_base_to_divisor(int baud, int base)
 {
 	static const unsigned char divfrac[8] = { 0, 3, 2, 4, 1, 5, 6, 7 };
@@ -1212,11 +1245,30 @@ static u32 ftdi_232bm_baud_base_to_divisor(int baud, int base)
 	return divisor;
 }
 
+static int ftdi_232bm_divisor_base_to_baud(u32 divisor, int base)
+{
+	static const unsigned char divfrac_inv[8] = { 0, 4, 2, 1, 3, 5, 6, 7 };
+	u32 divisor3;
+	/* Deal with special cases for highest baud rates. */
+	if (divisor == 0)
+		divisor = 1;		/* 1.0 */
+	else if (divisor == 1)
+		divisor = 0x4001;	/* 1.5 */
+	divisor3 = (GENMASK(13, 0) & divisor) << 3;
+	divisor3 |= divfrac_inv[(divisor >> 14) & 0x7];
+	return DIV_ROUND_CLOSEST(base, 2 * divisor3);
+}
+
 static u32 ftdi_232bm_baud_to_divisor(int baud)
 {
 	 return ftdi_232bm_baud_base_to_divisor(baud, 48000000);
 }
 
+static int ftdi_232bm_divisor_to_baud(u32 divisor)
+{
+	return ftdi_232bm_divisor_base_to_baud(divisor, 48000000);
+}
+
 static u32 ftdi_2232h_baud_base_to_divisor(int baud, int base)
 {
 	static const unsigned char divfrac[8] = { 0, 3, 2, 4, 1, 5, 6, 7 };
@@ -1244,11 +1296,31 @@ static u32 ftdi_2232h_baud_base_to_divisor(int baud, int base)
 	return divisor;
 }
 
+static int ftdi_2232h_divisor_base_to_baud(u32 divisor, int base)
+{
+	static const unsigned char divfrac_inv[8] = { 0, 4, 2, 1, 3, 5, 6, 7 };
+	u32 divisor3;
+	divisor &= GENMASK(16, 0);
+	/* Deal with special cases for highest baud rates. */
+	if (divisor == 0)
+		divisor = 1;		/* 1.0 */
+	else if (divisor == 1)
+		divisor = 0x4001;	/* 1.5 */
+	divisor3 = (GENMASK(13, 0) & divisor) << 3;
+	divisor3 |= divfrac_inv[(divisor >> 14) & 0x7];
+	return DIV_ROUND_CLOSEST(8 * base, 10 * divisor3);
+}
+
 static u32 ftdi_2232h_baud_to_divisor(int baud)
 {
 	 return ftdi_2232h_baud_base_to_divisor(baud, 120000000);
 }
 
+static int ftdi_2232h_divisor_to_baud(u32 divisor)
+{
+	return ftdi_2232h_divisor_base_to_baud(divisor, 120000000);
+}
+
 #define set_mctrl(port, set)		update_mctrl((port), (set), 0)
 #define clear_mctrl(port, clear)	update_mctrl((port), 0, (clear))
 
@@ -1342,6 +1414,7 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 			}
 			div_okay = 0;
 		}
+		baud = ftdi_sdio_divisor_to_baud(div_value);
 		break;
 	case FT8U232AM: /* 8U232AM chip */
 		if (baud >= 183 && baud <= 3000000) {
@@ -1352,6 +1425,7 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 			div_value = ftdi_232am_baud_to_divisor(baud);
 			div_okay = 0;
 		}
+		baud = ftdi_232am_divisor_to_baud(div_value);
 		break;
 	case FT232BM: /* FT232BM chip */
 	case FT2232C: /* FT2232C chip */
@@ -1375,22 +1449,27 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 			div_value = ftdi_232bm_baud_to_divisor(baud);
 			div_okay = 0;
 		}
+		baud = ftdi_232bm_divisor_to_baud(div_value);
 		break;
 	case FT2232H: /* FT2232H chip */
 	case FT4232H: /* FT4232H chip */
 	case FT232H:  /* FT232H chip */
 		if ((baud <= 12000000) && (baud >= 1200)) {
 			div_value = ftdi_2232h_baud_to_divisor(baud);
+			baud = ftdi_2232h_divisor_to_baud(div_value);
 		} else if (baud >= 183 && baud < 1200) {
 			div_value = ftdi_232bm_baud_to_divisor(baud);
+			baud = ftdi_232bm_divisor_to_baud(div_value);
 		} else {
 			dev_dbg(dev, "%s - Baud rate too high!\n", __func__);
 			if (old_baud >= 183 && old_baud < 1200) {
 				baud = old_baud;
 				div_value = ftdi_232bm_baud_to_divisor(baud);
+				baud = ftdi_232bm_divisor_to_baud(div_value);
 			} else {
 				baud = (old_baud >= 1200 && old_baud <= 12000000) ? old_baud : 9600;
 				div_value = ftdi_2232h_baud_to_divisor(baud);
+				baud = ftdi_2232h_divisor_to_baud(div_value);
 			}
 			div_okay = 0;
 		}
-- 
2.35.1

