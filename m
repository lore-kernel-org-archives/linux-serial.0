From: George Spelvin <linux@horizon.com>
Subject: [PATCH 6/7] pps: Use pps_lookup_dev to reduce ldisc coupling
Date: Fri, 8 Feb 2013 01:48:37 -0500
Message-ID: <81becf8131bcc289f2142d3419c13030906ffe6d.1360307140.git.linux@horizon.com>
References: <cover.1360307140.git.linux@horizon.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:36263 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1946112Ab3BHJQh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 8 Feb 2013 04:16:37 -0500
In-Reply-To: <cover.1360307140.git.linux@horizon.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, peter@hurleysoftware.com
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, giometti@linux.it

Now that N_TTY uses tty->disc_data for its private data,
'subclass' ldiscs cannot use ->disc_data for their own private data.
(This is a regression is v3.8-rc1)

Use pps_lookup_dev to associate the tty with the pps source instead.

Signed-off-by: George Spelvin <linux@horizon.com>
---
 drivers/pps/clients/pps-ldisc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/pps/clients/pps-ldisc.c b/drivers/pps/clients/pps-ldisc.c
index e5a702a..5c22c5f 100644
--- a/drivers/pps/clients/pps-ldisc.c
+++ b/drivers/pps/clients/pps-ldisc.c
@@ -32,10 +32,12 @@
 static void pps_tty_dcd_change(struct tty_struct *tty, unsigned int status)
 {
 	struct pps_event_time ts;
-	struct pps_device *pps = (struct pps_device *)tty->disc_data;
+	struct pps_device *pps;
 
 	pps_get_ts(&ts);
 
+	pps = pps_lookup_dev(tty);
+
 	/*
 	 * This should never fail, but the ldisc locking is very
 	 * convoluted, so don't crash just in case.
@@ -75,9 +77,9 @@ static int pps_tty_open(struct tty_struct *tty)
 		pr_err("cannot register PPS source \"%s\"\n", info.path);
 		return -ENOMEM;
 	}
-	tty->disc_data = pps;
+	pps->lookup_cookie = tty;
 
-	/* Should open N_TTY ldisc too */
+	/* Now open the base class N_TTY ldisc */
 	ret = alias_n_tty_open(tty);
 	if (ret < 0) {
 		pr_err("cannot open tty ldisc \"%s\"\n", info.path);
@@ -89,7 +91,7 @@ static int pps_tty_open(struct tty_struct *tty)
 	return 0;
 
 err_unregister:
-	tty->disc_data = NULL;
+	pps->lookup_cookie = NULL;
 	pps_unregister_source(pps);
 	return ret;
 }
@@ -98,12 +100,15 @@ static void (*alias_n_tty_close)(struct tty_struct *tty);
 
 static void pps_tty_close(struct tty_struct *tty)
 {
-	struct pps_device *pps = (struct pps_device *)tty->disc_data;
+	struct pps_device *pps = pps_lookup_dev(tty);
 
 	alias_n_tty_close(tty);
 
-	tty->disc_data = NULL;
+	if (WARN_ON(!pps))
+		return;
+
 	dev_info(pps->dev, "removed\n");
+	pps->lookup_cookie = NULL;
 	pps_unregister_source(pps);
 }
 
-- 
1.8.1.2

