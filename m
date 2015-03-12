From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 1/2] staging: dgnc: some off by one bugs
Date: Thu, 12 Mar 2015 20:07:39 +0300
Message-ID: <20150312170739.GA21911@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Lidza Louina <lidza.louina@gmail.com>
Cc: Mark Hounschell <markh@compro.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

"dgnc_NumBoards" is the number of filled out elements in the
dgnc_Board[] array.  "->nasync" and "->maxports" are the value.  They
are the number of channels in the ->channels[] array so these tests
should be ">=" instead of ">" so we avoid reading past the end of the
arrays.

I cleaned up the conditions in dgnc_mgmt_ioctl() a bit.  There was a
work around for the off by one bug in the case where there were no
boards which is no longer needed.  "channel" is unsigned so it can't be
negative.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/staging/dgnc/dgnc_cls.c b/drivers/staging/dgnc/dgnc_cls.c
index bedc522..0d8f154 100644
--- a/drivers/staging/dgnc/dgnc_cls.c
+++ b/drivers/staging/dgnc/dgnc_cls.c
@@ -406,7 +406,7 @@ static inline void cls_parse_isr(struct dgnc_board *brd, uint port)
 	 * verified in the interrupt routine.
 	 */
 
-	if (port > brd->nasync)
+	if (port >= brd->nasync)
 		return;
 
 	ch = brd->channels[port];
diff --git a/drivers/staging/dgnc/dgnc_mgmt.c b/drivers/staging/dgnc/dgnc_mgmt.c
index 5544a8e..01b290e 100644
--- a/drivers/staging/dgnc/dgnc_mgmt.c
+++ b/drivers/staging/dgnc/dgnc_mgmt.c
@@ -196,11 +196,11 @@ long dgnc_mgmt_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		channel = ni.channel;
 
 		/* Verify boundaries on board */
-		if ((board > dgnc_NumBoards) || (dgnc_NumBoards == 0))
+		if (board >= dgnc_NumBoards)
 			return -ENODEV;
 
 		/* Verify boundaries on channel */
-		if ((channel < 0) || (channel > dgnc_Board[board]->nasync))
+		if (channel >= dgnc_Board[board]->nasync)
 			return -ENODEV;
 
 		ch = dgnc_Board[board]->channels[channel];
diff --git a/drivers/staging/dgnc/dgnc_neo.c b/drivers/staging/dgnc/dgnc_neo.c
index 1268aa9..921e463 100644
--- a/drivers/staging/dgnc/dgnc_neo.c
+++ b/drivers/staging/dgnc/dgnc_neo.c
@@ -407,7 +407,7 @@ static inline void neo_parse_isr(struct dgnc_board *brd, uint port)
 	if (!brd || brd->magic != DGNC_BOARD_MAGIC)
 		return;
 
-	if (port > brd->maxports)
+	if (port >= brd->maxports)
 		return;
 
 	ch = brd->channels[port];
@@ -537,7 +537,7 @@ static inline void neo_parse_lsr(struct dgnc_board *brd, uint port)
 	if (!brd || brd->magic != DGNC_BOARD_MAGIC)
 		return;
 
-	if (port > brd->maxports)
+	if (port >= brd->maxports)
 		return;
 
 	ch = brd->channels[port];
@@ -1019,7 +1019,7 @@ static irqreturn_t neo_intr(int irq, void *voidbrd)
 			 */
 
 			/* Verify the port is in range. */
-			if (port > brd->nasync)
+			if (port >= brd->nasync)
 				continue;
 
 			ch = brd->channels[port];
diff --git a/drivers/staging/dgnc/dgnc_tty.c b/drivers/staging/dgnc/dgnc_tty.c
index 8179342..4507d4a 100644
--- a/drivers/staging/dgnc/dgnc_tty.c
+++ b/drivers/staging/dgnc/dgnc_tty.c
@@ -1060,7 +1060,7 @@ static int dgnc_tty_open(struct tty_struct *tty, struct file *file)
 	spin_lock_irqsave(&brd->bd_lock, flags);
 
 	/* If opened device is greater than our number of ports, bail. */
-	if (PORT_NUM(minor) > brd->nasync) {
+	if (PORT_NUM(minor) >= brd->nasync) {
 		spin_unlock_irqrestore(&brd->bd_lock, flags);
 		return -ENXIO;
 	}
