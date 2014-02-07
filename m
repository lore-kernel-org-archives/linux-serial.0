From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 0/6] serial: max310x: Improve driver. Part 1.
Date: Fri,  7 Feb 2014 18:16:02 +0400
Message-ID: <1391782568-19442-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback7.mail.ru ([94.100.176.135]:37308 "EHLO
	fallback7.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbaBGOQ3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Feb 2014 09:16:29 -0500
Received: from smtp48.i.mail.ru (smtp48.i.mail.ru [94.100.177.108])
	by fallback7.mail.ru (mPOP.Fallback_MX) with ESMTP id 52565F7DF535
	for <linux-serial@vger.kernel.org>; Fri,  7 Feb 2014 18:16:27 +0400 (MSK)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This patchset provide various improvements/fixes for MAX310X
serial driver.

Alexander Shiyan (6):
  serial: max310x: Allow driver to be compiled as module
  serial: max310x: Setup baud rate generator more precisely
  serial: max310x: Remove init() and exit() callbacks
  serial: max310x: Remove excess port configure at startup
  serial: max310x: Add the loopback mode support
  serial: max310x: Remove IRQ validation

 drivers/tty/serial/Kconfig            |  2 +-
 drivers/tty/serial/max310x.c          | 76 +++++++++++++++++------------------
 include/linux/platform_data/max310x.h |  5 ---
 3 files changed, 39 insertions(+), 44 deletions(-)

-- 
1.8.3.2

