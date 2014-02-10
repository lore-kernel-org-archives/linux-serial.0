From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 0/8] serial: max310x: Improve driver. Part 2.
Date: Mon, 10 Feb 2014 22:18:29 +0400
Message-ID: <1392056316-13844-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback8.mail.ru ([94.100.176.136]:36576 "EHLO
	fallback8.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbaBJSZ2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Feb 2014 13:25:28 -0500
Received: from smtp32.i.mail.ru (smtp32.i.mail.ru [94.100.177.92])
	by fallback8.mail.ru (mPOP.Fallback_MX) with ESMTP id 54A2E5038DE3
	for <linux-serial@vger.kernel.org>; Mon, 10 Feb 2014 22:19:06 +0400 (MSK)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This patchset provide various improvements/fixes for MAX310X
serial driver.
Series is designed to overlay on top of the first part of a
series of improvements. The end result of this series adds DT
support for this driver and eliminates private header.

Alexander Shiyan (8):
  serial: max310x: Move all SPI-dependent stuff in one place
  serial: max310x: Migrate to CLK API
  serial: max310x: Always use dynamic GPIO ID assignment
  serial: max310x: Add missing mutex_destroy() on driver exit
  serial: max310x: Add support for RS-485 mode
  serial: max310x: Driver cleanup
  serial: max310x: Add devicetree support
  serial: max310x: Add bindings documentation for the MAX310X UARTs

 .../devicetree/bindings/serial/maxim,max310x.txt   |  36 +++
 drivers/tty/serial/max310x.c                       | 340 ++++++++++++---------
 include/linux/platform_data/max310x.h              |  59 ----
 3 files changed, 233 insertions(+), 202 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/maxim,max310x.txt
 delete mode 100644 include/linux/platform_data/max310x.h

-- 
1.8.3.2

