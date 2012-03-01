From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 0/6] Remove tty_lock from the console drivers
Date: Thu, 01 Mar 2012 19:49:34 +0000
Message-ID: <20120301194831.11322.38295.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:46301 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab2CATfR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Mar 2012 14:35:17 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

This needs a fair bit of testing and a bit of review wouldn't go amiss, but
it does drive the tty_lock() mess out of the console and correct chunks of
console locking in the process.

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
	"It's 106 miles to Chicago, we've got a full tank of gas, the
	 sat-nav has crashed, it's dark and we're completely lost"
