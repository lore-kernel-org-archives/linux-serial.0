From: Arseny Maslennikov <ar@cs.msu.ru>
Subject: [PATCH v2 6/7] n_tty: ->ops->write: Cut core logic out to a separate function
Date: Tue, 25 Jun 2019 19:11:52 +0300
Message-ID: <20190625161153.29811-7-ar@cs.msu.ru>
References: <20190625161153.29811-1-ar@cs.msu.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625161153.29811-1-ar@cs.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Vladimir D. Seleznev" <vseleznv@altlinux.org>, Rob Landley <rob@landley.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Arseny Maslennikov <ar@cs.msu.ru>
List-Id: linux-serial@vger.kernel.org

To simplify internal re-use of the line discipline's write method,
we isolate the work it does to its own function.

Since in-kernel callers might not refer to the tty through a file,
the struct file* argument might make no sense, so we also stop
tty_io_nonblock() from dereferencing file too early, allowing
to pass NULL as the referring file here.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 drivers/tty/n_tty.c | 33 ++++++++++++++++++++++-----------
 include/linux/tty.h |  2 +-
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 29f33798a6cd..7d7d84adcffe 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2309,22 +2309,15 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
  *		  lock themselves)
  */
 
-static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
-			   const unsigned char *buf, size_t nr)
+static ssize_t do_n_tty_write(struct tty_struct *tty, struct file *file,
+			      const unsigned char *buf, size_t nr)
 {
 	const unsigned char *b = buf;
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	int c;
 	ssize_t retval = 0;
 
-	/* Job control check -- must be done at start (POSIX.1 7.1.1.4). */
-	if (L_TOSTOP(tty) && file->f_op->write != redirected_tty_write) {
-		retval = tty_check_change(tty);
-		if (retval)
-			return retval;
-	}
-
-	down_read(&tty->termios_rwsem);
+	lockdep_assert_held_read(&tty->termios_rwsem);
 
 	/* Write out any echoed characters that are still pending */
 	process_echoes(tty);
@@ -2392,10 +2385,28 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 	remove_wait_queue(&tty->write_wait, &wait);
 	if (nr && tty->fasync)
 		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-	up_read(&tty->termios_rwsem);
 	return (b - buf) ? b - buf : retval;
 }
 
+static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
+			   const unsigned char *buf, size_t nr)
+{
+	ssize_t retval = 0;
+
+	/* Job control check -- must be done at start (POSIX.1 7.1.1.4). */
+	if (L_TOSTOP(tty) && file->f_op->write != redirected_tty_write) {
+		retval = tty_check_change(tty);
+		if (retval)
+			return retval;
+	}
+
+	down_read(&tty->termios_rwsem);
+	retval = do_n_tty_write(tty, file, buf, nr);
+	up_read(&tty->termios_rwsem);
+
+	return retval;
+}
+
 /**
  *	n_tty_poll		-	poll method for N_TTY
  *	@tty: terminal device
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 07189f18f93d..ddb97704956d 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -388,7 +388,7 @@ static inline void tty_set_flow_change(struct tty_struct *tty, int val)
 
 static inline bool tty_io_nonblock(struct tty_struct *tty, struct file *file)
 {
-	return file->f_flags & O_NONBLOCK ||
+	return (file && file->f_flags & O_NONBLOCK) ||
 		test_bit(TTY_LDISC_CHANGING, &tty->flags);
 }
 
-- 
2.20.1
