From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 0/4] *** SUBJECT HERE ***
Date: Wed,  9 Feb 2011 10:51:10 +0100
Message-ID: <cover.1297244810.git.tklauser@distanz.ch>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:64222 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753464Ab1BIJvL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Feb 2011 04:51:11 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
Cc: nios2-dev@sopc.et.ntust.edu.tw, linux-kernel@vger.kernel.org

*** BLURB HERE ***

Tobias Klauser (4):
  tty: serial: altera_uart: Handle pdev->id == -1 in altera_uart_remove
  tty: serial: altera_uart: Use port->regshift to store bus shift
  tty: serial: altera_uart: Add devicetree support
  MAINTAINERS: Add myself as a maintainer for
    altera_uart/altera_jtaguart

 .../devicetree/bindings/serial/altera_uart.txt     |    7 ++
 MAINTAINERS                                        |   10 +++
 drivers/tty/serial/altera_uart.c                   |   69 ++++++++++++++++----
 3 files changed, 74 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/altera_uart.txt

