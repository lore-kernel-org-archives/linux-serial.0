From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH v4 0/2] serial: Drivers for Altera UARTs
Date: Tue, 30 Mar 2010 16:54:40 +0200
Message-ID: <cover.1269960350.git.tklauser@distanz.ch>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx2.zhaw.ch ([160.85.104.51]:43245 "EHLO mx2.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357Ab0C3Oyt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Mar 2010 10:54:49 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Tobias Klauser <tklauser@distanz.ch>, gregkh@suse.de, nios2-dev@sopc.et.ntust.edu.tw, linux-kernel@vger.kernel.org

This is the fourth version of the patchset to add the serial drivers for the
Altera UARTs. The following changes were made on top of the third version
submitted on 5 Mar 2010:

 - altera_uart: Remove usage of altera_uart_getppdcd, altera_uart_getppdtr,
   altera_uart_setppdtr. This makes altera_uart actually compile again (verified
   on x86_64 with Linus' master branch as of today).

Cheers,
Tobias

Tobias Klauser (2):
  serial: Add driver for the Altera JTAG UART
  serial: Add driver for the Altera UART

 drivers/serial/Kconfig           |   52 ++++
 drivers/serial/Makefile          |    2 +
 drivers/serial/altera_jtaguart.c |  504 +++++++++++++++++++++++++++++++++
 drivers/serial/altera_uart.c     |  570 ++++++++++++++++++++++++++++++++++++++
 include/linux/altera_jtaguart.h  |   16 +
 include/linux/altera_uart.h      |   14 +
 include/linux/serial_core.h      |    4 +
 7 files changed, 1162 insertions(+), 0 deletions(-)
 create mode 100644 drivers/serial/altera_jtaguart.c
 create mode 100644 drivers/serial/altera_uart.c
 create mode 100644 include/linux/altera_jtaguart.h
 create mode 100644 include/linux/altera_uart.h

