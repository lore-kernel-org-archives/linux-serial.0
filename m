Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795786929;
	b=u+04R1nw5AhMBYnPJmfqxRngOQ/ge42yDdbIdizRVefcgYfhYMQKTcJZiS1XAvg/1krr
	 trRyJw/5QC6RlJXrqGZJpsBAS5yyCtW/e/j7dFqg7XVzyyfoF5t4VVEw5ZV3JicV+l5Qs
	 yH1EjpHP/GGDGnQTjSEYO02NcNVfOvUEU1mZIIO1qT8LAscAMMhhmGhjKGggGNibKk8Q2
	 7zSdkwvT1X6U4NKxNsSm9yL9KnUNK1M7xUCB5IGoNncOu86peCM3xEB27EfFSkdtJtgf8
	 rck5gQaQc7F5xsUj2PQ5YVPsEM4N+Iq1nxb+CebQ2osyMexFgFCgxWU95SeKSX1D7+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795786929;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=atyb43qYmihoBCqNKLY27VMh3jBuUG9hc9RrYHqQ2yE=;
	b=spMjJ/usMjIkb8/Mfc2d/PzsDzamt6v76zyRwZ9sVhbtcD/IyDCRWRRoep/sNX+SoDYl
	 ACjYhn45o7MqmrM4ZVBD26fKEC+F6zzGEIeMFXmAZ81lphaAzEqJanu9SXgxNNpZczll4
	 ufiXjNka9xrETZ3ANbnNEOpUWjJ6TH3u3MjzqFQbH8qY3ks/K/BzjOSqfPv5ROvJz1qdF
	 8ZhV7qQ75xTrZonP88myBJYBf+q8j0FANWbWxkrbSP0PGbhn8ZtqxQ3fEavIh1aXoElHY
	 tNxnmMeoNMtBHq3nyKV8rGtWyrePqDK2HCPqgOwmj3gFR5GTh93vAmHYmj7ZSpFAVLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=FERLc25K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.12
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011012.outbound.protection.outlook.com [52.101.125.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C3606A31C;
	Fri, 27 Nov 2026 13:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 859C3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=FERLc25K
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dafh59c96deJRV7MT09+u7BChD2xT3XIaiR7RvAcHYzXqUkeFkjzraUQ2kyMlA5+xfFhX6hoxGZuBuUG3MLjp2On67eFZG6oMj2yhnklbMU8/NGClBMsxTTTyO0Y2/V1TNXPt7YIzoBX6dWsp1XJx8MuIhY+NoIMlfMEVwGg8ntJWyNRCve24H3upMUgCN4i8+f+BSofDHjD+GFCD/uGOTldFuerrj55Nu7ajynlprWLyTTwMXSZUQBu0zkUE3xZmOQKFJVeUVA9ccAkLj/ktJ4jRmdKoLwthzpRsKnV51M8MQVrk6zyXp8ZVtcPfyJE14yxLDbih13k+xseizWvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atyb43qYmihoBCqNKLY27VMh3jBuUG9hc9RrYHqQ2yE=;
 b=O0HM3DGs0C+/CWdXq1dLp2mrtLxU6ovCmSR1QkFylEhrIr62mvynNwC3Q++O3VRHRcleb7lyNwhi8h+zjfBNeX6oj9kCy+x0Q5VgK1oZ9yElF32SSNMK6cksY3fOKK4K67zM28F8K9lACUuChICXo7Y+AjTYHJERGiLzWArjG1slGyT/X3RKM8Go2PHY7xwsR4H757XS+33kMNpuegD15VjZ8cH55YUPQv/xOnd7VUQ7XWZbSjykJNql9KyACiiK6oDJp3z9ChM2wmS46ZXXPbHlyGjKRnsTJdOfpAoawH+dFYTo65wjUkWPrwu2dMNCV/l44LoJcagzKTIyuj+nxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atyb43qYmihoBCqNKLY27VMh3jBuUG9hc9RrYHqQ2yE=;
 b=FERLc25KmT3sUnzjN08aKmYWk1tIydtFTTJ6U3hAtIWFXjKmQcIwiy0LE+Y88i44fSp25kNPWeTsOENnYCiGDtegAUN5j3N+MFbyLQNOzkiQUWG8c0ZPoSYWhXIURaaOiz79XvngkWtgsXlKfMP5NOMnHJZgCM6RvMLIERRZrh0=
Received: from OS7P286CA0027.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:26d::8)
 by TYCPR01MB18545.jpnprd01.prod.outlook.com (2603:1096:405:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 13:42:04 +0000
Received: from OS1PEPF0000D215.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:26d:cafe::6e) by OS7P286CA0027.outlook.office365.com
 (2603:1096:604:26d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 13:42:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D215.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.5
 via Frontend Transport; Fri, 27 Nov 2026 13:42:04 +0000
Received: from [192.168.1.200] (unknown [10.226.92.192])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 677663000224;
	Fri, 27 Nov 2026 22:41:59 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Fri, 27 Nov 2026 13:40:57 +0000
Subject: [PATCH] serial: rsci: Clear TDRE once per TX FIFO refill
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-divo-ssgrlpcsrc-2996-rsci-txi-v1-1-88e1614ea0b8@renesas.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02O26rCMBBFf6Xk2UAy2mnSXzmI5DLtGVHrybRFE
 P/deHk4jws2a6+7EipMovrmrgqtLDxdKthNo9JvuIykOVdWYACthU5nXictMpbTNUlJGrxHXSS
 xnm+sB5cd7dDGTF5Vx7XQwLe3/2f/YVnikdL8kn4Xhf6Wejx/ZioGIZ2m85nnvtlmAJ/IeYcQH
 TnInQ2erM04uJ1JAToImFH9D+6bd64Bo0dYTodXXayMBim0se3XVu0fjydwpMSP/QAAAA==
X-Change-ID: 20261127-divo-ssgrlpcsrc-2996-rsci-txi-f8d8e461bde9
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Diogo Ivo <diogo.ivo.sx@renesas.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795786918; l=3519;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=62oEN9KCPFY5TOgPKuoUWjc9cPu6NmFjLDK+Gt4Al+s=;
 b=tPBL0XRGJaJ9WscCVCddiXb8+ER1KHZ0+T7eaiWi3C0mM+GcBUIFkTun2wwwUcgyCAsKPkZDB
 +XaOj0FV2M4D0onutXtRIBUAlVvTDLWIAWruwmu1bt6rriYpndBYfB0
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D215:EE_|TYCPR01MB18545:EE_
X-MS-Office365-Filtering-Correlation-Id: 119174c9-b635-48df-5a0f-08df4c8c38e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|10067099003|11063799006|56012099006|261021121427099003|261026121527099003|261022105027099003|261021123027099003|261028144727099003|261102123227099003|261026140227099003|261009223027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ANwOfZxWlpq4pRuSu+JgB+BfBFVakWqRWaUZwkw6LwsL6bexIvmMeFuIgoZSKNjdO8rc7MkHwWvVHQwp9UmXwUa2rUA+70PWtH5lxjRCJ9YjHBchvzG2J2ECFWZxq3KIDxFNEsmEnm+5cmNgtNnFBZ/vCwuCc6J7SSofUeW/0J+tmrQyh5rZenHeFV2P27g1mAdG2+tg7V4siuSYpi9Vauk/AuTJy91mHhihQTLxXHK9ToRHHQ8AxPfkPj/M1FO8m6LpxV6V6yED1XZlX4c92VX4heGYVYuKmSvs3wSDK+5xI0UJiP1uo6hI7qnnQNkvRuxTcjYsYtVL61tv2MXNYwLOvmIKFc0z0NG1CERdUPtA0DjvIom8cr0WurqfUOk9PTblAUAMQpWe7BJMSmlzLTh/yCCynA/UmQ+g4Yozrm76vh425XfrIO8x4GlBxGYtUHQ82SnA8k16vbzRLOSASImeWVerU8kP4cAjxvg7HsoiSLlbP0t5PFJaukZj3fIAMS4pGJqxolumXdixKL7r9y+Bu93JIowzzfOgFOUqSDI7tVqLE2CBcrev8CiUmSG3i3XVDA+24Tk/wESIE1RfNdkpuX3QfpYmVrcSEhYJaDUUATqySvDZuyt/vVXSnHorlxNE/6HrZTty2Jfc2v9rNxwfis93TDVr3MiAIn6UAqdfMVoxPxvuRKbCbZeukgiJ2nw0k0mejYI12Fh/P/erKw==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261022105027099003)(261021123027099003)(261028144727099003)(261102123227099003)(261026140227099003)(261009223027099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AEOA6M7JXuhxOZGP5G4pM76nqQovithz1qzApjHJ7ySvHgSbOu98K+xsh96RMnUCL1xM3635lT36d/6D4gqgD3QVGGqB3mPlqQU7RLGwL26HuOseQq5sT8jbLSUsTEdM7GpnsTCsk0dDChSHSGw0UvEhe1cVEbxJvK8RG9I/OXSh13UBDawa4NvYiQW/8FvRJysMkmwsj6uVZlOYJdCGeSLdewsf8ZaAp2hIomJL7XLk2uG73jUnUpkix9QsUXxSm7WYn0ghiWXkbsk03IvAAkaCTMuLGbexkuwcIeF/xEWqX+iyq2zwCurcftfOtLegB9iOFrNqxnViHue1pn/hIwKNy+i9Tp+udW57VHqQ42/K3v+vD0u0p3J0xRDKXipkZQ7SlGLzzM2Pjt/7h9FL20wkMFF0khI6nTgvsEXwQg+eKqLQ2ctVAezW4Ru8qaqq
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:42:04.2680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 119174c9-b635-48df-5a0f-08df4c8c38e1
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D215.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB18545

rsci_transmit_chars() clears TDRE before each write to TDR, going
against what is stated in Figure 7.3-17 of section 7.3.3.8 (Serial
Data Transmission (Asynchronous Mode)), FIFO mode, of the RZ/G3L
hardware manual:

  To continue serial transmission, write all transmit data to
  the transmit FIFO (TDR) by using a TXI interrupt and clear
  TDRE flag to 0.

This leads to two problems: (a) up to (FIFO_SIZE - 1) unnecessary MMIO
writes to clear TDRE that take a significant amount of time in interrupt
context and (b) a second TXI interrupt is generated while the first is
being handled. This is described in the RZ/G3L hardware manual in section
7.3.2.2.18 (Common Status Register), under the TDRE bit,

  When the condition which becomes 1b and the condition which becomes 0b
  were formed at the same time, TDRE flag will be 0b. After that, when the
  number of data stored in transmit FIFO is judged, and if that is equal to
  or less than TTRG value, TDRE is set to 1b after 1b RSCI_m_PCLK.

meaning that if we clear TDRE while the FIFO is still empty TDRE can
reassert and trigger another TXI. This was observed on a test on RZ/G3L:
clearing TDRE with an empty FIFO made another TXI pending.

Fix both issues by writing the batch to TDR before clearing TDRE. If no
bytes were written leave TDRE alone.

A test on an RZ/G3L platform (FIFO_SIZE = 32) sending 64KiB of data led
to 4096 TXIs and around 159 ms spent servicing them without this patch.
With the patch the number of TXIs went down to the expected
(64KiB / 32) = 2048 which took around 86 ms in total.

Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
 drivers/tty/serial/rsci.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 80087be11808..e4704cb3b6c7 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -432,16 +432,16 @@ static void rsci_transmit_chars(struct uart_port *port)
 {
 	unsigned int stopped = uart_tx_stopped(port);
 	struct tty_port *tport = &port->state->port;
+	unsigned int sent, room;
 	u32 status;
-	int count;
 
 	status = rsci_serial_in(port, CSR);
 	if (!(status & CSR_TDRE))
 		return;
 
-	count = rsci_txroom(port);
+	room = rsci_txroom(port);
 
-	do {
+	for (sent = 0; sent < room; sent++) {
 		unsigned char c;
 
 		if (port->x_char) {
@@ -451,11 +451,13 @@ static void rsci_transmit_chars(struct uart_port *port)
 			break;
 		}
 
-		rsci_clear_CFC(port, CFCLR_TDREC);
 		rsci_serial_out(port, TDR, c);
+	}
 
-		port->icount.tx++;
-	} while (--count > 0);
+	if (sent) {
+		rsci_clear_CFC(port, CFCLR_TDREC);
+		port->icount.tx += sent;
+	}
 
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
 		uart_write_wakeup(port);

---
base-commit: 3d229ce89862b8e82d71a9e11d6f840ca272a6d6
change-id: 20261127-divo-ssgrlpcsrc-2996-rsci-txi-f8d8e461bde9
prerequisite-change-id: 20261020-g2ul_sci-b610606ea5b5:v5
prerequisite-patch-id: ed5f3ae4090037e6b4c6126e86b3a5ef1c6c1b44
prerequisite-patch-id: bec547271f9d220883db537de4c595fb9734d5ce
prerequisite-patch-id: fd136809f0c9d90c66f23b5165f59d3e50117928
prerequisite-patch-id: 498b88618f0dd6fcc63f671fde36edaf5cd0c811
prerequisite-patch-id: da7a159d3cd6376a17a9ab5edb91eb283574243b
prerequisite-patch-id: fd9ac71ffbbcc1aa106be6f923583a39342c7296
prerequisite-patch-id: 988f616382a3b4aedf191e097cc829b7be0546e1

Best regards,
--  
Diogo Ivo <diogo.ivo.sx@renesas.com>

