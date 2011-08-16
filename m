From: Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH 0/2] serial8250: support for DesignWare 8250
Date: Tue, 16 Aug 2011 17:47:45 +0100
Message-ID: <1313513267-25955-1-git-send-email-jamie@jamieiles.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49357 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580Ab1HPQsB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Aug 2011 12:48:01 -0400
Received: by wwf5 with SMTP id 5so106726wwf.1
        for <linux-serial@vger.kernel.org>; Tue, 16 Aug 2011 09:48:00 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: arnd@arndb.de, alan@lxorguk.ukuu.org.uk, Jamie Iles <jamie@jamieiles.com>

This builds on my previous series that removes UPIO_DWAPB and
UPIO_DWAPB32 and allows the DesignWare 8250 extra features to be used.
I've set this up as a helper function that adds the accessors to a
uart_port as I thought this could be used by both of_serial and normal
platform devices.  These helpers could be converted to a set of 8250 ops
once we have that in place.

Jamie

Jamie Iles (2):
  tty: serial8250: add helpers for the DesignWare 8250
  tty: of_serial: add support for the DesignWare 8250

 .../devicetree/bindings/tty/serial/of-serial.txt   |    1 +
 drivers/tty/serial/8250_dw.c                       |   99 ++++++++++++++++++++
 drivers/tty/serial/Kconfig                         |    7 ++
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/of_serial.c                     |    7 ++
 include/linux/serial_8250.h                        |    8 ++
 6 files changed, 123 insertions(+), 0 deletions(-)
 create mode 100644 drivers/tty/serial/8250_dw.c

-- 
1.7.4.1

