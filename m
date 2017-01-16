From: Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/9] tty_port: allow a port to be opened with a tty that has no file handle
Date: Mon, 16 Jan 2017 16:54:29 -0600
Message-ID: <20170116225436.17505-3-robh@kernel.org>
References: <20170116225436.17505-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170116225436.17505-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-By: Sebastian Reichel <sre@kernel.org>
---
Alan, Need your SoB here.

v2:
- no change

 drivers/tty/tty_io.c   | 2 +-
 drivers/tty/tty_port.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 4790c0fb5a45..a1fd3f7d487a 100644
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
