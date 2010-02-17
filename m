From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 3/3] nozomi: Tidy up the PCI table
Date: Wed, 17 Feb 2010 13:00:14 +0000
Message-ID: <20100217130010.15264.17190.stgit@localhost.localdomain>
References: <20100217125940.15264.98701.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46210 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932286Ab0BQNYM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Feb 2010 08:24:12 -0500
In-Reply-To: <20100217125940.15264.98701.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: fseidel@suse.de, greg@kroah.com, linux-serial@vger.kernel.org

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/char/nozomi.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)


diff --git a/drivers/char/nozomi.c b/drivers/char/nozomi.c
index fac9157..584910f 100644
--- a/drivers/char/nozomi.c
+++ b/drivers/char/nozomi.c
@@ -136,10 +136,6 @@ static int debug;
 #define RECEIVE_BUF_MAX		4
 
 
-/* Define all types of vendors and devices to support */
-#define VENDOR1		0x1931	/* Vendor Option */
-#define DEVICE1		0x000c	/* HSDPA card */
-
 #define R_IIR		0x0000	/* Interrupt Identity Register */
 #define R_FCR		0x0000	/* Flow Control Register */
 #define R_IER		0x0004	/* Interrupt Enable Register */
@@ -407,7 +403,7 @@ struct buffer {
 
 /*    Global variables */
 static const struct pci_device_id nozomi_pci_tbl[] __devinitconst = {
-	{PCI_DEVICE(VENDOR1, DEVICE1)},
+	{PCI_DEVICE(0x1931, 0x000c)},	/* Nozomi HSDPA */
 	{},
 };
 

