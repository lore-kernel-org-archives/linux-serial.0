Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013024.outbound.protection.outlook.com [40.107.44.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FCE34A76B;
	Mon,  4 May 2026 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884626; cv=fail; b=oThrMGvzDDCFQL4kAVbSsRwcNmDlgESXmGWhA7r0TgxwWisiMY1iwADJD9vnUl+5YHxDGY6x8rg0mP17Ch4l9c+tIkcHl0+V4bo0ZJwe9U6kAOUbyg3z+ZDluhzB4MePmnRwgLKnv8y0e379Le4Ku3rFLjlNUTBxyxLfjXd+3Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884626; c=relaxed/simple;
	bh=xKBvLkqxDtv6U1lZnKgvraOQEB+TSCDuSM2rdJk6Wl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n+x2CiSXPaCK8l2n5qLvQspicaeHOPxzTzTGHhUxMcUM7vYzknGUPI4d+UcJ5HHj/uBMdXJlA9sWzGM7ORb6iixfE35a6cgZ2EhCeKm0aoKFW8ymyjp44qwZSGNYurX6QOmz9R9nvf0cz6wippAeIfCdoMOss0C51dS39lvI9JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=aZGTyxYq; arc=fail smtp.client-ip=40.107.44.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="aZGTyxYq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Msz34k2KQwPmeGK/VZjOaZLw8TpdJGDywGpuL/iGxV6qs829nMdY1vlouv01b149IB8GMyFOQjGjI2Vmm7yILfUizlIsbTjRhLPYwQBnJaak2vOZNLOnRoDini/AR/XpIAip7Wf4FwNv/IYC2hFjE/1ktUiYbSxP1qa3u0dDQkLLTiA/Gk/6DNJvRDbw+zZ63urVFvHWxN0P8AZ1pS85Ob8B/R6Zx7MDa/ahRTqoj/GDpMkPnOQTyagZZrY6YMviJVnFlMTHMGcWuIhDbQvTORGyZFDUfDZaxT1FdHDPCpPNdDxiH3UXrEGilvG9Dcesib/4yD8O0LvsA8o72n/PYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZZykS7L49T+f77OFZ589/58pChY1UbheilEgTp2iFQ=;
 b=Kl7hJl6RaGl06XIBr1RALaLGNVq2ULdtHfQuYt/Tk35PQoCX3MrrR3BT0EBIQ3w72X5urrr93o0KJ1p3LxGiVTLXS2M7XXzAg+0DPZQzCQNiWbCSS7w8T17olhjtICe1HG7+s/hlJFgTdG3trEvFtstTBJ9ClQlqjElwFD4tZiGui1jxqxJS5TGuXuic1RTgs1yuowvZaVALkRPe5tdb5IYC9gZun06W8luia0dLofWbtEOS7onnNxAwKkh7vV92yFLWWjGOARb2xSCd/rKWZt4kORLmy6SN8XuDnIMCBX7FZ1P42GItGpwpK0I3XDmlLP3YlecrzJlY6yo4CI5lpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZZykS7L49T+f77OFZ589/58pChY1UbheilEgTp2iFQ=;
 b=aZGTyxYqf2vhhhqbcfk1tWCQovZtRS6bLR1t0ttNpGEXmexIAFiLy+yqUxl0gN/VCeOYfruyGwnUYYlOI05hoKFsIZ89YcZrOr03t3Kbj9dHJ3ZFHcPh+SFl0f5+KiMm98nY4/gnvHNCvZGlX8NquEcnuC+1l1S/6rPPX9MnUJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by JH0PR01MB5516.apcprd01.prod.exchangelabs.com
 (2603:1096:990:13::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 08:50:21 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 08:50:21 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: crescentcy.hsieh@moxa.com,
	fangpingfp.cheng@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 07/15] serial: 8250_mxpcie: speed up RX using memory-mapped FIFO window
Date: Mon,  4 May 2026 16:48:52 +0800
Message-ID: <20260504084900.22380-8-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
References: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0040.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::13) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|JH0PR01MB5516:EE_
X-MS-Office365-Filtering-Correlation-Id: 48520837-daa9-4111-4bbf-08dea9ba2ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	kGtlax5CAfnWNX9J9I20KPUZW2wojInbWJf98etVA5E8wnPsZyuJOr9ds0FMprHF8HxvIH2PRADk8/9LF/rGlYoG7qBZcO9JsoGe/JiVrYK5w7VrX2UE/cAYIWGZBxWcxuCUu3KPuhOAhHtzcSpVv9GLevg5wo6QsGOe8p1Llk9w6afF/6Gxsy8513OLgppTYSw8kDdL6kIdVGaS+mgLYsWzYzAfJ3PbIc43lYLUhDif0rKj5uj2XCq4/nwzJTzE+yKPU+kmrPUNVVuvubnf9TiVaphWsACgyqIoOxDOFAjKvZJQKReUrEVxVWPYFjhc+I6hONOMKTYte3hW4OaEhFiym/pHaTzcq65s3lepzzYtBRWZTDM3+3/cvzek9D//tr0F/5HXpJ7oMov7aGDiNRzVmsYJTIxuut8gveB7ptkQAV4hnF1fc5f/K1TAdmbhuVrbDvG6DAJqoKEOVxhMxsCemh/pqto4dfXuxe8cKjyq8gDf4FUgfablipHIBjNp4l3AiYGGbiBfAuqfXShOgG0ZNngekgC/59CX0XphCr8ThceLN6H9yYd0habR6KDHTyXPCXu5f06IzYbjR0myTN4oGIk3LNdG8KqOdrjD4D7nA41U/j5omeZgVSqP5lzdy+LACskq4t2tTTjZM39RLUK5o66rU4iBpSqN1UG6NInZhDFgwvA2NPN9gab2sso4KtpySG+FUn+RMkfxVjTk0LBpahZ5z7P7KjJf3QOWtEC6x52DFECPX3QlBRu+tmK2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XvaqckGqu5PRZfsYSZS5JP57Ibciejz5mrEPZOVguQMEg3B3BzS0mT8qCGxt?=
 =?us-ascii?Q?FRxsoG5MqLLjqDnimcWtUQZQs6H92UF0Q1385b87cAQMWpRsGAwc2bxMaZCE?=
 =?us-ascii?Q?fEgOtKSO5qQ5NsiFS0kZ09h7APBIJUlkIXYarOXBjYoU12RPxW1DE4xxP4Fy?=
 =?us-ascii?Q?8dQ41AnHU8tMbFKYYyiTxU8/u06zd0wEXhsjGcDTnIoEt/tXOgp336JEbeSX?=
 =?us-ascii?Q?CqWMvYcb3FyOZw/PMJyuX0pPWsm0T0QHJZBseBjLA8W7V2lyEQP+/apoEoiV?=
 =?us-ascii?Q?9cWPJQGUOcLS7eADgE2ImJKgd5y1PKf2fsiTrAPOgVd+lx/xdHKysnFij2rD?=
 =?us-ascii?Q?LrdwXu1jVmJ31vt7rR41zwkNEkP1rix1+P2mUjycrTKDj5LWzzVWPMcEZWp/?=
 =?us-ascii?Q?WbHPEkURx5gVUYGsr5IIMTem9Pcs7HgN1g28iooJfb5NvPI6SKcC3LVugVKp?=
 =?us-ascii?Q?n9sm6BgaE/oPfno3olgRRObOgQEyelU39KteFwwFmpqag10jKf+a11Wvm20k?=
 =?us-ascii?Q?2wsQMgaYQech5KgABof7MPOGNBZ/5tvweVkPHx56BR+AtmOHeQrKzgyB58bq?=
 =?us-ascii?Q?+qnJ3SiylJu4nMhsF9uA7cQDtFAtqi5RC3cV5kYDSHgrVJNJDhPVXp5hp1uZ?=
 =?us-ascii?Q?/lydCF4R9kWhQJqbJKbA8dXfc9/WTrfKIYzlDSMcZkTBDFHGzmGmB2S7VqII?=
 =?us-ascii?Q?KxEtlpdVlznlry2kzSY1rf3PS+XjG6RlPODRMqf7TgN8YCLThGmCzkrgfRFy?=
 =?us-ascii?Q?NsRqqVEhyamMgWPh1xnamw6/m/+3ceU/bsTtxOko8bHAIdNN1fIrR3yyxPaH?=
 =?us-ascii?Q?q34rNPgzTZGHy0swA7/Kux75rG2DeLDE7wi6kWv9sGu5RZL0OyIzzGSm9Lej?=
 =?us-ascii?Q?hMcIue9wRNy2yftax43nHw+iD2vgYzbU96y4kxLXIgncJfFGEgk+gdxfZI+F?=
 =?us-ascii?Q?kdPkSeYk2Gn4GW0TZS/DWHqrRIG8cKTkJY/CvxmTyH98su9U1TeLYj92XlzK?=
 =?us-ascii?Q?OBXs2fJ004e/itGRRaOe8M4pC3JxcQ8NXUTFPML0IbP4NSzNdTmJU+FBp+pV?=
 =?us-ascii?Q?FUNfC1NBSDWqHwqORpbDQcu6TzeHSyD26jZ4Cr2h+eQf+PPX+GACNskAAd50?=
 =?us-ascii?Q?NTb4wIRKsPD1wafr4PZc4/X/zDoyZqXYm7yrlhOPybMiDwltMrUdtB9Affmf?=
 =?us-ascii?Q?4BOGIdFIY9Jy6BEVOjl9r5Mez/OxR5mdL9PBxNGgY+Z3ySZo+OMH8Mu4veI1?=
 =?us-ascii?Q?ceLwhLqZgiAI+PFxDfAUKTxwQmtvuo4A2Jcg0Z89EnUP3+OLKL1jI8CyuNa4?=
 =?us-ascii?Q?Xv+SHjgNZFe7p6l9v5HD2G/Mykdds5hPIM5q6m5tczBI3X90C++wRIqtXca2?=
 =?us-ascii?Q?iYxd/Hmtd+qzvqA07bKI+Y5WuX0J0BNEzGKC3Ks/m2fwoUo/9B5WuD+zeoFJ?=
 =?us-ascii?Q?noalrYtt8gpWBr1+RR+6oQaXIQGHdLqVPrss0nelf4BGAigEdm+GuZToxaEE?=
 =?us-ascii?Q?hORrLF22uRxeCPreYcSf7nN6DvsYULplsCjMeGKSv6a6LMY2KIkcRigvNUb5?=
 =?us-ascii?Q?h7qX4xAVO0e7M4UMSj8HrqmBJ6OQ0BlPhYFGkmTL/4viW7wj6Rq3rvPRgHpx?=
 =?us-ascii?Q?k3CyqmXeb1ZDf9O+9GpTSN+LUt0gn5Y/oDf5cKm2gBo8QnvFMGLyO27ppBuQ?=
 =?us-ascii?Q?vtN1vOB6ExIp/1cC8Y7ZnWOwX0sWyXPdwzJGmfsJFVxKBdEQk6ILH1PG46s/?=
 =?us-ascii?Q?B6dfGPYiEbHg6x9yGZsgEbDuQryVnEE=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48520837-daa9-4111-4bbf-08dea9ba2ccc
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 08:50:21.5142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i47iRHxNb5Utw7if+xe0GW9S1V6Rm0sxIcRAVchoiHNGBsI7za6XrOKARb7gkNCLhpX8hIXDrD4+3a0C42Jk12gDrWQydyAjx+hGWqb+fuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5516

