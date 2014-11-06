From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 00/11] Handle TIOC[GS]RS485 iocts on serial_core
Date: Thu,  6 Nov 2014 09:22:49 +0100
Message-ID: <1415262180-2694-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:62466 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbaKFIXF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Nov 2014 03:23:05 -0500
Received: by mail-lb0-f172.google.com with SMTP id w7so481494lbi.17
        for <linux-serial@vger.kernel.org>; Thu, 06 Nov 2014 00:23:03 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Right now there are six serial drivers doing RS485 ioctl handling.

Replace all the duplicated implementations with a single ioclt handler and a
callback function.

Change log v2:

-Removed patches already merged on tty-testing
-Rebase to latest tty-next
-Add Reviewed-by

Ricardo Ribalda Delgado (11):
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
  tty/serial_core: Introduce lock mechanism for RS485

 drivers/tty/serial/8250/8250_core.c   | 41 +----------------
 drivers/tty/serial/8250/8250_fintek.c |  8 ++--
 drivers/tty/serial/atmel_serial.c     | 87 +++++++++++------------------------
 drivers/tty/serial/max310x.c          | 70 +++++++++++-----------------
 drivers/tty/serial/mcf.c              | 42 ++++-------------
 drivers/tty/serial/omap-serial.c      | 74 +++++++++--------------------
 drivers/tty/serial/sc16is7xx.c        | 53 +++++----------------
 drivers/tty/serial/serial_core.c      | 49 ++++++++++++++++++++
 include/linux/serial_8250.h           |  3 --
 include/linux/serial_core.h           |  3 ++
 10 files changed, 156 insertions(+), 274 deletions(-)

-- 
2.1.1

