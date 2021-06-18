Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BFDC48BE8
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3C8F61154
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbhFRGRk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:17:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58898 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbhFRGR1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F060C21B4C;
        Fri, 18 Jun 2021 06:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tXGOhdln+pG9u9TiQDZ26g25kUECzjYEBniA8nuTcFo=;
        b=ZXw5koD9tuA3Am21CglZsdgyPQVPHRGSLKDKBrbNqXrl5UeYl6P/B0oI8uMAhpYySt/Nbv
        SSmFEBKAYaVmYgN3a4kwK/PHLIpweB0YmmHf9C+1tf9LNmr3D8MJNCG3FCitqLF4k0Lhxj
        mxHG91B9Va4LN6Y892+gijKM5HvMsxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996917;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tXGOhdln+pG9u9TiQDZ26g25kUECzjYEBniA8nuTcFo=;
        b=XTK5oInusD5jJYJ60pA3j6rt2BXtujUb1DRwPXWTIKGO1xfVSfwmrTbE3OKEuppmi7KTqW
        QdMc8CEnryjbBfCg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D16C6A3BA3;
        Fri, 18 Jun 2021 06:15:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 04/70] mxser: integrate mxser.h into .c
Date:   Fri, 18 Jun 2021 08:14:10 +0200
Message-Id: <20210618061516.662-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

As mxser.h serves only mxser.c, integrate the definitions into .c and
drop .h. There are some "semi-public" ioctl definitions, but they are
mostly go away in the next patches. If something, they would need to
live in an uapi header anyway.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 130 +++++++++++++++++++++++++++++++++++++-
 drivers/tty/mxser.h | 151 --------------------------------------------
 2 files changed, 129 insertions(+), 152 deletions(-)
 delete mode 100644 drivers/tty/mxser.h

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index d91f8e791aab..0c779559f978 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -41,7 +41,135 @@
 #include <asm/irq.h>
 #include <linux/uaccess.h>
 
