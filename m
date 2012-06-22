From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 03/12] tty: note race we need to fix
Date: Fri, 22 Jun 2012 16:40:20 +0100
Message-ID: <20120622153900.1405.47389.stgit@localhost.localdomain>
References: <20120622153600.1405.15575.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:40738 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762296Ab2FVPYc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Jun 2012 11:24:32 -0400
In-Reply-To: <20120622153600.1405.15575.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

This was identified by Vincent Pillet with a high speed interface that uses
low latency mode. In the low latency case we have a tiny race but it can
be hit.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/n_tty.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index ee1c268..4f34491 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1432,6 +1432,12 @@ static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	 */
 	if (tty->receive_room < TTY_THRESHOLD_THROTTLE)
 		tty_throttle(tty);
+
+        /* FIXME: there is a tiny race here if the receive room check runs
+           before the other work executes and empties the buffer (upping
+           the receiving room and unthrottling. We then throttle and get
+           stuck. This has been observed and traced down by Vincent Pillet/
+           We need to address this when we sort out out the rx path locking */
 }
 
 int is_ignored(int sig)

