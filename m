From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 49/75] tty: Remove some pointless casts
Date: Fri, 02 Jan 2009 13:47:26 +0000
Message-ID: <20090102134725.13472.2664.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37621 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757790AbZABNrS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:47:18 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

disc_data and driver_data are void *

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/amiserial.c      |   34 +++++++++++++++++-----------------
 drivers/char/epca.c           |   10 +++++-----
 drivers/char/generic_serial.c |    2 +-
 drivers/char/hvsi.c           |   12 ++++++------
 drivers/char/n_r3964.c        |   12 ++++++------
 drivers/char/riscom8.c        |   34 +++++++++++++++++-----------------
 drivers/char/rocket.c         |   36 ++++++++++++++++++------------------
 drivers/char/selection.c      |    2 +-
 drivers/char/ser_a2232.c      |    4 ++--
 drivers/char/serial167.c      |   32 ++++++++++++++++----------------
 drivers/char/specialix.c      |   34 +++++++++++++++++-----------------
 drivers/char/sx.c             |    4 ++--
 drivers/char/synclink.c       |   36 ++++++++++++++++++------------------
 drivers/char/synclinkmp.c     |   38 +++++++++++++++++++-------------------
 drivers/char/vme_scc.c        |    8 ++++----
 drivers/char/vt_ioctl.c       |    2 +-
 16 files changed, 150 insertions(+), 150 deletions(-)


