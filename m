From: Rob Herring <robh@kernel.org>
Subject: [PATCH v2 4/9] tty: constify tty_ldisc_receive_buf buffer pointer
Date: Mon, 16 Jan 2017 16:54:31 -0600
Message-ID: <20170116225436.17505-5-robh@kernel.org>
References: <20170116225436.17505-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170116225436.17505-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This is needed to work with the client operations which uses const ptrs.

Really, the flags pointer could be const, too, but this would be a tree
wide fix.

Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-By: Sebastian Reichel <sre@kernel.org>
---
v2:
- no change

 drivers/tty/tty_buffer.c | 2 +-
 include/linux/tty.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index aa80dc94ddc2..f4dc3e296dd5 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -422,7 +422,7 @@ EXPORT_SYMBOL_GPL(tty_prepare_flip_string);
  *
  *	Returns the number of bytes not processed
  */
-int tty_ldisc_receive_buf(struct tty_ldisc *ld, unsigned char *p,
+int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
 			  char *f, int count)
 {
 	if (ld->ops->receive_buf2)
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 86c7853282b7..21c0fabfed60 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -657,7 +657,7 @@ extern int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty);
 extern void tty_ldisc_release(struct tty_struct *tty);
 extern void tty_ldisc_init(struct tty_struct *tty);
 extern void tty_ldisc_deinit(struct tty_struct *tty);
-extern int tty_ldisc_receive_buf(struct tty_ldisc *ld, unsigned char *p,
+extern int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
 				 char *f, int count);

 /* n_tty.c */
--
2.10.1
