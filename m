From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: serial: add PNP ID GVC0303 for Archtek 3334BRV ISA modem
Date: Mon, 25 Feb 2008 09:15:27 -0700
Message-ID: <200802250915.27783.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:9404 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022AbYBYQN6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Feb 2008 11:13:58 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Lehmann <thomas.lehmann@alumni.tu-berlin.de>, linux-kernel@vger.kernel.org

Thomas Lehmann <thomas.lehmann@alumni.tu-berlin.de> verified that this
entry works.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work6/drivers/serial/8250_pnp.c
===================================================================
--- work6.orig/drivers/serial/8250_pnp.c	2008-02-20 16:55:04.000000000 -0700
+++ work6/drivers/serial/8250_pnp.c	2008-02-25 09:04:41.000000000 -0700
@@ -91,6 +91,8 @@
 	/* Archtek America Corp. */
 	/* Archtek SmartLink Modem 3334BT Plug & Play */
 	{	"GVC000F",		0	},
+	/* Archtek SmartLink Modem 3334BRV 33.6K Data Fax Voice */
+	{	"GVC0303",		0	},
 	/* Hayes */
 	/* Hayes Optima 288 V.34-V.FC + FAX + Voice Plug & Play */
 	{	"HAY0001",		0	},
