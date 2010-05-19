From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 0/3] Serial reference passing
Date: Wed, 19 May 2010 13:06:50 +0100
Message-ID: <20100519120532.17281.38433.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53662 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758056Ab0ESMtU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 May 2010 08:49:20 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

Clean up the way we pass stuff around a bit so that we can avoid a lot of the
tty back references in the serial layer. This is by no means the whole fix but
it lays the groundwork for the important user side bits.
---

Alan Cox (3):
      tty: serial - fix tty referencing in set_ldisc
      tty: serial - fix tty back references in termios
      tty: serial - fix various misuses/mishandlings of port->tty


 drivers/serial/21285.c       |   10 +---
 drivers/serial/bfin_5xx.c    |    7 +--
 drivers/serial/imx.c         |   10 ++--
 drivers/serial/ioc3_serial.c |    9 ++-
 drivers/serial/ioc4_serial.c |    9 ++-
 drivers/serial/max3100.c     |    7 +--
 drivers/serial/serial_core.c |  111 +++++++++++++++++++++++-------------------
 include/linux/serial_core.h  |    2 -
 8 files changed, 83 insertions(+), 82 deletions(-)

-- 
No Signature

