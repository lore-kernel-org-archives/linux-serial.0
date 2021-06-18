Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0580C49361
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7433611CE
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhFRGUq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:20:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46780 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhFRGSF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:18:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AE4041FDF9;
        Fri, 18 Jun 2021 06:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vcLmznICkzCP1tnpjE7llznqce1TDBfGeFKnxfywsZY=;
        b=XyOK1dKWTUYBOqgcu6BEefz1+MgDAFah4yoqGaXNgkNcaQSEwuh/vm4PdjkIL8zuh+suvO
        mITyUDV+i8cmw2W+o1MP5zgw/HBol2zqKg4HNPKLfTHxwsIxN7zTm0zR+y/q65kXohBFiO
        EBk1e/EtULQUQwkBo5S/46lxyN4nWwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996931;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vcLmznICkzCP1tnpjE7llznqce1TDBfGeFKnxfywsZY=;
        b=PsNRSRApJYzSIe4vWPwjImFp0oeC322cXUmLPAB6QQdGTMNiz8F+KZgIYGofDsi4Qon6xn
        7XpaWhoMtE6/VoCg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 82929A3BCB;
        Fri, 18 Jun 2021 06:15:31 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 68/70] mxser: Documentation, make the docs up-to-date
Date:   Fri, 18 Jun 2021 08:15:14 +0200
Message-Id: <20210618061516.662-69-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Remove all the obsolete information from the documentation of mxser
driver. Either it was about the out-of-tree driver, or it was superseded
by udev et al.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 .../driver-api/serial/moxa-smartio.rst        | 325 +-----------------
 1 file changed, 9 insertions(+), 316 deletions(-)

diff --git a/Documentation/driver-api/serial/moxa-smartio.rst b/Documentation/driver-api/serial/moxa-smartio.rst
index 3a0a8b502898..838888f81b6d 100644
--- a/Documentation/driver-api/serial/moxa-smartio.rst
+++ b/Documentation/driver-api/serial/moxa-smartio.rst
@@ -2,14 +2,8 @@
 MOXA Smartio/Industio Family Device Driver Installation Guide
 =============================================================
 
-.. note::
-
-   This file is outdated. It needs some care in order to make it
-   updated to Kernel 5.0 and upper
-
 Copyright (C) 2008, Moxa Inc.
-
-Date: 01/21/2008
+Copyright (C) 2021, Jiri Slaby
 
 .. Content
 
@@ -17,12 +11,7 @@ Date: 01/21/2008
    2. System Requirement
    3. Installation
       3.1 Hardware installation
-      3.2 Driver files
-      3.3 Device naming convention
-      3.4 Module driver configuration
-      3.5 Static driver configuration for Linux kernel 2.4.x and 2.6.x.
-      3.6 Custom configuration
-      3.7 Verify driver installation
+      3.2 Device naming convention
    4. Utilities
    5. Setserial
    6. Troubleshooting
@@ -56,11 +45,8 @@ Date: 01/21/2008
 	C168H/PCI,
 	CB-108
 
-   This driver and installation procedure have been developed upon Linux Kernel
-   2.4.x and 2.6.x. This driver supports Intel x86 hardware platform. In order
-   to maintain compatibility, this version has also been properly tested with
-   RedHat, Mandrake, Fedora and S.u.S.E Linux. However, if compatibility problem
-   occurs, please contact Moxa at support@moxa.com.tw.
+   If a compatibility problem occurs, please contact Moxa at
+   support@moxa.com.tw.
 
    In addition to device driver, useful utilities are also provided in this
    version. They are:
@@ -77,14 +63,14 @@ Date: 01/21/2008
    GNU General Public License in this version. Please refer to GNU General
    Public License announcement in each source code file for more detail.
 
-   In Moxa's Web sites, you may always find latest driver at http://www.moxa.com/.
+   In Moxa's Web sites, you may always find latest driver at
+   https://www.moxa.com/.
 
    This version of driver can be installed as Loadable Module (Module driver)
-   or built-in into kernel (Static driver). You may refer to following
-   installation procedure for suitable one. Before you install the driver,
+   or built-in into kernel (Static driver). Before you install the driver,
    please refer to hardware installation procedure in the User's Manual.
 
-   We assume the user should be familiar with following documents.
+   We assume the user should be familiar with following documents:
 
    - Serial-HOWTO
    - Kernel-HOWTO
@@ -92,9 +78,6 @@ Date: 01/21/2008
 2. System Requirement
 ^^^^^^^^^^^^^^^^^^^^^
 
-   - Hardware platform: Intel x86 machine
-   - Kernel version: 2.4.x or 2.6.x
-   - gcc version 2.72 or later
    - Maximum 4 boards can be installed in combination
 
 3. Installation
@@ -118,35 +101,10 @@ PCI IRQ Sharing
    together on one system and they can share the same IRQ.
 
 
