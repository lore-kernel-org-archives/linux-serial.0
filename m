From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 2/3] tty: Make vt's have a tty_port
Date: Wed, 19 May 2010 13:11:14 +0100
Message-ID: <20100519121109.17652.7632.stgit@localhost.localdomain>
References: <20100519120901.17652.67379.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36504 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754635Ab0ESMxm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 May 2010 08:53:42 -0400
In-Reply-To: <20100519120901.17652.67379.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

The vt layer isn't safely handling reference counts to tty object on the input
side. Add a tty port structure to the vt layer in order to implement this using
the standard helpers.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/char/vt.c              |    2 ++
 include/linux/console_struct.h |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index c5e30e3..e5269cc 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -772,6 +772,7 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
 	    if (!vc)
 		return -ENOMEM;
 	    vc_cons[currcons].d = vc;
+	    tty_port_init(&vc->port);
 	    INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
 	    visual_init(vc, currcons, 1);
 	    if (!*vc->vc_uni_pagedir_loc)
@@ -2909,6 +2910,7 @@ static int __init con_init(void)
 	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
 		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
 		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
+		tty_port_init(&vc->port);
 		visual_init(vc, currcons, 1);
 		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
 		vc_init(vc, vc->vc_rows, vc->vc_cols,
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index 38fe59d..57e83f1 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -21,6 +21,8 @@ struct vt_struct;
 #define NPAR 16
 
 struct vc_data {
+	struct tty_port port;			/* Upper level data */
+
 	unsigned short	vc_num;			/* Console number */
 	unsigned int	vc_cols;		/* [#] Console size */
 	unsigned int	vc_rows;

