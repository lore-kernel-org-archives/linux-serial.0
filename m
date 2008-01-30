From: Bryan Wu <bryan.wu@analog.com>
Subject: [PATCH 07/12] [Blackfin] serial driver: add extra IRQ flag for 8250 serial driver
Date: Wed, 30 Jan 2008 17:30:07 +0800
Message-ID: <1201685412-29095-8-git-send-email-bryan.wu@analog.com>
References: <1201685412-29095-1-git-send-email-bryan.wu@analog.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:40738 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756354AbYA3JaU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Jan 2008 04:30:20 -0500
In-Reply-To: <1201685412-29095-1-git-send-email-bryan.wu@analog.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Javier Herrero <jherrero@hvsistemas.es>, Bryan Wu <bryan.wu@analog.com>

From: Javier Herrero <jherrero@hvsistemas.es>

Signed-off-by: Javier Herrero <jherrero@hvsistemas.es>
Signed-off-by: Bryan Wu <bryan.wu@analog.com>
---
 include/asm-blackfin/serial.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-blackfin/serial.h

diff --git a/include/asm-blackfin/serial.h b/include/asm-blackfin/serial.h
new file mode 100644
index 0000000..994dd86
--- /dev/null
+++ b/include/asm-blackfin/serial.h
@@ -0,0 +1,5 @@
+/*
+ * include/asm-blackfin/serial.h
+ */
+
+#define SERIAL_EXTRA_IRQ_FLAGS IRQF_TRIGGER_HIGH
-- 
1.5.3.4
