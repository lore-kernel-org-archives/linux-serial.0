From: Denis Joseph Barrow <D.Barow@option.com>
Subject: [Fwd: [PATCH] hso_spinlockfix.patch]
Date: Wed, 14 Jan 2009 11:04:05 +0100
Message-ID: <496DB895.1040809@option.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000907070605050606010306"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailer1.option.com ([81.246.70.162]:37840 "EHLO
	mailer1.option.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449AbZANKOp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Jan 2009 05:14:45 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linux Serial <linux-serial@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000907070605050606010306
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



-------- Original Message --------
Subject: [PATCH] hso_spinlockfix.patch
Date: Wed, 14 Jan 2009 10:54:51 +0100
From: Denis Joseph Barrow <D.Barow@option.com>
To: Linux USB kernel mailing list <linux-usb@vger.kernel.org>,  Linux netdev Mailing list <netdev@vger.kernel.org>

Hi,
This is a really important fix it fixes a consistent kernel deadlock
when the hso driver starts going. It's against 2.6.29-rc1, 2.6.29-rc6
worked fine.

This patch obviously wasn't tested & I neither I or Filip was subscribed to the tty mailing 
list to catch it.

Even with this patch the driver is still broken.
opening the serial port on the driver a second time causes a -EIO,
I've yet to figure out what but it is not returned from hso_serial_open
but a parent function.


This patch fixes a double grabbing of a spinlock all
functions which call put_rxbuf_data already have serial->serial_lock grabbed.
Signed-off-by: Denis Joseph Barrow <D.Barow@option.com>
Index: linux-2.6/drivers/net/usb/hso.c
===================================================================
--- linux-2.6.orig/drivers/net/usb/hso.c	2009-01-13 17:39:15.000000000 +0100
+++ linux-2.6/drivers/net/usb/hso.c	2009-01-13 17:40:42.000000000 +0100
@@ -2043,9 +2043,7 @@
 		return -2;
 	}
 
-	spin_lock(&serial->serial_lock);
 	tty = tty_kref_get(serial->tty);
-	spin_unlock(&serial->serial_lock);
 
 	/* Push data to tty */
 	if (tty) {

-- 
best regards,
D.J. Barrow

Linux Kernel Developer
Option NV, Gaston Geenslaan 14, 3001 Leuven, Belgium
 
T: +32 16 311 621
F: +32 16 207 164
d.barow@option.com
www.option.com

Disclaimer:
http://www.option.com/company/disclaimer.shtml


-- 
best regards,
D.J. Barrow

Linux Kernel Developer
Option NV, Gaston Geenslaan 14, 3001 Leuven, Belgium
 
T: +32 16 311 621
F: +32 16 207 164
d.barow@option.com
www.option.com

Disclaimer:
http://www.option.com/company/disclaimer.shtml

--------------000907070605050606010306
Content-Type: text/x-diff;
 name="hso_spinlockfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hso_spinlockfix.patch"

This patch fixes a double grabbing of a spinlock all
functions which call put_rxbuf_data already have serial->serial_lock grabbed.
Signed-off-by: Denis Joseph Barrow <D.Barow@option.com>
Index: linux-2.6/drivers/net/usb/hso.c
===================================================================
--- linux-2.6.orig/drivers/net/usb/hso.c	2009-01-13 17:39:15.000000000 +0100
+++ linux-2.6/drivers/net/usb/hso.c	2009-01-13 17:40:42.000000000 +0100
@@ -2043,9 +2043,7 @@
 		return -2;
 	}
 
-	spin_lock(&serial->serial_lock);
 	tty = tty_kref_get(serial->tty);
-	spin_unlock(&serial->serial_lock);
 
 	/* Push data to tty */
 	if (tty) {


--------------000907070605050606010306--