-#include "mxser.h"
+/*
+ *	Semi-public control interfaces
+ */
+
+/*
+ *	MOXA ioctls
+ */
+
+#define MOXA			0x400
+#define MOXA_GETDATACOUNT	(MOXA + 23)
+#define MOXA_DIAGNOSE		(MOXA + 50)
+#define MOXA_CHKPORTENABLE	(MOXA + 60)
+#define MOXA_HighSpeedOn	(MOXA + 61)
+#define MOXA_GET_MAJOR		(MOXA + 63)
+#define MOXA_GETMSTATUS		(MOXA + 65)
+#define MOXA_SET_OP_MODE	(MOXA + 66)
+#define MOXA_GET_OP_MODE	(MOXA + 67)
+
+#define RS232_MODE		0
+#define RS485_2WIRE_MODE	1
+#define RS422_MODE		2
+#define RS485_4WIRE_MODE	3
+#define OP_MODE_MASK		3
+
+#define MOXA_SDS_RSTICOUNTER	(MOXA + 69)
+#define MOXA_ASPP_OQUEUE	(MOXA + 70)
+#define MOXA_ASPP_MON		(MOXA + 73)
+#define MOXA_ASPP_LSTATUS	(MOXA + 74)
+#define MOXA_ASPP_MON_EXT	(MOXA + 75)
+#define MOXA_SET_BAUD_METHOD	(MOXA + 76)
+
+/* --------------------------------------------------- */
+
+#define NPPI_NOTIFY_PARITY	0x01
+#define NPPI_NOTIFY_FRAMING	0x02
+#define NPPI_NOTIFY_HW_OVERRUN	0x04
+#define NPPI_NOTIFY_SW_OVERRUN	0x08
+#define NPPI_NOTIFY_BREAK	0x10
+
+#define NPPI_NOTIFY_CTSHOLD         0x01	/* Tx hold by CTS low */
+#define NPPI_NOTIFY_DSRHOLD         0x02	/* Tx hold by DSR low */
+#define NPPI_NOTIFY_XOFFHOLD        0x08	/* Tx hold by Xoff received */
+#define NPPI_NOTIFY_XOFFXENT        0x10	/* Xoff Sent */
+
+/*
+ * Follow just what Moxa Must chip defines.
+ *
+ * When LCR register (offset 0x03) writes the following value, the Must chip
+ * will enter enchance mode. And write value on EFR (offset 0x02) bit 6,7 to
+ * change bank.
+ */
+#define MOXA_MUST_ENTER_ENCHANCE	0xBF
+
+/* when enhance mode enabled, access on general bank register */
+#define MOXA_MUST_GDL_REGISTER		0x07
+#define MOXA_MUST_GDL_MASK		0x7F
+#define MOXA_MUST_GDL_HAS_BAD_DATA	0x80
+
+#define MOXA_MUST_LSR_RERR		0x80	/* error in receive FIFO */
+/* enchance register bank select and enchance mode setting register */
+/* when LCR register equals to 0xBF */
+#define MOXA_MUST_EFR_REGISTER		0x02
+#define MOXA_MUST_EFR_EFRB_ENABLE	0x10 /* enchance mode enable */
+/* enchance register bank set 0, 1, 2 */
+#define MOXA_MUST_EFR_BANK0		0x00
+#define MOXA_MUST_EFR_BANK1		0x40
+#define MOXA_MUST_EFR_BANK2		0x80
+#define MOXA_MUST_EFR_BANK3		0xC0
+#define MOXA_MUST_EFR_BANK_MASK		0xC0
+
+/* set XON1 value register, when LCR=0xBF and change to bank0 */
+#define MOXA_MUST_XON1_REGISTER		0x04
+
+/* set XON2 value register, when LCR=0xBF and change to bank0 */
+#define MOXA_MUST_XON2_REGISTER		0x05
+
+/* set XOFF1 value register, when LCR=0xBF and change to bank0 */
+#define MOXA_MUST_XOFF1_REGISTER	0x06
+
+/* set XOFF2 value register, when LCR=0xBF and change to bank0 */
+#define MOXA_MUST_XOFF2_REGISTER	0x07
+
+#define MOXA_MUST_RBRTL_REGISTER	0x04
+#define MOXA_MUST_RBRTH_REGISTER	0x05
+#define MOXA_MUST_RBRTI_REGISTER	0x06
+#define MOXA_MUST_THRTL_REGISTER	0x07
+#define MOXA_MUST_ENUM_REGISTER		0x04
+#define MOXA_MUST_HWID_REGISTER		0x05
+#define MOXA_MUST_ECR_REGISTER		0x06
+#define MOXA_MUST_CSR_REGISTER		0x07
+
+#define MOXA_MUST_FCR_GDA_MODE_ENABLE	0x20 /* good data mode enable */
+#define MOXA_MUST_FCR_GDA_ONLY_ENABLE	0x10 /* only good data put into RxFIFO */
+
+#define MOXA_MUST_IER_ECTSI		0x80 /* enable CTS interrupt */
+#define MOXA_MUST_IER_ERTSI		0x40 /* enable RTS interrupt */
+#define MOXA_MUST_IER_XINT		0x20 /* enable Xon/Xoff interrupt */
+#define MOXA_MUST_IER_EGDAI		0x10 /* enable GDA interrupt */
+
+#define MOXA_MUST_RECV_ISR		(UART_IER_RDI | MOXA_MUST_IER_EGDAI)
+
+/* GDA interrupt pending */
+#define MOXA_MUST_IIR_GDA		0x1C
+#define MOXA_MUST_IIR_RDA		0x04
+#define MOXA_MUST_IIR_RTO		0x0C
+#define MOXA_MUST_IIR_LSR		0x06
+
+/* received Xon/Xoff or specical interrupt pending */
+#define MOXA_MUST_IIR_XSC		0x10
+
+/* RTS/CTS change state interrupt pending */
+#define MOXA_MUST_IIR_RTSCTS		0x20
+#define MOXA_MUST_IIR_MASK		0x3E
+
+#define MOXA_MUST_MCR_XON_FLAG		0x40
+#define MOXA_MUST_MCR_XON_ANY		0x80
+#define MOXA_MUST_MCR_TX_XON		0x08
+
+#define MOXA_MUST_EFR_SF_MASK		0x0F /* software flow control on chip mask value */
+#define MOXA_MUST_EFR_SF_TX1		0x08 /* send Xon1/Xoff1 */
+#define MOXA_MUST_EFR_SF_TX2		0x04 /* send Xon2/Xoff2 */
+#define MOXA_MUST_EFR_SF_TX12		0x0C /* send Xon1,Xon2/Xoff1,Xoff2 */
+#define MOXA_MUST_EFR_SF_TX_NO		0x00 /* don't send Xon/Xoff */
+#define MOXA_MUST_EFR_SF_TX_MASK	0x0C /* Tx software flow control mask */
+#define MOXA_MUST_EFR_SF_RX_NO		0x00 /* don't receive Xon/Xoff */
+#define MOXA_MUST_EFR_SF_RX1		0x02 /* receive Xon1/Xoff1 */
+#define MOXA_MUST_EFR_SF_RX2		0x01 /* receive Xon2/Xoff2 */
+#define MOXA_MUST_EFR_SF_RX12		0x03 /* receive Xon1,Xon2/Xoff1,Xoff2 */
+#define MOXA_MUST_EFR_SF_RX_MASK	0x03 /* Rx software flow control mask */
 
 #define	MXSERMAJOR	 174
 
