From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 0/4] Further serial driver bits
Date: Thu, 17 Jun 2010 11:01:38 +0100
Message-ID: <20100617100012.4379.92949.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13312 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755395Ab0FQKYn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Jun 2010 06:24:43 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

Some cleanups for the 3110 driver and an initial release of the driver for
the hsu high speed serial.

Again these stand alone, there are other bits for early printk support and the
like to follow once the things they depend upon are integrated

---

Arjan van de Ven (2):
      serial: fix wakup races in the mrst_max3110 driver
      serial: replace open coded mutex with a real mutex in mrst_max3110.c

Feng Tang (2):
      hsu: add a periodic timer to check dma rx channel
      hsu: driver for Medfield High Speed UART device


 drivers/serial/Kconfig        |    9 
 drivers/serial/Makefile       |    1 
 drivers/serial/mfd.c          | 1532 +++++++++++++++++++++++++++++++++++++++++
 drivers/serial/mrst_max3110.c |   61 +-
 include/linux/serial_core.h   |    3 
 include/linux/serial_mfd.h    |   47 +
 include/linux/serial_reg.h    |   16 
 7 files changed, 1634 insertions(+), 35 deletions(-)
 create mode 100644 drivers/serial/mfd.c
 create mode 100644 include/linux/serial_mfd.h

