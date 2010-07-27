From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 0/4] Medfield HSU serial
Date: Tue, 27 Jul 2010 08:20:11 +0100
Message-ID: <20100727071936.26058.23502.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55992 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752425Ab0G0Hxh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Jul 2010 03:53:37 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

With the header file escape fixed (sorry about that)
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
 include/linux/serial_mfd.h  |   47 +
 include/linux/serial_reg.h  |   16 
 6 files changed, 1574 insertions(+), 0 deletions(-)
 create mode 100644 drivers/serial/mfd.c
 create mode 100644 include/linux/serial_mfd.h

