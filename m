Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF202C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C9C60E97
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhINJJm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:09:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:32894 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhINJJm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 05:09:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7B15D21FC6;
        Tue, 14 Sep 2021 09:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631610504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=7LmzOsq3hitI/fN7eRLd3PSKuWQeiMUJ7eVefISghLY=;
        b=W+ZKxf+dyDxCd7bhYLDgX6s1JVwbkpi2XLsVgL6cNyeLRZYdUvq16Kc8p/TTJnuFCob2tL
        03wdeZvf5fm8P00Z4sgE6P5BytN1uRStFbmA7BiJIDAlZPOPhzdXd1qeli27R5xuOMVYAI
        HKlOgPwtSEPd9rZ5P5LtWE72cptwxsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631610504;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=7LmzOsq3hitI/fN7eRLd3PSKuWQeiMUJ7eVefISghLY=;
        b=ef7h2lOvxZkHhTnkh9eQAxx4PhblVQxEVVho1HxtoP33TJ3LeMTPkGMU2TpkfqctfJHtd2
        BTCmLP23I2R33YBA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4E296A3B90;
        Tue, 14 Sep 2021 09:08:24 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] moxa: merge moxa.h into moxa.c
Date:   Tue, 14 Sep 2021 11:08:23 +0200
Message-Id: <20210914090823.17206-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is no need for existence of a separate header for Moxa's Intellio
cards. Merge it into moxa.c to clean up the tty dir a bit.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/moxa.c | 302 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/tty/moxa.h | 307 ---------------------------------------------
 2 files changed, 301 insertions(+), 308 deletions(-)
 delete mode 100644 drivers/tty/moxa.h

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index bf17e90858b8..e37683e25055 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -45,7 +45,307 @@
 #include <asm/io.h>
 #include <linux/uaccess.h>
 
