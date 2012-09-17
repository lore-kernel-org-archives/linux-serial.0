From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] tty: Fix hvc return
Date: Mon, 17 Sep 2012 12:03:39 +0100
Message-ID: <20120917110324.30537.26940.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:32948 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863Ab2IQKpL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Sep 2012 06:45:11 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

HVC returns a size of -1 bytes for the write room in some cases.
This is bogus and not handled by the tty layer at all.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/hvc/hvc_console.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index b57dcbd..a5dec1c 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -568,7 +568,7 @@ static int hvc_write_room(struct tty_struct *tty)
 	struct hvc_struct *hp = tty->driver_data;
 
 	if (!hp)
-		return -1;
+		return 0;
 
 	return hp->outbuf_size - hp->n_outbuf;
 }

