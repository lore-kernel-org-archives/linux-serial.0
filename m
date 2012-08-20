From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 0/3] serial: make serial_uart_config non-global
Date: Mon, 20 Aug 2012 19:56:25 -0400
Message-ID: <1345506988-15390-1-git-send-email-paul.gortmaker@windriver.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:57559 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab2HTX7w (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Aug 2012 19:59:52 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Hirokazu Takata <takata@linux-m32r.org>, "David S. Miller" <davem@davemloft.net>

I happened to notice that serial_uart_config was largely a relic
of the past and only used by two drivers (one of which was just
a trivial use case) so it seemed to make sense to reduce its scope
by removing the trivial use case and giving exclusive ownership
of the struct to the one real remaining user (sparc's sunsu.c).

Build tested on sparc64 defconfig and m32r defconfig.

Paul.
---

Cc: Hirokazu Takata <takata@linux-m32r.org>
Cc: "David S. Miller" <davem@davemloft.net>

Paul Gortmaker (3):
  m32r_sio: remove dependency on struct serial_uart_config
  serial: sunsu.c - don't explicitly tie array size to dynamic entity
  serial: diminish usage of struct serial_uart_config

 drivers/staging/speakup/serialio.h |  3 +--
 drivers/tty/serial/8250/8250.h     |  3 ---
 drivers/tty/serial/m32r_sio.c      | 36 ++----------------------------------
 drivers/tty/serial/sunsu.c         |  8 +++++++-
 include/linux/serial.h             |  6 ------
 5 files changed, 10 insertions(+), 46 deletions(-)

-- 
1.7.11.1