diff --git a/drivers/tty/mxser.h b/drivers/tty/mxser.h
deleted file mode 100644
index e6cb15626567..000000000000
--- a/drivers/tty/mxser.h
+++ /dev/null
@@ -1,151 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _MXSER_H
-#define _MXSER_H
-
-/*
- *	Semi-public control interfaces
- */
-
-/*
- *	MOXA ioctls
- */
-
-#define MOXA			0x400
-#define MOXA_GETDATACOUNT	(MOXA + 23)
-#define MOXA_DIAGNOSE		(MOXA + 50)
-#define MOXA_CHKPORTENABLE	(MOXA + 60)
-#define MOXA_HighSpeedOn	(MOXA + 61)
-#define MOXA_GET_MAJOR		(MOXA + 63)
-#define MOXA_GETMSTATUS		(MOXA + 65)
-#define MOXA_SET_OP_MODE	(MOXA + 66)
-#define MOXA_GET_OP_MODE	(MOXA + 67)
-
-#define RS232_MODE		0
-#define RS485_2WIRE_MODE	1
-#define RS422_MODE		2
-#define RS485_4WIRE_MODE	3
-#define OP_MODE_MASK		3
-
-#define MOXA_SDS_RSTICOUNTER	(MOXA + 69)
-#define MOXA_ASPP_OQUEUE  	(MOXA + 70)
-#define MOXA_ASPP_MON     	(MOXA + 73)
-#define MOXA_ASPP_LSTATUS 	(MOXA + 74)
-#define MOXA_ASPP_MON_EXT 	(MOXA + 75)
-#define MOXA_SET_BAUD_METHOD	(MOXA + 76)
-
-/* --------------------------------------------------- */
-
-#define NPPI_NOTIFY_PARITY	0x01
-#define NPPI_NOTIFY_FRAMING	0x02
-#define NPPI_NOTIFY_HW_OVERRUN	0x04
-#define NPPI_NOTIFY_SW_OVERRUN	0x08
-#define NPPI_NOTIFY_BREAK	0x10
-
-#define NPPI_NOTIFY_CTSHOLD         0x01	/* Tx hold by CTS low */
-#define NPPI_NOTIFY_DSRHOLD         0x02	/* Tx hold by DSR low */
-#define NPPI_NOTIFY_XOFFHOLD        0x08	/* Tx hold by Xoff received */
-#define NPPI_NOTIFY_XOFFXENT        0x10	/* Xoff Sent */
-
-/* follow just for Moxa Must chip define. */
-/* */
-/* when LCR register (offset 0x03) write following value, */
-/* the Must chip will enter enchance mode. And write value */
-/* on EFR (offset 0x02) bit 6,7 to change bank. */
-#define MOXA_MUST_ENTER_ENCHANCE	0xBF
-
-/* when enhance mode enable, access on general bank register */
-#define MOXA_MUST_GDL_REGISTER		0x07
-#define MOXA_MUST_GDL_MASK		0x7F
-#define MOXA_MUST_GDL_HAS_BAD_DATA	0x80
-
-#define MOXA_MUST_LSR_RERR		0x80	/* error in receive FIFO */
-/* enchance register bank select and enchance mode setting register */
-/* when LCR register equal to 0xBF */
-#define MOXA_MUST_EFR_REGISTER		0x02
-/* enchance mode enable */
-#define MOXA_MUST_EFR_EFRB_ENABLE	0x10
-/* enchance reister bank set 0, 1, 2 */
-#define MOXA_MUST_EFR_BANK0		0x00
-#define MOXA_MUST_EFR_BANK1		0x40
-#define MOXA_MUST_EFR_BANK2		0x80
-#define MOXA_MUST_EFR_BANK3		0xC0
-#define MOXA_MUST_EFR_BANK_MASK		0xC0
-
-/* set XON1 value register, when LCR=0xBF and change to bank0 */
-#define MOXA_MUST_XON1_REGISTER		0x04
-
-/* set XON2 value register, when LCR=0xBF and change to bank0 */
-#define MOXA_MUST_XON2_REGISTER		0x05
-
-/* set XOFF1 value register, when LCR=0xBF and change to bank0 */
-#define MOXA_MUST_XOFF1_REGISTER	0x06
-
-/* set XOFF2 value register, when LCR=0xBF and change to bank0 */
-#define MOXA_MUST_XOFF2_REGISTER	0x07
-
-#define MOXA_MUST_RBRTL_REGISTER	0x04
-#define MOXA_MUST_RBRTH_REGISTER	0x05
-#define MOXA_MUST_RBRTI_REGISTER	0x06
-#define MOXA_MUST_THRTL_REGISTER	0x07
-#define MOXA_MUST_ENUM_REGISTER		0x04
-#define MOXA_MUST_HWID_REGISTER		0x05
-#define MOXA_MUST_ECR_REGISTER		0x06
-#define MOXA_MUST_CSR_REGISTER		0x07
-
-/* good data mode enable */
-#define MOXA_MUST_FCR_GDA_MODE_ENABLE	0x20
-/* only good data put into RxFIFO */
-#define MOXA_MUST_FCR_GDA_ONLY_ENABLE	0x10
-
-/* enable CTS interrupt */
-#define MOXA_MUST_IER_ECTSI		0x80
-/* enable RTS interrupt */
-#define MOXA_MUST_IER_ERTSI		0x40
-/* enable Xon/Xoff interrupt */
-#define MOXA_MUST_IER_XINT		0x20
-/* enable GDA interrupt */
-#define MOXA_MUST_IER_EGDAI		0x10
-
-#define MOXA_MUST_RECV_ISR		(UART_IER_RDI | MOXA_MUST_IER_EGDAI)
-
-/* GDA interrupt pending */
-#define MOXA_MUST_IIR_GDA		0x1C
-#define MOXA_MUST_IIR_RDA		0x04
-#define MOXA_MUST_IIR_RTO		0x0C
-#define MOXA_MUST_IIR_LSR		0x06
-
-/* received Xon/Xoff or specical interrupt pending */
-#define MOXA_MUST_IIR_XSC		0x10
-
-/* RTS/CTS change state interrupt pending */
-#define MOXA_MUST_IIR_RTSCTS		0x20
-#define MOXA_MUST_IIR_MASK		0x3E
-
-#define MOXA_MUST_MCR_XON_FLAG		0x40
-#define MOXA_MUST_MCR_XON_ANY		0x80
-#define MOXA_MUST_MCR_TX_XON		0x08
-
-/* software flow control on chip mask value */
-#define MOXA_MUST_EFR_SF_MASK		0x0F
-/* send Xon1/Xoff1 */
-#define MOXA_MUST_EFR_SF_TX1		0x08
-/* send Xon2/Xoff2 */
-#define MOXA_MUST_EFR_SF_TX2		0x04
-/* send Xon1,Xon2/Xoff1,Xoff2 */
-#define MOXA_MUST_EFR_SF_TX12		0x0C
-/* don't send Xon/Xoff */
-#define MOXA_MUST_EFR_SF_TX_NO		0x00
-/* Tx software flow control mask */
-#define MOXA_MUST_EFR_SF_TX_MASK	0x0C
-/* don't receive Xon/Xoff */
-#define MOXA_MUST_EFR_SF_RX_NO		0x00
-/* receive Xon1/Xoff1 */
-#define MOXA_MUST_EFR_SF_RX1		0x02
-/* receive Xon2/Xoff2 */
-#define MOXA_MUST_EFR_SF_RX2		0x01
-/* receive Xon1,Xon2/Xoff1,Xoff2 */
-#define MOXA_MUST_EFR_SF_RX12		0x03
-/* Rx software flow control mask */
-#define MOXA_MUST_EFR_SF_RX_MASK	0x03
-
-#endif
-- 
2.32.0

