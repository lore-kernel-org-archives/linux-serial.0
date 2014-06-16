From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH tty-next 01/22] tty: Document locking for tty driver methods
Date: Mon, 16 Jun 2014 09:16:58 -0400
Message-ID: <1402924639-5164-2-git-send-email-peter@hurleysoftware.com>
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The tty core calls the tty driver's open, close and hangup
methods holding the tty lock.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 include/linux/tty_driver.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 756a609..e48c608 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -35,14 +35,14 @@
  * 	This routine is mandatory; if this routine is not filled in,
  * 	the attempted open will fail with ENODEV.
  *
- *	Required method.
- *     
+ *	Required method. Called with tty lock held.
+ *
  * void (*close)(struct tty_struct * tty, struct file * filp);
  *
  * 	This routine is called when a particular tty device is closed.
  *	Note: called even if the corresponding open() failed.
  *
- *	Required method.
+ *	Required method. Called with tty lock held.
  *
  * void (*shutdown)(struct tty_struct * tty);
  *
@@ -172,6 +172,8 @@
  *
  *	Optional:
  *
+ *	Called with tty lock held.
+ *
  * int (*break_ctl)(struct tty_struct *tty, int state);
  *
  * 	This optional routine requests the tty driver to turn on or
-- 
2.0.0