-#include "moxa.h"
+#define	MOXA			0x400
+#define MOXA_GET_IQUEUE		(MOXA + 1)	/* get input buffered count */
+#define MOXA_GET_OQUEUE		(MOXA + 2)	/* get output buffered count */
+#define MOXA_GETDATACOUNT       (MOXA + 23)
+#define MOXA_GET_IOQUEUE	(MOXA + 27)
+#define MOXA_FLUSH_QUEUE	(MOXA + 28)
+#define MOXA_GETMSTATUS         (MOXA + 65)
+
+/*
+ *    System Configuration
+ */
+
+#define Magic_code	0x404
+
+/*
+ *    for C218 BIOS initialization
+ */
+#define C218_ConfBase	0x800
+#define C218_status	(C218_ConfBase + 0)	/* BIOS running status    */
+#define C218_diag	(C218_ConfBase + 2)	/* diagnostic status      */
+#define C218_key	(C218_ConfBase + 4)	/* WORD (0x218 for C218) */
+#define C218DLoad_len	(C218_ConfBase + 6)	/* WORD           */
+#define C218check_sum	(C218_ConfBase + 8)	/* BYTE           */
+#define C218chksum_ok	(C218_ConfBase + 0x0a)	/* BYTE (1:ok)            */
+#define C218_TestRx	(C218_ConfBase + 0x10)	/* 8 bytes for 8 ports    */
+#define C218_TestTx	(C218_ConfBase + 0x18)	/* 8 bytes for 8 ports    */
+#define C218_RXerr	(C218_ConfBase + 0x20)	/* 8 bytes for 8 ports    */
+#define C218_ErrFlag	(C218_ConfBase + 0x28)	/* 8 bytes for 8 ports    */
+
+#define C218_LoadBuf	0x0F00
+#define C218_KeyCode	0x218
+#define CP204J_KeyCode	0x204
+
+/*
+ *    for C320 BIOS initialization
+ */
+#define C320_ConfBase	0x800
+#define C320_LoadBuf	0x0f00
+#define STS_init	0x05	/* for C320_status        */
+
+#define C320_status	C320_ConfBase + 0	/* BIOS running status    */
+#define C320_diag	C320_ConfBase + 2	/* diagnostic status      */
+#define C320_key	C320_ConfBase + 4	/* WORD (0320H for C320) */
+#define C320DLoad_len	C320_ConfBase + 6	/* WORD           */
+#define C320check_sum	C320_ConfBase + 8	/* WORD           */
+#define C320chksum_ok	C320_ConfBase + 0x0a	/* WORD (1:ok)            */
+#define C320bapi_len	C320_ConfBase + 0x0c	/* WORD           */
+#define C320UART_no	C320_ConfBase + 0x0e	/* WORD           */
+
+#define C320_KeyCode	0x320
+
+#define FixPage_addr	0x0000	/* starting addr of static page  */
+#define DynPage_addr	0x2000	/* starting addr of dynamic page */
+#define C218_start	0x3000	/* starting addr of C218 BIOS prg */
+#define Control_reg	0x1ff0	/* select page and reset control */
+#define HW_reset	0x80
+
+/*
+ *    Function Codes
+ */
+#define FC_CardReset	0x80
+#define FC_ChannelReset 1	/* C320 firmware not supported */
+#define FC_EnableCH	2
+#define FC_DisableCH	3
+#define FC_SetParam	4
+#define FC_SetMode	5
+#define FC_SetRate	6
+#define FC_LineControl	7
+#define FC_LineStatus	8
+#define FC_XmitControl	9
+#define FC_FlushQueue	10
+#define FC_SendBreak	11
+#define FC_StopBreak	12
+#define FC_LoopbackON	13
+#define FC_LoopbackOFF	14
+#define FC_ClrIrqTable	15
+#define FC_SendXon	16
+#define FC_SetTermIrq	17	/* C320 firmware not supported */
+#define FC_SetCntIrq	18	/* C320 firmware not supported */
+#define FC_SetBreakIrq	19
+#define FC_SetLineIrq	20
+#define FC_SetFlowCtl	21
+#define FC_GenIrq	22
+#define FC_InCD180	23
+#define FC_OutCD180	24
+#define FC_InUARTreg	23
+#define FC_OutUARTreg	24
+#define FC_SetXonXoff	25
+#define FC_OutCD180CCR	26
+#define FC_ExtIQueue	27
+#define FC_ExtOQueue	28
+#define FC_ClrLineIrq	29
+#define FC_HWFlowCtl	30
+#define FC_GetClockRate 35
+#define FC_SetBaud	36
+#define FC_SetDataMode  41
+#define FC_GetCCSR      43
+#define FC_GetDataError 45
+#define FC_RxControl	50
+#define FC_ImmSend	51
+#define FC_SetXonState	52
+#define FC_SetXoffState	53
+#define FC_SetRxFIFOTrig 54
+#define FC_SetTxFIFOCnt 55
+#define FC_UnixRate	56
+#define FC_UnixResetTimer 57
+
+#define	RxFIFOTrig1	0
+#define	RxFIFOTrig4	1
+#define	RxFIFOTrig8	2
+#define	RxFIFOTrig14	3
+
+/*
+ *    Dual-Ported RAM
+ */
+#define DRAM_global	0
+#define INT_data	(DRAM_global + 0)
+#define Config_base	(DRAM_global + 0x108)
+
+#define IRQindex	(INT_data + 0)
+#define IRQpending	(INT_data + 4)
+#define IRQtable	(INT_data + 8)
+
+/*
+ *    Interrupt Status
+ */
+#define IntrRx		0x01	/* receiver data O.K.             */
+#define IntrTx		0x02	/* transmit buffer empty  */
+#define IntrFunc	0x04	/* function complete              */
+#define IntrBreak	0x08	/* received break         */
+#define IntrLine	0x10	/* line status change
+				   for transmitter                */
+#define IntrIntr	0x20	/* received INTR code             */
+#define IntrQuit	0x40	/* received QUIT code             */
+#define IntrEOF		0x80	/* received EOF code              */
+
+#define IntrRxTrigger	0x100	/* rx data count reach trigger value */
+#define IntrTxTrigger	0x200	/* tx data count below trigger value */
+
+#define Magic_no	(Config_base + 0)
+#define Card_model_no	(Config_base + 2)
+#define Total_ports	(Config_base + 4)
+#define Module_cnt	(Config_base + 8)
+#define Module_no	(Config_base + 10)
+#define Timer_10ms	(Config_base + 14)
+#define Disable_IRQ	(Config_base + 20)
+#define TMS320_PORT1	(Config_base + 22)
+#define TMS320_PORT2	(Config_base + 24)
+#define TMS320_CLOCK	(Config_base + 26)
+
+/*
+ *    DATA BUFFER in DRAM
+ */
+#define Extern_table	0x400	/* Base address of the external table
+				   (24 words *    64) total 3K bytes
+				   (24 words * 128) total 6K bytes */
+#define Extern_size	0x60	/* 96 bytes                       */
+#define RXrptr		0x00	/* read pointer for RX buffer     */
+#define RXwptr		0x02	/* write pointer for RX buffer    */
+#define TXrptr		0x04	/* read pointer for TX buffer     */
+#define TXwptr		0x06	/* write pointer for TX buffer    */
+#define HostStat	0x08	/* IRQ flag and general flag      */
+#define FlagStat	0x0A
+#define FlowControl	0x0C	/* B7 B6 B5 B4 B3 B2 B1 B0              */
+				/*  x  x  x  x  |  |  |  |            */
+				/*              |  |  |  + CTS flow   */
+				/*              |  |  +--- RTS flow   */
+				/*              |  +------ TX Xon/Xoff */
+				/*              +--------- RX Xon/Xoff */
+#define Break_cnt	0x0E	/* received break count   */
+#define CD180TXirq	0x10	/* if non-0: enable TX irq        */
+#define RX_mask		0x12
+#define TX_mask		0x14
+#define Ofs_rxb		0x16
+#define Ofs_txb		0x18
+#define Page_rxb	0x1A
+#define Page_txb	0x1C
+#define EndPage_rxb	0x1E
+#define EndPage_txb	0x20
+#define Data_error	0x22
+#define RxTrigger	0x28
+#define TxTrigger	0x2a
+
+#define rRXwptr		0x34
+#define Low_water	0x36
+
+#define FuncCode	0x40
+#define FuncArg		0x42
+#define FuncArg1	0x44
+
+#define C218rx_size	0x2000	/* 8K bytes */
+#define C218tx_size	0x8000	/* 32K bytes */
+
+#define C218rx_mask	(C218rx_size - 1)
+#define C218tx_mask	(C218tx_size - 1)
+
+#define C320p8rx_size	0x2000
+#define C320p8tx_size	0x8000
+#define C320p8rx_mask	(C320p8rx_size - 1)
+#define C320p8tx_mask	(C320p8tx_size - 1)
+
+#define C320p16rx_size	0x2000
+#define C320p16tx_size	0x4000
+#define C320p16rx_mask	(C320p16rx_size - 1)
+#define C320p16tx_mask	(C320p16tx_size - 1)
+
+#define C320p24rx_size	0x2000
+#define C320p24tx_size	0x2000
+#define C320p24rx_mask	(C320p24rx_size - 1)
+#define C320p24tx_mask	(C320p24tx_size - 1)
+
+#define C320p32rx_size	0x1000
+#define C320p32tx_size	0x1000
+#define C320p32rx_mask	(C320p32rx_size - 1)
+#define C320p32tx_mask	(C320p32tx_size - 1)
+
+#define Page_size	0x2000U
+#define Page_mask	(Page_size - 1)
+#define C218rx_spage	3
+#define C218tx_spage	4
+#define C218rx_pageno	1
+#define C218tx_pageno	4
+#define C218buf_pageno	5
+
+#define C320p8rx_spage	3
+#define C320p8tx_spage	4
+#define C320p8rx_pgno	1
+#define C320p8tx_pgno	4
+#define C320p8buf_pgno	5
+
+#define C320p16rx_spage 3
+#define C320p16tx_spage 4
+#define C320p16rx_pgno	1
+#define C320p16tx_pgno	2
+#define C320p16buf_pgno 3
+
+#define C320p24rx_spage 3
+#define C320p24tx_spage 4
+#define C320p24rx_pgno	1
+#define C320p24tx_pgno	1
+#define C320p24buf_pgno 2
+
+#define C320p32rx_spage 3
+#define C320p32tx_ofs	C320p32rx_size
+#define C320p32tx_spage 3
+#define C320p32buf_pgno 1
+
+/*
+ *    Host Status
+ */
+#define WakeupRx	0x01
+#define WakeupTx	0x02
+#define WakeupBreak	0x08
+#define WakeupLine	0x10
+#define WakeupIntr	0x20
+#define WakeupQuit	0x40
+#define WakeupEOF	0x80	/* used in VTIME control */
+#define WakeupRxTrigger	0x100
+#define WakeupTxTrigger	0x200
+/*
+ *    Flag status
+ */
+#define Rx_over		0x01
+#define Xoff_state	0x02
+#define Tx_flowOff	0x04
+#define Tx_enable	0x08
+#define CTS_state	0x10
+#define DSR_state	0x20
+#define DCD_state	0x80
+/*
+ *    FlowControl
+ */
+#define CTS_FlowCtl	1
+#define RTS_FlowCtl	2
+#define Tx_FlowCtl	4
+#define Rx_FlowCtl	8
+#define IXM_IXANY	0x10
+
+#define LowWater	128
+
+#define DTR_ON		1
+#define RTS_ON		2
+#define CTS_ON		1
+#define DSR_ON		2
+#define DCD_ON		8
+
+/* mode definition */
+#define	MX_CS8		0x03
+#define	MX_CS7		0x02
+#define	MX_CS6		0x01
+#define	MX_CS5		0x00
+
+#define	MX_STOP1	0x00
+#define	MX_STOP15	0x04
+#define	MX_STOP2	0x08
+
+#define	MX_PARNONE	0x00
+#define	MX_PAREVEN	0x40
+#define	MX_PARODD	0xC0
+#define	MX_PARMARK	0xA0
+#define	MX_PARSPACE	0x20
 
 #define MOXA_VERSION		"6.0k"
 
