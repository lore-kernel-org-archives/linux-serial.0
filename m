From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 28/30] mux: fix build problem
Date: Tue, 24 Mar 2009 14:06:45 +0000
Message-ID: <20090324140639.12735.38520.stgit@localhost.localdomain>
References: <20090324135930.12735.7827.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34004 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758481AbZCXOGl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Mar 2009 10:06:41 -0400
In-Reply-To: <20090324135930.12735.7827.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, torvalds@linux-foundation.org

From: Alexander Beregalov <a.beregalov@gmail.com>

Fixes:

In file included from drivers/serial/mux.c:37:
include/linux/serial_core.h: In function 'uart_handle_sysrq_char':
include/linux/serial_core.h:467: error: 'struct uart_port' has no member named 'sysrq'
include/linux/serial_core.h:468: error: 'struct uart_port' has no member named 'sysrq'


Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
Signed-off-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
---

 include/linux/serial_core.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index df9245c..83e4b3f 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -277,7 +277,7 @@ struct uart_port {
 	struct uart_icount	icount;			/* statistics */
 
 	struct console		*cons;			/* struct console, if any */
-#ifdef CONFIG_SERIAL_CORE_CONSOLE
+#if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(SUPPORT_SYSRQ)
 	unsigned long		sysrq;			/* sysrq timeout */
 #endif
 

