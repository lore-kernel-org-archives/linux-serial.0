From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 0/3] serial: of_serial: new properties
Date: Mon, 25 Mar 2013 13:34:43 +0200
Message-ID: <1364211286-31611-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32083 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756237Ab3CYLet (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Mar 2013 07:34:49 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ley Foon Tan <lftan@altera.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

These add support for  fifo-size and hw-flow-control properties. The
idea is to try to avoid adding new types to 8250.c for UARTs that are
compatible with the standard types but that have different size fifo
or support 16750 compatible auto flow control.


Heikki Krogerus (3):
  serial: 8250: Allow probe drivers to ignore tx_loadsz
  serial: of_serial: Handle fifo-size property
  serial: of_serial: Handle hw-flow-control property

 .../devicetree/bindings/tty/serial/of-serial.txt      |    2 ++
 drivers/tty/serial/8250/8250.c                        |    4 ++++
 drivers/tty/serial/of_serial.c                        |   17 ++++++++++++++---
 3 files changed, 20 insertions(+), 3 deletions(-)

-- 
1.7.10.4

