From: Rene Herman <rene.herman@home.nl>
Subject: [TRIVIAL] add PnP ID to 8250_pnp.c
Date: Mon, 29 Dec 2003 01:45:33 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <3FEF792D.7030503@home.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090405000700000807090900"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtpq2.home.nl ([213.51.128.197]:22401 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S262164AbTL2Asl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 28 Dec 2003 19:48:41 -0500
List-Id: linux-serial@vger.kernel.org
To: Russel King <rmk+serial@arm.linux.org.uk>
Cc: linux-serial <linux-serial@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090405000700000807090900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Russel.

I need the attached patch to have my modem visible on 2.6.0 (really do; 
the modem unfortunately doesn't advertise a "compatible device" generic 
PNPC/D ID)

Please advice if you want me to send this to the patch monkey instead.

Kind regards,
Rene

--------------090405000700000807090900
Content-Type: text/plain;
 name="linux-2.6.0_8250_pnp.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.0_8250_pnp.diff"

--- linux-2.6.0/drivers/serial/8250_pnp.c.orig	2003-12-29 01:24:46.000000000 +0100
+++ linux-2.6.0/drivers/serial/8250_pnp.c	2003-12-29 01:24:51.000000000 +0100
@@ -74,6 +74,9 @@
 	{	"DMB1032",		0	},
 	/* Creative Modem Blaster V.90 DI5660 */
 	{	"DMB2001",		0	},
+	/* E-Tech */
+	/* E-Tech CyberBULLET PC56RVP */
+	{	"ETT0002",		0	},
 	/* FUJITSU */
 	/* Fujitsu 33600 PnP-I2 R Plug & Play */
 	{	"FUJ0202",		0	},

--------------090405000700000807090900--

