From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: trivial 2.4 HCDP documentation/config patch
Date: Tue, 29 Jul 2003 13:53:49 -0600
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200307291353.49226.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:55737 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S272126AbTG2UBl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Jul 2003 16:01:41 -0400
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-serial@vger.kernel.org

Hi Marcelo,

This just adds help for CONFIG_SERIAL_HCDP and fixes indentation.

#### AUTHOR bjorn.helgaas@hp.com
#### COMMENT START
### Comments for ChangeSet
CONFIG_SERIAL_HCDP documentation and indent fix.
### Comments for Documentation/Configure.help
Add CONFIG_SERIAL_HCDP documentation.
### Comments for drivers/char/Config.in
Fix CONFIG_SERIAL_HCDP indentation.
#### COMMENT END

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1039  -> 1.1040 
#	drivers/char/Config.in	1.46    -> 1.47   
#	Documentation/Configure.help	1.168   -> 1.169  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/07/29	bjorn.helgaas@hp.com	1.1040
# CONFIG_SERIAL_HCDP documentation and indent fix.
# --------------------------------------------
#
diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Tue Jul 29 13:55:03 2003
+++ b/Documentation/Configure.help	Tue Jul 29 13:55:03 2003
@@ -17512,6 +17512,13 @@
 
   If unsure, say N.
 
+Support for serial port described by EFI HCDP table
+CONFIG_SERIAL_HCDP
+  If you wish to make the serial console port described by the EFI
+  HCDP table available for use as serial console or general
+  purpose port, say Y here. See
+  <http://www.dig64.org/specifications/DIG64_HCDPv10a_01.pdf>.
+
 Support for PowerMac serial ports
 CONFIG_MAC_SERIAL
   If you have Macintosh style serial ports (8 pin mini-DIN), say Y
diff -Nru a/drivers/char/Config.in b/drivers/char/Config.in
--- a/drivers/char/Config.in	Tue Jul 29 13:55:03 2003
+++ b/drivers/char/Config.in	Tue Jul 29 13:55:03 2003
@@ -18,7 +18,7 @@
       bool '   serial port on GSC support' CONFIG_SERIAL_GSC
    fi
    if [ "$CONFIG_IA64" = "y" ]; then
-      bool 'Support for serial console port described by EFI HCDP table' CONFIG_SERIAL_HCDP
+      bool '  Support for serial port described by EFI HCDP table' CONFIG_SERIAL_HCDP
    fi
    if [ "$CONFIG_ARCH_ACORN" = "y" ]; then
       tristate '   Atomwide serial port support' CONFIG_ATOMWIDE_SERIAL

