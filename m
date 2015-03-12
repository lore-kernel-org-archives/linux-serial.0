From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 2/2] serial: jsm: some off by one bugs
Date: Thu, 12 Mar 2015 20:08:24 +0300
Message-ID: <20150312170823.GB21911@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-janitors@vger.kernel.org, driverdev-devel@linuxdriverproject.org, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

"brd->nasync" amd "brd->maxports" are the same.  They hold the number of
filled out channels in the brd->channels[] array.  These tests should
be ">=" instead of ">" so that we don't read one element past the end.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

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
index 7291c21..f413ef0 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
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