diff --git a/drivers/tty/moxa.h b/drivers/tty/moxa.h
deleted file mode 100644
index f0a4381b6861..000000000000
--- a/drivers/tty/moxa.h
+++ /dev/null
@@ -1,307 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef MOXA_H_FILE
-#define MOXA_H_FILE
-
-#define	MOXA		0x400
-#define MOXA_GET_IQUEUE 	(MOXA + 1)	/* get input buffered count */
-#define MOXA_GET_OQUEUE 	(MOXA + 2)	/* get output buffered count */
-#define MOXA_GETDATACOUNT       (MOXA + 23)
-#define MOXA_GET_IOQUEUE	(MOXA + 27)
-#define MOXA_FLUSH_QUEUE	(MOXA + 28)
-#define MOXA_GETMSTATUS         (MOXA + 65)
-
-/*
- *    System Configuration
- */
-
-#define Magic_code	0x404
-
-/*
- *    for C218 BIOS initialization
- */
-#define C218_ConfBase	0x800
-#define C218_status	(C218_ConfBase + 0)	/* BIOS running status    */
-#define C218_diag	(C218_ConfBase + 2)	/* diagnostic status      */
-#define C218_key	(C218_ConfBase + 4)	/* WORD (0x218 for C218) */
-#define C218DLoad_len	(C218_ConfBase + 6)	/* WORD           */
-#define C218check_sum	(C218_ConfBase + 8)	/* BYTE           */
-#define C218chksum_ok	(C218_ConfBase + 0x0a)	/* BYTE (1:ok)            */
-#define C218_TestRx	(C218_ConfBase + 0x10)	/* 8 bytes for 8 ports    */
-#define C218_TestTx	(C218_ConfBase + 0x18)	/* 8 bytes for 8 ports    */
-#define C218_RXerr	(C218_ConfBase + 0x20)	/* 8 bytes for 8 ports    */
-#define C218_ErrFlag	(C218_ConfBase + 0x28)	/* 8 bytes for 8 ports    */
-
-#define C218_LoadBuf	0x0F00
-#define C218_KeyCode	0x218
-#define CP204J_KeyCode	0x204
-
-/*
- *    for C320 BIOS initialization
- */
-#define C320_ConfBase	0x800
-#define C320_LoadBuf	0x0f00
-#define STS_init	0x05	/* for C320_status        */
-
-#define C320_status	C320_ConfBase + 0	/* BIOS running status    */
-#define C320_diag	C320_ConfBase + 2	/* diagnostic status      */
-#define C320_key	C320_ConfBase + 4	/* WORD (0320H for C320) */
-#define C320DLoad_len	C320_ConfBase + 6	/* WORD           */
-#define C320check_sum	C320_ConfBase + 8	/* WORD           */
-#define C320chksum_ok	C320_ConfBase + 0x0a	/* WORD (1:ok)            */
-#define C320bapi_len	C320_ConfBase + 0x0c	/* WORD           */
-#define C320UART_no	C320_ConfBase + 0x0e	/* WORD           */
-
-#define C320_KeyCode	0x320
-
-#define FixPage_addr	0x0000	/* starting addr of static page  */
-#define DynPage_addr	0x2000	/* starting addr of dynamic page */
-#define C218_start	0x3000	/* starting addr of C218 BIOS prg */
-#define Control_reg	0x1ff0	/* select page and reset control */
-#define HW_reset	0x80
-
-/*
- *    Function Codes
- */
-#define FC_CardReset	0x80
-#define FC_ChannelReset 1	/* C320 firmware not supported */
-#define FC_EnableCH	2
-#define FC_DisableCH	3
-#define FC_SetParam	4
-#define FC_SetMode	5
-#define FC_SetRate	6
-#define FC_LineControl	7
-#define FC_LineStatus	8
-#define FC_XmitControl	9
-#define FC_FlushQueue	10
-#define FC_SendBreak	11
-#define FC_StopBreak	12
-#define FC_LoopbackON	13
-#define FC_LoopbackOFF	14
-#define FC_ClrIrqTable	15
-#define FC_SendXon	16
-#define FC_SetTermIrq	17	/* C320 firmware not supported */
-#define FC_SetCntIrq	18	/* C320 firmware not supported */
-#define FC_SetBreakIrq	19
-#define FC_SetLineIrq	20
-#define FC_SetFlowCtl	21
-#define FC_GenIrq	22
-#define FC_InCD180	23
-#define FC_OutCD180	24
-#define FC_InUARTreg	23
-#define FC_OutUARTreg	24
-#define FC_SetXonXoff	25
-#define FC_OutCD180CCR	26
-#define FC_ExtIQueue	27
-#define FC_ExtOQueue	28
-#define FC_ClrLineIrq	29
-#define FC_HWFlowCtl	30
-#define FC_GetClockRate 35
-#define FC_SetBaud	36
-#define FC_SetDataMode  41
-#define FC_GetCCSR      43
-#define FC_GetDataError 45
-#define FC_RxControl	50
-#define FC_ImmSend	51
-#define FC_SetXonState	52
-#define FC_SetXoffState	53
-#define FC_SetRxFIFOTrig 54
-#define FC_SetTxFIFOCnt 55
-#define FC_UnixRate	56
-#define FC_UnixResetTimer 57
-
-#define	RxFIFOTrig1	0
-#define	RxFIFOTrig4	1
-#define	RxFIFOTrig8	2
-#define	RxFIFOTrig14	3
-
-/*
- *    Dual-Ported RAM
- */
-#define DRAM_global	0
-#define INT_data	(DRAM_global + 0)
-#define Config_base	(DRAM_global + 0x108)
-
-#define IRQindex	(INT_data + 0)
-#define IRQpending	(INT_data + 4)
-#define IRQtable	(INT_data + 8)
-
-/*
- *    Interrupt Status
- */
-#define IntrRx		0x01	/* receiver data O.K.             */
-#define IntrTx		0x02	/* transmit buffer empty  */
-#define IntrFunc	0x04	/* function complete              */
-#define IntrBreak	0x08	/* received break         */
-#define IntrLine	0x10	/* line status change
-				   for transmitter                */
-#define IntrIntr	0x20	/* received INTR code             */
-#define IntrQuit	0x40	/* received QUIT code             */
-#define IntrEOF 	0x80	/* received EOF code              */
-
-#define IntrRxTrigger 	0x100	/* rx data count reach trigger value */
-#define IntrTxTrigger 	0x200	/* tx data count below trigger value */
-
-#define Magic_no	(Config_base + 0)
-#define Card_model_no	(Config_base + 2)
-#define Total_ports	(Config_base + 4)
-#define Module_cnt	(Config_base + 8)
-#define Module_no	(Config_base + 10)
-#define Timer_10ms	(Config_base + 14)
-#define Disable_IRQ	(Config_base + 20)
-#define TMS320_PORT1	(Config_base + 22)
-#define TMS320_PORT2	(Config_base + 24)
-#define TMS320_CLOCK	(Config_base + 26)
-
-/*
- *    DATA BUFFER in DRAM
- */
-#define Extern_table	0x400	/* Base address of the external table
-				   (24 words *    64) total 3K bytes
-				   (24 words * 128) total 6K bytes */
-#define Extern_size	0x60	/* 96 bytes                       */
-#define RXrptr		0x00	/* read pointer for RX buffer     */
-#define RXwptr		0x02	/* write pointer for RX buffer    */
-#define TXrptr		0x04	/* read pointer for TX buffer     */
-#define TXwptr		0x06	/* write pointer for TX buffer    */
-#define HostStat	0x08	/* IRQ flag and general flag      */
-#define FlagStat	0x0A
-#define FlowControl	0x0C	/* B7 B6 B5 B4 B3 B2 B1 B0              */
-				/*  x  x  x  x  |  |  |  |            */
-				/*              |  |  |  + CTS flow   */
-				/*              |  |  +--- RTS flow   */
-				/*              |  +------ TX Xon/Xoff */
-				/*              +--------- RX Xon/Xoff */
-#define Break_cnt	0x0E	/* received break count   */
-#define CD180TXirq	0x10	/* if non-0: enable TX irq        */
-#define RX_mask 	0x12
-#define TX_mask 	0x14
-#define Ofs_rxb 	0x16
-#define Ofs_txb 	0x18
-#define Page_rxb	0x1A
-#define Page_txb	0x1C
-#define EndPage_rxb	0x1E
-#define EndPage_txb	0x20
-#define Data_error	0x22
-#define RxTrigger	0x28
-#define TxTrigger	0x2a
-
-#define rRXwptr 	0x34
-#define Low_water	0x36
-
-#define FuncCode	0x40
-#define FuncArg 	0x42
-#define FuncArg1	0x44
-
-#define C218rx_size	0x2000	/* 8K bytes */
-#define C218tx_size	0x8000	/* 32K bytes */
-
-#define C218rx_mask	(C218rx_size - 1)
-#define C218tx_mask	(C218tx_size - 1)
-
-#define C320p8rx_size	0x2000
-#define C320p8tx_size	0x8000
-#define C320p8rx_mask	(C320p8rx_size - 1)
-#define C320p8tx_mask	(C320p8tx_size - 1)
-
-#define C320p16rx_size	0x2000
-#define C320p16tx_size	0x4000
-#define C320p16rx_mask	(C320p16rx_size - 1)
-#define C320p16tx_mask	(C320p16tx_size - 1)
-
-#define C320p24rx_size	0x2000
-#define C320p24tx_size	0x2000
-#define C320p24rx_mask	(C320p24rx_size - 1)
-#define C320p24tx_mask	(C320p24tx_size - 1)
-
-#define C320p32rx_size	0x1000
-#define C320p32tx_size	0x1000
-#define C320p32rx_mask	(C320p32rx_size - 1)
-#define C320p32tx_mask	(C320p32tx_size - 1)
-
-#define Page_size	0x2000U
-#define Page_mask	(Page_size - 1)
-#define C218rx_spage	3
-#define C218tx_spage	4
-#define C218rx_pageno	1
-#define C218tx_pageno	4
-#define C218buf_pageno	5
-
-#define C320p8rx_spage	3
-#define C320p8tx_spage	4
-#define C320p8rx_pgno	1
-#define C320p8tx_pgno	4
-#define C320p8buf_pgno	5
-
-#define C320p16rx_spage 3
-#define C320p16tx_spage 4
-#define C320p16rx_pgno	1
-#define C320p16tx_pgno	2
-#define C320p16buf_pgno 3
-
-#define C320p24rx_spage 3
-#define C320p24tx_spage 4
-#define C320p24rx_pgno	1
-#define C320p24tx_pgno	1
-#define C320p24buf_pgno 2
-
-#define C320p32rx_spage 3
-#define C320p32tx_ofs	C320p32rx_size
-#define C320p32tx_spage 3
-#define C320p32buf_pgno 1
-
-/*
- *    Host Status
- */
-#define WakeupRx	0x01
-#define WakeupTx	0x02
-#define WakeupBreak	0x08
-#define WakeupLine	0x10
-#define WakeupIntr	0x20
-#define WakeupQuit	0x40
-#define WakeupEOF	0x80	/* used in VTIME control */
-#define WakeupRxTrigger	0x100
-#define WakeupTxTrigger	0x200
-/*
- *    Flag status
- */
-#define Rx_over		0x01
-#define Xoff_state	0x02
-#define Tx_flowOff	0x04
-#define Tx_enable	0x08
-#define CTS_state	0x10
-#define DSR_state	0x20
-#define DCD_state	0x80
-/*
- *    FlowControl
- */
-#define CTS_FlowCtl	1
-#define RTS_FlowCtl	2
-#define Tx_FlowCtl	4
-#define Rx_FlowCtl	8
-#define IXM_IXANY	0x10
-
-#define LowWater	128
-
-#define DTR_ON		1
-#define RTS_ON		2
-#define CTS_ON		1
-#define DSR_ON		2
-#define DCD_ON		8
-
-/* mode definition */
-#define	MX_CS8		0x03
-#define	MX_CS7		0x02
-#define	MX_CS6		0x01
-#define	MX_CS5		0x00
-
-#define	MX_STOP1	0x00
-#define	MX_STOP15	0x04
-#define	MX_STOP2	0x08
-
-#define	MX_PARNONE	0x00
-#define	MX_PAREVEN	0x40
-#define	MX_PARODD	0xC0
-#define	MX_PARMARK	0xA0
-#define	MX_PARSPACE	0x20
-
-#endif
-- 
2.33.0