The MUEx50 UART provides a memory-mapped RX FIFO data window along with
an RX FIFO byte counter.

When no break or error conditions are present, read received data in
bulk via the MMIO FIFO window and push it to the tty layer in one
operation. Fall back to the generic 8250 RX path for break and error
handling.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 9860f2ac2572..f13fcb090df7 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -17,6 +17,7 @@
 #include <linux/serial_8250.h>
 #include <linux/serial_core.h>
 #include <linux/serial_reg.h>
+#include <linux/tty_flip.h>
 #include <linux/8250_pci.h>
 
 #include "8250.h"
@@ -48,6 +49,7 @@
 /* UART */
 #define MOXA_PUART_BASE_BAUD	921600
 #define MOXA_PUART_OFFSET	0x200
+#define MOXA_PUART_FIFO_SIZE	128
 
 /* Special Function Register (SFR) */
 #define MOXA_PUART_SFR		0x07
@@ -83,6 +85,9 @@
 #define MOXA_PUART_RTL		0x11	/* Rx Interrupt Trigger Level */
 #define MOXA_PUART_FCL		0x12	/* Flow Control Low Trigger Level */
 #define MOXA_PUART_FCH		0x13	/* Flow Control High Trigger Level */
+#define MOXA_PUART_RX_FIFO_CNT	0x15	/* Rx FIFO Data Counter */
+
+#define MOXA_PUART_RX_FIFO_MEM	0x100	/* Memory Space to Rx FIFO Data Register */
 
 #define MOXA_GPIO_DIRECTION	0x09
 #define MOXA_GPIO_OUTPUT	0x0A
