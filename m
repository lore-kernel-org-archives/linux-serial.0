From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 7/9] n_tty: Un-inline single-use functions
Date: Wed, 24 Jul 2013 08:29:55 -0400
Message-ID: <1374668997-29726-7-git-send-email-peter@hurleysoftware.com>
References: <20130724001259.GA9239@kroah.com>
 <1374668997-29726-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374668997-29726-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

gcc will likely inline these single-use functions anyway; remove
inline modifier.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 0f33e0c..f516247 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -263,7 +263,7 @@ static void n_tty_check_throttle(struct tty_struct *tty)
 	__tty_set_flow_change(tty, 0);
 }
 
-static inline void n_tty_check_unthrottle(struct tty_struct *tty)
+static void n_tty_check_unthrottle(struct tty_struct *tty)
 {
 	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
 	    tty->link->ldisc->ops->write_wakeup == n_tty_write_wakeup) {
@@ -1109,7 +1109,7 @@ static void eraser(unsigned char c, struct tty_struct *tty)
  *	Locking: ctrl_lock
  */
 
-static inline void isig(int sig, struct tty_struct *tty)
+static void isig(int sig, struct tty_struct *tty)
 {
 	struct pid *tty_pgrp = tty_get_pgrp(tty);
 	if (tty_pgrp) {
@@ -1132,7 +1132,7 @@ static inline void isig(int sig, struct tty_struct *tty)
  *	Note: may get exclusive termios_rwsem if flushing input buffer
  */
 
-static inline void n_tty_receive_break(struct tty_struct *tty)
+static void n_tty_receive_break(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
@@ -1170,7 +1170,7 @@ static inline void n_tty_receive_break(struct tty_struct *tty)
  *	private.
  */
 
-static inline void n_tty_receive_overrun(struct tty_struct *tty)
+static void n_tty_receive_overrun(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	char buf[64];
@@ -1198,8 +1198,7 @@ static inline void n_tty_receive_overrun(struct tty_struct *tty)
  *		caller holds non-exclusive termios_rwsem
  *		publishes read_head via put_tty_queue()
  */
-static inline void n_tty_receive_parity_error(struct tty_struct *tty,
-					      unsigned char c)
+static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
-- 
1.8.1.2
