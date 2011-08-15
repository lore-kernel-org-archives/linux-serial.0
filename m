From: Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH 0/5] Remove UPIO_DWAPB{,32} from 8250 driver
Date: Mon, 15 Aug 2011 10:17:50 +0100
Message-ID: <1313399875-11006-1-git-send-email-jamie@jamieiles.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39182 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab1HOJSB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Aug 2011 05:18:01 -0400
Received: by wyg24 with SMTP id 24so3358602wyg.19
        for <linux-serial@vger.kernel.org>; Mon, 15 Aug 2011 02:18:00 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: arnd@arndb.de, Jamie Iles <jamie@jamieiles.com>

This is just a repost of a series from a couple of months ago to remove
the special DWAPB 8250 handling from the generic driver.

Arnd, I'd have a platform that needs some special handlers like these
using the device tree and of_serial.  Once these are merged I plan on
passing the serial_{in,out} and handle_irq callbacks through
platform_data to of_serial.  Does this seem sensible?

Jamie

Jamie Iles (5):
  tty: serial: allow ports to override the irq handler
  tty: serial8250: allow platforms to override irq handler
  mips: msp71xx/serial: convert to pr_foo() helpers
  mips: msp71xx/serial: add workaround for DW UART
  tty: serial8250: remove UPIO_DWAPB{,32}

 arch/mips/pmc-sierra/msp71xx/msp_serial.c |   73 ++++++++++++++++++--
 drivers/tty/serial/8250.c                 |  107 +++++++++-------------------
 drivers/tty/serial/serial_core.c          |    4 -
 include/linux/serial_8250.h               |    2 +
 include/linux/serial_core.h               |    5 +-
 5 files changed, 106 insertions(+), 85 deletions(-)

-- 
1.7.4.1

