From: Sean Young <sean@mess.org>
Subject: [PATCH 0/2] winbond-cir: Fix initialization v2
Date: Thu,  6 Sep 2012 23:20:30 +0100
Message-ID: <cover.1346969721.git.sean@mess.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from pequod.mess.org ([93.97.41.153]:43599 "EHLO pequod.mess.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461Ab2IFWUe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Sep 2012 18:20:34 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: =?UTF-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>, Mauro Carvalho Chehab <mchehab@redhat.com>

The serial driver will detect the winbond cir device as a serial port,
since it looks exactly like a serial port unless you know what it is
from the PNP ID.

Alan Cox pointed out[1] that the pnp serial probe should be done before
the legacy probe and we should keep track of any IR ports during the
pnp scan. This is an implementation of that idea.

Diffed against tty-next.

[1] http://www.spinics.net/lists/linux-serial/msg06757.html

Sean Young (2):
  8250_pnp: merge into 8250 module so pnp probe can done first
  8250: blacklist IR ports

 drivers/tty/serial/8250/8250.c     | 47 ++++++++++++++++++++++++++------------
 drivers/tty/serial/8250/8250.h     |  9 ++++++++
 drivers/tty/serial/8250/8250_pnp.c | 34 ++++++++++++++++-----------
 drivers/tty/serial/8250/Kconfig    | 16 ++++++-------
 drivers/tty/serial/8250/Makefile   |  5 ++--
 include/linux/serial_core.h        |  3 ++-
 6 files changed, 75 insertions(+), 39 deletions(-)

-- 
1.7.11.4

