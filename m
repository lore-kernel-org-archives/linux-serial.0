From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 00/11] BKL pruning and serial bug fixing
Date: Wed, 19 May 2010 13:01:42 +0100
Message-ID: <20100519120111.16717.71992.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51074 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756041Ab0ESMoM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 May 2010 08:44:12 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

BKL elemination using the existing locks


---

Alan Cox (11):
      synclink: reworking locking a bit
      specialix; Kill the BKL
      epca: Kill the big kernel lock
      cyclades: Kill off BKL usage
      synclink: kill the big kernel lock
      rocket: kill BKL
      isicom: kill off the BKL
      riscom8: kill use of lock_kernel
      istallion: use bit ops for the board flags
      stallion: prune lock_kernel calls
      tty: Fix the digi acceleport driver NULL checks


 drivers/char/cyclades.c              |   20 +++-----
 drivers/char/epca.c                  |    4 --
 drivers/char/isicom.c                |   13 ++---
 drivers/char/istallion.c             |   56 +++++++++++----------
 drivers/char/riscom8.c               |   14 +++--
 drivers/char/rocket.c                |   28 +++++++----
 drivers/char/specialix.c             |   11 ++--
 drivers/char/stallion.c              |   20 +++++---
 drivers/char/synclink.c              |   19 ++++---
 drivers/char/synclink_gt.c           |   90 +++++++++++++++++-----------------
 drivers/char/synclinkmp.c            |   41 ++++++++-------
 drivers/usb/serial/digi_acceleport.c |   14 +++--
 include/linux/istallion.h            |    2 -
 13 files changed, 174 insertions(+), 158 deletions(-)

-- 
Signature
