Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FE9272E42
	for <linux-serial@vger.kernel.org>; Thu, 14 Aug 2025 20:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755204895; cv=none; b=GGx49cW4ZI2AbqxC1a/fNUPACAkc3uiqk4Nu5Pp5jYTT5yITFqd+WO3Iy7Oj6tCTp9TO8GikR2DyrYYLmjlSca+N8vvI+mxzoxfF04rjvStlJ+4SPPgcteL8GBoSWtZH53Ntz0j1pTMPXFj76x0VWKfdNrk0F6BLO45ENt8H81I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755204895; c=relaxed/simple;
	bh=qKpUAE+h1rB4OIT8R3r5o75qyYSBe684vx3MBjFEzt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B8a/dg6w+FhdjTMworUAHEtHEE1QC87/CKurex4t9QBXvT0Dw2ceY4XsOoNbLTB7FoKWL+LZhZntLTfMTXCgH3cnHi04pVpcwFICnun4OXvM6FHUjJBiSua8P4OU38fEj5JFhLo4czGEpKOf0g9nei458uXmWR6A3xpNG4nHpoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailfence.com; spf=pass smtp.mailfrom=mailfence.com; dkim=pass (2048-bit key) header.d=mailfence.com header.i=willemgrant@mailfence.com header.b=Ic2VfGWH; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailfence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailfence.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailfence.com header.i=willemgrant@mailfence.com header.b="Ic2VfGWH"
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 068DD3649;
	Thu, 14 Aug 2025 22:45:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755204334;
	s=20240605-akrp; d=mailfence.com; i=willemgrant@mailfence.com;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=G2g1+iLW02EU5yfUGHqApFnqlQmQbixkEHjqQYoGb3Q=;
	b=Ic2VfGWHvg1TgfyTMJ9kDu+oqL2zLJji167CsFhvkj7iYqoWAnwiaaER9SGmL8q6
	sQqLgRwnt9lweM5P1i4RRvZ/pBNbOeXFU9Gl25PgefdQG2ZeohKgZvovR+TmWobrtfb
	JTNVgSy4+J8WgI9EJjKOqGdoXDzbf8HOce1nTZSOmXbFT5A1Kzv4subjwCBD4q0rDgG
	C2DFd8mpsf2iAIl6CL7+lu5JGzK1ZH1tPk6nypN/ZbKJPxKntmYQlpCizERGunAx6zL
	fLCuiGbxiWXn6NeT6bXsee7SB1zaM6W/oLO47JIdXqBOutT9+ezmX9h4wNLpexNowls
	1JgclZTXQA==
Received: by smtp.mailfence.com with ESMTPSA ; Thu, 14 Aug 2025 22:45:31 +0200 (CEST)
From: Willem Grant <willemgrant@mailfence.com>
To: linux-serial@vger.kernel.org
Cc: Willem Grant <willemgrant@mailfence.com>
Subject: [PATCH] Cleared out formatting warnings/errors for drivers/tty/serial/jsm/jsm_neo.c
Date: Thu, 14 Aug 2025 16:45:09 -0400
Message-ID: <20250814204509.20777-1-willemgrant@mailfence.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ContactOffice-Account: com:612363997

Signed-off-by: Willem Grant <willemgrant@mailfence.com>
---
 drivers/tty/serial/jsm/jsm_neo.c | 49 +++++++++++++++++---------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index e8e13bf056e2..2d413ec82f34 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -13,7 +13,7 @@
 #include <linux/serial_reg.h>	/* For the various UART offsets */
 #include <linux/tty.h>
 #include <linux/pci.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include "jsm.h"		/* Driver main header file */
 
