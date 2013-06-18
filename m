From: David Daney <ddaney.cavm@gmail.com>
Subject: [PATCH 1/5] Revert "MIPS: Octeon: Fix build error if CONFIG_SERIAL_8250=n"
Date: Tue, 18 Jun 2013 12:12:51 -0700
Message-ID: <1371582775-12141-2-git-send-email-ddaney.cavm@gmail.com>
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:59188 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756307Ab3FRTNG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Jun 2013 15:13:06 -0400
In-Reply-To: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-mips@linux-mips.org, ralf@linux-mips.org, Jamie Iles <jamie@jamieiles.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>

From: David Daney <david.daney@cavium.com>

This reverts commit fc0fcde2ea9740944acf6134d2c84983d1297bc1.
---
 arch/mips/cavium-octeon/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 643809f..e3fd50c 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -12,13 +12,12 @@
 CFLAGS_octeon-platform.o = -I$(src)/../../../scripts/dtc/libfdt
 CFLAGS_setup.o = -I$(src)/../../../scripts/dtc/libfdt
 
-obj-y := cpu.o setup.o octeon-platform.o octeon-irq.o csrc-octeon.o
+obj-y := cpu.o setup.o serial.o octeon-platform.o octeon-irq.o csrc-octeon.o
 obj-y += dma-octeon.o
 obj-y += octeon-memcpy.o
 obj-y += executive/
 
 obj-$(CONFIG_MTD)		      += flash_setup.o
-obj-$(CONFIG_SERIAL_8250)	      += serial.o
 obj-$(CONFIG_SMP)		      += smp.o
 obj-$(CONFIG_OCTEON_ILM)	      += oct_ilm.o
 
-- 
1.7.11.7

