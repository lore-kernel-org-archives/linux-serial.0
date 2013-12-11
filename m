From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 0/2] serial: clps711x: UART driver refactor
Date: Wed, 11 Dec 2013 19:50:16 +0400
Message-ID: <1386777016-24750-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp37.i.mail.ru ([94.100.177.97]:59392 "EHLO smtp37.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070Ab3LKPu2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 11 Dec 2013 10:50:28 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, arm@kenrel.org, Alexander Shiyan <shc_work@mail.ru>

This is a complex patch for refactoring CLPS711X serial driver.
Major changes:
- Eliminate <mach/hardware.h> usage.
- Devicetree support.

Patch created for adding in tty tree, but this changes need attention
from ARM and DT maintainers, so "ACK" will be useful here.

Alexander Shiyan (2):
  serial: clps711x: Driver refactor
  serial: clps711x: dts: Add bindings documentation for the CLPS711X
    UART

 .../bindings/serial/cirrus,clps711x-uart.txt       |  29 ++
 arch/arm/mach-clps711x/devices.c                   |  21 +
 drivers/tty/serial/clps711x.c                      | 448 ++++++++++++---------
 3 files changed, 304 insertions(+), 194 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt

-- 
1.8.3.2

