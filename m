Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022074.outbound.protection.outlook.com [52.101.126.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B4C277C8D;
	Sun, 30 Nov 2025 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499492; cv=fail; b=exocaLyFnCPdK2phit6moUFxaYthIKbM/JhVkgIHllnQb3RfztUWjnKOoxHXOZv5mSNXXzVfPlcIYsWJakH3eZ9JcYy68eOliZNPViQSJSW8eKsQ8Xcgziy5bAFf5rtGFw5uJ368WuFE/5bBK11V10F0dFodhyCcLhk32sSoTmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499492; c=relaxed/simple;
	bh=+o2d+7O/s9ibiGD/ubtuOhyGLbdwq359hSMjaxfjXAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a1OzMH/EvTAOKjLQPgfAPHkDMow+KA7Ggdn11raNayK0q4yIuTZldZ60qVG8jPc9f5e/bDf+4/sq0Sx0qEO8z7gICF3TJvs25j0AJskTt4jkNpfDtmpiOmGUvU2Spe9505GQVdNdvkvYmIJxMzNlhs/T5jm4mwNEQ4een6Kl0q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=dUbWKCGU; arc=fail smtp.client-ip=52.101.126.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="dUbWKCGU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3sgiR4WB0YY8cns6vV+jFZ2mVIpcFeBuoZF7h42RFN1h5FwWYvbv3mdTVKikytKxtxMRpthRhMkpaBEpzpKuRul56rNRW+IW4+K+qeV7AwHDRBIwtP3KIpHJaPQLnmON922Uvj5TtT2jmjOFHDuH4RejeGiZV+i6TP251IIdQVL3bOtp1LMdysd0Rzt/SG57ZYkD9T55SN5VryBznx9nMaYNffhQu8eWqzkpaqoj3pHyA5yZl41QHXf+soJbfppKbnpC/K4Cq1dERR2udfeA/AJUAX4qJwtlN7WLfjA/w8Nfp5/aKde7OtTRm2bKir9/QQUTaXYdbxTlg6FUXzl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nosEr36Z+f86yrzs/Egc69+dWSHoSX3wrThkdJ6Vm5I=;
 b=VaWTNnqxRzgV+TOgnt0jG5yAUFFBw5ZvDA0nKyr0j3NoUCnsLNoZ1fV/TqKHNBAg8zjInSh0m6/UqClamUh77KEG55x1PoeXgWR3rz64BQzW9bx0Q/Y7ovejydYrP+FCayZbsm2XY/5epwXESZvc8FDxCs+EQGswdTQaSs+4Ht1QbVCMPtX99JvRHPfzKicAKPMmbxAcAN/+7TSDUVe9VnKau/HgaO1h8sN/UseFv0d84aArYHrxOc5Z5QeXjR/R/+GvrkblmgFFTUSRQrir/ZKmZtFZ3RJGwY41g4yFJFHN5FYTFcPAiJRLVz911tvbwsXOBI3zZtUIuqHa0rWU6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nosEr36Z+f86yrzs/Egc69+dWSHoSX3wrThkdJ6Vm5I=;
 b=dUbWKCGU9M6GXam68kpA0tpODVxPX0FJXw85KQu7yL/VQspniyixpcdqDEiR7yPWvX1mXCGQQTRYY8ESeruNN2FZVWb+hZWyGBqOCCWmdgUTWuYNB74BUJfxhO0FCUFLXTwgsjCyuN68uL6tZc8LArm1rJTnIkScuROuODa+vv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB6080.apcprd01.prod.exchangelabs.com
 (2603:1096:101:221::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:44:44 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:44:44 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 16/31] serial: 8250_mxpcie: optimize Tx using memory-mapped FIFO access
Date: Sun, 30 Nov 2025 18:42:07 +0800
Message-ID: <20251130104222.63077-17-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::18) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 49326138-247e-4e49-1cff-08de2ffd7990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0pKckdAki5x36q7TKPt+/nMEsCYFym7FBQQYBU6TR+8bKZ6yAjH6XBbfoC+L?=
 =?us-ascii?Q?tmdMfy5CQwVMEop0RVbWnxlocFw9bNMrRYB73fqAwgC4EfazeXUsrNG/rzBR?=
 =?us-ascii?Q?NiDgZ6i+r3QZECY9ZRX++ekT9KZwvyemDChHrYVg8TBLG4y5Ks83Xk6pdEYS?=
 =?us-ascii?Q?PF63Mp8tdP0c3YyzuJLZ77mgxnOWGYu9j8ZNKvEbfBfzy1NSFMsODqWitQ33?=
 =?us-ascii?Q?pJie8khSjGKMdQBL2iyYjhdagDCCEchT2O0XmG6mkanK+67qrivuungjsELh?=
 =?us-ascii?Q?wz6Q9rFjlhIOHzQDFFmQWDbSC6iImx7t6mlSs9oxYxdVOJTq+Rb8pYj3zS9X?=
 =?us-ascii?Q?G0//ATcoUErYK5iCrbC4MxpEu04nzjRJhueKn0waWAl0lpbYE8rlOmuLcn79?=
 =?us-ascii?Q?hkBxmMH+0Na/ANlJJqfSuORYrpJl5nTG3eflw4luTDvUSe21JdpRP22qTIcH?=
 =?us-ascii?Q?URtgUgYDpiFlcgEv0iB22xC36SsOGHFRRATmEbaw7X2A0WkfcMLmVMzRpWsx?=
 =?us-ascii?Q?dU3bh34jyJPNptxyvYU6mRikwqIxILMBC1rkP/Czof98dLSOtwTAJgy+hMHo?=
 =?us-ascii?Q?VtFHlhPZXlC1039DbCvaG3aNuWjaMgXd3VQqHE+diRhiEkzrUWvxs3oRRd8s?=
 =?us-ascii?Q?OBfTT+2Rhgc+5MESvd7+aS/8bsmk8WcJ/oXqY0ExEZlDKmgPy/KWrqRefqR6?=
 =?us-ascii?Q?5TyS3Joyww9Qak7qsbtWrIdAWnCBgbBIEMQUku2M/4sv02NQh1x5hVJKRN1B?=
 =?us-ascii?Q?zkapsjPXOLwBgheQY4+mUhkK/y6RksnTRyL6J/zg30T8SmBQLIiypuwbRdxB?=
 =?us-ascii?Q?Jsl14ZNAnHaRJE2Nf6+tsPq24lIdMD2ePi7wi266Pri2rPisq1W56tJAxFZI?=
 =?us-ascii?Q?UEVKBMRXBuk7T/ixBKJNc5hJqiXDhEvz1e2fCDRuHgH23kJb0Sr9CwCz12g6?=
 =?us-ascii?Q?RgCvsYEnsGICUCI2jUeeNE69im/JQiQRfiTphTZCwgsR6eZpBEJELU+7/2pR?=
 =?us-ascii?Q?Z2nnpbfMizTWcPL3+2h2ZnzxVzvNHL+NSUzOI92KAFMwYYNIVK1HnPmvli+9?=
 =?us-ascii?Q?K/vcZeYeV0/shVOT8SzDB/nH1lKMAbfqfir4omIAoO6CR82gVXj+LDvgGMyz?=
 =?us-ascii?Q?0VnfLwFS8T/enD5IX0OhN6Bogrui5BPc5aVa9AZ7WyWlrgnOicXYFyIUUIQb?=
 =?us-ascii?Q?KVAKr1B9IQVTekE9oT3/wZZQRjIB4AgKIBM8JKUSjGz8oNkH761nkyUeRWVk?=
 =?us-ascii?Q?31G/U8l/n55PVCoqIcq0RqgdGbYGJbA0VPD+O5hhvmcygUrzD8sd2t/tEd6+?=
 =?us-ascii?Q?l0sACmZjje9ZBU8J2iOt8IFkWyOyroQh5+ADsdgyXNTtlOclih/3XWqfmuGf?=
 =?us-ascii?Q?Itp9eT7Vw94RM9ezbYd2+DiL1bUFm9+ywFTzYA8ZZCYQhEK5HWgUg04x9J63?=
 =?us-ascii?Q?K84pV5LUUHNxBtpA3U8MRnoUuQrxpYWNfCx5r0sF8+xzr640F0s+mnP5YHaK?=
 =?us-ascii?Q?WiD+e6bMzXtFeIxiLEvECFyai0weTmg1TO+Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?93NdljD0oViH2gpRNb5f8EFD55hW7XMdiUd3cCwm2jBo0cuis5ctak8Ld/TU?=
 =?us-ascii?Q?LNPjYZ1qx4/UQn4unaAg7qXfoP3TzLsRcFqkD/Y5tF7aaXBH5Tjh2cPJ8NoO?=
 =?us-ascii?Q?+NZmrIbizCioxMUiBre3Leb8lHZCNeORvJIeWsboe272nlmrSdKZTtYjtGDF?=
 =?us-ascii?Q?A9XZDBAEWITAvY/gTA/u8dhRSVWyzAkwYp1xFH7XXhcc3/lTxk5CyQ292Hh4?=
 =?us-ascii?Q?4Slw/NVDKpggkmhCz4Fb/5RrG2K4GtwQPFjcPoOR18hEzo6u+TsZrV5DbAu1?=
 =?us-ascii?Q?+dc42a+KXTRNS0HI0r49Z1kh7A9/bJ3BVAn3I2n+y/ceJkLAxq8YjYdqstXP?=
 =?us-ascii?Q?AtYxXrc8d5kqiY3z0MrHLzMur7qopufjFmoJ2a39Ng74785aRZugidfzdXI0?=
 =?us-ascii?Q?/Ks9kTh53PX6Hftr4hzrLo0eXQfUImt8ed0g6PHJ1mxI125oqqU8RdOMnFs4?=
 =?us-ascii?Q?8FLoap2/6VVEfD00YMiLzcRQcVIkNL6Kis4exMSEG8gFr5zVPVyaRgCjCTr8?=
 =?us-ascii?Q?hSWN0g3NieKG0GGULBt7zDQ4MupqzCrMo0Gka+FRTyBby1/2GFmx7egd3gQc?=
 =?us-ascii?Q?U64umP+TCmxy5TZK6HvuLydfF2GTvh1m76ypnwsoVo6V7pE62ml2hKNptNwD?=
 =?us-ascii?Q?Qf9ihDgBgU1fOS+5siMzQD23Ni0WmGm0AcuAQkHL4KiDTdQGHc2kInG7W1Bq?=
 =?us-ascii?Q?WxmJGYTV1gRfCKg+IDemvYEKFqkYi1eBHxlqswTbOD4uzMa4SyI89bL8Qj8E?=
 =?us-ascii?Q?FjKxD45gddhaW0/Ppp6k54AAbeZC9k6TDkvpLlRkYVqo9VjEiIiBSbOiW+41?=
 =?us-ascii?Q?lEYWg6hkgcBGJt5VtiQarpuHNzecvMt+BN/stl3liIC+KCuIH/yiseoO9VgO?=
 =?us-ascii?Q?H0glezq4K5fiTZ2PLtSr6eGbo8W84XP71rLoHH+0yq6Kph+7NN8EKvEFl1y1?=
 =?us-ascii?Q?PptUMK+ZBUS3qaYSPfTKrQxW/XxWmKJP2dgatFJoVH+ZDruD4uW1d/gwvAe+?=
 =?us-ascii?Q?MeFLtWba+JDh3ECEgI6SB7p1kW6ltPAb5j5JOnYtwRVXs1Yg5rs2kx2/uRRn?=
 =?us-ascii?Q?xtHaNkwLZz95lpSmY+JL1EyA6wruBGxK1Lw+CAVaNlKRqhc4P55Bf8EXROsg?=
 =?us-ascii?Q?VZjc3owm/fz2dqSTrmwFb5Oc7dyt6giqoorqCRAA0CusBezWsj6/ZBScw7tY?=
 =?us-ascii?Q?i7Z4QL4H5VK7kDDT4qtcKA1h2wa42UNR0OLYa5MANFELM0ADldCGn+nC9xbI?=
 =?us-ascii?Q?Hd25x1b619c9LjUf1Zs7XBy3CinUHzA5bil0540FVb21bZRPlt+03duy8QYz?=
 =?us-ascii?Q?cUjNqhmy9WhiZWcNcsPBi11/Y5I6H9+hriNZifqoJgRGdUqxFSKwZxw136v/?=
 =?us-ascii?Q?GBUGPFPYsUzGdePeo+e+vbERs16F9znWL18xSeMB1Apf6NLdZAgYhq351Ag0?=
 =?us-ascii?Q?2r3IUd/8NRTMOoD88HlsfRdW16XJXVBR4rrRol9Janc4F3rk0n1aTwU4XBtf?=
 =?us-ascii?Q?vO2WMCjES5wobMuqQyD2VfLFn8bdSx+VRVQ5XRDe0aIKQO9kUnVBYPJVpR+l?=
 =?us-ascii?Q?LjGW1RaYnhQlkz6VopFSsUcTFEhv+vy817NGLneiTeDWwUTI0oYekKSEKeU4?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49326138-247e-4e49-1cff-08de2ffd7990
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:44:44.6542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3bM6U5VTxEd49u+G4QyOsswqBV6V/i3wSYgtCc8VzNMOdk9lyH/X+VKPRBr0C6sxehjK6FCf9mAKGzLfkQH9UEm31TZKLK9+/k7mB60vNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6080

