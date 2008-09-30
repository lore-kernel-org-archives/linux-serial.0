From: Aristeu Rozanski <aris@ruivo.org>
Subject: [PATCH RFC 2/6] serial_core: add separated CTS, RTS, DTR, DSR flow control flags
Date: Tue, 30 Sep 2008 14:41:57 -0400
Message-ID: <20080930184156.710710772@ruivo.org>
References: <20080930184155.944902515@ruivo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lobo.ruivo.org ([66.92.68.119]:54568 "EHLO lobo.ruivo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753164AbYI3SmR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Sep 2008 14:42:17 -0400
Received: from jake.ruivo.org (gw.qemu.cathedral [192.168.72.1])
	by lobo.ruivo.org (Postfix) with ESMTP id D0690526DA
	for <linux-serial@vger.kernel.org>; Tue, 30 Sep 2008 14:41:55 -0400 (EDT)
Content-Disposition: inline; filename=serial_core-add_port_flags.patch
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

This patch is the first step to implement hardware flow control using termiox
which will allow the user to customize which pins to use for hardware flow
control.

Signed-off-by: Aristeu Rozanski <aris@redhat.com>

---
 include/linux/serial_core.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- linux-next.orig/include/linux/serial_core.h	2008-09-25 11:50:14.000000000 -0400
+++ linux-next/include/linux/serial_core.h	2008-09-25 11:53:57.000000000 -0400
@@ -288,7 +288,11 @@ struct uart_port {
 #define UPF_LOW_LATENCY		((__force upf_t) (1 << 13))
 #define UPF_BUGGY_UART		((__force upf_t) (1 << 14))
 #define UPF_MAGIC_MULTIPLIER	((__force upf_t) (1 << 16))
-#define UPF_CONS_FLOW		((__force upf_t) (1 << 23))
+#define UPF_FLOW_DTRXOFF	((__force upf_t) (1 << 20))
+#define UPF_FLOW_RTSXOFF	((__force upf_t) (1 << 21))
+#define UPF_FLOW_DSRXON		((__force upf_t) (1 << 22))
+#define UPF_FLOW_CTSXON		((__force upf_t) (1 << 23))
+#define UPF_CONS_FLOW		(UPF_FLOW_RTSXOFF | UPF_FLOW_CTSXON)
 #define UPF_SHARE_IRQ		((__force upf_t) (1 << 24))
 #define UPF_BOOT_AUTOCONF	((__force upf_t) (1 << 28))
 #define UPF_FIXED_PORT		((__force upf_t) (1 << 29))

-- 
Aristeu

