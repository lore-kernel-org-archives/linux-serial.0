From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 0/6] Series short description
Date: Fri, 02 Mar 2012 14:58:56 +0000
Message-ID: <20120302145628.32320.53944.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:36966 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754891Ab2CBOoi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Mar 2012 09:44:38 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

With corrections noted. This is going to cause problems somewhere I'm sure
but I don't see any way to avoid that apart from trying it.

Alan

---

Alan Cox (6):
      vt: push the tty_lock down into the map handling
      vt: tackle the main part of the selection logic
      vt: waitevent is self locked so drop the tty_lock
      vt: push down tioclinux cases
      vt: push down the tty lock so we can see what is left to tackle
      vt: sort out locking for font handling


 drivers/tty/vt/consolemap.c |  119 ++++++++++++++++++++++++++++++++-----------
 drivers/tty/vt/selection.c  |   49 +++++++++++++-----
 drivers/tty/vt/vc_screen.c  |    4 +
 drivers/tty/vt/vt.c         |   37 ++++++++++---
 drivers/tty/vt/vt_ioctl.c   |   68 ++++++++++++-------------
 include/linux/vt_kern.h     |    1 
 6 files changed, 186 insertions(+), 92 deletions(-)

-- 
 "And the nice thing is you don't need to be able to type, because every
  possible keystroke does {something} for/to you. Anything from point out
  off-by-one errors to perform a sex change on your gerbil."
			-- Bill Davidsen describing emacs

