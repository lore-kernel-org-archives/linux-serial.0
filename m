From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 2/2 v2] serial: jsm: some off by one bugs
Date: Tue, 17 Mar 2015 12:17:28 +0300
Message-ID: <20150317091728.GA19685@mwanda>
References: <20150316174743.GB6037@oc0812247204.ltc.br.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150316174743.GB6037@oc0812247204.ltc.br.ibm.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

"brd->nasync" amd "brd->maxports" are the same.  They hold the number of
filled out channels in the brd->channels[] array.  These tests should
be ">=" instead of ">" so that we don't read one element past the end.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: Thadeu Cascardo noticed another off by one that I missed.

diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
index bfb0681..4eb12a9 100644
--- a/drivers/tty/serial/jsm/jsm_cls.c
+++ b/drivers/tty/serial/jsm/jsm_cls.c
@@ -570,7 +570,7 @@ static inline void cls_parse_isr(struct jsm_board *brd, uint port)
 	 * verified in the interrupt routine.
 	 */
 
-	if (port > brd->nasync)
+	if (port >= brd->nasync)
 		return;
 
 	ch = brd->channels[port];
diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index 7291c21..932b2ac 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -724,7 +724,7 @@ static inline void neo_parse_isr(struct jsm_board *brd, u32 port)
 	if (!brd)
 		return;
 
-	if (port > brd->maxports)
+	if (port >= brd->maxports)
 		return;
 
 	ch = brd->channels[port];
@@ -840,7 +840,7 @@ static inline void neo_parse_lsr(struct jsm_board *brd, u32 port)
 	if (!brd)
 		return;
 
-	if (port > brd->maxports)
+	if (port >= brd->maxports)
 		return;
 
 	ch = brd->channels[port];
@@ -1180,7 +1180,7 @@ static irqreturn_t neo_intr(int irq, void *voidbrd)
 			 */
 
 			/* Verify the port is in range. */
-			if (port > brd->nasync)
+			if (port >= brd->nasync)
 				continue;
 
 			ch = brd->channels[port];
