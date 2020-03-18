Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B69C10DCE
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 14:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F6A20774
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 14:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgCRO1U (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:27:20 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37354 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbgCRO1A (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 10:27:00 -0400
Received: from [94.134.91.63] (helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jEZen-0004YX-OA; Wed, 18 Mar 2020 15:26:53 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 2/7] serial: 8250: add serial_in_poll_timeout helper
Date:   Wed, 18 Mar 2020 15:26:35 +0100
Message-Id: <20200318142640.982763-3-heiko@sntech.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318142640.982763-1-heiko@sntech.de>
References: <20200318142640.982763-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

In cases where a serial register needs to be polled until a specific
state, this should have a timeout as noted in the thread bringing em485
support to 8250_dw.

To not re-implement timeout handling in each case, add a helper modelled
after readx_poll_timeout / regmap_read_poll_timeout to facilitate this.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 drivers/tty/serial/8250/8250.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 33ad9d6de532..50a4c174410d 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -118,6 +118,40 @@ static inline void serial_out(struct uart_8250_port *up, int offset, int value)
 	up->port.serial_out(&up->port, offset, value);
 }
 
+/**
+ * serial_in_poll_timeout - Poll until a condition is met or a timeout occurs
+ *
+ * @port: uart_8250_port to read from
+ * @offs: Offset to poll
+ * @val: Integer variable to read the value into
+ * @cond: Break condition (usually involving @val)
+ * @timeout_us: Timeout in us, 0 means never timeout
+ *
+ * Returns 0 on success and -ETIMEDOUT upon a timeout or the serial_in
+ * error return value in case of a error read.
+ *
+ * This is modelled after the readx_poll_timeout macros in linux/iopoll.h.
+ */
+#define serial_in_poll_timeout(port, offs, val, cond, timeout_us) \
+({ \
+	u64 __timeout_us = (timeout_us); \
+	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
+	for (;;) { \
+		val = serial_in((port), (offs)); \
+		if (val < 0) \
+			break; \
+		if (cond) \
+			break; \
+		if ((__timeout_us) && \
+		    ktime_compare(ktime_get(), __timeout) > 0) { \
+			val = serial_in((port), (offs)); \
+			break; \
+		} \
+		cpu_relax(); \
+	} \
+	(val < 0) ? val : ((cond) ? 0 : -ETIMEDOUT); \
+})
+
 void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p);
 
 static inline int serial_dl_read(struct uart_8250_port *up)
-- 
2.24.1

