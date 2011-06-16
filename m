From: Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH 0/5] Remove UPIO_DWAPB{,32} from 8250 driver
Date: Thu, 16 Jun 2011 10:19:56 +0100
Message-ID: <1308216001-5299-1-git-send-email-jamie@jamieiles.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54149 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755772Ab1FPJUH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Jun 2011 05:20:07 -0400
Received: by wwa36 with SMTP id 36so1330937wwa.1
        for <linux-serial@vger.kernel.org>; Thu, 16 Jun 2011 02:20:06 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jamie Iles <jamie@jamieiles.com>

This series removes UPIO_DWAPB and UPIO_DWAPB32 from the 8250 serial driver.
The quirk handling is moved into the platform code for the only user
(MIPS pmc-sierra).

A .handle_irq callback is added to uart_port and uart_8250_port so that
platforms can override IRQ behaviour in a generic way.

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