diff --git a/drivers/char/amiserial.c b/drivers/char/amiserial.c
index b97aebd..4e0cfde 100644
--- a/drivers/char/amiserial.c
+++ b/drivers/char/amiserial.c
@@ -170,7 +170,7 @@ static __inline__ void rtsdtr_ctrl(int bits)
  */
 static void rs_stop(struct tty_struct *tty)
 {
-	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	struct async_struct *info = tty->driver_data;
 	unsigned long flags;
 
 	if (serial_paranoia_check(info, tty->name, "rs_stop"))
@@ -190,7 +190,7 @@ static void rs_stop(struct tty_struct *tty)
 
 static void rs_start(struct tty_struct *tty)
 {
-	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	struct async_struct *info = tty->driver_data;
 	unsigned long flags;
 
 	if (serial_paranoia_check(info, tty->name, "rs_start"))
@@ -861,7 +861,7 @@ static int rs_put_char(struct tty_struct *tty, unsigned char ch)
 
 static void rs_flush_chars(struct tty_struct *tty)
 {
-	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	struct async_struct *info = tty->driver_data;
 	unsigned long flags;
 
 	if (serial_paranoia_check(info, tty->name, "rs_flush_chars"))
@@ -934,7 +934,7 @@ static int rs_write(struct tty_struct * tty, const unsigned char *buf, int count
 
 static int rs_write_room(struct tty_struct *tty)
 {
-	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	struct async_struct *info = tty->driver_data;
 
 	if (serial_paranoia_check(info, tty->name, "rs_write_room"))
 		return 0;
@@ -943,7 +943,7 @@ static int rs_write_room(struct tty_struct *tty)
 
 static int rs_chars_in_buffer(struct tty_struct *tty)
 {
-	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	struct async_struct *info = tty->driver_data;
 
 	if (serial_paranoia_check(info, tty->name, "rs_chars_in_buffer"))
 		return 0;
@@ -952,7 +952,7 @@ static int rs_chars_in_buffer(struct tty_struct *tty)
 
 static void rs_flush_buffer(struct tty_struct *tty)
 {
-	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	struct async_struct *info = tty->driver_data;
 	unsigned long flags;
 
 	if (serial_paranoia_check(info, tty->name, "rs_flush_buffer"))
@@ -969,7 +969,7 @@ static void rs_flush_buffer(struct tty_struct *tty)
  */
 static void rs_send_xchar(struct tty_struct *tty, char ch)
 {
-	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	struct async_struct *info = tty->driver_data;
         unsigned long flags;
 
 	if (serial_paranoia_check(info, tty->name, "rs_send_char"))
@@ -1004,7 +1004,7 @@ static void rs_send_xchar(struct tty_struct *tty, char ch)
  */
 static void rs_throttle(struct tty_struct * tty)
 {
-	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	struct async_struct *info = tty->driver_data;
 	unsigned long flags;
 #ifdef SERIAL_DEBUG_THROTTLE
 	char	buf[64];
@@ -1029,7 +1029,7 @@ static void rs_throttle(struct tty_struct * tty)
 
 static void rs_unthrottle(struct tty_struct * tty)
 {
-	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	struct async_struct *info = tty->driver_data;
 	unsigned long flags;
 #ifdef SERIAL_DEBUG_THROTTLE
 	char	buf[64];
@@ -1194,7 +1194,7 @@ static int get_lsr_info(struct async_struct * info, unsigned int __user *value)
 
 static int rs_tiocmget(struct tty_struct *tty, struct file *file)
 {
-	struct async_struct * info = (struct async_struct *)tty->driver_data;
+	struct async_struct * info = tty->driver_data;
 	unsigned char control, status;
 	unsigned long flags;
 
@@ -1217,7 +1217,7 @@ static int rs_tiocmget(struct tty_struct *tty, struct file *file)
 static int rs_tiocmset(struct tty_struct *tty, struct file *file,
 		       unsigned int set, unsigned int clear)
 {
-	struct async_struct * info = (struct async_struct *)tty->driver_data;
+	struct async_struct * info = tty->driver_data;
 	unsigned long flags;
 
 	if (serial_paranoia_check(info, tty->name, "rs_ioctl"))
@@ -1244,7 +1244,7 @@ static int rs_tiocmset(struct tty_struct *tty, struct file *file,
  */
 static int rs_break(struct tty_struct *tty, int break_state)
 {
-	struct async_struct * info = (struct async_struct *)tty->driver_data;
+	struct async_struct * info = tty->driver_data;
 	unsigned long flags;
 
 	if (serial_paranoia_check(info, tty->name, "rs_break"))
@@ -1264,7 +1264,7 @@ static int rs_break(struct tty_struct *tty, int break_state)
 static int rs_ioctl(struct tty_struct *tty, struct file * file,
 		    unsigned int cmd, unsigned long arg)
 {
-	struct async_struct * info = (struct async_struct *)tty->driver_data;
+	struct async_struct * info = tty->driver_data;
 	struct async_icount cprev, cnow;	/* kernel counter temps */
 	struct serial_icounter_struct icount;
 	void __user *argp = (void __user *)arg;
@@ -1368,7 +1368,7 @@ static int rs_ioctl(struct tty_struct *tty, struct file * file,
 
 static void rs_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 {
-	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	struct async_struct *info = tty->driver_data;
 	unsigned long flags;
 	unsigned int cflag = tty->termios->c_cflag;
 
@@ -1428,7 +1428,7 @@ static void rs_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
  */
 static void rs_close(struct tty_struct *tty, struct file * filp)
 {
-	struct async_struct * info = (struct async_struct *)tty->driver_data;
+	struct async_struct * info = tty->driver_data;
 	struct serial_state *state;
 	unsigned long flags;
 
@@ -1523,7 +1523,7 @@ static void rs_close(struct tty_struct *tty, struct file * filp)
  */
 static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
 {
-	struct async_struct * info = (struct async_struct *)tty->driver_data;
+	struct async_struct * info = tty->driver_data;
 	unsigned long orig_jiffies, char_time;
 	int lsr;
 
@@ -1587,7 +1587,7 @@ static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
  */
 static void rs_hangup(struct tty_struct *tty)
 {
-	struct async_struct * info = (struct async_struct *)tty->driver_data;
+	struct async_struct * info = tty->driver_data;
 	struct serial_state *state = info->state;
 
 	if (serial_paranoia_check(info, tty->name, "rs_hangup"))
diff --git a/drivers/char/epca.c b/drivers/char/epca.c
index cf2461d..da2d2cf 100644
--- a/drivers/char/epca.c
+++ b/drivers/char/epca.c
@@ -392,7 +392,7 @@ static struct channel *verifyChannel(struct tty_struct *tty)
 	 * through tty->driver_data this should catch it.
 	 */
 	if (tty) {
-		struct channel *ch = (struct channel *)tty->driver_data;
+		struct channel *ch = tty->driver_data;
 		if (ch >= &digi_channels[0] && ch < &digi_channels[nbdevs]) {
 			if (ch->magic == EPCA_MAGIC)
 				return ch;
@@ -2097,7 +2097,7 @@ static int info_ioctl(struct tty_struct *tty, struct file *file,
 
 static int pc_tiocmget(struct tty_struct *tty, struct file *file)
 {
-	struct channel *ch = (struct channel *) tty->driver_data;
+	struct channel *ch = tty->driver_data;
 	struct board_chan __iomem *bc;
 	unsigned int mstat, mflag = 0;
 	unsigned long flags;
@@ -2131,7 +2131,7 @@ static int pc_tiocmget(struct tty_struct *tty, struct file *file)
 static int pc_tiocmset(struct tty_struct *tty, struct file *file,
 		       unsigned int set, unsigned int clear)
 {
-	struct channel *ch = (struct channel *) tty->driver_data;
+	struct channel *ch = tty->driver_data;
 	unsigned long flags;
 
 	if (!ch)
@@ -2178,7 +2178,7 @@ static int pc_ioctl(struct tty_struct *tty, struct file *file,
 	unsigned int mflag, mstat;
 	unsigned char startc, stopc;
 	struct board_chan __iomem *bc;
-	struct channel *ch = (struct channel *) tty->driver_data;
+	struct channel *ch = tty->driver_data;
 	void __user *argp = (void __user *)arg;
 
 	if (ch)
@@ -2473,7 +2473,7 @@ static void pc_unthrottle(struct tty_struct *tty)
 
 static int pc_send_break(struct tty_struct *tty, int msec)
 {
-	struct channel *ch = (struct channel *) tty->driver_data;
+	struct channel *ch = tty->driver_data;
 	unsigned long flags;
 
 	if (msec == -1)
diff --git a/drivers/char/generic_serial.c b/drivers/char/generic_serial.c
index 2f040d1..9e4e569 100644
--- a/drivers/char/generic_serial.c
+++ b/drivers/char/generic_serial.c
@@ -511,7 +511,7 @@ void gs_close(struct tty_struct * tty, struct file * filp)
 	
 	func_enter ();
 
-	port = (struct gs_port *) tty->driver_data;
+	port = tty->driver_data;
 
 	if (!port) return;
 
diff --git a/drivers/char/hvsi.c b/drivers/char/hvsi.c
index af05528..406f874 100644
--- a/drivers/char/hvsi.c
+++ b/drivers/char/hvsi.c
@@ -997,14 +997,14 @@ out:
 
 static int hvsi_write_room(struct tty_struct *tty)
 {
-	struct hvsi_struct *hp = (struct hvsi_struct *)tty->driver_data;
+	struct hvsi_struct *hp = tty->driver_data;
 
 	return N_OUTBUF - hp->n_outbuf;
 }
 
 static int hvsi_chars_in_buffer(struct tty_struct *tty)
 {
-	struct hvsi_struct *hp = (struct hvsi_struct *)tty->driver_data;
+	struct hvsi_struct *hp = tty->driver_data;
 
 	return hp->n_outbuf;
 }
@@ -1070,7 +1070,7 @@ out:
  */
 static void hvsi_throttle(struct tty_struct *tty)
 {
-	struct hvsi_struct *hp = (struct hvsi_struct *)tty->driver_data;
+	struct hvsi_struct *hp = tty->driver_data;
 
 	pr_debug("%s\n", __func__);
 
@@ -1079,7 +1079,7 @@ static void hvsi_throttle(struct tty_struct *tty)
 
 static void hvsi_unthrottle(struct tty_struct *tty)
 {
-	struct hvsi_struct *hp = (struct hvsi_struct *)tty->driver_data;
+	struct hvsi_struct *hp = tty->driver_data;
 	unsigned long flags;
 	int shouldflip = 0;
 
@@ -1100,7 +1100,7 @@ static void hvsi_unthrottle(struct tty_struct *tty)
 
 static int hvsi_tiocmget(struct tty_struct *tty, struct file *file)
 {
-	struct hvsi_struct *hp = (struct hvsi_struct *)tty->driver_data;
+	struct hvsi_struct *hp = tty->driver_data;
 
 	hvsi_get_mctrl(hp);
 	return hp->mctrl;
@@ -1109,7 +1109,7 @@ static int hvsi_tiocmget(struct tty_struct *tty, struct file *file)
 static int hvsi_tiocmset(struct tty_struct *tty, struct file *file,
 		unsigned int set, unsigned int clear)
 {
-	struct hvsi_struct *hp = (struct hvsi_struct *)tty->driver_data;
+	struct hvsi_struct *hp = tty->driver_data;
 	unsigned long flags;
 	uint16_t new_mctrl;
 
diff --git a/drivers/char/n_r3964.c b/drivers/char/n_r3964.c
index 4a8215a..d2e93e3 100644
--- a/drivers/char/n_r3964.c
+++ b/drivers/char/n_r3964.c
@@ -1003,7 +1003,7 @@ static int r3964_open(struct tty_struct *tty)
 
 static void r3964_close(struct tty_struct *tty)
 {
-	struct r3964_info *pInfo = (struct r3964_info *)tty->disc_data;
+	struct r3964_info *pInfo = tty->disc_data;
 	struct r3964_client_info *pClient, *pNext;
 	struct r3964_message *pMsg;
 	struct r3964_block_header *pHeader, *pNextHeader;
@@ -1058,7 +1058,7 @@ static void r3964_close(struct tty_struct *tty)
 static ssize_t r3964_read(struct tty_struct *tty, struct file *file,
 			  unsigned char __user * buf, size_t nr)
 {
-	struct r3964_info *pInfo = (struct r3964_info *)tty->disc_data;
+	struct r3964_info *pInfo = tty->disc_data;
 	struct r3964_client_info *pClient;
 	struct r3964_message *pMsg;
 	struct r3964_client_message theMsg;
@@ -1113,7 +1113,7 @@ static ssize_t r3964_read(struct tty_struct *tty, struct file *file,
 static ssize_t r3964_write(struct tty_struct *tty, struct file *file,
 			   const unsigned char *data, size_t count)
 {
-	struct r3964_info *pInfo = (struct r3964_info *)tty->disc_data;
+	struct r3964_info *pInfo = tty->disc_data;
 	struct r3964_block_header *pHeader;
 	struct r3964_client_info *pClient;
 	unsigned char *new_data;
@@ -1182,7 +1182,7 @@ static ssize_t r3964_write(struct tty_struct *tty, struct file *file,
 static int r3964_ioctl(struct tty_struct *tty, struct file *file,
 		unsigned int cmd, unsigned long arg)
 {
-	struct r3964_info *pInfo = (struct r3964_info *)tty->disc_data;
+	struct r3964_info *pInfo = tty->disc_data;
 	if (pInfo == NULL)
 		return -EINVAL;
 	switch (cmd) {
@@ -1216,7 +1216,7 @@ static void r3964_set_termios(struct tty_struct *tty, struct ktermios *old)
 static unsigned int r3964_poll(struct tty_struct *tty, struct file *file,
 			struct poll_table_struct *wait)
 {
-	struct r3964_info *pInfo = (struct r3964_info *)tty->disc_data;
+	struct r3964_info *pInfo = tty->disc_data;
 	struct r3964_client_info *pClient;
 	struct r3964_message *pMsg = NULL;
 	unsigned long flags;
@@ -1241,7 +1241,7 @@ static unsigned int r3964_poll(struct tty_struct *tty, struct file *file,
 static void r3964_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			char *fp, int count)
 {
-	struct r3964_info *pInfo = (struct r3964_info *)tty->disc_data;
+	struct r3964_info *pInfo = tty->disc_data;
 	const unsigned char *p;
 	char *f, flags = 0;
 	int i;
diff --git a/drivers/char/riscom8.c b/drivers/char/riscom8.c
index 9ac5feb..9af8d74 100644
--- a/drivers/char/riscom8.c
+++ b/drivers/char/riscom8.c
@@ -906,7 +906,7 @@ static int rc_open(struct tty_struct *tty, struct file *filp)
 
 static void rc_flush_buffer(struct tty_struct *tty)
 {
-	struct riscom_port *port = (struct riscom_port *)tty->driver_data;
+	struct riscom_port *port = tty->driver_data;
 	unsigned long flags;
 
 	if (rc_paranoia_check(port, tty->name, "rc_flush_buffer"))
@@ -921,7 +921,7 @@ static void rc_flush_buffer(struct tty_struct *tty)
 
 static void rc_close(struct tty_struct *tty, struct file *filp)
 {
-	struct riscom_port *port = (struct riscom_port *) tty->driver_data;
+	struct riscom_port *port = tty->driver_data;
 	struct riscom_board *bp;
 	unsigned long flags;
 	unsigned long timeout;
@@ -972,7 +972,7 @@ static void rc_close(struct tty_struct *tty, struct file *filp)
 static int rc_write(struct tty_struct *tty,
 		    const unsigned char *buf, int count)
 {
-	struct riscom_port *port = (struct riscom_port *)tty->driver_data;
+	struct riscom_port *port = tty->driver_data;
 	struct riscom_board *bp;
 	int c, total = 0;
 	unsigned long flags;
@@ -1015,7 +1015,7 @@ static int rc_write(struct tty_struct *tty,
 
 static int rc_put_char(struct tty_struct *tty, unsigned char ch)
 {
-	struct riscom_port *port = (struct riscom_port *)tty->driver_data;
+	struct riscom_port *port = tty->driver_data;
 	unsigned long flags;
 	int ret = 0;
 
@@ -1039,7 +1039,7 @@ out:
 
 static void rc_flush_chars(struct tty_struct *tty)
 {
-	struct riscom_port *port = (struct riscom_port *)tty->driver_data;
+	struct riscom_port *port = tty->driver_data;
 	unsigned long flags;
 
 	if (rc_paranoia_check(port, tty->name, "rc_flush_chars"))
@@ -1059,7 +1059,7 @@ static void rc_flush_chars(struct tty_struct *tty)
 
 static int rc_write_room(struct tty_struct *tty)
 {
-	struct riscom_port *port = (struct riscom_port *)tty->driver_data;
+	struct riscom_port *port = tty->driver_data;
 	int	ret;
 
 	if (rc_paranoia_check(port, tty->name, "rc_write_room"))
@@ -1073,7 +1073,7 @@ static int rc_write_room(struct tty_struct *tty)
 
 static int rc_chars_in_buffer(struct tty_struct *tty)
 {
-	struct riscom_port *port = (struct riscom_port *)tty->driver_data;
+	struct riscom_port *port = tty->driver_data;
 
 	if (rc_paranoia_check(port, tty->name, "rc_chars_in_buffer"))
 		return 0;
@@ -1083,7 +1083,7 @@ static int rc_chars_in_buffer(struct tty_struct *tty)
 
 static int rc_tiocmget(struct tty_struct *tty, struct file *file)
 {
-	struct riscom_port *port = (struct riscom_port *)tty->driver_data;
+	struct riscom_port *port = tty->driver_data;
 	struct riscom_board *bp;
 	unsigned char status;
 	unsigned int result;
@@ -1113,7 +1113,7 @@ static int rc_tiocmget(struct tty_struct *tty, struct file *file)
 static int rc_tiocmset(struct tty_struct *tty, struct file *file,
 		       unsigned int set, unsigned int clear)
 {
-	struct riscom_port *port = (struct riscom_port *)tty->driver_data;
+	struct riscom_port *port = tty->driver_data;
 	unsigned long flags;
 	struct riscom_board *bp;
 
@@ -1145,7 +1145,7 @@ static int rc_tiocmset(struct tty_struct *tty, struct file *file,
 
 static int rc_send_break(struct tty_struct *tty, int length)
 {
-	struct riscom_port *port = (struct riscom_port *)tty->driver_data;
+	struct riscom_port *port = tty->driver_data;
 	struct riscom_board *bp = port_Board(port);
 	unsigned long flags;
 
@@ -1238,7 +1238,7 @@ static int rc_get_serial_info(struct riscom_port *port,
 static int rc_ioctl(struct tty_struct *tty, struct file *filp,
 		    unsigned int cmd, unsigned long arg)
 {
-	struct riscom_port *port = (struct riscom_port *)tty->driver_data;
+	struct riscom_port *port = tty->driver_data;
 	void __user *argp = (void __user *)arg;
 	int retval;
 
@@ -1264,7 +1264,7 @@ static int rc_ioctl(struct tty_struct *tty, struct file *filp,
 
 static void rc_throttle(struct tty_struct *tty)
 {
-	struct riscom_port *port = (struct riscom_port *)tty->driver_data;
+	struct riscom_port *port = tty->driver_data;
 	struct riscom_board *bp;
 	unsigned long flags;
 
@@ -1286,7 +1286,7 @@ static void rc_throttle(struct tty_struct *tty)
 
 static void rc_unthrottle(struct tty_struct *tty)
 {
-	struct riscom_port *port = (struct riscom_port *)tty->driver_data;
+	struct riscom_port *port = tty->driver_data;
 	struct riscom_board *bp;
 	unsigned long flags;
 
@@ -1308,7 +1308,7 @@ static void rc_unthrottle(struct tty_struct *tty)
 
 static void rc_stop(struct tty_struct *tty)
 {
-	struct riscom_port *port = (struct riscom_port *)tty->driver_data;
+	struct riscom_port *port = tty->driver_data;
 	struct riscom_board *bp;
 	unsigned long flags;
 
@@ -1326,7 +1326,7 @@ static void rc_stop(struct tty_struct *tty)
 
 static void rc_start(struct tty_struct *tty)
 {
-	struct riscom_port *port = (struct riscom_port *)tty->driver_data;
+	struct riscom_port *port = tty->driver_data;
 	struct riscom_board *bp;
 	unsigned long flags;
 
@@ -1347,7 +1347,7 @@ static void rc_start(struct tty_struct *tty)
 
 static void rc_hangup(struct tty_struct *tty)
 {
-	struct riscom_port *port = (struct riscom_port *)tty->driver_data;
+	struct riscom_port *port = tty->driver_data;
 	struct riscom_board *bp;
 	unsigned long flags;
 
@@ -1368,7 +1368,7 @@ static void rc_hangup(struct tty_struct *tty)
 static void rc_set_termios(struct tty_struct *tty,
 					struct ktermios *old_termios)
 {
-	struct riscom_port *port = (struct riscom_port *)tty->driver_data;
+	struct riscom_port *port = tty->driver_data;
 	unsigned long flags;
 
 	if (rc_paranoia_check(port, tty->name, "rc_set_termios"))
diff --git a/drivers/char/rocket.c b/drivers/char/rocket.c
index 9d81980..1e68cc2 100644
--- a/drivers/char/rocket.c
+++ b/drivers/char/rocket.c
@@ -1094,7 +1094,7 @@ static int rp_open(struct tty_struct *tty, struct file *filp)
  */
 static void rp_close(struct tty_struct *tty, struct file *filp)
 {
-	struct r_port *info = (struct r_port *) tty->driver_data;
+	struct r_port *info = tty->driver_data;
 	unsigned long flags;
 	int timeout;
 	CHANNEL_t *cp;
@@ -1208,7 +1208,7 @@ static void rp_close(struct tty_struct *tty, struct file *filp)
 static void rp_set_termios(struct tty_struct *tty,
 			   struct ktermios *old_termios)
 {
-	struct r_port *info = (struct r_port *) tty->driver_data;
+	struct r_port *info = tty->driver_data;
 	CHANNEL_t *cp;
 	unsigned cflag;
 
@@ -1251,7 +1251,7 @@ static void rp_set_termios(struct tty_struct *tty,
 
 static int rp_break(struct tty_struct *tty, int break_state)
 {
-	struct r_port *info = (struct r_port *) tty->driver_data;
+	struct r_port *info = tty->driver_data;
 	unsigned long flags;
 
 	if (rocket_paranoia_check(info, "rp_break"))
@@ -1297,7 +1297,7 @@ static int sGetChanRI(CHANNEL_T * ChP)
  */
 static int rp_tiocmget(struct tty_struct *tty, struct file *file)
 {
-	struct r_port *info = (struct r_port *)tty->driver_data;
+	struct r_port *info = tty->driver_data;
 	unsigned int control, result, ChanStatus;
 
 	ChanStatus = sGetChanStatusLo(&info->channel);
@@ -1318,7 +1318,7 @@ static int rp_tiocmget(struct tty_struct *tty, struct file *file)
 static int rp_tiocmset(struct tty_struct *tty, struct file *file,
 		    unsigned int set, unsigned int clear)
 {
-	struct r_port *info = (struct r_port *)tty->driver_data;
+	struct r_port *info = tty->driver_data;
 
 	if (set & TIOCM_RTS)
 		info->channel.TxControl[3] |= SET_RTS;
@@ -1447,7 +1447,7 @@ static int get_version(struct r_port *info, struct rocket_version __user *retver
 static int rp_ioctl(struct tty_struct *tty, struct file *file,
 		    unsigned int cmd, unsigned long arg)
 {
-	struct r_port *info = (struct r_port *) tty->driver_data;
+	struct r_port *info = tty->driver_data;
 	void __user *argp = (void __user *)arg;
 	int ret = 0;
 
@@ -1485,7 +1485,7 @@ static int rp_ioctl(struct tty_struct *tty, struct file *file,
 
 static void rp_send_xchar(struct tty_struct *tty, char ch)
 {
-	struct r_port *info = (struct r_port *) tty->driver_data;
+	struct r_port *info = tty->driver_data;
 	CHANNEL_t *cp;
 
 	if (rocket_paranoia_check(info, "rp_send_xchar"))
@@ -1500,7 +1500,7 @@ static void rp_send_xchar(struct tty_struct *tty, char ch)
 
 static void rp_throttle(struct tty_struct *tty)
 {
-	struct r_port *info = (struct r_port *) tty->driver_data;
+	struct r_port *info = tty->driver_data;
 	CHANNEL_t *cp;
 
 #ifdef ROCKET_DEBUG_THROTTLE
@@ -1520,7 +1520,7 @@ static void rp_throttle(struct tty_struct *tty)
 
 static void rp_unthrottle(struct tty_struct *tty)
 {
-	struct r_port *info = (struct r_port *) tty->driver_data;
+	struct r_port *info = tty->driver_data;
 	CHANNEL_t *cp;
 #ifdef ROCKET_DEBUG_THROTTLE
 	printk(KERN_INFO "unthrottle %s: %d....\n", tty->name,
@@ -1547,7 +1547,7 @@ static void rp_unthrottle(struct tty_struct *tty)
  */
 static void rp_stop(struct tty_struct *tty)
 {
-	struct r_port *info = (struct r_port *) tty->driver_data;
+	struct r_port *info = tty->driver_data;
 
 #ifdef ROCKET_DEBUG_FLOW
 	printk(KERN_INFO "stop %s: %d %d....\n", tty->name,
@@ -1563,7 +1563,7 @@ static void rp_stop(struct tty_struct *tty)
 
 static void rp_start(struct tty_struct *tty)
 {
-	struct r_port *info = (struct r_port *) tty->driver_data;
+	struct r_port *info = tty->driver_data;
 
 #ifdef ROCKET_DEBUG_FLOW
 	printk(KERN_INFO "start %s: %d %d....\n", tty->name,
@@ -1583,7 +1583,7 @@ static void rp_start(struct tty_struct *tty)
  */
 static void rp_wait_until_sent(struct tty_struct *tty, int timeout)
 {
-	struct r_port *info = (struct r_port *) tty->driver_data;
+	struct r_port *info = tty->driver_data;
 	CHANNEL_t *cp;
 	unsigned long orig_jiffies;
 	int check_time, exit_time;
@@ -1640,7 +1640,7 @@ static void rp_wait_until_sent(struct tty_struct *tty, int timeout)
 static void rp_hangup(struct tty_struct *tty)
 {
 	CHANNEL_t *cp;
-	struct r_port *info = (struct r_port *) tty->driver_data;
+	struct r_port *info = tty->driver_data;
 
 	if (rocket_paranoia_check(info, "rp_hangup"))
 		return;
@@ -1680,7 +1680,7 @@ static void rp_hangup(struct tty_struct *tty)
  */
 static int rp_put_char(struct tty_struct *tty, unsigned char ch)
 {
-	struct r_port *info = (struct r_port *) tty->driver_data;
+	struct r_port *info = tty->driver_data;
 	CHANNEL_t *cp;
 	unsigned long flags;
 
@@ -1727,7 +1727,7 @@ static int rp_put_char(struct tty_struct *tty, unsigned char ch)
 static int rp_write(struct tty_struct *tty,
 		    const unsigned char *buf, int count)
 {
-	struct r_port *info = (struct r_port *) tty->driver_data;
+	struct r_port *info = tty->driver_data;
 	CHANNEL_t *cp;
 	const unsigned char *b;
 	int c, retval = 0;
@@ -1819,7 +1819,7 @@ end:
  */
 static int rp_write_room(struct tty_struct *tty)
 {
-	struct r_port *info = (struct r_port *) tty->driver_data;
+	struct r_port *info = tty->driver_data;
 	int ret;
 
 	if (rocket_paranoia_check(info, "rp_write_room"))
@@ -1840,7 +1840,7 @@ static int rp_write_room(struct tty_struct *tty)
  */
 static int rp_chars_in_buffer(struct tty_struct *tty)
 {
-	struct r_port *info = (struct r_port *) tty->driver_data;
+	struct r_port *info = tty->driver_data;
 	CHANNEL_t *cp;
 
 	if (rocket_paranoia_check(info, "rp_chars_in_buffer"))
@@ -1861,7 +1861,7 @@ static int rp_chars_in_buffer(struct tty_struct *tty)
  */
 static void rp_flush_buffer(struct tty_struct *tty)
 {
-	struct r_port *info = (struct r_port *) tty->driver_data;
+	struct r_port *info = tty->driver_data;
 	CHANNEL_t *cp;
 	unsigned long flags;
 
diff --git a/drivers/char/selection.c b/drivers/char/selection.c
index 2978a49..f29fbe9 100644
--- a/drivers/char/selection.c
+++ b/drivers/char/selection.c
@@ -306,7 +306,7 @@ int set_selection(const struct tiocl_selection __user *sel, struct tty_struct *t
  */
 int paste_selection(struct tty_struct *tty)
 {
-	struct vc_data *vc = (struct vc_data *)tty->driver_data;
+	struct vc_data *vc = tty->driver_data;
 	int	pasted = 0;
 	unsigned int count;
 	struct  tty_ldisc *ld;
diff --git a/drivers/char/ser_a2232.c b/drivers/char/ser_a2232.c
index 0c97f34..33872a2 100644
--- a/drivers/char/ser_a2232.c
+++ b/drivers/char/ser_a2232.c
@@ -460,14 +460,14 @@ static void a2232_throttle(struct tty_struct *tty)
    if switched on. So the only thing we can do at this
    layer here is not taking any characters out of the
    A2232 buffer any more. */
-	struct a2232_port *port = (struct a2232_port *) tty->driver_data;
+	struct a2232_port *port = tty->driver_data;
 	port->throttle_input = -1;
 }
 
 static void a2232_unthrottle(struct tty_struct *tty)
 {
 /* Unthrottle: dual to "throttle()" above. */
-	struct a2232_port *port = (struct a2232_port *) tty->driver_data;
+	struct a2232_port *port = tty->driver_data;
 	port->throttle_input = 0;
 }
 
diff --git a/drivers/char/serial167.c b/drivers/char/serial167.c
index a8f15e6..f1f24f0 100644
--- a/drivers/char/serial167.c
+++ b/drivers/char/serial167.c
@@ -315,7 +315,7 @@ u_short write_cy_cmd(volatile u_char * base_addr, u_char cmd)
 
 static void cy_stop(struct tty_struct *tty)
 {
-	struct cyclades_port *info = (struct cyclades_port *)tty->driver_data;
+	struct cyclades_port *info = tty->driver_data;
 	volatile unsigned char *base_addr = (unsigned char *)BASE_ADDR;
 	int channel;
 	unsigned long flags;
@@ -337,7 +337,7 @@ static void cy_stop(struct tty_struct *tty)
 
 static void cy_start(struct tty_struct *tty)
 {
-	struct cyclades_port *info = (struct cyclades_port *)tty->driver_data;
+	struct cyclades_port *info = tty->driver_data;
 	volatile unsigned char *base_addr = (unsigned char *)BASE_ADDR;
 	int channel;
 	unsigned long flags;
@@ -1062,7 +1062,7 @@ static void config_setup(struct cyclades_port *info)
 
 static int cy_put_char(struct tty_struct *tty, unsigned char ch)
 {
-	struct cyclades_port *info = (struct cyclades_port *)tty->driver_data;
+	struct cyclades_port *info = tty->driver_data;
 	unsigned long flags;
 
 #ifdef SERIAL_DEBUG_IO
@@ -1090,7 +1090,7 @@ static int cy_put_char(struct tty_struct *tty, unsigned char ch)
 
 static void cy_flush_chars(struct tty_struct *tty)
 {
-	struct cyclades_port *info = (struct cyclades_port *)tty->driver_data;
+	struct cyclades_port *info = tty->driver_data;
 	unsigned long flags;
 	volatile unsigned char *base_addr = (u_char *) BASE_ADDR;
 	int channel;
@@ -1122,7 +1122,7 @@ static void cy_flush_chars(struct tty_struct *tty)
  */
 static int cy_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
-	struct cyclades_port *info = (struct cyclades_port *)tty->driver_data;
+	struct cyclades_port *info = tty->driver_data;
 	unsigned long flags;
 	int c, total = 0;
 
@@ -1166,7 +1166,7 @@ static int cy_write(struct tty_struct *tty, const unsigned char *buf, int count)
 
 static int cy_write_room(struct tty_struct *tty)
 {
-	struct cyclades_port *info = (struct cyclades_port *)tty->driver_data;
+	struct cyclades_port *info = tty->driver_data;
 	int ret;
 
 #ifdef SERIAL_DEBUG_IO
@@ -1183,7 +1183,7 @@ static int cy_write_room(struct tty_struct *tty)
 
 static int cy_chars_in_buffer(struct tty_struct *tty)
 {
-	struct cyclades_port *info = (struct cyclades_port *)tty->driver_data;
+	struct cyclades_port *info = tty->driver_data;
 
 #ifdef SERIAL_DEBUG_IO
 	printk("cy_chars_in_buffer %s %d\n", tty->name, info->xmit_cnt);	/* */
@@ -1197,7 +1197,7 @@ static int cy_chars_in_buffer(struct tty_struct *tty)
 
 static void cy_flush_buffer(struct tty_struct *tty)
 {
-	struct cyclades_port *info = (struct cyclades_port *)tty->driver_data;
+	struct cyclades_port *info = tty->driver_data;
 	unsigned long flags;
 
 #ifdef SERIAL_DEBUG_IO
@@ -1218,7 +1218,7 @@ static void cy_flush_buffer(struct tty_struct *tty)
  */
 static void cy_throttle(struct tty_struct *tty)
 {
-	struct cyclades_port *info = (struct cyclades_port *)tty->driver_data;
+	struct cyclades_port *info = tty->driver_data;
 	unsigned long flags;
 	volatile unsigned char *base_addr = (u_char *) BASE_ADDR;
 	int channel;
@@ -1250,7 +1250,7 @@ static void cy_throttle(struct tty_struct *tty)
 
 static void cy_unthrottle(struct tty_struct *tty)
 {
-	struct cyclades_port *info = (struct cyclades_port *)tty->driver_data;
+	struct cyclades_port *info = tty->driver_data;
 	unsigned long flags;
 	volatile unsigned char *base_addr = (u_char *) BASE_ADDR;
 	int channel;
@@ -1345,7 +1345,7 @@ check_and_exit:
 
 static int cy_tiocmget(struct tty_struct *tty, struct file *file)
 {
-	struct cyclades_port *info = (struct cyclades_port *)tty->driver_data;
+	struct cyclades_port *info = tty->driver_data;
 	int channel;
 	volatile unsigned char *base_addr = (u_char *) BASE_ADDR;
 	unsigned long flags;
@@ -1369,7 +1369,7 @@ static int
 cy_tiocmset(struct tty_struct *tty, struct file *file,
 	    unsigned int set, unsigned int clear)
 {
-	struct cyclades_port *info = (struct cyclades_port *)tty->driver_data;
+	struct cyclades_port *info = tty->driver_data;
 	int channel;
 	volatile unsigned char *base_addr = (u_char *) BASE_ADDR;
 	unsigned long flags;
@@ -1532,7 +1532,7 @@ cy_ioctl(struct tty_struct *tty, struct file *file,
 	 unsigned int cmd, unsigned long arg)
 {
 	unsigned long val;
-	struct cyclades_port *info = (struct cyclades_port *)tty->driver_data;
+	struct cyclades_port *info = tty->driver_data;
 	int ret_val = 0;
 	void __user *argp = (void __user *)arg;
 
@@ -1607,7 +1607,7 @@ cy_ioctl(struct tty_struct *tty, struct file *file,
 
 static void cy_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 {
-	struct cyclades_port *info = (struct cyclades_port *)tty->driver_data;
+	struct cyclades_port *info = tty->driver_data;
 
 #ifdef SERIAL_DEBUG_OTHER
 	printk("cy_set_termios %s\n", tty->name);
@@ -1631,7 +1631,7 @@ static void cy_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 
 static void cy_close(struct tty_struct *tty, struct file *filp)
 {
-	struct cyclades_port *info = (struct cyclades_port *)tty->driver_data;
+	struct cyclades_port *info = tty->driver_data;
 
 /* CP('C'); */
 #ifdef SERIAL_DEBUG_OTHER
@@ -1698,7 +1698,7 @@ static void cy_close(struct tty_struct *tty, struct file *filp)
  */
 void cy_hangup(struct tty_struct *tty)
 {
-	struct cyclades_port *info = (struct cyclades_port *)tty->driver_data;
+	struct cyclades_port *info = tty->driver_data;
 
 #ifdef SERIAL_DEBUG_OTHER
 	printk("cy_hangup %s\n", tty->name);	/* */
diff --git a/drivers/char/specialix.c b/drivers/char/specialix.c
index a16b94f..3c67c3d 100644
--- a/drivers/char/specialix.c
+++ b/drivers/char/specialix.c
@@ -1450,7 +1450,7 @@ static int sx_open(struct tty_struct *tty, struct file *filp)
 
 static void sx_flush_buffer(struct tty_struct *tty)
 {
-	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
+	struct specialix_port *port = tty->driver_data;
 	unsigned long flags;
 	struct specialix_board  *bp;
 
@@ -1472,7 +1472,7 @@ static void sx_flush_buffer(struct tty_struct *tty)
 
 static void sx_close(struct tty_struct *tty, struct file *filp)
 {
-	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
+	struct specialix_port *port = tty->driver_data;
 	struct specialix_board *bp;
 	unsigned long flags;
 	unsigned long timeout;
@@ -1585,7 +1585,7 @@ static void sx_close(struct tty_struct *tty, struct file *filp)
 static int sx_write(struct tty_struct *tty,
 					const unsigned char *buf, int count)
 {
-	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
+	struct specialix_port *port = tty->driver_data;
 	struct specialix_board *bp;
 	int c, total = 0;
 	unsigned long flags;
@@ -1637,7 +1637,7 @@ static int sx_write(struct tty_struct *tty,
 
 static int sx_put_char(struct tty_struct *tty, unsigned char ch)
 {
-	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
+	struct specialix_port *port = tty->driver_data;
 	unsigned long flags;
 	struct specialix_board  *bp;
 
@@ -1676,7 +1676,7 @@ static int sx_put_char(struct tty_struct *tty, unsigned char ch)
 
 static void sx_flush_chars(struct tty_struct *tty)
 {
-	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
+	struct specialix_port *port = tty->driver_data;
 	unsigned long flags;
 	struct specialix_board  *bp = port_Board(port);
 
@@ -1703,7 +1703,7 @@ static void sx_flush_chars(struct tty_struct *tty)
 
 static int sx_write_room(struct tty_struct *tty)
 {
-	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
+	struct specialix_port *port = tty->driver_data;
 	int	ret;
 
 	func_enter();
@@ -1724,7 +1724,7 @@ static int sx_write_room(struct tty_struct *tty)
 
 static int sx_chars_in_buffer(struct tty_struct *tty)
 {
-	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
+	struct specialix_port *port = tty->driver_data;
 
 	func_enter();
 
@@ -1738,7 +1738,7 @@ static int sx_chars_in_buffer(struct tty_struct *tty)
 
 static int sx_tiocmget(struct tty_struct *tty, struct file *file)
 {
-	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
+	struct specialix_port *port = tty->driver_data;
 	struct specialix_board *bp;
 	unsigned char status;
 	unsigned int result;
@@ -1780,7 +1780,7 @@ static int sx_tiocmget(struct tty_struct *tty, struct file *file)
 static int sx_tiocmset(struct tty_struct *tty, struct file *file,
 		       unsigned int set, unsigned int clear)
 {
-	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
+	struct specialix_port *port = tty->driver_data;
 	unsigned long flags;
 	struct specialix_board *bp;
 
@@ -1820,7 +1820,7 @@ static int sx_tiocmset(struct tty_struct *tty, struct file *file,
 
 static int sx_send_break(struct tty_struct *tty, int length)
 {
-	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
+	struct specialix_port *port = tty->driver_data;
 	struct specialix_board *bp = port_Board(port);
 	unsigned long flags;
 
@@ -1931,7 +1931,7 @@ static int sx_get_serial_info(struct specialix_port *port,
 static int sx_ioctl(struct tty_struct *tty, struct file *filp,
 				unsigned int cmd, unsigned long arg)
 {
-	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
+	struct specialix_port *port = tty->driver_data;
 	void __user *argp = (void __user *)arg;
 
 	func_enter();
@@ -1959,7 +1959,7 @@ static int sx_ioctl(struct tty_struct *tty, struct file *filp,
 
 static void sx_throttle(struct tty_struct *tty)
 {
-	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
+	struct specialix_port *port = tty->driver_data;
 	struct specialix_board *bp;
 	unsigned long flags;
 
@@ -2004,7 +2004,7 @@ static void sx_throttle(struct tty_struct *tty)
 
 static void sx_unthrottle(struct tty_struct *tty)
 {
-	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
+	struct specialix_port *port = tty->driver_data;
 	struct specialix_board *bp;
 	unsigned long flags;
 
@@ -2045,7 +2045,7 @@ static void sx_unthrottle(struct tty_struct *tty)
 
 static void sx_stop(struct tty_struct *tty)
 {
-	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
+	struct specialix_port *port = tty->driver_data;
 	struct specialix_board *bp;
 	unsigned long flags;
 
@@ -2072,7 +2072,7 @@ static void sx_stop(struct tty_struct *tty)
 
 static void sx_start(struct tty_struct *tty)
 {
-	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
+	struct specialix_port *port = tty->driver_data;
 	struct specialix_board *bp;
 	unsigned long flags;
 
@@ -2100,7 +2100,7 @@ static void sx_start(struct tty_struct *tty)
 
 static void sx_hangup(struct tty_struct *tty)
 {
-	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
+	struct specialix_port *port = tty->driver_data;
 	struct specialix_board *bp;
 	unsigned long flags;
 
@@ -2135,7 +2135,7 @@ static void sx_hangup(struct tty_struct *tty)
 static void sx_set_termios(struct tty_struct *tty,
 					struct ktermios *old_termios)
 {
-	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
+	struct specialix_port *port = tty->driver_data;
 	unsigned long flags;
 	struct specialix_board  *bp;
 
diff --git a/drivers/char/sx.c b/drivers/char/sx.c
index a71bc58..b60be7b 100644
--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -1941,7 +1941,7 @@ static int sx_ioctl(struct tty_struct *tty, struct file *filp,
 
 static void sx_throttle(struct tty_struct *tty)
 {
-	struct sx_port *port = (struct sx_port *)tty->driver_data;
+	struct sx_port *port = tty->driver_data;
 
 	func_enter2();
 	/* If the port is using any type of input flow
@@ -1955,7 +1955,7 @@ static void sx_throttle(struct tty_struct *tty)
 
 static void sx_unthrottle(struct tty_struct *tty)
 {
-	struct sx_port *port = (struct sx_port *)tty->driver_data;
+	struct sx_port *port = tty->driver_data;
 
 	func_enter2();
 	/* Always unthrottle even if flow control is not enabled on
diff --git a/drivers/char/synclink.c b/drivers/char/synclink.c
index fbd5a5c..b8063d4 100644
--- a/drivers/char/synclink.c
+++ b/drivers/char/synclink.c
@@ -977,7 +977,7 @@ static void ldisc_receive_buf(struct tty_struct *tty,
  */
 static void mgsl_stop(struct tty_struct *tty)
 {
-	struct mgsl_struct *info = (struct mgsl_struct *)tty->driver_data;
+	struct mgsl_struct *info = tty->driver_data;
 	unsigned long flags;
 	
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_stop"))
@@ -1000,7 +1000,7 @@ static void mgsl_stop(struct tty_struct *tty)
  */
 static void mgsl_start(struct tty_struct *tty)
 {
-	struct mgsl_struct *info = (struct mgsl_struct *)tty->driver_data;
+	struct mgsl_struct *info = tty->driver_data;
 	unsigned long flags;
 	
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_start"))
@@ -2057,7 +2057,7 @@ static int mgsl_put_char(struct tty_struct *tty, unsigned char ch)
  */
 static void mgsl_flush_chars(struct tty_struct *tty)
 {
-	struct mgsl_struct *info = (struct mgsl_struct *)tty->driver_data;
+	struct mgsl_struct *info = tty->driver_data;
 	unsigned long flags;
 				
 	if ( debug_level >= DEBUG_LEVEL_INFO )
@@ -2109,7 +2109,7 @@ static int mgsl_write(struct tty_struct * tty,
 		    const unsigned char *buf, int count)
 {
 	int	c, ret = 0;
-	struct mgsl_struct *info = (struct mgsl_struct *)tty->driver_data;
+	struct mgsl_struct *info = tty->driver_data;
 	unsigned long flags;
 	
 	if ( debug_level >= DEBUG_LEVEL_INFO )
@@ -2232,7 +2232,7 @@ cleanup:
  */
 static int mgsl_write_room(struct tty_struct *tty)
 {
-	struct mgsl_struct *info = (struct mgsl_struct *)tty->driver_data;
+	struct mgsl_struct *info = tty->driver_data;
 	int	ret;
 				
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_write_room"))
@@ -2267,7 +2267,7 @@ static int mgsl_write_room(struct tty_struct *tty)
  */
 static int mgsl_chars_in_buffer(struct tty_struct *tty)
 {
-	struct mgsl_struct *info = (struct mgsl_struct *)tty->driver_data;
+	struct mgsl_struct *info = tty->driver_data;
 			 
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_chars_in_buffer(%s)\n",
@@ -2301,7 +2301,7 @@ static int mgsl_chars_in_buffer(struct tty_struct *tty)
  */
 static void mgsl_flush_buffer(struct tty_struct *tty)
 {
-	struct mgsl_struct *info = (struct mgsl_struct *)tty->driver_data;
+	struct mgsl_struct *info = tty->driver_data;
 	unsigned long flags;
 	
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -2329,7 +2329,7 @@ static void mgsl_flush_buffer(struct tty_struct *tty)
  */
 static void mgsl_send_xchar(struct tty_struct *tty, char ch)
 {
-	struct mgsl_struct *info = (struct mgsl_struct *)tty->driver_data;
+	struct mgsl_struct *info = tty->driver_data;
 	unsigned long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -2358,7 +2358,7 @@ static void mgsl_send_xchar(struct tty_struct *tty, char ch)
  */
 static void mgsl_throttle(struct tty_struct * tty)
 {
-	struct mgsl_struct *info = (struct mgsl_struct *)tty->driver_data;
+	struct mgsl_struct *info = tty->driver_data;
 	unsigned long flags;
 	
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -2388,7 +2388,7 @@ static void mgsl_throttle(struct tty_struct * tty)
  */
 static void mgsl_unthrottle(struct tty_struct * tty)
 {
-	struct mgsl_struct *info = (struct mgsl_struct *)tty->driver_data;
+	struct mgsl_struct *info = tty->driver_data;
 	unsigned long flags;
 	
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -2841,7 +2841,7 @@ static int modem_input_wait(struct mgsl_struct *info,int arg)
  */
 static int tiocmget(struct tty_struct *tty, struct file *file)
 {
-	struct mgsl_struct *info = (struct mgsl_struct *)tty->driver_data;
+	struct mgsl_struct *info = tty->driver_data;
 	unsigned int result;
  	unsigned long flags;
 
@@ -2867,7 +2867,7 @@ static int tiocmget(struct tty_struct *tty, struct file *file)
 static int tiocmset(struct tty_struct *tty, struct file *file,
 		    unsigned int set, unsigned int clear)
 {
-	struct mgsl_struct *info = (struct mgsl_struct *)tty->driver_data;
+	struct mgsl_struct *info = tty->driver_data;
  	unsigned long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -2898,7 +2898,7 @@ static int tiocmset(struct tty_struct *tty, struct file *file,
  */
 static int mgsl_break(struct tty_struct *tty, int break_state)
 {
-	struct mgsl_struct * info = (struct mgsl_struct *)tty->driver_data;
+	struct mgsl_struct * info = tty->driver_data;
 	unsigned long flags;
 	
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -2932,7 +2932,7 @@ static int mgsl_break(struct tty_struct *tty, int break_state)
 static int mgsl_ioctl(struct tty_struct *tty, struct file * file,
 		    unsigned int cmd, unsigned long arg)
 {
-	struct mgsl_struct * info = (struct mgsl_struct *)tty->driver_data;
+	struct mgsl_struct * info = tty->driver_data;
 	int ret;
 	
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -3042,7 +3042,7 @@ static int mgsl_ioctl_common(struct mgsl_struct *info, unsigned int cmd, unsigne
  */
 static void mgsl_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 {
-	struct mgsl_struct *info = (struct mgsl_struct *)tty->driver_data;
+	struct mgsl_struct *info = tty->driver_data;
 	unsigned long flags;
 	
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -3096,7 +3096,7 @@ static void mgsl_set_termios(struct tty_struct *tty, struct ktermios *old_termio
  */
 static void mgsl_close(struct tty_struct *tty, struct file * filp)
 {
-	struct mgsl_struct * info = (struct mgsl_struct *)tty->driver_data;
+	struct mgsl_struct * info = tty->driver_data;
 
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_close"))
 		return;
@@ -3136,7 +3136,7 @@ cleanup:
  */
 static void mgsl_wait_until_sent(struct tty_struct *tty, int timeout)
 {
-	struct mgsl_struct * info = (struct mgsl_struct *)tty->driver_data;
+	struct mgsl_struct * info = tty->driver_data;
 	unsigned long orig_jiffies, char_time;
 
 	if (!info )
@@ -3209,7 +3209,7 @@ exit:
  */
 static void mgsl_hangup(struct tty_struct *tty)
 {
-	struct mgsl_struct * info = (struct mgsl_struct *)tty->driver_data;
+	struct mgsl_struct * info = tty->driver_data;
 	
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_hangup(%s)\n",
diff --git a/drivers/char/synclinkmp.c b/drivers/char/synclinkmp.c
index 2aac55b..7b0c5b2 100644
--- a/drivers/char/synclinkmp.c
+++ b/drivers/char/synclinkmp.c
@@ -801,7 +801,7 @@ cleanup:
  */
 static void close(struct tty_struct *tty, struct file *filp)
 {
-	SLMP_INFO * info = (SLMP_INFO *)tty->driver_data;
+	SLMP_INFO * info = tty->driver_data;
 
 	if (sanity_check(info, tty->name, "close"))
 		return;
@@ -833,7 +833,7 @@ cleanup:
  */
 static void hangup(struct tty_struct *tty)
 {
-	SLMP_INFO *info = (SLMP_INFO *)tty->driver_data;
+	SLMP_INFO *info = tty->driver_data;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):%s hangup()\n",
@@ -856,7 +856,7 @@ static void hangup(struct tty_struct *tty)
  */
 static void set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 {
-	SLMP_INFO *info = (SLMP_INFO *)tty->driver_data;
+	SLMP_INFO *info = tty->driver_data;
 	unsigned long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -909,7 +909,7 @@ static int write(struct tty_struct *tty,
 		 const unsigned char *buf, int count)
 {
 	int	c, ret = 0;
-	SLMP_INFO *info = (SLMP_INFO *)tty->driver_data;
+	SLMP_INFO *info = tty->driver_data;
 	unsigned long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -987,7 +987,7 @@ cleanup:
  */
 static int put_char(struct tty_struct *tty, unsigned char ch)
 {
-	SLMP_INFO *info = (SLMP_INFO *)tty->driver_data;
+	SLMP_INFO *info = tty->driver_data;
 	unsigned long flags;
 	int ret = 0;
 
@@ -1024,7 +1024,7 @@ static int put_char(struct tty_struct *tty, unsigned char ch)
  */
 static void send_xchar(struct tty_struct *tty, char ch)
 {
-	SLMP_INFO *info = (SLMP_INFO *)tty->driver_data;
+	SLMP_INFO *info = tty->driver_data;
 	unsigned long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -1048,7 +1048,7 @@ static void send_xchar(struct tty_struct *tty, char ch)
  */
 static void wait_until_sent(struct tty_struct *tty, int timeout)
 {
-	SLMP_INFO * info = (SLMP_INFO *)tty->driver_data;
+	SLMP_INFO * info = tty->driver_data;
 	unsigned long orig_jiffies, char_time;
 
 	if (!info )
@@ -1115,7 +1115,7 @@ exit:
  */
 static int write_room(struct tty_struct *tty)
 {
-	SLMP_INFO *info = (SLMP_INFO *)tty->driver_data;
+	SLMP_INFO *info = tty->driver_data;
 	int ret;
 
 	if (sanity_check(info, tty->name, "write_room"))
@@ -1142,7 +1142,7 @@ static int write_room(struct tty_struct *tty)
  */
 static void flush_chars(struct tty_struct *tty)
 {
-	SLMP_INFO *info = (SLMP_INFO *)tty->driver_data;
+	SLMP_INFO *info = tty->driver_data;
 	unsigned long flags;
 
 	if ( debug_level >= DEBUG_LEVEL_INFO )
@@ -1181,7 +1181,7 @@ static void flush_chars(struct tty_struct *tty)
  */
 static void flush_buffer(struct tty_struct *tty)
 {
-	SLMP_INFO *info = (SLMP_INFO *)tty->driver_data;
+	SLMP_INFO *info = tty->driver_data;
 	unsigned long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -1203,7 +1203,7 @@ static void flush_buffer(struct tty_struct *tty)
  */
 static void tx_hold(struct tty_struct *tty)
 {
-	SLMP_INFO *info = (SLMP_INFO *)tty->driver_data;
+	SLMP_INFO *info = tty->driver_data;
 	unsigned long flags;
 
 	if (sanity_check(info, tty->name, "tx_hold"))
@@ -1223,7 +1223,7 @@ static void tx_hold(struct tty_struct *tty)
  */
 static void tx_release(struct tty_struct *tty)
 {
-	SLMP_INFO *info = (SLMP_INFO *)tty->driver_data;
+	SLMP_INFO *info = tty->driver_data;
 	unsigned long flags;
 
 	if (sanity_check(info, tty->name, "tx_release"))
@@ -1253,7 +1253,7 @@ static void tx_release(struct tty_struct *tty)
 static int do_ioctl(struct tty_struct *tty, struct file *file,
 		 unsigned int cmd, unsigned long arg)
 {
-	SLMP_INFO *info = (SLMP_INFO *)tty->driver_data;
+	SLMP_INFO *info = tty->driver_data;
 	int error;
 	struct mgsl_icount cnow;	/* kernel counter temps */
 	struct serial_icounter_struct __user *p_cuser;	/* user space */
@@ -1464,7 +1464,7 @@ done:
  */
 static int chars_in_buffer(struct tty_struct *tty)
 {
-	SLMP_INFO *info = (SLMP_INFO *)tty->driver_data;
+	SLMP_INFO *info = tty->driver_data;
 
 	if (sanity_check(info, tty->name, "chars_in_buffer"))
 		return 0;
@@ -1480,7 +1480,7 @@ static int chars_in_buffer(struct tty_struct *tty)
  */
 static void throttle(struct tty_struct * tty)
 {
-	SLMP_INFO *info = (SLMP_INFO *)tty->driver_data;
+	SLMP_INFO *info = tty->driver_data;
 	unsigned long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -1505,7 +1505,7 @@ static void throttle(struct tty_struct * tty)
  */
 static void unthrottle(struct tty_struct * tty)
 {
-	SLMP_INFO *info = (SLMP_INFO *)tty->driver_data;
+	SLMP_INFO *info = tty->driver_data;
 	unsigned long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -1536,7 +1536,7 @@ static void unthrottle(struct tty_struct * tty)
 static int set_break(struct tty_struct *tty, int break_state)
 {
 	unsigned char RegValue;
-	SLMP_INFO * info = (SLMP_INFO *)tty->driver_data;
+	SLMP_INFO * info = tty->driver_data;
 	unsigned long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -3218,7 +3218,7 @@ static int modem_input_wait(SLMP_INFO *info,int arg)
  */
 static int tiocmget(struct tty_struct *tty, struct file *file)
 {
-	SLMP_INFO *info = (SLMP_INFO *)tty->driver_data;
+	SLMP_INFO *info = tty->driver_data;
 	unsigned int result;
  	unsigned long flags;
 
@@ -3244,7 +3244,7 @@ static int tiocmget(struct tty_struct *tty, struct file *file)
 static int tiocmset(struct tty_struct *tty, struct file *file,
 		    unsigned int set, unsigned int clear)
 {
-	SLMP_INFO *info = (SLMP_INFO *)tty->driver_data;
+	SLMP_INFO *info = tty->driver_data;
  	unsigned long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
diff --git a/drivers/char/vme_scc.c b/drivers/char/vme_scc.c
index 2d9242a..0e8234b 100644
--- a/drivers/char/vme_scc.c
+++ b/drivers/char/vme_scc.c
@@ -784,7 +784,7 @@ static void scc_setsignals(struct scc_port *port, int dtr, int rts)
 
 static void scc_send_xchar(struct tty_struct *tty, char ch)
 {
-	struct scc_port *port = (struct scc_port *)tty->driver_data;
+	struct scc_port *port = tty->driver_data;
 
 	port->x_char = ch;
 	if (ch)
@@ -911,7 +911,7 @@ static int scc_open (struct tty_struct * tty, struct file * filp)
 
 static void scc_throttle (struct tty_struct * tty)
 {
-	struct scc_port *port = (struct scc_port *)tty->driver_data;
+	struct scc_port *port = tty->driver_data;
 	unsigned long	flags;
 	SCC_ACCESS_INIT(port);
 
@@ -927,7 +927,7 @@ static void scc_throttle (struct tty_struct * tty)
 
 static void scc_unthrottle (struct tty_struct * tty)
 {
-	struct scc_port *port = (struct scc_port *)tty->driver_data;
+	struct scc_port *port = tty->driver_data;
 	unsigned long	flags;
 	SCC_ACCESS_INIT(port);
 
@@ -950,7 +950,7 @@ static int scc_ioctl(struct tty_struct *tty, struct file *file,
 
 static int scc_break_ctl(struct tty_struct *tty, int break_state)
 {
-	struct scc_port *port = (struct scc_port *)tty->driver_data;
+	struct scc_port *port = tty->driver_data;
 	unsigned long	flags;
 	SCC_ACCESS_INIT(port);
 
diff --git a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
index 8944ce5..a2dee0e 100644
--- a/drivers/char/vt_ioctl.c
+++ b/drivers/char/vt_ioctl.c
@@ -366,7 +366,7 @@ do_unimap_ioctl(int cmd, struct unimapdesc __user *user_ud, int perm, struct vc_
 int vt_ioctl(struct tty_struct *tty, struct file * file,
 	     unsigned int cmd, unsigned long arg)
 {
-	struct vc_data *vc = (struct vc_data *)tty->driver_data;
+	struct vc_data *vc = tty->driver_data;
 	struct console_font_op op;	/* used in multiple places here */
 	struct kbd_struct * kbd;
 	unsigned int console;

