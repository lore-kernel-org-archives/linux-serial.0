From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 0/4] Medfield HSU serial
Date: Mon, 26 Jul 2010 10:17:56 +0100
Message-ID: <20100726091542.21579.55123.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:52817 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754021Ab0GZJvG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 26 Jul 2010 05:51:06 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

The Medfield platform has its own high speed UART with DMA support. This
patch set enables it but leaves some of the DMA off for the moment while
we get the DMA controller merged and a few other oddments in place.

---

Feng Tang (4):
      hsu: call PCI pm hooks in suspend/resume function
      hsu: some code cleanup
      hsu: add a periodic timer to check dma rx channel
      hsu: driver for Medfield High Speed UART device


 drivers/serial/Kconfig      |   10 
 drivers/serial/Makefile     |    1 
 drivers/serial/mfd.c        | 1498 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/serial_core.h |    2 
 include/linux/serial_reg.h  |   16 
 5 files changed, 1527 insertions(+), 0 deletions(-)
 create mode 100644 drivers/serial/mfd.c

-- 
toolroom chaos: File not found

