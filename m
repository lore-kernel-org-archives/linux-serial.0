From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/9] tty_port: allow a port to be opened with a tty that has no file handle
Date: Fri,  6 Jan 2017 10:26:28 -0600
Message-ID: <20170106162635.19677-3-robh@kernel.org>
References: <20170106162635.19677-1-robh@kernel.org>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170106162635.19677-1-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Let us create tty objects entirely in kernel space. Untested proposal to
show why all the ideas around rewriting half the uart stack are not needed.

With this a kernel created non file backed tty object could be used to handle
data, and set terminal modes. Not all ldiscs can cope with this as N_TTY in
particular has to work back to the fs/tty layer.

The tty_port code is however otherwise clean of file handles as far as I can
tell as is the low level tty port write path used by the ldisc, the
configuration low level interfaces and most of the ldiscs.

Currently you don't have any exposure to see tty hangups because those are
built around the file layer. However a) it's a fixed port so you probably
don't care about that b) if you do we can add a callback and c) you almost
certainly don't want the userspace tear down/rebuild behaviour anyway.

This should however be sufficient if we wanted for example to enumerate all
the bluetooth bound fixed ports via ACPI and make them directly available.
It doesn't deal with the case of a user opening a port that's also kernel
opened and that would need some locking out (so it returned EBUSY if bound
to a kernel device of some kind). That needs resolving along with how you
"up" or "down" your new bluetooth device, or enumerate it while providing
the existing tty API to avoid regressions (and to debug).

Alan
---

Alan, I need a proper patch with your S-O-B for this one.

 drivers/tty/tty_io.c   | 2 +-
 drivers/tty/tty_port.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 5ebc090ec47f..928a70ed9175 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -855,7 +855,7 @@ static void tty_vhangup_session(struct tty_struct *tty)

 int tty_hung_up_p(struct file *filp)
 {
-	return (filp->f_op == &hung_up_tty_fops);
+	return (filp && filp->f_op == &hung_up_tty_fops);
 }

 EXPORT_SYMBOL(tty_hung_up_p);
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index c3f9d93ba227..606d9e5bf28f 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -335,7 +335,7 @@ EXPORT_SYMBOL(tty_port_lower_dtr_rts);
  *	tty_port_block_til_ready	-	Waiting logic for tty open
  *	@port: the tty port being opened
  *	@tty: the tty device being bound
- *	@filp: the file pointer of the opener
+ *	@filp: the file pointer of the opener or NULL
  *
  *	Implement the core POSIX/SuS tty behaviour when opening a tty device.
  *	Handles:
@@ -369,7 +369,7 @@ int tty_port_block_til_ready(struct tty_port *port,
 		tty_port_set_active(port, 1);
 		return 0;
 	}
-	if (filp->f_flags & O_NONBLOCK) {
+	if (filp == NULL || (filp->f_flags & O_NONBLOCK)) {
 		/* Indicate we are open */
 		if (C_BAUD(tty))
 			tty_port_raise_dtr_rts(port);
--
2.10.1
