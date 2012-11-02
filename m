From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3] linux,stdout-path helper
Date: Fri,  2 Nov 2012 10:48:51 +0100
Message-ID: <1351849734-9836-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54950 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889Ab2KBJtE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Nov 2012 05:49:04 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

The following adds a helper for matching the linux,stdout-path property
in the chosen node and makes use of it in the i.MX serial driver.

changes since v2:

- move helper to OF core and make it independent of serial devices

changes since v1:

- move it out of the i.MX serial driver and make it generic for serial
  devices.

----------------------------------------------------------------
Sascha Hauer (3):
      OF: Add helper for matching against linux,stdout-path
      serial: i.MX: Make console support non optional
      serial: i.MX: evaluate linux,stdout-path property

 drivers/of/Kconfig         |    3 +++
 drivers/of/Makefile        |    1 +
 drivers/of/of_stdout.c     |   27 +++++++++++++++++++++++++++
 drivers/tty/serial/Kconfig |   16 +---------------
 drivers/tty/serial/imx.c   |   12 +++++-------
 include/linux/of_stdout.h  |   24 ++++++++++++++++++++++++
 6 files changed, 61 insertions(+), 22 deletions(-)
 create mode 100644 drivers/of/of_stdout.c
 create mode 100644 include/linux/of_stdout.h
