From: George Spelvin <linux@horizon.com>
Subject: [PATCH v2 5/9] pps: Move timestamp read into PPS code proper
Date: Tue, 12 Feb 2013 02:00:43 -0500
Message-ID: <31e24f360b1715c262c05d6708353e292640b3a8.1360677367.git.linux@horizon.com>
References: <cover.1360677367.git.linux@horizon.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1360677367.git.linux@horizon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, peter@hurleysoftware.com, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, giometti@linux.it, linux@horizon.com
List-Id: linux-serial@vger.kernel.org

The PPS (Pulse-Per-Second) line discipline has developed a number of
unhealthy attachments to core tty data and functions, ultimately leading
to its breakage.

The previous patches fixed the crashing.  This one reduces coupling further
by eliminating the timestamp parameter from the dcd_change ldisc method.
This reduces header file linkage and makes the extension more generic,
and the timestamp read is delayed only slightly, from just before the
ldisc->ops->dcd_change method call to just after.

Fix attendant build breakage in
    drivers/tty/n_tty.c
    drivers/tty/tty_buffer.c
    drivers/staging/speakup/selection.c

Cc: William Hubbs <w.d.hubbs@gmail.com>
Cc: Chris Brannon <chris@the-brannons.com>
Cc: Kirk Reiser <kirk@braille.uwo.ca>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: George Spelvin <linux@horizon.com>
---
 drivers/pps/clients/pps-ldisc.c     | 11 +++++++----
 drivers/staging/speakup/selection.c |  1 +
 drivers/tty/n_tty.c                 |  3 ++-
 drivers/tty/serial/serial_core.c    |  5 +----
 drivers/tty/tty_buffer.c            |  1 +
 include/linux/serial_core.h         |  1 -
 include/linux/tty_ldisc.h           | 11 ++++-------
 7 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/pps/clients/pps-ldisc.c b/drivers/pps/clients/pps-ldisc.c
index a94f73e..73bd3bb 100644
--- a/drivers/pps/clients/pps-ldisc.c
+++ b/drivers/pps/clients/pps-ldisc.c
@@ -29,11 +29,14 @@
 
 #define PPS_TTY_MAGIC		0x0001
 
-static void pps_tty_dcd_change(struct tty_struct *tty, unsigned int status,
-				struct pps_event_time *ts)
+static void pps_tty_dcd_change(struct tty_struct *tty, unsigned int status)
 {
-	struct pps_device *pps = pps_lookup_dev(tty);
+	struct pps_device *pps;
+	struct pps_event_time ts;
+
+	pps_get_ts(&ts);
 
+	pps = pps_lookup_dev(tty);
 	/*
 	 * This should never fail, but the ldisc locking is very
 	 * convoluted, so don't crash just in case.
@@ -42,7 +45,7 @@ static void pps_tty_dcd_change(struct tty_struct *tty, unsigned int status,
 		return;
 
 	/* Now do the PPS event report */
-	pps_event(pps, ts, status ? PPS_CAPTUREASSERT :
+	pps_event(pps, &ts, status ? PPS_CAPTUREASSERT :
 			PPS_CAPTURECLEAR, NULL);
 
 	dev_dbg(pps->dev, "PPS %s at %lu\n",
diff --git a/drivers/staging/speakup/selection.c b/drivers/staging/speakup/selection.c
index 0612df0..2aa2237 100644
--- a/drivers/staging/speakup/selection.c
+++ b/drivers/staging/speakup/selection.c
@@ -2,6 +2,7 @@
 #include <linux/consolemap.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
+#include <linux/device.h> /* for dev_warn */
 #include <linux/selection.h>
 
 #include "speakup.h"
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 19083ef..ed66b20 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -49,6 +49,7 @@
 #include <linux/file.h>
 #include <linux/uaccess.h>
 #include <linux/module.h>
+#include <linux/ratelimit.h>
 
 
 /* number of characters left in xmit buffer before select has we have room */
@@ -2188,7 +2189,7 @@ struct tty_ldisc_ops tty_ldisc_N_TTY = {
  *	n_tty_inherit_ops	-	inherit N_TTY methods
  *	@ops: struct tty_ldisc_ops where to save N_TTY methods
  *
- *	Used by a generic struct tty_ldisc_ops to easily inherit N_TTY
+ *	Enables a 'subclass' line discipline to 'inherit' N_TTY
  *	methods.
  */
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2c7230a..23fc494 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2718,13 +2718,12 @@ void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
 	struct uart_state *state = uport->state;
 	struct tty_port *port = &state->port;
 	struct tty_ldisc *ld = NULL;
-	struct pps_event_time ts;
 	struct tty_struct *tty = port->tty;
 
 	if (tty)
 	        ld = tty_ldisc_ref(tty);
 	if (ld && ld->ops->dcd_change)
-		pps_get_ts(&ts);
+		ld->ops->dcd_change(tty, status);
 
 	uport->icount.dcd++;
 #ifdef CONFIG_HARD_PPS
@@ -2739,8 +2738,6 @@ void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
 			tty_hangup(tty);
 	}
 
-	if (ld && ld->ops->dcd_change)
-		ld->ops->dcd_change(tty, status, &ts);
 	if (ld)
 		tty_ldisc_deref(ld);
 }
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 45d9161..1bdd896 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -16,6 +16,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/ratelimit.h>
 
 /**
  *	tty_buffer_free_all		-	free buffers used by a tty
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index c6690a2..a5f1da9 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -29,7 +29,6 @@
 #include <linux/tty.h>
 #include <linux/mutex.h>
 #include <linux/sysrq.h>
-#include <linux/pps_kernel.h>
 #include <uapi/linux/serial_core.h>
 
 struct uart_port;
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index fb79dd8d..455a0d7 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -100,16 +100,14 @@
  *	seek to perform this action quickly but should wait until
  *	any pending driver I/O is completed.
  *
- * void (*dcd_change)(struct tty_struct *tty, unsigned int status,
- *			struct pps_event_time *ts)
+ * void (*dcd_change)(struct tty_struct *tty, unsigned int status)
  *
- *	Tells the discipline that the DCD pin has changed its status and
- *	the relative timestamp. Pointer ts cannot be NULL.
+ *	Tells the discipline that the DCD pin has changed its status.
+ *	Used exclusively by the N_PPS (Pulse-Per-Second) line discipline.
  */
 
 #include <linux/fs.h>
 #include <linux/wait.h>
-#include <linux/pps_kernel.h>
 #include <linux/wait.h>
 
 struct tty_ldisc_ops {
@@ -144,8 +142,7 @@ struct tty_ldisc_ops {
 	void	(*receive_buf)(struct tty_struct *, const unsigned char *cp,
 			       char *fp, int count);
 	void	(*write_wakeup)(struct tty_struct *);
-	void	(*dcd_change)(struct tty_struct *, unsigned int,
-				struct pps_event_time *);
+	void	(*dcd_change)(struct tty_struct *, unsigned int);
 
 	struct  module *owner;
 	
-- 
1.8.1.3
