From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [RFC PATCH 0/2] serial 8250 platform PM hooks
Date: Wed, 24 Mar 2010 18:16:24 +0100
Message-ID: <1269450986-3714-1-git-send-email-manuel.lauss@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:5059 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873Ab0CXRPR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Mar 2010 13:15:17 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, Manuel Lauss <manuel.lauss@gmail.com>

The following 2 patches implement a PM hook for platform 8250
UARTs and a sample PM implementation for a MIPS SoC.

Patch #1 hooks a new .pm callback in struct plat_serial8250_port to
the rest of serial_core's PM infrastructure,

Patch #2 implements uart power gating for Alchemy line of mips socs
using the new hook.

With these 2 patches serial console on my test system survives
suspend/resume cycles without having to resort to platform-specific
hacks in the PM code.

Thanks,
     Manuel Lauss

Manuel Lauss (2):
  8250: allow platform uarts to install PM callback.
  Alchemy: UART PM through serial framework.

 arch/mips/alchemy/common/platform.c |   17 +++++++++++++++++
 arch/mips/alchemy/common/power.c    |   32 --------------------------------
 drivers/serial/8250.c               |   31 ++++++++++++++++++++++++++++---
 include/linux/serial_8250.h         |    6 ++++++
 4 files changed, 51 insertions(+), 35 deletions(-)

