From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 19/75] tty: Fix sparse static warning for tty_driver_lookup_tty
Date: Fri, 02 Jan 2009 13:43:04 +0000
Message-ID: <20090102134302.13472.82761.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60320 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755914AbZABNmt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:42:49 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Jason Wessel <jason.wessel@windriver.com>

Fixed sparse warning:
drivers/char/tty_io.c:1216:19: warning: symbol 'tty_driver_lookup_tty' was not declared. Should it be static?

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/tty_io.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index d8d240c..2a15af6 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -1211,7 +1211,7 @@ static void tty_line_name(struct tty_driver *driver, int index, char *p)
  *	be held until the 'fast-open' is also done. Will change once we
  *	have refcounting in the driver and per driver locking
  */
-struct tty_struct *tty_driver_lookup_tty(struct tty_driver *driver,
+static struct tty_struct *tty_driver_lookup_tty(struct tty_driver *driver,
 		struct inode *inode, int idx)
 {
 	struct tty_struct *tty;

