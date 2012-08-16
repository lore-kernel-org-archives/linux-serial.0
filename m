From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/2] Remove BUG_ON from n_tty_read()
Date: Thu, 16 Aug 2012 12:01:47 +0100
Message-ID: <20120816110146.774.73249.stgit@localhost.localdomain>
References: <20120816110130.774.87642.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:48650 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731Ab2HPKoY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Aug 2012 06:44:24 -0400
In-Reply-To: <20120816110130.774.87642.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Stanislav Kozina <skozina@redhat.com>

Change the BUG_ON to WARN_ON and return in case of tty->read_buf==NULL. We want to track a
couple of long standing reports of this but at the same time we can avoid killing the box.

Signed-off-by: Stanislav Kozina <skozina@redhat.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
Cc: Horses <stable@kernel.org>
---

 drivers/tty/n_tty.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 4776aa2..ece22c0 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1734,7 +1734,8 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 
 do_it_again:
 
-	BUG_ON(!tty->read_buf);
+	if (WARN_ON(!tty->read_buf))
+		return -EAGAIN;
 
 	c = job_control(tty, file);
 	if (c < 0)

