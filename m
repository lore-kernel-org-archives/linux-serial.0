From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/5] tty: serial: get rid of .set_wake()
Date: Tue, 15 Oct 2013 09:19:29 +0200
Message-ID: <1381821569-19343-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:62145 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab3JOHUF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Oct 2013 03:20:05 -0400
Received: by mail-wg0-f48.google.com with SMTP id b13so7131005wgh.27
        for <linux-serial@vger.kernel.org>; Tue, 15 Oct 2013 00:20:03 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>

The .set_wake() vtable entry in struct uart_ops appear to have
been unused since kernel 2.5 times. It has since been superceded
by struct dev_pm_ops in struct device and this will likely never
be resurrected, so delete this dead entry.

More details in patch 5/5.

Linus Walleij (5):
  serial: omap: delete .set_wake callback
  serial: sa1100: delete .set_wake callback
  serial: mpc52xx: remove reference to .set_wake()
  serial: pch_uart: remove reference to .set_wake()
  serial: core: delete .set_wake() callback

 Documentation/serial/driver       |  4 ----
 drivers/tty/serial/mpc52xx_uart.c |  1 -
 drivers/tty/serial/omap-serial.c  | 10 ----------
 drivers/tty/serial/pch_uart.c     |  1 -
 drivers/tty/serial/sa1100.c       |  5 ++++-
 include/linux/serial_core.h       |  1 -
 6 files changed, 4 insertions(+), 18 deletions(-)

-- 
1.8.3.1

