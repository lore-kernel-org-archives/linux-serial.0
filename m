From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 0/3] serial: max310x: Add support for MAX3109 & MAX14830
Date: Sat, 29 Jun 2013 09:24:16 +0400
Message-ID: <1372483459-11836-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback3.mail.ru ([94.100.176.58]:55793 "EHLO
	fallback3.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab3F2FZA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 29 Jun 2013 01:25:00 -0400
Received: from smtp29.i.mail.ru (smtp29.i.mail.ru [94.100.177.89])
	by fallback3.mail.ru (mPOP.Fallback_MX) with ESMTP id 111A4EABC72E
	for <linux-serial@vger.kernel.org>; Sat, 29 Jun 2013 09:24:58 +0400 (MSK)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This series adds support for dual (MAX3109) and quad (MAX14830) ICs
into the max310x driver.
There are lot of changes in the code, as we had to change almost every
function to achieve the required functionality. Because of this
the first part of the patch can not be divided into smaller parts.
Result was checked for a long time:
MAX3107 with SPI on Cirrus Logic EP7312,
MAX14830 with SPI on Freescale i.MX51 (two ports simultaneously).

Alexander Shiyan (3):
  serial: max310x: Driver rework
  serial: max310x: Add MAX3109 support
  serial: max310x: Add MAX14830 support

 drivers/tty/serial/Kconfig            |   6 +-
 drivers/tty/serial/max310x.c          | 996 ++++++++++++++++++----------------
 include/linux/platform_data/max310x.h |   9 +-
 3 files changed, 531 insertions(+), 480 deletions(-)

-- 
1.8.1.5

