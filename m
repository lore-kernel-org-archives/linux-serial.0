From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: [PATCH 7/8] altera_uart: Fix missing prototype for registering an
 early console
Date: Fri, 1 Oct 2010 17:22:55 +0400
Message-ID: <20101001132255.GG25897@oksana.dev.rtsoft.ru>
References: <20101001132045.GA9649@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:65327 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932337Ab0JANXG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Oct 2010 09:23:06 -0400
Content-Disposition: inline
In-Reply-To: <20101001132045.GA9649@oksana.dev.rtsoft.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Tobias Klauser <tklauser@distanz.ch>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Simply add an early_altera_uart_setup() prototype declaration, otherwise
platform code have to do it in .c files, which is ugly.

Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
---
 include/linux/altera_uart.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/altera_uart.h b/include/linux/altera_uart.h
index c022c82..a10a907 100644
--- a/include/linux/altera_uart.h
+++ b/include/linux/altera_uart.h
@@ -5,6 +5,8 @@
 #ifndef	__ALTUART_H
 #define	__ALTUART_H
 
+#include <linux/init.h>
+
 struct altera_uart_platform_uart {
 	unsigned long mapbase;	/* Physical address base */
 	unsigned int irq;	/* Interrupt vector */
@@ -12,4 +14,6 @@ struct altera_uart_platform_uart {
 	unsigned int bus_shift;	/* Bus shift (address stride) */
 };
 
+int __init early_altera_uart_setup(struct altera_uart_platform_uart *platp);
+
 #endif /* __ALTUART_H */
-- 
1.7.0.5

