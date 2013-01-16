From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 0/4] 8250_dw and 8250_dma fixes
Date: Wed, 16 Jan 2013 14:08:12 +0200
Message-ID: <1358338096-32081-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60437 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753614Ab3APMHP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 07:07:15 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

Hi,

The 8250_dma.c needs to be converted to use tty_port since the tty
buffer functions are now changes. The 8250_dw.c needs to have ifdef
wrapping the ACPI code as there are no stubs for ACPI functions. 

There is also an optimisation for 8250_dw.c and an optimisation for
8250_dma.c in this set.


Heikki Krogerus (4):
  serial: 8250_dma: Switch to using tty_port
  serial: 8250_dma: TX optimisation
  serial: 8250_dw: Use ifdef with ACPI
  serial: 8250_dw: Set maxburst size

 drivers/tty/serial/8250/8250_dma.c |   17 ++++++++++-------
 drivers/tty/serial/8250/8250_dw.c  |   13 +++++++++++--
 2 files changed, 21 insertions(+), 9 deletions(-)

-- 
1.7.10.4

