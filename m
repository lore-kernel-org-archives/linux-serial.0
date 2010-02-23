From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [RFC PATCH 0/2] serial 8250 platform PM hooks
Date: Tue, 23 Feb 2010 19:22:25 +0100
Message-ID: <1266949347-12024-1-git-send-email-manuel.lauss@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:35726 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564Ab0BWSVg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Feb 2010 13:21:36 -0500
Received: by bwz1 with SMTP id 1so1240235bwz.21
        for <linux-serial@vger.kernel.org>; Tue, 23 Feb 2010 10:21:29 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linux Serial <linux-serial@vger.kernel.org>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, Manuel Lauss <manuel.lauss@gmail.com>

The following 2 patches implement a PM hook for platform 8250
UARTs and a sample PM implementation for a MIPS SoC.

Patch #1 hooks a new .pm callback in struct plat_serial8250_port to
the rest of serial_core's PM infrastructure,

Patch #2 implements uart power gating for Alchemy line of mips socs.

With these 2 patches serial console on my test system survives
suspend/resume cycles without having to resort to platform-specific
hacks in the PM code.

Thanks,
     Manuel Lauss

Manuel Lauss (2):
  8250: allow platform uarts to install PM callback.
  Alchemy: UART PM through serial framework.

 arch/mips/alchemy/common/platform.c |   17 +++++++++++++++++
 arch/mips/alchemy/common/power.c    |   35 -----------------------------------
 drivers/serial/8250.c               |   31 ++++++++++++++++++++++++++++---
 include/linux/serial_8250.h         |    6 ++++++
 4 files changed, 51 insertions(+), 38 deletions(-)

