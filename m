From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 4/4] MAINTAINERS: Add myself as a maintainer for altera_uart/altera_jtaguart
Date: Wed,  9 Feb 2011 10:58:29 +0100
Message-ID: <04c107d8032cbaffada91066c1d010b9274aebe1.1297245277.git.tklauser@distanz.ch>
References: <cover.1297245277.git.tklauser@distanz.ch>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:64816 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754001Ab1BIJ6a (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Feb 2011 04:58:30 -0500
In-Reply-To: <cover.1297245277.git.tklauser@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
Cc: nios2-dev@sopc.et.ntust.edu.tw, linux-kernel@vger.kernel.org

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 MAINTAINERS |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ecef0f1..4e86a11 100644
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
1.7.0.4

