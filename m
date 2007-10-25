From: Jan Nikitenko <jan.nikitenko@gmail.com>
Subject: [PATCH] serial: fix au1xxx UART0 irq setup
Date: Thu, 25 Oct 2007 15:58:54 +0200
Message-ID: <4720A11E.5060101@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060501070907010108080001"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:1590 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756646AbXJYN5a (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Oct 2007 09:57:30 -0400
Received: by ug-out-1314.google.com with SMTP id z38so504958ugc
        for <linux-serial@vger.kernel.org>; Thu, 25 Oct 2007 06:57:28 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------060501070907010108080001
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

UART0 on Alchemy mips platforms (au1xxx) does not use real uart's hw
irq, causing 'ttyS0: 1 input overrun(s)' kernel message with data loss,
when more characters than uart's fifo size were to be received by the uart.

This problem can be experienced for example when uart0 is used as a
serial console on au1550 and more than 16 characters are pasted from
clipboard to the console.

The is_real_interrupt(irq) macro is defined in drivers/serial/8250.c as
a check, if the irq number is other than zero.
Because UART0 on au1xxx platforms uses irq number 0, the
is_real_interrupt() check fails and serial8250_backup_timeout() is used
instead of uart's hw irq.

The patch redefines the is_real_interrupt(irq) macro, as suggested in
the comment above the macro definition in 8250.c, in the
asm-mips/serial.h to be always true for CONFIG_SERIAL_8250_AU1X00.
This allows the irq number 0 to be used as hw irq for the alchemy uart0
and fixes the overrun problem.

Signed-off-by: Jan Nikitenko <jan.nikitenko@gmail.com>

---

 include/asm-mips/serial.h |    5 +++++
 1 file changed, 5 insertions(+)

--------------060501070907010108080001
Content-Type: text/plain;
 name="serial-fix-au1xxx-uart0-irq-setup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial-fix-au1xxx-uart0-irq-setup.patch"

diff --git a/include/asm-mips/serial.h b/include/asm-mips/serial.h
index c07ebd8..526bd2e 100644
--- a/include/asm-mips/serial.h
+++ b/include/asm-mips/serial.h
@@ -19,4 +19,9 @@
  */
 #define BASE_BAUD (1843200 / 16)
 
+#ifdef CONFIG_SERIAL_8250_AU1X00
+#undef is_real_interrupt
+#define is_real_interrupt(irq)  (1)
+#endif
+
 #endif /* _ASM_SERIAL_H */

--------------060501070907010108080001--
