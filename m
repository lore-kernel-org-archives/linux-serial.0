From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [RESEND PATCH] nozomi: Fix warning from the previous TIOCGCOUNT
	changes
Date: Tue, 26 Oct 2010 15:56:34 +0100
Message-ID: <20101026145622.31646.34518.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34053 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932308Ab0JZPvS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Oct 2010 11:51:18 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Just remove a now unused variable

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/char/nozomi.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)


diff --git a/drivers/char/nozomi.c b/drivers/char/nozomi.c
index dd3f9b1..294d03e 100644
--- a/drivers/char/nozomi.c
+++ b/drivers/char/nozomi.c
@@ -1828,7 +1828,6 @@ static int ntty_ioctl(struct tty_struct *tty, struct file *file,
 		      unsigned int cmd, unsigned long arg)
 {
 	struct port *port = tty->driver_data;
-	void __user *argp = (void __user *)arg;
 	int rval = -ENOIOCTLCMD;
 
 	DBG1("******** IOCTL, cmd: %d", cmd);

