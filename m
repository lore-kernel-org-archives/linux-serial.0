From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/2] serial: 8250_dma: couple of cleanups
Date: Thu,  6 Nov 2014 13:28:15 +0200
Message-ID: <1415273297-23323-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:25436 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142AbaKFL2q (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Nov 2014 06:28:46 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Here are couple of cleanups against DMA support for 8250 serial driver.

Since v1:
- rebase on top of tty-testing
- append patch 2/2

Andy Shevchenko (2):
  serial: 8250_dma: call serial8250_tx_dma unconditionally
  serial: 8250_dma: no need to set tx_err twice

 drivers/tty/serial/8250/8250_dma.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

-- 
2.1.1