@@ -265,6 +270,29 @@ static void mxpcie8250_unthrottle(struct uart_port *port)
 	uart_port_unlock_irqrestore(port, flags);
 }
 
+static void mxpcie8250_do_rx_chars(struct uart_8250_port *up)
+{
+	struct uart_port *port = &up->port;
+	struct tty_port *tport = &port->state->port;
+	u8 buf[MOXA_PUART_FIFO_SIZE];
+	int recv_room, gdl, i;
+
+	recv_room = tty_buffer_request_room(tport, port->fifosize);
+	if (!recv_room)
+		return;
+
+	gdl = serial_in(up, MOXA_PUART_RX_FIFO_CNT);
+	if (gdl > recv_room)
+		gdl = recv_room;
+
+	for (i = 0; i < gdl; ++i)
+		buf[i] = serial_in(up, MOXA_PUART_RX_FIFO_MEM + i);
+
+	port->icount.rx += gdl;
+	tty_insert_flip_string(tport, buf, gdl);
+	tty_flip_buffer_push(tport);
+}
+
 static u16 mxpcie8250_rx_chars(struct uart_8250_port *up, u16 lsr)
 {
 	struct uart_port *port = &up->port;
@@ -282,6 +310,10 @@ static u16 mxpcie8250_rx_chars(struct uart_8250_port *up, u16 lsr)
 	return lsr;
 
 do_rx:
+	if (!(lsr & UART_LSR_BRK_ERROR_BITS)) {
+		mxpcie8250_do_rx_chars(up);
+		return lsr;
+	}
 	return serial8250_rx_chars(up, lsr);
 }
 
-- 
2.43.0

