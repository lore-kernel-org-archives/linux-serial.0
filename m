Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011068.outbound.protection.outlook.com [40.93.194.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945E533CEAF;
	Mon, 12 Jan 2026 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205926; cv=fail; b=M05jWLoCYDDF6+5h7PALBeLBPU7NX+dHPs3Zmu+W2YafO6pX03Nz+lIvdvIa17ZnOC0nMdLUm/cE+N0Ez9DkldGGSbIFG7YyWzu7K7CqPuo9tMv41qbWAyApfDfzORP0ObEh7plyH30zKSZ3/PD+AO4VZ5UP2ebGukj6skroNq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205926; c=relaxed/simple;
	bh=smZcUQqBRW7byz5UqUrANpqO4pGPinu31B4ip70xlIY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHZ8V2rnMqBRDrrsTKqRraoevUV1yabtQ7vkjkFeVLUgqEIMNbMPgW7KVkUY3GjRqKYa2fNUyp0mJCvNQXHrrqD7m6gUeo+60HcarmMaYhbb8o3KC9PVA60sFSM5zwQfdsZpy5DBdm3JbT7hJ2iIwTD22K6mt5G+Up6LB5Elnh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=byQoEu3D; arc=fail smtp.client-ip=40.93.194.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="byQoEu3D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLlTiwYDEj6k5zu7FgAsS6ZSIlsy6pQtcnj56Qq3SSKF58e3ibdGkCHBwYv4IZ5QFw04zpV5nknLOb8Jiq1niGjuuKzCqeNlqPE9DkDDRAPhj8onuclCEcoBR/ErJ924l1ilust2N5Jje0AeiE93ffHz3J/Z7KdCg4qhD7XXBRA3KeETIIqMJavjyx5XFfQ0GnGUevDGwcWCp6ZZdaTj9qh5p+JTmE9BHprTqvzKJJKvIAST5Yb+nAnFsZGtGNl4oFFiQASVCI1F6b4RWldBuCHWEBCy4tl2ZBjz3P5FaThEo446WQCgdoR5fFUAOKGsfQ8F6o2Jk+biLSGRrCBpzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHrr0UV/u9soU2oYr7LQSBfNlYmXE5vItevpG/hMuXI=;
 b=RFUKpXnlmDIc5mig3gjvRN6RGvneJ82zPdTegu8TVA11yvNFV63kH0ki2XRF/TA7t6C/QE2ff2+nBaNB1VuFz6AoAWSaoe/OVgVX0MCXJLknFgNP3E820d2dk3pgK+advOrYtrI1OVY7ZOUGaLwvcdHFnJCClFUFBM6ft2YqTMPo46UcXToT5+BA2iqAhZwUsnWBWJaLHCv/Kfu7n9MMsaKr667HrJEbvZaWjsAMpaYBgGeIFBG91M9Cr1CB1Uv8NFrrGwhYrP03A5RixxN2JJAdALekeTluWizjPmHL7ltoZkVAaQuJLQ77J4gZnQHFkoHqUY3pqdVp8bl5pHFUhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHrr0UV/u9soU2oYr7LQSBfNlYmXE5vItevpG/hMuXI=;
 b=byQoEu3DndHsKYnsoIDtjmGcUhO5ml3ODFH224m/uqwhZknmM+4Zq0cfoqk1qiTpL4bb1T5BHyOjCk36wgyJ42xHwnWeHZb9zNwm4BKFQ3Ok9wLjASAVgrof4kW1j8mmTCwxn/SdsDY+JK1OJq5oi/QM96UQljYnt1cTbYLSCD4=
Received: from BL1PR13CA0357.namprd13.prod.outlook.com (2603:10b6:208:2c6::32)
 by PH8PR10MB997765.namprd10.prod.outlook.com (2603:10b6:510:39f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 08:18:42 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::13) by BL1PR13CA0357.outlook.office365.com
 (2603:10b6:208:2c6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Mon,
 12 Jan 2026 08:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 08:18:41 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 02:18:38 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 02:18:38 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 02:18:38 -0600
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com [172.24.235.46])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60C8IUWm171777;
	Mon, 12 Jan 2026 02:18:35 -0600
From: Moteen Shah <m-shah@ti.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<vigneshr@ti.com>, <u-kumar1@ti.com>, <gehariprasath@ti.com>,
	<g-praveen@ti.com>, <j-keerthy@ti.com>, <m-shah@ti.com>
Subject: [PATCH 1/2] serial: 8250: 8250_omap.c: Add support for handling UART error conditions
Date: Mon, 12 Jan 2026 13:48:28 +0530
Message-ID: <20260112081829.63049-2-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260112081829.63049-1-m-shah@ti.com>
References: <20260112081829.63049-1-m-shah@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|PH8PR10MB997765:EE_
X-MS-Office365-Filtering-Correlation-Id: b412f48b-6e1b-4b88-7332-08de51b3323f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|34020700016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZdDXVf8xWUSrzh1Q3hVotgR+Ju52c4/9BniRqHI13/Y15Qx/ciYoSbD7LHqT?=
 =?us-ascii?Q?pTFnPJstlZtdLp0oSiUYt0TOd1BzokFbhspragR72KuoCMDCg97wkfjsW3VJ?=
 =?us-ascii?Q?YUQ1s6hgEOndB4sLCW5mDcV5HyAuoQS3jk1h1X83D4MyDrMQLX5AnMneJEse?=
 =?us-ascii?Q?RvoQR66HKDEK9OyBvryUeFPXGeFx9nRkmKqn8gRSjAtH4R6L7DFOL1KnnLei?=
 =?us-ascii?Q?MFAi5cvypHhYZyGuN9zrXULcR+Y/twKHNqvA0ftdTxli8e9ISHUayJJcvxEE?=
 =?us-ascii?Q?dHiMxLXUs+utr/WbgzB1tsvYIeLfR116jNMZzvcCf7gdoIrJrdEmEPbHVUHy?=
 =?us-ascii?Q?Bt3KnYGcl9fVtViYQD3YOoCCZ/mjiBBoVF7tC8O3TtuEDm+ttjjho8JShJjK?=
 =?us-ascii?Q?ifawLuw9ypy8BzRbnXOudTk3opU+G7xtw/BiYPrdUPV0rhr9M9Go5jBTh1Wl?=
 =?us-ascii?Q?HewJcLGrBuk8gFPfr8XXLiUBqzcGo8Dxs2q6HhZNslVHdTDTu3bpBpKzjE/5?=
 =?us-ascii?Q?IXJ+tiz9YjeHVCqhObtHLUwuz2iJzQZ8M2Z7PTphamMycxyStEpukpTGEtkV?=
 =?us-ascii?Q?LrNlKHc6RnhjAePLdQTjw6wGPfATnJMnb1Olf3SVmofK+fvPt6Yk5zOCu9L+?=
 =?us-ascii?Q?RxEOOdJIFzp+GWZ5UE9s5rlU/AZR4FcJ37ExyTLu76MVHfRR7U7j49hJGsBp?=
 =?us-ascii?Q?bnZYM9T+F4EoG/t6Qky5LUSEsrmQQlsAYsASAI9yLxd2mbq6c9bX/P2xwl6y?=
 =?us-ascii?Q?Ij2tOwvd0MRLi0VqYRwU0pLyQ9Lx5B9NUfqEqDD9I4nUbvNR3LWvIzLbmaiX?=
 =?us-ascii?Q?rKsawjWOwaCfYPmwO5y5x9PpwC68bkeJKvAPM6iQBGhUdjM5aOtZxoN4zUpz?=
 =?us-ascii?Q?/3crRCYYFccd0ZUvtBjQ1wI1+H2WB3ZXwUqe+xuboW9oNa/WJuNt0cd0L/fG?=
 =?us-ascii?Q?VHuG2qtyUc4zzqPIuJ0T9Hu96hisbYKYB0BxXC3l8eg+qPOruza1PWdsHuT+?=
 =?us-ascii?Q?4iZ0u7a938FLzjPXU6/Ifd4nAKQ8xrBa4IAaW4Go3jemyFD1eN5NgFpJCdKo?=
 =?us-ascii?Q?2TiwySPyxr6y/u4GTkBSmGKljAe0wN1jqbIiaoCegPanIaVucAHRFNcl9BN6?=
 =?us-ascii?Q?0IsZMX7NjYioOBf+Kz4pC0IBovWVOiFLfg2As1UFgRa9J8kTUq6QCx/qVVVE?=
 =?us-ascii?Q?knu90PikwUc1+mn/p3jmxaiBNLUr3DA4X6FK1pC00MuC9cdgycRtnCBl8HFN?=
 =?us-ascii?Q?FLEGRdoXy3n8vB0EhgFtSCLyBQI+NV0mcloCTJxd6cSEDREXW3l8X3P/eCU1?=
 =?us-ascii?Q?eVbNXw1UEMe9RhovwM0ERgDHezCk6yBRIZnGkAalE+lLRYn3OiwLLo4FVi/P?=
 =?us-ascii?Q?sE6Af5Cc75s5uOeIAJeBXEO60rpviMUUGCN9LuqI25AKeBdsPwCoe+vqRkoy?=
 =?us-ascii?Q?RtEtp+pXh6Dh6KdOAUjm36k64UOD+YBsyT7+Qs0Lybk+2bfuLtetBKc8xKQx?=
 =?us-ascii?Q?j0VKUUTCAQMNJ4GqpQd5Xl/qYg18ZwYGBLqeg70lu0N4rQaasEHd9rIR976B?=
 =?us-ascii?Q?pMqbBoe4N8XUVQhZPTg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(34020700016)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 08:18:41.6010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b412f48b-6e1b-4b88-7332-08de51b3323f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB997765

The DMA IRQ handler does not accounts for the overrun(OE) or any other
errors being reported by the IP before triggering a DMA transaction which
leads to the interrupts not being handled resulting into an IRQ storm.

The way to handle OE is to:
1. Reset the RX FIFO.
2. Read the UART_RESUME register, which clears the internal flag

Earlier, the driver issued DMA transations even in case of OE which shouldn't
be done according to the OE handling mechanism mentioned above, as we are
resetting the FIFO's, refer section: "12.1.6.4.8.1.3.6 Overrun During
Receive" [0].

[0] https://www.ti.com/lit/pdf/spruiu1

Signed-off-by: Moteen Shah <m-shah@ti.com>
---
 drivers/tty/serial/8250/8250_omap.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 9e49ef48b851..e26bae0a6488 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -100,6 +100,9 @@
 #define OMAP_UART_REV_52 0x0502
 #define OMAP_UART_REV_63 0x0603
 
+/* Resume register */
+#define UART_OMAP_RESUME		0x0B
+
 /* Interrupt Enable Register 2 */
 #define UART_OMAP_IER2			0x1B
 #define UART_OMAP_IER2_RHR_IT_DIS	BIT(2)
@@ -119,7 +122,6 @@
 /* Timeout low and High */
 #define UART_OMAP_TO_L                 0x26
 #define UART_OMAP_TO_H                 0x27
-
 struct omap8250_priv {
 	void __iomem *membase;
 	int line;
@@ -1256,6 +1258,20 @@ static u16 omap_8250_handle_rx_dma(struct uart_8250_port *up, u8 iir, u16 status
 	return status;
 }
 
+static void am654_8250_handle_uart_errors(struct uart_8250_port *up, u8 iir, u16 status)
+{
+	if (status & UART_LSR_OE) {
+		serial8250_clear_and_reinit_fifos(up);
+		serial_in(up, UART_LSR);
+		serial_in(up, UART_OMAP_RESUME);
+	} else {
+		if (status & (UART_LSR_FE | UART_LSR_PE | UART_LSR_BI))
+			serial_in(up, UART_RX);
+		if (iir & UART_IIR_XOFF)
+			serial_in(up, UART_IIR);
+	}
+}
+
 static void am654_8250_handle_rx_dma(struct uart_8250_port *up, u8 iir,
 				     u16 status)
 {
@@ -1266,7 +1282,8 @@ static void am654_8250_handle_rx_dma(struct uart_8250_port *up, u8 iir,
 	 * Queue a new transfer if FIFO has data.
 	 */
 	if ((status & (UART_LSR_DR | UART_LSR_BI)) &&
-	    (up->ier & UART_IER_RDI)) {
+	    (up->ier & UART_IER_RDI) && !(status & UART_LSR_OE)) {
+		am654_8250_handle_uart_errors(up, iir, status);
 		omap_8250_rx_dma(up);
 		serial_out(up, UART_OMAP_EFR2, UART_OMAP_EFR2_TIMEOUT_BEHAVE);
 	} else if ((iir & 0x3f) == UART_IIR_RX_TIMEOUT) {
@@ -1282,6 +1299,8 @@ static void am654_8250_handle_rx_dma(struct uart_8250_port *up, u8 iir,
 		serial_out(up, UART_OMAP_EFR2, 0x0);
 		up->ier |= UART_IER_RLSI | UART_IER_RDI;
 		serial_out(up, UART_IER, up->ier);
+	} else {
+		am654_8250_handle_uart_errors(up, iir, status);
 	}
 }
 
-- 
2.34.1