-3.2 Driver files
-================
-
-   The driver file may be obtained from ftp, CD-ROM or floppy disk. The
-   first step, anyway, is to copy driver file "mxser.tgz" into specified
-   directory. e.g. /moxa. The execute commands as below::
-
-       # cd /
-       # mkdir moxa
-       # cd /moxa
-       # tar xvf /dev/fd0
-
-or::
-
-       # cd /
-       # mkdir moxa
-       # cd /moxa
-       # cp /mnt/cdrom/<driver directory>/mxser.tgz .
-       # tar xvfz mxser.tgz
 
-
-3.3 Device naming convention
+3.2 Device naming convention
 ============================
 
-   You may find all the driver and utilities files in /moxa/mxser.
-   Following installation procedure depends on the model you'd like to
-   run the driver. If you prefer module driver, please refer to 3.4.
-   If static driver is required, please refer to 3.5.
-
    The device node is named "ttyMxx".
 
 Device naming when more than 2 boards installed
@@ -163,245 +121,6 @@ Device naming when more than 2 boards installed
    4th board	ttyM24 - ttyM31
    ============ ===============
 
-3.4 Module driver configuration
-===============================
-
-   Module driver is easiest way to install. If you prefer static driver
-   installation, please skip this paragraph.
-
-
-   ------------- Prepare to use the MOXA driver --------------------
-
-3.4.1 Create tty device with correct major number
--------------------------------------------------
-
-   Before using MOXA driver, your system must have the tty devices
-   which are created with driver's major number. We offer one shell
-   script "msmknod" to simplify the procedure.
-   This step is only needed to be executed once. But you still
-   need to do this procedure when:
-
-   a. You change the driver's major number. Please refer the "3.7"
-      section.
-   b. Your total installed MOXA boards number is changed. Maybe you
-      add/delete one MOXA board.
-   c. You want to change the tty name. This needs to modify the
-      shell script "msmknod"
-
-   The procedure is::
-
-	 # cd /moxa/mxser/driver
-	 # ./msmknod
-
-   This shell script will require the major number for the device. You also
-   need to specify the total installed MOXA board number. If you need to
-   change to other number, please refer section "3.7" for more detailed
-   procedure. Msmknod will delete any special files occupying the same device
-   naming.
-
-3.4.2 Build the MOXA driver and utilities
------------------------------------------
-
-   Before using the MOXA driver and utilities, you need compile the
-   all the source code. This step is only need to be executed once.
-   But you still re-compile the source code if you modify the source
-   code. For example, if you change the driver's major number (see
-   "3.7" section), then you need to do this step again.
-
-   Find "Makefile" in /moxa/mxser, then run
-
-	 # make clean; make install
-
-   ..note::
-
-	 For Red Hat 9, Red Hat Enterprise Linux AS3/ES3/WS3 & Fedora Core1:
-	 # make clean; make installsp1
-
-	 For Red Hat Enterprise Linux AS4/ES4/WS4:
-	 # make clean; make installsp2
-
-   The driver files "mxser.o" and utilities will be properly compiled
-   and copied to system directories respectively.
-
-------------- Load MOXA driver--------------------
-
-3.4.3 Load the MOXA driver
---------------------------
-
-   ::
-
-	 # modprobe mxser
-
-   will activate the module driver. You may run "lsmod" to check
-   if "mxser" is activated.
-
-------------- Load MOXA driver on boot --------------------
-
-3.4.4 Load the mxser driver
----------------------------
-
-
-   For the above description, you may manually execute
-   "modprobe mxser" to activate this driver and run
-   "rmmod mxser" to remove it.
-
-   However, it's better to have a boot time configuration to
-   eliminate manual operation. Boot time configuration can be
-   achieved by rc file. We offer one "rc.mxser" file to simplify
-   the procedure under "moxa/mxser/driver".
-
-   Run following command for setting rc files::
-
-	 # cd /moxa/mxser/driver
-	 # cp ./rc.mxser /etc/rc.d
-	 # cd /etc/rc.d
-
-   Check "rc.serial" is existed or not. If "rc.serial" doesn't exist,
-   create it by vi, run "chmod 755 rc.serial" to change the permission.
-
-   Add "/etc/rc.d/rc.mxser" in last line.
-
-   Reboot and check if moxa.o activated by "lsmod" command.
-
-3.5 Static driver configuration for Linux kernel 2.4.x and 2.6.x
-================================================================
-
-    Note:
-          To use static driver, you must install the linux kernel
-          source package.
-
-3.5.1 Backup the built-in driver in the kernel
-----------------------------------------------
-
-    ::
-
-       # cd /usr/src/linux/drivers/char
-       # mv mxser.c mxser.c.old
-
-       For Red Hat 7.x user, you need to create link:
-       # cd /usr/src
-       # ln -s linux-2.4 linux
-
-3.5.2 Create link
------------------
-    ::
-
-	  # cd /usr/src/linux/drivers/char
-	  # ln -s /moxa/mxser/driver/mxser.c mxser.c
-
-3.5.3 Setup kernel configuration
---------------------------------
-
-    Configure the kernel::
-
-      # cd /usr/src/linux
-      # make menuconfig
-
-    You will go into a menu-driven system. Please select [Character
-    devices][Non-standard serial port support], enable the [Moxa
-    SmartIO support] driver with "[*]" for built-in (not "[M]"), then
-    select [Exit] to exit this program.
-
-3.5.4 Rebuild kernel
---------------------
-
-    The following are for Linux kernel rebuilding, for your
-    reference only.
-
-    For appropriate details, please refer to the Linux document:
-
-        a. Run the following commands::
-
-	     cd /usr/src/linux
-	     make clean		     # take a few minutes
-	     make dep		     # take a few minutes
-	     make bzImage	     # take probably 10-20 minutes
-	     make install	     # copy boot image to correct position
-
-	f. Please make sure the boot kernel (vmlinuz) is in the
-	   correct position.
-	g. If you use 'lilo' utility, you should check /etc/lilo.conf
-	   'image' item specified the path which is the 'vmlinuz' path,
-	   or you will load wrong (or old) boot kernel image (vmlinuz).
-	   After checking /etc/lilo.conf, please run "lilo".
-
-	  Note that if the result of "make bzImage" is ERROR, then you have to
-	  go back to Linux configuration Setup. Type "make menuconfig" in
-          directory /usr/src/linux.
-
-
-3.5.5 Make tty device and special file
---------------------------------------
-
-    ::
-       # cd /moxa/mxser/driver
-       # ./msmknod
-
-3.5.6 Make utility
-------------------
-
-    ::
-
-	  # cd /moxa/mxser/utility
-	  # make clean; make install
-
-3.5.7 Reboot
-------------
-
-
-
-3.6 Custom configuration
-========================
-
-    Although this driver already provides you default configuration, you
-    still can change the device name and major number. The instruction to
-    change these parameters are shown as below.
-
-a. Change Device name
-
-    If you'd like to use other device names instead of default naming
-    convention, all you have to do is to modify the internal code
-    within the shell script "msmknod". First, you have to open "msmknod"
-    by vi. Locate each line contains "ttyM" and "cum" and change them
-    to the device name you desired. "msmknod" creates the device names
-    you need next time executed.
-
-b. Change Major number
-
-    If major number 30 and 35 had been occupied, you may have to select
-    2 free major numbers for this driver. There are 3 steps to change
-    major numbers.
-
-3.6.1 Find free major numbers
------------------------------
-
-    In /proc/devices, you may find all the major numbers occupied
-    in the system. Please select 2 major numbers that are available.
-    e.g. 40, 45.
-
-3.6.2 Create special files
---------------------------
-
-   Run /moxa/mxser/driver/msmknod to create special files with
-   specified major numbers.
-
-3.6.3 Modify driver with new major number
------------------------------------------
-
-   Run vi to open /moxa/mxser/driver/mxser.c. Locate the line
-   contains "MXSERMAJOR". Change the content as below::
-
-	  #define	  MXSERMAJOR		  40
-	  #define	  MXSERCUMAJOR		  45
-
-    3.6.4 Run "make clean; make install" in /moxa/mxser/driver.
-
-3.7 Verify driver installation
-==============================
-
-    You may refer to /var/log/messages to check the latest status
-    log reported by this driver whenever it's activated.
-
 4. Utilities
 ^^^^^^^^^^^^
 
