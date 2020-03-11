Return-Path: <SRS0=Gen4=44=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C5AC0044D
	for <linux-serial@archiver.kernel.org>; Wed, 11 Mar 2020 22:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E10120752
	for <linux-serial@archiver.kernel.org>; Wed, 11 Mar 2020 22:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i6eyPqu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbgCKW5n (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:57:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387464AbgCKW5k (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Mar 2020 18:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bg0B1Jp7uoLqckhclI4IviL7y7FNdBtaCLeJxN52Y98=; b=i6eyPqu9zkZNB5N7Z4r6NDZBSv
        TpCfE9rb5+8fUkWQqe+MfhqCktm0X08uZFJR7lKfRvR3PXix79oWLzgvwfLTjCHgWBCcbACNTFSFo
        oiRoEw5GIl8l8JvZKlfUyphFt5ThI5/e4CRz68edL4hey9CbkPnxQUxFvdgz8pPUUUuvvyCyP3N5m
        EMEEytrpntB6pgyf+apN2mObMuMXROqldYQAm0rJXjRrOXLeKO8nrSQmiViz+di0QPgkC7hQaRMFE
        icOfQpkhKBG+SuHF6Gg7wmYZqwe6/TTJxAyqfgB1ANaMolljcfkWee6cbMpefjE2iCVo4Qo5Pe+Zf
        oNJbX5Rw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCAIF-0001PR-8n; Wed, 11 Mar 2020 22:57:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: [PATCH 3/3 v2] tty: reorganize tty & serial menus
Date:   Wed, 11 Mar 2020 15:57:36 -0700
Message-Id: <20200311225736.32147-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200311225736.32147-1-rdunlap@infradead.org>
References: <20200311225736.32147-1-rdunlap@infradead.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Move LDISC_AUTOLOAD ahead of the Serial drivers menu.

Move the Serial drivers menu ahead of the Non-standard serial port
support menu.

Move NOZOMI out of the SERIAL_NONSTANDARD area since it does not
depend on SERIAL_NONSTANDARD and it breaks the SERIAL_NONSTANDARD
menu list.

Alphabetize the remaining drivers (in tty/Kconfig) by their prompt strings.
[The drivers in tty/hvc/Kconfig and tty/serial/Kconfig have not
been alphabetized.]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
---
v2: new patch

 drivers/tty/Kconfig |  173 ++++++++++++++++++++----------------------
 1 file changed, 86 insertions(+), 87 deletions(-)

--- linux-next-20200311.orig/drivers/tty/Kconfig
+++ linux-next-20200311/drivers/tty/Kconfig
@@ -137,7 +137,6 @@ config LEGACY_PTYS
 	  security.  This option enables these legacy devices; on most
 	  systems, it is safe to say N.
 
-
 config LEGACY_PTY_COUNT
 	int "Maximum number of legacy PTY in use"
 	depends on LEGACY_PTYS
@@ -151,6 +150,31 @@ config LEGACY_PTY_COUNT
 	  When not in use, each legacy PTY occupies 12 bytes on 32-bit
 	  architectures and 24 bytes on 64-bit architectures.
 
+config LDISC_AUTOLOAD
+	bool "Automatically load TTY Line Disciplines"
+	default y
+	help
+	  Historically the kernel has always automatically loaded any
+	  line discipline that is in a kernel module when a user asks
+	  for it to be loaded with the TIOCSETD ioctl, or through other
+	  means.  This is not always the best thing to do on systems
+	  where you know you will not be using some of the more
+	  "ancient" line disciplines, so prevent the kernel from doing
+	  this unless the request is coming from a process with the
+	  CAP_SYS_MODULE permissions.
+
+	  Say 'Y' here if you trust your userspace users to do the right
+	  thing, or if you have only provided the line disciplines that
+	  you know you will be using, or if you wish to continue to use
+	  the traditional method of on-demand loading of these modules
+	  by any user.
+
+	  This functionality can be changed at runtime with the
+	  dev.tty.ldisc_autoload sysctl, this configuration option will
+	  only set the default value of this functionality.
+
+source "drivers/tty/serial/Kconfig"
+
 config SERIAL_NONSTANDARD
 	bool "Non-standard serial port support"
 	depends on HAS_IOMEM
@@ -270,16 +294,6 @@ config SYNCLINK_GT
 	  synchronous and asynchronous serial adapters
 	  manufactured by Microgate Systems, Ltd. (www.microgate.com)
 
-config NOZOMI
-	tristate "HSDPA Broadband Wireless Data Card - Globe Trotter"
-	depends on PCI
-	help
-	  If you have a HSDPA driver Broadband Wireless Data Card -
-	  Globe Trotter PCMCIA card, say Y here.
-
-	  To compile this driver as a module, choose M here, the module
-	  will be called nozomi.
-
 config ISI
 	tristate "Multi-Tech multiport card support"
 	depends on SERIAL_NONSTANDARD && PCI
@@ -302,43 +316,6 @@ config N_HDLC
 	  The module will be called n_hdlc. If you want to do that, say M
 	  here.
 
-config N_GSM
-	tristate "GSM MUX line discipline support (EXPERIMENTAL)"
-	depends on NET
-	help
-	  This line discipline provides support for the GSM MUX protocol and
-	  presents the mux as a set of 61 individual tty devices.
-
-config TRACE_ROUTER
-	tristate "Trace data router for MIPI P1149.7 cJTAG standard"
-	depends on TRACE_SINK
-	help
-	  The trace router uses the Linux tty line discipline framework to
-	  route trace data coming from a tty port (say UART for example) to
-	  the trace sink line discipline driver and to another tty port (say
-	  USB). This is part of a solution for the MIPI P1149.7, compact JTAG,
-	  standard, which is for debugging mobile devices. The PTI driver in
-	  drivers/misc/pti.c defines the majority of this MIPI solution.
-
-	  You should select this driver if the target kernel is meant for
-	  a mobile device containing a modem.  Then you will need to select
-	  "Trace data sink for MIPI P1149.7 cJTAG standard" line discipline
-	  driver.
-
-config TRACE_SINK
-	tristate "Trace data sink for MIPI P1149.7 cJTAG standard"
-	help
-	  The trace sink uses the Linux line discipline framework to receive
-	  trace data coming from the trace router line discipline driver
-	  to a user-defined tty port target, like USB.
-	  This is to provide a way to extract modem trace data on
-	  devices that do not have a PTI HW module, or just need modem
-	  trace data to come out of a different HW output port.
-	  This is part of a solution for the P1149.7, compact JTAG, standard.
-
-	  If you select this option, you need to select
-	  "Trace data router for MIPI P1149.7 cJTAG standard".
-
 config PPC_EPAPR_HV_BYTECHAN
 	bool "ePAPR hypervisor byte channel driver"
 	depends on PPC
@@ -374,20 +351,6 @@ config PPC_EARLY_DEBUG_EHV_BC_HANDLE
 	  there simply will be no early console output.  This is true also
 	  if you don't boot under a hypervisor at all.
 
-config NULL_TTY
-	tristate "NULL TTY driver"
-	help
-	  Say Y here if you want a NULL TTY which simply discards messages.
-
-	  This is useful to allow userspace applications which expect a console
-	  device to work without modifications even when no console is
-	  available or desired.
-
-	  In order to use this driver, you should redirect the console to this
-	  TTY, or boot the kernel with console=ttynull.
-
-	  If unsure, say N.
-
 config GOLDFISH_TTY
 	tristate "Goldfish TTY Driver"
 	depends on GOLDFISH
@@ -401,6 +364,23 @@ config GOLDFISH_TTY_EARLY_CONSOLE
 	default y if GOLDFISH_TTY=y
 	select SERIAL_EARLYCON
 
+config N_GSM
+	tristate "GSM MUX line discipline support (EXPERIMENTAL)"
+	depends on NET
+	help
+	  This line discipline provides support for the GSM MUX protocol and
+	  presents the mux as a set of 61 individual tty devices.
+
+config NOZOMI
+	tristate "HSDPA Broadband Wireless Data Card - Globe Trotter"
+	depends on PCI
+	help
+	  If you have a HSDPA driver Broadband Wireless Data Card -
+	  Globe Trotter PCMCIA card, say Y here.
+
+	  To compile this driver as a module, choose M here, the module
+	  will be called nozomi.
+
 config MIPS_EJTAG_FDC_TTY
 	bool "MIPS EJTAG Fast Debug Channel TTY"
 	depends on MIPS_CDMM
@@ -448,38 +428,57 @@ config MIPS_EJTAG_FDC_KGDB_CHAN
 	help
 	  FDC channel number to use for KGDB.
 
-config VCC
-	tristate "Sun Virtual Console Concentrator"
-	depends on SUN_LDOMS
+config NULL_TTY
+	tristate "NULL TTY driver"
 	help
-	  Support for Sun logical domain consoles.
+	  Say Y here if you want a NULL TTY which simply discards messages.
 
-config LDISC_AUTOLOAD
-	bool "Automatically load TTY Line Disciplines"
-	default y
+	  This is useful to allow userspace applications which expect a console
+	  device to work without modifications even when no console is
+	  available or desired.
+
+	  In order to use this driver, you should redirect the console to this
+	  TTY, or boot the kernel with console=ttynull.
+
+	  If unsure, say N.
+
+config TRACE_ROUTER
+	tristate "Trace data router for MIPI P1149.7 cJTAG standard"
+	depends on TRACE_SINK
 	help
-	  Historically the kernel has always automatically loaded any
-	  line discipline that is in a kernel module when a user asks
-	  for it to be loaded with the TIOCSETD ioctl, or through other
-	  means.  This is not always the best thing to do on systems
-	  where you know you will not be using some of the more
-	  "ancient" line disciplines, so prevent the kernel from doing
-	  this unless the request is coming from a process with the
-	  CAP_SYS_MODULE permissions.
+	  The trace router uses the Linux tty line discipline framework to
+	  route trace data coming from a tty port (say UART for example) to
+	  the trace sink line discipline driver and to another tty port (say
+	  USB). This is part of a solution for the MIPI P1149.7, compact JTAG,
+	  standard, which is for debugging mobile devices. The PTI driver in
+	  drivers/misc/pti.c defines the majority of this MIPI solution.
 
-	  Say 'Y' here if you trust your userspace users to do the right
-	  thing, or if you have only provided the line disciplines that
-	  you know you will be using, or if you wish to continue to use
-	  the traditional method of on-demand loading of these modules
-	  by any user.
+	  You should select this driver if the target kernel is meant for
+	  a mobile device containing a modem.  Then you will need to select
+	  "Trace data sink for MIPI P1149.7 cJTAG standard" line discipline
+	  driver.
 
-	  This functionality can be changed at runtime with the
-	  dev.tty.ldisc_autoload sysctl, this configuration option will
-	  only set the default value of this functionality.
+config TRACE_SINK
+	tristate "Trace data sink for MIPI P1149.7 cJTAG standard"
+	help
+	  The trace sink uses the Linux line discipline framework to receive
+	  trace data coming from the trace router line discipline driver
+	  to a user-defined tty port target, like USB.
+	  This is to provide a way to extract modem trace data on
+	  devices that do not have a PTI HW module, or just need modem
+	  trace data to come out of a different HW output port.
+	  This is part of a solution for the P1149.7, compact JTAG, standard.
 
-source "drivers/tty/hvc/Kconfig"
+	  If you select this option, you need to select
+	  "Trace data router for MIPI P1149.7 cJTAG standard".
 
-source "drivers/tty/serial/Kconfig"
+config VCC
+	tristate "Sun Virtual Console Concentrator"
+	depends on SUN_LDOMS
+	help
+	  Support for Sun logical domain consoles.
+
+source "drivers/tty/hvc/Kconfig"
 
 endif # TTY
 
