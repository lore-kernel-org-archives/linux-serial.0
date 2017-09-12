From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v2 1/2] mxser: fix timeout calculation for low rates
Date: Tue, 12 Sep 2017 12:39:54 +0200
Message-ID: <20170912103955.25826-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Paul <Paul@abelian.netcom.co.uk>
List-Id: linux-serial@vger.kernel.org

Paul reported, that low rates like B300 make the driver to hang in
mxser_wait_until_sent. His debugging tackled the issue down to the
info->timeout computation in mxser_set_baud. Obviously, ints are used
there and they easily overflow with these low rates: B300 makes
info->timeout to be -373.

So switch all these types to unsigned as it ought to be. And use the u64
domain to perform the computation as in the worst case, we need 35 bits
to store the computed value (before division).

And use do_div not to break 32 bit kernels.

[v2] make it actually build

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Paul <Paul@abelian.netcom.co.uk>
Tested-by: <Paul@abelian.netcom.co.uk>
---
 drivers/tty/mxser.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 816681d6ec98..2e61a2d0d7cb 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -246,11 +246,11 @@ struct mxser_port {
 	unsigned char err_shadow;
 
 	struct async_icount icount; /* kernel counters for 4 input interrupts */
-	int timeout;
+	unsigned int timeout;
 
 	int read_status_mask;
 	int ignore_status_mask;
-	int xmit_fifo_size;
+	unsigned int xmit_fifo_size;
 	int xmit_head;
 	int xmit_tail;
 	int xmit_cnt;
@@ -572,8 +572,9 @@ static void mxser_dtr_rts(struct tty_port *port, int on)
 static int mxser_set_baud(struct tty_struct *tty, long newspd)
 {
 	struct mxser_port *info = tty->driver_data;
-	int quot = 0, baud;
+	unsigned int quot = 0, baud;
 	unsigned char cval;
+	u64 timeout;
 
 	if (!info->ioaddr)
 		return -1;
@@ -594,8 +595,13 @@ static int mxser_set_baud(struct tty_struct *tty, long newspd)
 		quot = 0;
 	}
 
-	info->timeout = ((info->xmit_fifo_size * HZ * 10 * quot) / info->baud_base);
-	info->timeout += HZ / 50;	/* Add .02 seconds of slop */
+	/*
+	 * worst case (128 * 1000 * 10 * 18432) needs 35 bits, so divide in the
+	 * u64 domain
+	 */
+	timeout = (u64)info->xmit_fifo_size * HZ * 10 * quot;
+	do_div(timeout, info->baud_base);
+	info->timeout = timeout + HZ / 50; /* Add .02 seconds of slop */
 
 	if (quot) {
 		info->MCR |= UART_MCR_DTR;
-- 
2.14.1
