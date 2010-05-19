From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 0/3] Console preparatory work
Date: Wed, 19 May 2010 13:10:06 +0100
Message-ID: <20100519120901.17652.67379.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36496 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757425Ab0ESMwg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 May 2010 08:52:36 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

Preparatory locking clean up and tty_port work for the console.
---

Alan Cox (3):
      tty: Move the vt_tty field from the vc_data into the standard tty_port
      tty: Make vt's have a tty_port
      vc: Locking clean up


 drivers/char/keyboard.c        |   10 +++++-----
 drivers/char/selection.c       |    4 ++++
 drivers/char/vt.c              |   19 +++++++++++--------
 drivers/char/vt_ioctl.c        |    2 +-
 include/linux/console_struct.h |    3 ++-
 5 files changed, 23 insertions(+), 15 deletions(-)

-- 
Signature|No Signature
