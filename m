From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next v2 06/26] pty: Always return -EIO if slave BSD pty opened first
Date: Wed,  5 Nov 2014 12:12:49 -0500
Message-ID: <1415207589-15967-7-git-send-email-peter@hurleysoftware.com>
References: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
 <1415207589-15967-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415207589-15967-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Opening the slave BSD pty first already returns -EIO from the slave
pty_open(), which in turn causes the newly installed tty pair to be
released before returning from tty_open(). However, this can also
cause a parallel master BSD pty open to fail because the pty pair
destruction may already been taking place in tty_release().

Failing at driver->install() if the slave pty is opened first ensures
that a pty master open cannot fail, because the driver tables will
not have been updated so tty_driver_lookup_tty() won't find the
master pty (and attempt to "re-open" it).

In turn, this guarantees that any tty with a tty->count == 0 is
in final close (rather than never opened).

Reviewed-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/pty.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 7a1a538..bdb8fd1 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -383,6 +383,10 @@ static int pty_common_install(struct tty_driver *driver, struct tty_struct *tty,
 	int idx = tty->index;
 	int retval = -ENOMEM;
 
+	/* Opening the slave first has always returned -EIO */
+	if (driver->subtype != PTY_TYPE_MASTER)
+		return -EIO;
+
 	ports[0] = kmalloc(sizeof **ports, GFP_KERNEL);
 	ports[1] = kmalloc(sizeof **ports, GFP_KERNEL);
 	if (!ports[0] || !ports[1])
@@ -419,8 +423,6 @@ static int pty_common_install(struct tty_driver *driver, struct tty_struct *tty,
 	 * Everything allocated ... set up the o_tty structure.
 	 */
 	tty_driver_kref_get(driver->other);
-	if (driver->subtype == PTY_TYPE_MASTER)
-		o_tty->count++;
 	/* Establish the links in both directions */
 	tty->link   = o_tty;
 	o_tty->link = tty;
@@ -432,6 +434,7 @@ static int pty_common_install(struct tty_driver *driver, struct tty_struct *tty,
 
 	tty_driver_kref_get(driver);
 	tty->count++;
+	o_tty->count++;
 	return 0;
 err_free_termios:
 	if (legacy)
-- 
2.1.3
