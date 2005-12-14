From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: [PATCH] Problem with detecting the serial ports on a NetMos 9845
Date: Wed, 14 Dec 2005 02:00:28 +0100
Message-ID: <20051214010028.GA11052@uio.no>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cassarossa.samfundet.no ([129.241.93.19]:17623 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S932624AbVLNBAc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 13 Dec 2005 20:00:32 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: magne@samfundet.no


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

We have a NetMos 9845 controller with four serial ports but no parallel port, 
and tried to use parport_serial driver with it. However, all it would say was
that it had detected a parallel port at 9710:9735, and then exit.

We tracked it down, and found two problems:

  - For some reason, it detects the 9845 as a 9735 -- it appears this is
    simply related to the ordering in parport_serial_pci_tbl[]. If we move
    the 9845 up above the 9735, it prints out 9710:9845, but no change in
    behaviour. (We didn't find out why this was the case; we left it alone
    since it didn't affect our problem.)
  - The card has no parallel port (at least no physical ones), yet it reports
    (via its subsystem ID of 0x0014) one parallel port and four serial ports.
    The probe for the parallel port fails, and the driver just aborts. Thus,
    it doesn't find the serial ports.

We tested this under both 2.6.12 and 2.6.15, and both had the same problem.
The attached patch (against 2.6.12) changes the logic for the parallel port
detection: If there are detected parallel ports but the probe fails, the
number of parallel ports is simply set to zero, and the probe continues as
usual. This makes it work correctly in our case, and should not present a
problem for other systems.

/* Steinar */
-- 
Homepage: http://www.sesse.net/

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="parport_serial.c.diff"

--- linux-source-2.6.12-2.6.12/drivers/parport/parport_serial.c	2005-06-17 21:48:29.000000000 +0200
@@ -418,10 +419,13 @@
 		return err;
 	}
 
-	if (parport_register (dev, id)) {
+	err = parport_register (dev, id);
+	if (err < 0) {
 		pci_set_drvdata (dev, NULL);
 		kfree (priv);
 		return -ENODEV;
+	} else if (err) {
+		priv->num_par = 0;
 	}
 
 	if (serial_register (dev, id)) {

--J2SCkAp4GZ/dPZZf--
