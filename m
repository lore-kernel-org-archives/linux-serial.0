From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 0/3] serial: 8250: dma related fixes
Date: Thu,  5 Sep 2013 17:34:51 +0300
Message-ID: <1378391694-28725-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59118 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753227Ab3IEOe4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 5 Sep 2013 10:34:56 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org


Heikki Krogerus (3):
  serial: 8250: don't change the fifo trigger level when using dma
  serial: 8250_dw: don't limit DMA support to ACPI
  serial: 8250_dw: provide a filter for DMA channel detection

 drivers/tty/serial/8250/8250_core.c |  2 +-
 drivers/tty/serial/8250/8250_dw.c   | 34 ++++++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 11 deletions(-)

-- 
1.8.4.rc3

