From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 0/5] tty: serial: Updates for altera_jtaguart driver
Date: Thu, 17 Feb 2011 21:28:23 +0100
Message-ID: <cover.1297974227.git.tklauser@distanz.ch>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:39248 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837Ab1BQU2Z (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Feb 2011 15:28:25 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
Cc: nios2-dev@sopc.et.ntust.edu.tw

This patchset adds updates taken from the Nios2 Linux port (currently
out-of-tree) repository to the altera_jtaguart driver.

And this time with the correct cover letter right away :-)

Tobias Klauser (5):
  tty: serial: altera_jtaguart: Don't use plain integer as NULL pointer
  tty: serial: altera_jtaguart: Remove unused function
    early_altera_jtaguart_setup
  tty: serial: altera_jtaguart: Support getting mapbase and IRQ from
    resources
  tty: serial: altera_jtaguart: Fixup type usage of port flags
  tty: serial: altera_jtaguart: Add device tree support

 .../devicetree/bindings/altera_jtaguart.txt        |    4 +
 drivers/tty/serial/altera_jtaguart.c               |  100 +++++++++++---------
 2 files changed, 60 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/altera_jtaguart.txt