Add mxpcie8250_tx_chars() to transmit data via memory-mapped FIFO
access, using the UART-specific Tx FIFO counter and buffer region.

This replaces serial8250_tx_chars() to reduce per-byte I/O operations
and improve transmit throughput on Moxa PCIe UART devices.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 35 ++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index cf519960d5d1..90ce522fe40f 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -73,8 +73,10 @@
 #define MOXA_PUART_FCL		0x12	/* Flow Control Low Trigger Level */
 #define MOXA_PUART_FCH		0x13	/* Flow Control High Trigger Level */
 #define MOXA_PUART_RX_FIFO_CNT	0x15	/* Rx FIFO Data Counter */
+#define MOXA_PUART_TX_FIFO_CNT	0x16	/* Tx FIFO Data Counter */
 
 #define MOXA_PUART_RX_FIFO_MEM	0x100	/* Memory Space to Rx FIFO Data Register */
+#define MOXA_PUART_TX_FIFO_MEM	0x100	/* Memory Space to Tx FIFO Data Register */
 
 #define MOXA_GPIO_DIRECTION	0x09
 #define MOXA_GPIO_OUTPUT	0x0A
@@ -282,6 +284,37 @@ static void mxpcie8250_rx_chars(struct uart_8250_port *up)
 	}
 }
 
