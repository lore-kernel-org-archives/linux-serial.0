From: maximilian attems <janitor@sternwelten.at>
Subject: [patch 2.6.14-rc4] 8250 add SupraExpress 56i support
Date: Sat, 15 Oct 2005 01:26:18 +0200
Message-ID: <20051014232618.GK30947@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:47801 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S1750703AbVJNX0W
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Oct 2005 19:26:22 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org

The modem is said to work with belows addition to pnp_dev_table[]:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=296011

Signed-off-by: maximilian attems <janitor@sternwelten.at>

--- linux-2.6.14-rc4/drivers/serial/8250_pnp.c.orig	2005-10-15 01:17:32.000000000 +0200
+++ linux-2.6.14-rc4/drivers/serial/8250_pnp.c	2005-10-15 01:18:41.000000000 +0200
@@ -274,6 +274,8 @@ static const struct pnp_device_id pnp_de
 	{	"SUP1590",		0	},
 	/* SupraExpress 33.6 Data/Fax PnP modem */
 	{	"SUP1760",		0	},
+	/* SupraExpress 56i Sp Intl */
+	{	"SUP2171",		0	},
 	/* Phoebe Micro */
 	/* Phoebe Micro 33.6 Data Fax 1433VQH Plug & Play */
 	{	"TEX0011",		0	},
