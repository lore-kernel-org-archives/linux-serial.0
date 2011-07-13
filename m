From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Subject: drivers/usb/serial/ftdi_sio.c: For the FT232H FTDI_SIO_SET_BAUDRATE_REQUEST, index needs to be shifted too
Date: Wed, 13 Jul 2011 11:14:05 +0200
Message-ID: <19997.25053.862456.607559@elektron.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lnx503.hrz.tu-darmstadt.de ([130.83.156.232]:53541 "EHLO
	lnx503.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965124Ab1GMJOI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Jul 2011 05:14:08 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@suse.de
Cc: linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

Hello,

the recent addition of the FT232H showed that baudrate was set wrong. See
gmane.linux.usb.general: "[ftdi_sio] FT232H support".  With the old code,
the MSB of the 4 encoded fractional divider bits and more important the
clock predivider bits got lost. Adding the FT232H to the code patch were
these bits are shifted solves the problem. I verified baud rates with a
scope now.

I suspect, that the BM device probably needs these bits shifted too. But
there is no predivider bit, so this is not obvious, and a missing MSB of the
encoded fractional divider only shifts the resulting baudrate minimal. 
The AM has only 3 bits of encoded fractional divider, so it is not impacted.

I have no BM device to test, so I only added a comment and left the code for
the BM untouched.

This time with checkpatch happy.

Bye

-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
>From 892f1ac2b0b47ffc7adf70ecbe5d7d2f31c79232 Mon Sep 17 00:00:00 2001
From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Date: Tue, 12 Jul 2011 18:47:08 +0200
Subject: ftdi_sio: For the FT232H FTDI_SIO_SET_BAUDRATE_REQUEST, index needs to be shifted too

---
 drivers/usb/serial/ftdi_sio.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 2e06b90..0692a36 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1205,7 +1205,10 @@ static int change_speed(struct tty_struct *tty, struct usb_serial_port *port)
 	urb_index_value = get_ftdi_divisor(tty, port);
 	urb_value = (__u16)urb_index_value;
 	urb_index = (__u16)(urb_index_value >> 16);
-	if (priv->interface) {	/* FT2232C */
+	if ((priv->chip_type == FT2232C) || (priv->chip_type == FT2232H) ||
+		(priv->chip_type == FT4232H) || (priv->chip_type == FT232H)) {
+		/* Probably the BM type needs the MSB of the encoded fractional
+		 * divider also moved like for the chips above. Any infos? */
 		urb_index = (__u16)((urb_index << 8) | priv->interface);
 	}
 
-- 
1.7.3.4
Signed-off-by: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>

