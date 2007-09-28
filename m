From: Maik Broemme <mbroemme@plusserver.de>
Subject: [PATCH] Added support for Wacom WACF007 and WACF008 to serial pnp
	driver.
Date: Fri, 28 Sep 2007 17:19:18 +0200
Message-ID: <20070928151917.GA28155@bart.intergenia.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from isis45.plusserver.de ([217.172.174.164]:32830 "EHLO
	isis45.plusserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbXI1QB2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Sep 2007 12:01:28 -0400
Received: from static-ip-62-75-200-52.inaddr.intergenia.de ([62.75.200.52] helo=bart.intergenia.de)
	by isis45.plusserver.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <babyface@isis45.plusserver.de>)
	id 1IbHdu-0003Xc-O7
	for linux-serial@vger.kernel.org; Fri, 28 Sep 2007 17:20:41 +0200
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

notebook manufacturer seems to built a newer Wacom pen enabled tablet to
recent tablet pcs which are not recognized by the serial pnp driver.

Attached is a patch which makes the newer Wacom WACF007 and WACF008
tablets useable with the serial driver. The device is fully compatible
with it.

--Maik

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.23-rc8-newer-wacom.patch"

diff -Nur linux-2.6.23-rc8/drivers/serial/8250_pnp.c linux-2.6.23-rc8-newer-wacom/drivers/serial/8250_pnp.c
--- linux-2.6.23-rc8/drivers/serial/8250_pnp.c	2007-09-28 17:14:07.000000000 +0200
+++ linux-2.6.23-rc8-newer-wacom/drivers/serial/8250_pnp.c	2007-09-28 17:09:45.000000000 +0200
@@ -327,6 +327,8 @@
 	{	"WACF004",		0	},
 	{	"WACF005",		0	},
 	{       "WACF006",              0       },
+	{       "WACF007",              0       },
+	{       "WACF008",              0       },
 	/* Compaq touchscreen */
 	{       "FPI2002",              0 },
 	/* Fujitsu Stylistic touchscreens */

--yrj/dFKFPuw6o+aM--
