From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 03/30] serial: Update PNP IDs
Date: Tue, 24 Mar 2009 14:02:12 +0000
Message-ID: <20090324140208.12735.29637.stgit@localhost.localdomain>
References: <20090324135930.12735.7827.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757736AbZCXOCq@vger.kernel.org>
In-Reply-To: <20090324135930.12735.7827.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, torvalds@linux-foundation.org
List-Id: linux-serial@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

Add new Wacom device IDs to the 8250_pnp serial driver, to support
autoconfig on some newer tablet PCs.  Also add a comment to clarify that
the FUJ02E6 device is a custom protocol, not a Wacom tablet.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Alan Cox <alan@etchedpixels.co.uk>
---

 drivers/serial/8250_pnp.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)


diff --git a/drivers/serial/8250_pnp.c b/drivers/serial/8250_pnp.c
index 6db9f13..d71dfe3 100644
--- a/drivers/serial/8250_pnp.c
+++ b/drivers/serial/8250_pnp.c
@@ -334,6 +334,9 @@ static const struct pnp_device_id pnp_dev_table[] = {
 	{       "WACF007",              0       },
 	{       "WACF008",              0       },
 	{       "WACF009",              0       },
+	{       "WACF00A",              0       },
+	{       "WACF00B",              0       },
+	{       "WACF00C",              0       },
 	/* Compaq touchscreen */
 	{       "FPI2002",              0 },
 	/* Fujitsu Stylistic touchscreens */
@@ -347,8 +350,9 @@ static const struct pnp_device_id pnp_dev_table[] = {
 	{       "FUJ02B8",              0 },
 	{       "FUJ02B9",              0 },
 	{       "FUJ02BC",              0 },
-	/* Fujitsu Wacom Tablet PC devices */
+	/* Fujitsu Wacom Tablet PC device */
 	{	"FUJ02E5",		0	},
+	/* Fujitsu P-series tablet PC device */
 	{	"FUJ02E6",		0	},
 	/*
 	 * LG C1 EXPRESS DUAL (C1-PB11A3) touch screen (actually a FUJ02E6 in
