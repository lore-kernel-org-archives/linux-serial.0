From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 74/75] hso maintainers update patch
Date: Fri, 02 Jan 2009 13:50:36 +0000
Message-ID: <20090102135035.13472.69274.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50533 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757597AbZABNuW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:50:22 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Denis Joseph Barrow <D.Barow@option.com>

Added D.J. Barrow as maintainer of hso driver.

Signed-off-by: Denis Joseph Barrow <D.Barow@option.com>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 MAINTAINERS           |    6 ++++++
 drivers/net/usb/hso.c |    2 ++
 2 files changed, 8 insertions(+), 0 deletions(-)


diff --git a/MAINTAINERS b/MAINTAINERS
index ceb32ee..d5fc534 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2049,6 +2049,12 @@ M:	mikulas@artax.karlin.mff.cuni.cz
 W:	http://artax.karlin.mff.cuni.cz/~mikulas/vyplody/hpfs/index-e.cgi
 S:	Maintained
 
+HSO	3G Modem Driver (hso.c)
+P:	Denis Joseph Barrow
+M:	d.barow@option.com
+W:	http://www.pharscape.org
+S:	Maintained
+
 HTCPEN TOUCHSCREEN DRIVER
 P:	Pau Oliva Fora
 M:	pof@eslack.org
diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index 148af34..c4918b8 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -3,6 +3,8 @@
  * Driver for Option High Speed Mobile Devices.
  *
  *  Copyright (C) 2008 Option International
+ *                     Filip Aben <f.aben@option.com>
+ *                     Denis Joseph Barrow <d.barow@option.com>
  *  Copyright (C) 2007 Andrew Bird (Sphere Systems Ltd)
  *  			<ajb@spheresystems.co.uk>
  *  Copyright (C) 2008 Greg Kroah-Hartman <gregkh@suse.de>

