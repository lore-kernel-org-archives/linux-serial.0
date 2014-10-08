From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 00/12] Handle TIOC[GS]RS485 iocts on serial_core
Date: Wed,  8 Oct 2014 21:57:26 +0200
Message-ID: <1412798258-23655-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:42109 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbaJHT5w (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Oct 2014 15:57:52 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so8892797lbg.32
        for <linux-serial@vger.kernel.org>; Wed, 08 Oct 2014 12:57:51 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Right now there are six serial drivers doing RS485 ioctl handling. 

Replace all the duplicated implementations with a single ioclt handler and a
callback function.

Ricardo Ribalda Delgado (12):
  serial/max310x: Remove obsolete #ifset TIOC[SG]RS485
  serial/sc16is7xx: Remove obsolete #ifset TIOC[SG]RS485
  serial_core: Handle TIOC[GS]RS485 ioctls.
  serial/8250: Copy RS485 fields to serial_core
  8250/fintek: Use rs485 handler from serial_core
  serial/8250: Remove obsolete handling of rs485 ioctls
  serial/sc16is7xx: Use the rs485 functions on serial_core
  serial/mcf: Use the rs485 functions on serial_core
  serial/atmel: Use the rs485 functions on serial_core
  serial/omap: Use the rs485 functions on serial_core
  drivers/max310: Use the rs485 functions on serial_core
  serial_core: Remove call to driver-specific TIO[GS]RS485]

 drivers/tty/serial/8250/8250_core.c   | 41 +-----------------
 drivers/tty/serial/8250/8250_fintek.c |  8 ++--
 drivers/tty/serial/atmel_serial.c     | 79 +++++++++++------------------------
 drivers/tty/serial/max310x.c          | 72 ++++++++++++-------------------
 drivers/tty/serial/mcf.c              | 37 ++++------------
 drivers/tty/serial/omap-serial.c      | 71 ++++++++++---------------------
 drivers/tty/serial/sc16is7xx.c        | 57 ++++++-------------------
 drivers/tty/serial/serial_core.c      | 38 +++++++++++++++++
 include/linux/serial_8250.h           |  3 --
 include/linux/serial_core.h           |  3 ++
 10 files changed, 141 insertions(+), 268 deletions(-)

-- 
2.1.1