@@ -29,12 +29,13 @@ static u32 jsm_offset_table[8] = { 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x8
  */
 static inline void neo_pci_posting_flush(struct jsm_board *bd)
 {
-      readb(bd->re_map_membase + 0x8D);
+	readb(bd->re_map_membase + 0x8D);
 }
 
 static void neo_set_cts_flow_control(struct jsm_channel *ch)
 {
 	u8 ier, efr;
+
 	ier = readb(&ch->ch_neo_uart->ier);
 	efr = readb(&ch->ch_neo_uart->efr);
 
@@ -66,6 +67,7 @@ static void neo_set_cts_flow_control(struct jsm_channel *ch)
 static void neo_set_rts_flow_control(struct jsm_channel *ch)
 {
 	u8 ier, efr;
+
 	ier = readb(&ch->ch_neo_uart->ier);
 	efr = readb(&ch->ch_neo_uart->efr);
 
@@ -106,6 +108,7 @@ static void neo_set_rts_flow_control(struct jsm_channel *ch)
 static void neo_set_ixon_flow_control(struct jsm_channel *ch)
 {
 	u8 ier, efr;
+
 	ier = readb(&ch->ch_neo_uart->ier);
 	efr = readb(&ch->ch_neo_uart->efr);
 
@@ -143,6 +146,7 @@ static void neo_set_ixon_flow_control(struct jsm_channel *ch)
 static void neo_set_ixoff_flow_control(struct jsm_channel *ch)
 {
 	u8 ier, efr;
+
 	ier = readb(&ch->ch_neo_uart->ier);
 	efr = readb(&ch->ch_neo_uart->efr);
 
@@ -181,6 +185,7 @@ static void neo_set_ixoff_flow_control(struct jsm_channel *ch)
 static void neo_set_no_input_flow_control(struct jsm_channel *ch)
 {
 	u8 ier, efr;
+
 	ier = readb(&ch->ch_neo_uart->ier);
 	efr = readb(&ch->ch_neo_uart->efr);
 
@@ -220,6 +225,7 @@ static void neo_set_no_input_flow_control(struct jsm_channel *ch)
 static void neo_set_no_output_flow_control(struct jsm_channel *ch)
 {
 	u8 ier, efr;
+
 	ier = readb(&ch->ch_neo_uart->ier);
 	efr = readb(&ch->ch_neo_uart->efr);
 
@@ -350,7 +356,7 @@ static void neo_copy_data_from_uart_to_queue(struct jsm_channel *ch)
 		 * IBM pSeries platform.
 		 * 15 bytes max appears to be the magic number.
 		 */
-		n = min((u32) n, (u32) 12);
+		n = min_t(u32, n, 12);
 
 		/*
 		 * Since we are grabbing the linestatus register, which
@@ -425,6 +431,7 @@ static void neo_copy_data_from_uart_to_queue(struct jsm_channel *ch)
 		 */
 		if (linestatus & error_mask) {
 			u8 discard;
+
 			linestatus = 0;
 			memcpy_fromio(&discard, &ch->ch_neo_uart->txrxburst, 1);
 			continue;
@@ -433,7 +440,7 @@ static void neo_copy_data_from_uart_to_queue(struct jsm_channel *ch)
 		/*
 		 * If our queue is full, we have no choice but to drop some data.
 		 * The assumption is that HWFLOW or SWFLOW should have stopped
-		 * things way way before we got to this point.
+		 * things way before we got to this point.
 		 *
 		 * I decided that I wanted to ditch the oldest data first,
 		 * I hope thats okay with everyone? Yes? Good.
@@ -548,7 +555,7 @@ static void neo_parse_modem(struct jsm_channel *ch, u8 signals)
 	u8 msignals = signals;
 
 	jsm_dbg(MSIGS, &ch->ch_bd->pci_dev,
-		"neo_parse_modem: port: %d msignals: %x\n",
+		"%s: port: %d msignals: %x\n", __func__,
 		ch->ch_portnum, msignals);
 
 	/* Scrub off lower bits. They signify delta's, which I don't care about */
@@ -580,7 +587,7 @@ static void neo_parse_modem(struct jsm_channel *ch, u8 signals)
 		ch->ch_mistat &= ~UART_MSR_CTS;
 
 	jsm_dbg(MSIGS, &ch->ch_bd->pci_dev,
-		"Port: %d DTR: %d RTS: %d CTS: %d DSR: %d " "RI: %d CD: %d\n",
+		"Port: %d DTR: %d RTS: %d CTS: %d DSR: %d RI: %d CD: %d\n",
 		ch->ch_portnum,
 		!!((ch->ch_mistat | ch->ch_mostat) & UART_MCR_DTR),
 		!!((ch->ch_mistat | ch->ch_mostat) & UART_MCR_RTS),
@@ -625,8 +632,7 @@ static void neo_flush_uart_write(struct jsm_channel *ch)
 			jsm_dbg(IOCTL, &ch->ch_bd->pci_dev,
 				"Still flushing TX UART... i: %d\n", i);
 			udelay(10);
-		}
-		else
+		} else
 			break;
 	}
 
@@ -657,8 +663,7 @@ static void neo_flush_uart_read(struct jsm_channel *ch)
 			jsm_dbg(IOCTL, &ch->ch_bd->pci_dev,
 				"Still flushing RX UART... i: %d\n", i);
 			udelay(10);
-		}
-		else
+		} else
 			break;
 	}
 }
@@ -675,6 +680,7 @@ static void neo_clear_break(struct jsm_channel *ch)
 	/* Turn break off, and unset some variables */
 	if (ch->ch_flags & CH_BREAK_SENDING) {
 		u8 temp = readb(&ch->ch_neo_uart->lcr);
+
 		writeb((temp & ~UART_LCR_SBC), &ch->ch_neo_uart->lcr);
 
 		ch->ch_flags &= ~(CH_BREAK_SENDING);
@@ -758,14 +764,12 @@ static void neo_parse_isr(struct jsm_board *brd, u32 port)
 			spin_lock_irqsave(&ch->ch_lock, lock_flags);
 			if (cause == UART_17158_XON_DETECT) {
 				/* Is output stopped right now, if so, resume it */
-				if (brd->channels[port]->ch_flags & CH_STOP) {
+				if (brd->channels[port]->ch_flags & CH_STOP)
 					ch->ch_flags &= ~(CH_STOP);
-				}
 				jsm_dbg(INTR, &ch->ch_bd->pci_dev,
 					"Port %d. XON detected in incoming data\n",
 					port);
-			}
-			else if (cause == UART_17158_XOFF_DETECT) {
+			} else if (cause == UART_17158_XOFF_DETECT) {
 				if (!(brd->channels[port]->ch_flags & CH_STOP)) {
 					ch->ch_flags |= CH_STOP;
 					jsm_dbg(INTR, &ch->ch_bd->pci_dev,
@@ -896,8 +900,7 @@ static inline void neo_parse_lsr(struct jsm_board *brd, u32 port)
 
 		/* Transfer data (if any) from Write Queue -> UART. */
 		neo_copy_data_from_queue_to_uart(ch);
-	}
-	else if (linestatus & UART_17158_TX_AND_FIFO_CLR) {
+	} else if (linestatus & UART_17158_TX_AND_FIFO_CLR) {
 		spin_lock_irqsave(&ch->ch_lock, lock_flags);
 		ch->ch_flags |= (CH_TX_FIFO_EMPTY | CH_TX_FIFO_LWM);
 		spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
@@ -1026,8 +1029,7 @@ static void neo_param(struct jsm_channel *ch)
 			neo_set_no_output_flow_control(ch);
 		else
 			neo_set_ixon_flow_control(ch);
-	}
-	else
+	} else
 		neo_set_no_output_flow_control(ch);
 
 	if (ch->ch_c_cflag & CRTSCTS)
@@ -1038,8 +1040,7 @@ static void neo_param(struct jsm_channel *ch)
 			neo_set_no_input_flow_control(ch);
 		else
 			neo_set_ixoff_flow_control(ch);
-	}
-	else
+	} else
 		neo_set_no_input_flow_control(ch);
 	/*
 	 * Adjust the RX FIFO Trigger level if baud is less than 9600.
@@ -1055,7 +1056,6 @@ static void neo_param(struct jsm_channel *ch)
 
 	/* Get current status of the modem signals now */
 	neo_parse_modem(ch, readb(&ch->ch_neo_uart->msr));
-	return;
 }
 
 /*
@@ -1101,7 +1101,7 @@ static irqreturn_t neo_intr(int irq, void *voidbrd)
 	current_port = 0;
 
 	/* Loop on each port */
-	while (((uart_poll & 0xff) != 0) && (outofloop_count < 0xff)){
+	while (((uart_poll & 0xff) != 0) && (outofloop_count < 0xff)) {
 
 		tmp = uart_poll;
 		outofloop_count++;
@@ -1135,7 +1135,7 @@ static irqreturn_t neo_intr(int irq, void *voidbrd)
 		case UART_17158_RXRDY_TIMEOUT:
 			/*
 			 * RXRDY Time-out is cleared by reading data in the
-			* RX FIFO until it falls below the trigger level.
+			 * RX FIFO until it falls below the trigger level.
 			 */
 
 			/* Verify the port is in range. */
@@ -1213,6 +1213,7 @@ static irqreturn_t neo_intr(int irq, void *voidbrd)
 static void neo_disable_receiver(struct jsm_channel *ch)
 {
 	u8 tmp = readb(&ch->ch_neo_uart->ier);
+
 	tmp &= ~(UART_IER_RDI);
 	writeb(tmp, &ch->ch_neo_uart->ier);
 
@@ -1229,6 +1230,7 @@ static void neo_disable_receiver(struct jsm_channel *ch)
 static void neo_enable_receiver(struct jsm_channel *ch)
 {
 	u8 tmp = readb(&ch->ch_neo_uart->ier);
+
 	tmp |= (UART_IER_RDI);
 	writeb(tmp, &ch->ch_neo_uart->ier);
 
@@ -1309,6 +1311,7 @@ static void neo_send_break(struct jsm_channel *ch)
 	/* Tell the UART to start sending the break */
 	if (!(ch->ch_flags & CH_BREAK_SENDING)) {
 		u8 temp = readb(&ch->ch_neo_uart->lcr);
+
 		writeb((temp | UART_LCR_SBC), &ch->ch_neo_uart->lcr);
 		ch->ch_flags |= (CH_BREAK_SENDING);
 
-- 
2.50.1

