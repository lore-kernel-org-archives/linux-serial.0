From: akpm@linux-foundation.org
Subject: [patch 2/7] serial: fix missing bit coverage of ASYNC_FLAGS
Date: Tue, 20 Jul 2010 15:26:46 -0700
Message-ID: <201007202226.o6KMQkLd021523@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59187 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932862Ab0GTW1Y (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Jul 2010 18:27:24 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com
Cc: linux-serial@vger.kernel.org, akpm@linux-foundation.org, jvillalo@redhat.com, alan@lxorguk.ukuu.org.uk, john.l.villalovos@intel.com

From: John Villalovos <jvillalo@redhat.com>

It seems that currently ASYNC_FLAGS is one bit short of covering all the
bits of the ASYNC user flags.  In particular it does not cover the
ASYNC_AUTOPROBE bit.

ASYNCB_LAST_USER and ASYNCB_AUTOPROBE are both equal to 15.

Therefore:
ASYNC_AUTOPROBE = 1000 0000 0000 0000
ASYNC_FLAGS     = 0111 1111 1111 1111

So ASYNC_FLAGS is not covering the ASYNC_AUTOPROBE bit.

This patch fixes the issue and with the patch the values will be:
ASYNC_AUTOPROBE = 1000 0000 0000 0000
ASYNC_FLAGS     = 1111 1111 1111 1111

As a side note, doing a "git grep" I didn't find any use of
ASYNC_AUTOPROBE or ASYNCB_AUTOPROBE in the kernel, besides this include
file.

Signed-off-by: John Villalovos <john.l.villalovos@intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/serial.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN include/linux/serial.h~serial-fix-missing-bit-coverage-of-async_flags include/linux/serial.h
--- a/include/linux/serial.h~serial-fix-missing-bit-coverage-of-async_flags
+++ a/include/linux/serial.h
@@ -151,7 +151,7 @@ struct serial_uart_config {
 #define ASYNC_BUGGY_UART	(1U << ASYNCB_BUGGY_UART)
 #define ASYNC_AUTOPROBE		(1U << ASYNCB_AUTOPROBE)
 
-#define ASYNC_FLAGS		((1U << ASYNCB_LAST_USER) - 1)
+#define ASYNC_FLAGS		((1U << (ASYNCB_LAST_USER + 1)) - 1)
 #define ASYNC_USR_MASK		(ASYNC_SPD_HI|ASYNC_SPD_VHI| \
 		ASYNC_CALLOUT_NOHUP|ASYNC_SPD_SHI|ASYNC_LOW_LATENCY)
 #define ASYNC_SPD_CUST		(ASYNC_SPD_HI|ASYNC_SPD_VHI)
_
