From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/4] tty_open can return to userspace holding tty_mutex
Date: Tue, 27 Jan 2009 11:50:37 +0000
Message-ID: <20090127115028.6236.27498.stgit@localhost.localdomain>
References: <20090127114820.6236.67019.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37021 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755529AbZA0Lu3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Jan 2009 06:50:29 -0500
In-Reply-To: <20090127114820.6236.67019.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@linux-foundation.org, linux-serial@vger.kernel.org

From: Eric Paris <eparis@redhat.com>

__tty_open could return (to userspace) holding the tty_mutex thanks to a
regression introduced by 4a2b5fddd53b80efcb3266ee36e23b8de28e761a.  This was
found by bisecting an fsfuzzer problem.  Admittedly I have no idea how it
managed to tickle this 100% reliably, but it is clearly a regression and
when hit leaves the box in a completely unusable state.  This patch lets
the fsfuzzer test complete every time.

Signed-off-by: Eric Paris <eparis@redhat.com>
Signed-off-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
---

 drivers/char/tty_io.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)


diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index d33e5ab..bc84e12 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -1817,8 +1817,10 @@ got_driver:
 		/* check whether we're reopening an existing tty */
 		tty = tty_driver_lookup_tty(driver, inode, index);
 
-		if (IS_ERR(tty))
+		if (IS_ERR(tty)) {
+			mutex_unlock(&tty_mutex);
 			return PTR_ERR(tty);
+		}
 	}
 
 	if (tty) {

