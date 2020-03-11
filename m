Return-Path: <SRS0=Gen4=44=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF74C4CECE
	for <linux-serial@archiver.kernel.org>; Wed, 11 Mar 2020 22:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828272075F
	for <linux-serial@archiver.kernel.org>; Wed, 11 Mar 2020 22:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p2jYHrKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387463AbgCKW5j (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:57:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58304 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387409AbgCKW5j (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Mar 2020 18:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5Iny0oW8kOcIg3CL6ITSaM3fSlMx2RkakItyz9/TiPs=; b=p2jYHrKdkvixzImKI+G3jyKbTf
        gGCb5ZtODgRtesPh/FkpzPdFyV2HwldzukFv5eNw3VWwctUUi8+bOJsY2PRxUx9vLw6vzzowksvhb
        VrXxr/IjK+Vao8oLx99ctFhSz4emOmwhi9GUQ+uGKAfjFd3tAEKTABoG83ceecOtCDPkMTpI32Cmc
        gQycyldBwQeZYpVHu03KXv0iZQ1Xy+jszVYJpm/P3lI8Ps/vRSi9Odq1q4lKk9H1sX2zMLDQdO0pZ
        1oHOUGcpSWUBqkioAoNHGUtBbtVUXRiuMYaQk9UACY5sSo65SNvwWohIba1AAc5+VF+kmbAEJl1tw
        SYA60m4w==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCAIE-0001PR-Do; Wed, 11 Mar 2020 22:57:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: [PATCH 1/3 v2] char: group dev configs togther
Date:   Wed, 11 Mar 2020 15:57:34 -0700
Message-Id: <20200311225736.32147-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200311225736.32147-1-rdunlap@infradead.org>
References: <20200311225736.32147-1-rdunlap@infradead.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Group /dev/{mem,kmem,nvram,raw,port} driver configs together.
This also means that tty configs are now grouped together instead
of being split up.

This just moves Kconfig lines around. There are no other changes.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
---
v2: no change

 drivers/char/Kconfig |  100 ++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 50 deletions(-)

--- linux-next-20200311.orig/drivers/char/Kconfig
+++ linux-next-20200311/drivers/char/Kconfig
@@ -7,25 +7,6 @@ menu "Character devices"
 
 source "drivers/tty/Kconfig"
 
-config DEVMEM
-	bool "/dev/mem virtual device support"
-	default y
-	help
-	  Say Y here if you want to support the /dev/mem device.
-	  The /dev/mem device is used to access areas of physical
-	  memory.
-	  When in doubt, say "Y".
-
-config DEVKMEM
-	bool "/dev/kmem virtual device support"
-	# On arm64, VMALLOC_START < PAGE_OFFSET, which confuses kmem read/write
-	depends on !ARM64
-	help
-	  Say Y here if you want to support the /dev/kmem device. The
-	  /dev/kmem device is rarely used, but can be used for certain
-	  kind of kernel debugging operations.
-	  When in doubt, say "N".
-
 source "drivers/tty/serial/Kconfig"
 source "drivers/tty/serdev/Kconfig"
 
@@ -220,29 +201,6 @@ config NWFLASH
 
 source "drivers/char/hw_random/Kconfig"
 
-config NVRAM
-	tristate "/dev/nvram support"
-	depends on X86 || HAVE_ARCH_NVRAM_OPS
-	default M68K || PPC
-	---help---
-	  If you say Y here and create a character special file /dev/nvram
-	  with major number 10 and minor number 144 using mknod ("man mknod"),
-	  you get read and write access to the non-volatile memory.
-
-	  /dev/nvram may be used to view settings in NVRAM or to change them
-	  (with some utility). It could also be used to frequently
-	  save a few bits of very important data that may not be lost over
-	  power-off and for which writing to disk is too insecure. Note
-	  however that most NVRAM space in a PC belongs to the BIOS and you
-	  should NEVER idly tamper with it. See Ralf Brown's interrupt list
-	  for a guide to the use of CMOS bytes by your BIOS.
-
-	  This memory is conventionally called "NVRAM" on PowerPC machines,
-	  "CMOS RAM" on PCs, "NVRAM" on Ataris and "PRAM" on Macintoshes.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called nvram.
-
 #
 # These legacy RTC drivers just cause too many conflicts with the generic
 # RTC framework ... let's not even try to coexist any more.
@@ -431,6 +389,48 @@ config NSC_GPIO
 	  pc8736x_gpio drivers.  If those drivers are built as
 	  modules, this one will be too, named nsc_gpio
 
+config DEVMEM
+	bool "/dev/mem virtual device support"
+	default y
+	help
+	  Say Y here if you want to support the /dev/mem device.
+	  The /dev/mem device is used to access areas of physical
+	  memory.
+	  When in doubt, say "Y".
+
+config DEVKMEM
+	bool "/dev/kmem virtual device support"
+	# On arm64, VMALLOC_START < PAGE_OFFSET, which confuses kmem read/write
+	depends on !ARM64
+	help
+	  Say Y here if you want to support the /dev/kmem device. The
+	  /dev/kmem device is rarely used, but can be used for certain
+	  kind of kernel debugging operations.
+	  When in doubt, say "N".
+
+config NVRAM
+	tristate "/dev/nvram support"
+	depends on X86 || HAVE_ARCH_NVRAM_OPS
+	default M68K || PPC
+	---help---
+	  If you say Y here and create a character special file /dev/nvram
+	  with major number 10 and minor number 144 using mknod ("man mknod"),
+	  you get read and write access to the non-volatile memory.
+
+	  /dev/nvram may be used to view settings in NVRAM or to change them
+	  (with some utility). It could also be used to frequently
+	  save a few bits of very important data that may not be lost over
+	  power-off and for which writing to disk is too insecure. Note
+	  however that most NVRAM space in a PC belongs to the BIOS and you
+	  should NEVER idly tamper with it. See Ralf Brown's interrupt list
+	  for a guide to the use of CMOS bytes by your BIOS.
+
+	  This memory is conventionally called "NVRAM" on PowerPC machines,
+	  "CMOS RAM" on PCs, "NVRAM" on Ataris and "PRAM" on Macintoshes.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called nvram.
+
 config RAW_DRIVER
 	tristate "RAW driver (/dev/raw/rawN)"
 	depends on BLOCK
@@ -452,6 +452,14 @@ config MAX_RAW_DEVS
 	  Default is 256. Increase this number in case you need lots of
 	  raw devices.
 
+config DEVPORT
+	bool "/dev/port character device"
+	depends on ISA || PCI
+	default y
+	help
+	  Say Y here if you want to support the /dev/port device. The /dev/port
+	  device is similar to /dev/mem, but for I/O ports.
+
 config HPET
 	bool "HPET - High Precision Event Timer" if (X86 || IA64)
 	default n
@@ -511,14 +519,6 @@ config TELCLOCK
 	  /sys/devices/platform/telco_clock, with a number of files for
 	  controlling the behavior of this hardware.
 
-config DEVPORT
-	bool "/dev/port character device"
-	depends on ISA || PCI
-	default y
-	help
-	  Say Y here if you want to support the /dev/port device. The /dev/port
-	  device is similar to /dev/mem, but for I/O ports.
-
 source "drivers/s390/char/Kconfig"
 
 source "drivers/char/xillybus/Kconfig"
