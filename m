From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 33/76] MAINTAINERS: Add myself as a maintainer for altera_uart/altera_jtaguart
Date: Wed, 16 Mar 2011 14:12:03 -0700
Message-ID: <1300309966-5745-33-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32946 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754838Ab1CPVN7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:13:59 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tobias Klauser <tklauser@distanz.ch>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tobias Klauser <tklauser@distanz.ch>

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 MAINTAINERS |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 445537d..1eaeda6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -465,6 +465,16 @@ M:	Matt Turner <mattst88@gmail.com>
 L:	linux-alpha@vger.kernel.org
 F:	arch/alpha/
 
+ALTERA UART/JTAG UART SERIAL DRIVERS
+M:	Tobias Klauser <tklauser@distanz.ch>
+L:	linux-serial@vger.kernel.org
+L:	nios2-dev@sopc.et.ntust.edu.tw (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/tty/serial/altera_uart.c
+F:	drivers/tty/serial/altera_jtaguart.c
+F:	include/linux/altera_uart.h
+F:	include/linux/altera_jtaguart.h
+
 AMD GEODE CS5536 USB DEVICE CONTROLLER DRIVER
 M:	Thomas Dahlmann <dahlmann.thomas@arcor.de>
 L:	linux-geode@lists.infradead.org (moderated for non-subscribers)
-- 
1.7.4.1