@@ -409,9 +128,6 @@ b. Change Major number
    msterm. These 3 utilities are released in form of source code. They should
    be compiled into executable file and copied into /usr/bin.
 
-   Before using these utilities, please load driver (refer 3.4 & 3.5) and
-   make sure you had run the "msmknod" utility.
-
 msdiag - Diagnostic
 ===================
 
@@ -479,26 +195,3 @@ msterm - Terminal Emulation
    Solution:
    To avoid this problem, please unplug fifth and after board, because Moxa
    driver supports up to 4 boards.
-
-   Error msg:
-	      Request_irq fail, IRQ(?) may be conflict with another device.
-
-   Solution:
-   Other PCI or ISA devices occupy the assigned IRQ. If you are not sure
-   which device causes the situation, please check /proc/interrupts to find
-   free IRQ and simply change another free IRQ for Moxa board.
-
-   Error msg:
-	      Board #: C1xx Series(CAP=xxx) interrupt number invalid.
-
-   Solution:
-   Each port within the same multiport board shares the same IRQ. Please set
-   one IRQ (IRQ doesn't equal to zero) for one Moxa board.
-
-   Error msg:
-              Couldn't install MOXA Smartio/Industio family driver!
-
-   Solution:
-   Load Moxa driver fail, the major number may conflict with other devices.
-   Please refer to previous section 3.7 to change a free major number for
-   Moxa driver.
-- 
2.32.0

