From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [RFC PATCH 0/2] 8250.c: platform PM callbacks
Date: Wed, 25 Mar 2009 18:55:10 +0100
Message-ID: <1238003712-17521-1-git-send-email-mano@roarinelk.homelinux.net>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:43239 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761262AbZCYRzP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Mar 2009 13:55:15 -0400
Received: by mail-bw0-f169.google.com with SMTP id 17so155199bwz.37
        for <linux-serial@vger.kernel.org>; Wed, 25 Mar 2009 10:55:13 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>
Cc: Manuel Lauss <mano@roarinelk.homelinux.net>

Patch #1 adds a PM callback to struct plat_serial8250_port,
patch #2 demonstrates use on Alchemy internal serial ports.

I need this to be able to disable the serial IP during suspend-to-RAM
and to reset the IP after wakeup.

Comments welcome!

Thanks,
	Manuel Lauss

--- 

Manuel Lauss (2):
  8250: allow platform uarts to install PM callback.
  Alchemy: UART PM through serial framework.

 arch/mips/alchemy/common/platform.c |   21 ++++++++++++++++++++-
 arch/mips/alchemy/common/power.c    |   35 -----------------------------------
 drivers/serial/8250.c               |   31 ++++++++++++++++++++++++++++---
 include/linux/serial_8250.h         |    6 ++++++
 4 files changed, 54 insertions(+), 39 deletions(-)