+static void mxpcie8250_tx_chars(struct uart_8250_port *up)
+{
+	struct uart_port *port = &up->port;
+	struct tty_port *tport = &port->state->port;
+	unsigned int count, i;
+	unsigned char c;
+
+	if (port->x_char) {
+		uart_xchar_out(port, UART_TX);
+		return;
+	}
+	if (uart_tx_stopped(port) || kfifo_is_empty(&tport->xmit_fifo)) {
+		port->ops->stop_tx(port);
+		return;
+	}
+	count = kfifo_len(&tport->xmit_fifo);
+	count = min(count, port->fifosize - serial_in(up, MOXA_PUART_TX_FIFO_CNT));
+
+	for (i = 0; i < count; ++i) {
+		if (!uart_fifo_get(port, &c))
+			break;
+
+		*(port->membase + MOXA_PUART_TX_FIFO_MEM + i) = c;
+	}
+	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	if (kfifo_is_empty(&tport->xmit_fifo) && !(up->capabilities & UART_CAP_RPM))
+		port->ops->stop_tx(port);
+}
+
 static int mxpcie8250_handle_irq(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -314,7 +347,7 @@ static int mxpcie8250_handle_irq(struct uart_port *port)
 	serial8250_modem_status(up);
 
 	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
-		serial8250_tx_chars(up);
+		mxpcie8250_tx_chars(up);
 
 	uart_unlock_and_check_sysrq_irqrestore(port, flags);
 
-- 
2.45.2

