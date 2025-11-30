Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022096.outbound.protection.outlook.com [40.107.75.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DF328312D;
	Sun, 30 Nov 2025 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499483; cv=fail; b=KJAOPaLqnoZIYLm5fu4z/dqDXSqwa5CUKKZEQp1FlFKJxDVuFzYLLAbSNkfkdXWSj4ZW+Wj4/966Uom9u4eI+ORSJ/Q/903h8/i9ThtteiNfWN/8thtF/4zHpjLcwSU8f4fLrbrap6T803RbUfy3qUtzbB9nJw/cvuGrnXezDQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499483; c=relaxed/simple;
	bh=qD6zx5lY1lcloJH9d1ODVVrcQyI+JzlFwIN4L6H/QF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qnmgnGGuySovicZi/UOKKKmzQSK6GKLM/EFyWc6iZxrq6z9KZ9OkPE8XA+odd5yDDrUgQToZwwIDClMjMuPUr6yGRzNRzA72q43T3y2XKNXTNy64oEsclqw4o9xy6RihOpDZ+eca97dl2kUAZLPZQcZZDK17dqDV9WHobXHRxbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=VQF94KLD; arc=fail smtp.client-ip=40.107.75.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="VQF94KLD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suiZ8Ewpvd523X1bngYFfc48ACeQHXuXahckeIpYL29xkRK90UnX/jSH2OSlfq0K8E/jjnJilrQX+zyWhKiOb2kdtlVNm4ZOfhKN9JVdkSLZkRsjPrHzpdvgzrAokWDiJROX/h3wGwgS6vN/iUCq/ISKuW6abeJsIiX3OuYBwG2TzKL++PF5sWFMWoQFkkb4xUDvsdwsyTsD/9aowHzEHFKZLizLLcKU9NbsVg+kZR5Y5DXhnIH1y1SGRCd14v6r1xbTRpfMc0iZVD9fcJn/WF6x+FnxQknx7CkcsfXKvPFfBU90wTD/k5XFbT5eu0glUEztgBu4eWuQdR0ux7qwfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUaWQliZbjqIAYzM9vzMuDOziazWqomsg9aokbRCPhw=;
 b=VXW5PhyE5vyYqTALhqG/k2r9/zcciesECFVSORd9X7tu81XA70u3LnuWaNh47/0VX+WTwpTy7nHaSzBuUdhgfDwBrCtm4J9bvQYza9tYxXoS4uf4fBz8sdUv3UoJD7i6LWErGk03W1vnAGJzXhGZO3uOy1F8pQG/zOzB0gex1koFWBROXc98bW2VzUVuEOlt4U/krp64v15W9GZMGz2GwWG+PNzwhC9ZuJTcvoD5HXl5YmHAcOHSSUsFZCkoR6QSESE92WrunomRGn+/EsN8jv5kYEpLLNRQJs8NGgPXEPbAclDMy6W5jXxXxyv2BjMB+8Z4AX9K9pGqa6NzsKsMlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUaWQliZbjqIAYzM9vzMuDOziazWqomsg9aokbRCPhw=;
 b=VQF94KLDHKvVLp0dHKhhluRoc+hZ4bdnTIRxfkWIDCt9po+vG6vMiQWHdHby95gUsip1Q7khLUuhndNdbbrd+z5szAGTeIgAlyWR74cgm0zUA484sCo3qIczqbCj+kUHp6KiKzpSYD5ku0JytTHMJIswaV3Qp+5Y71cdWvi4+hI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB4235.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:44:38 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:44:38 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 15/31] serial: 8250_mxpcie: optimize Rx using memory-mapped FIFO access
Date: Sun, 30 Nov 2025 18:42:06 +0800
Message-ID: <20251130104222.63077-16-crescentcy.hsieh@moxa.com>
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
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYZPR01MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b5998e4-2fed-4e91-da1a-08de2ffd75f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BhlQm6K+1TWB4XAYpI9zMGBqaFDjIG5ZJIcjdXH2rXWXBM7guJE1tIeSrcMy?=
 =?us-ascii?Q?gK1NOMPQ5qB8QFLoCJv12fRrgKGnXoNneANwbCv23G1KBUyfRlDgr5faIPLn?=
 =?us-ascii?Q?90lTX9QcA9MndDLlLzGXsRdMqr9lVOKI/BElM76vwFuVonSRTVqQAxOiYdF8?=
 =?us-ascii?Q?vQ0wZGBCFj8AKjdC06CX2JXwRKRKSCDkG9HoeVqo10ZrSmvOw/1752tHhtPH?=
 =?us-ascii?Q?oOyYAqpT/buRTxG2FhHotQelibMm9G3eqaxTyZwVdi0Mvh7WEWj51Tj1h3pN?=
 =?us-ascii?Q?in7Tk7qKfeibWm+LktNbZt6UTRSdWdMNjxzQqJv8e3tAgzlmprt9v92DLT7e?=
 =?us-ascii?Q?pHAziPABFXK80fDHxSj+BjHBnj5AdAaqMLQAjWnd0LfVcNJmrUb5GaFgYhmd?=
 =?us-ascii?Q?2AtEvX8n9F8xN9hkaUek1Vju9Gc5OG6NUT3y5J7dLBtA9QtDmrWnrO+cgQu8?=
 =?us-ascii?Q?0LM2x7kMIlACBYJ8a7hyg7khkblKMgb73zP5JLmAS/hLB3/8MgO0XbabYY7c?=
 =?us-ascii?Q?LbNURoTGQ7P3PVdGqcEm3DlxFl8rS705nk0WcNUgsLCHMgCj4LTo5xPFUyMF?=
 =?us-ascii?Q?lFAZW0sorKw56+UOHG1mumM8kBoThq4XlufMdvpN+O8gjow3SzwFjPuv+yJb?=
 =?us-ascii?Q?jRuGOjXlJphz6OmOF7QUstJBpjd53Mt2iS/8uUb3b9ZDgYut+qzJhYu2pO0i?=
 =?us-ascii?Q?vn2Trrg/dhhajSX7BNShIBkOWdmSa4Q/o5FHsDUmiRnU4Ctd5rXT0KlDucHJ?=
 =?us-ascii?Q?KWoJNu4fp8j0Qm3G0vYs/spPBC9eQYXnLQWNeDxmgnr1Uxu00HfWLdRlQQTU?=
 =?us-ascii?Q?l87j5C8mE+98IsY1OvEP13LVv/Zl7rJBR2i9ZPtxuy87RKzub/ic+UtL+lCD?=
 =?us-ascii?Q?2PRHsQ5LjyaOdvOF4O04WHO4jcXCP9Evu5BdJiHyHVgtqh/63HWFFFJDAizC?=
 =?us-ascii?Q?G4kRX0JIMjOEUQuDY1ekDq7qcxq/odeKO/rwRp0SkYr8t1U2TWU2kXu82xLn?=
 =?us-ascii?Q?bCJeA35gabz5kZS0RFlVedW6SWFrkWrDPS/i1Itou3AvwXqBe97/Tb67TnXn?=
 =?us-ascii?Q?Ua1mjm0U+OiWv8Dng9QnlyYBl7KbxNR4+1i5Kl+aR4HQMyzhKyxlvQp3zBX9?=
 =?us-ascii?Q?9B3O1hwMm1Am8w90QGROmSG/mcsb/6oIndUV7KZ8v0hKShlOUGGQ9elPPERK?=
 =?us-ascii?Q?KjGj8LYBj2Rvm8CiohwH91CJo1Lq2suYVxbKnPfVMgly1h0ftoM5OLEAs3c7?=
 =?us-ascii?Q?m9n8+kCtT51NJZHOOmr3Zk3fS+IhlxxAdQO58LVA9C/IlQna50hh93qC/TlV?=
 =?us-ascii?Q?efZzIWqtlgOM4SdShPSzp89Qvu9w2oeb7h0K3/uw9Ekgc/B5/RBjs0+hGr1C?=
 =?us-ascii?Q?C2WrCunVj/vCjOOpkrqKZrH4VAWZiGHKXfH9b40JoXXcmXLj+VslEZxQUSUu?=
 =?us-ascii?Q?xbRiwSjLMTy34oULRdRh7CSo4E24BeFDwCaavcEj4bXoRZYZ8rWeK0UrdIA/?=
 =?us-ascii?Q?tP4K9n//Nk6ihC3a4/yEjr7zoXEG8qQGNyLn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vQyiosywGJhTKQgGuLJ4x6eRnTiITt+0WpHvFWBNJOJ9Bh03tVDcnUHnIejH?=
 =?us-ascii?Q?7q5G+xaYcaMbmCpfuRJSvG+QuC/jI4lXvTmFikInzL+v6KOMuMf+5hgQcfoS?=
 =?us-ascii?Q?kRHyv4kqpHMiX3NXMM/SGru/zHK1+36gY2HeCKnME90/nPZ1nqn5PupJ5Mz6?=
 =?us-ascii?Q?ODgfOC9b3pNIGEkUbOGb2S8HSgzy1Nc8julTxatn2/mBZjBxVZpzSTODiR0M?=
 =?us-ascii?Q?0/8X7qVXxbANRCrMCMfYNFt23TO6y9y7NYXumFqUP5dB6n1gUdMDP/BI5Q6q?=
 =?us-ascii?Q?az5W7wLSroUs6OsZSBNo1tT6LXk4qdSoNIQfByCJ4yXabiLMGRwNH9H8QoaH?=
 =?us-ascii?Q?KGdjBfUK6+7SDe7MbgSoEHEplAVHxvtYKpQLJGUJB0Jkdm14Ke3xYYLLg3dK?=
 =?us-ascii?Q?xkbd+4S3JQLiXfWM5AIBSSbNgi5+kqQL8PcCt0eofT0UYknlkpYYERnn1FJD?=
 =?us-ascii?Q?9K00gvvy5aZiceFxUI4xNyJiWcwNfj/aapf3Mso3Sg0s2F1izEzgDfVyKBMO?=
 =?us-ascii?Q?aFLJ7QYkTa+rx3BPq22R2iHDQVZ6twZGJ8wtrgQIQdKnjKV96OAnwX1dyKzj?=
 =?us-ascii?Q?SHji9rSE5qbUQPjxSdZyvH41CKSbDdQQG1DQW6l26HttYShidBJqwB8j3Li1?=
 =?us-ascii?Q?3ur4z0tiAff+gXGWfWaM0lJ1iVZ8pJd3+yvG0Wn2dJ7nylWoybRoIk6tgrft?=
 =?us-ascii?Q?UxAvwKT1JR4ewvxqwmE4HXT/rc9+VvicG1D6RaXnkx7/Thc7rXwU8C9zI68i?=
 =?us-ascii?Q?uL5vSwdEahExie/nIgTGt8W8TI/ITU6filh/lBP8kqpDY6VokSDqxJqYCJ8n?=
 =?us-ascii?Q?VjcJZxJ/8c1c0oI/kJ44kWA9BugAHyUCH2DPjlL30tUwxhExPB1L/Fst49wf?=
 =?us-ascii?Q?1WbUQLGrwQhbphMzB7DEXipgKrbRJA06hluMZtT9aYiHrS9z2amcA0KlY/fS?=
 =?us-ascii?Q?Wvqc5GczcWdtVCUsCui31J2scPQeORpI+bKjoJiVm1pU0UYtPdoBKqb2vfYI?=
 =?us-ascii?Q?C1VZPeKZj3UwnBMgtK/XtNG1N7iK0QCAhJZhSKmXGpGXBAB+PrTAx5UTJaNg?=
 =?us-ascii?Q?4aaz/PfClQFoNNEE0qpvVCQyFPxlhdcjxZ3BbpkJbjuajPLkssXMypp6H1Zn?=
 =?us-ascii?Q?vj1o3RhlUReo4zmbReLtYsxFSBUjYQd3dmgKmqJvxeXmvszkPKC/daoWbL3k?=
 =?us-ascii?Q?caaAe77SPVVl/6ZTgeyRDyXvjxT4O3X6nRQoSCPUSJC4Zw9rRQ3P+YvbO/CF?=
 =?us-ascii?Q?6/ZFwa//QtMR55ERFppYMnl3V+MLyDEYcHtayotjOmOsT8beqjUeKv6lCpwR?=
 =?us-ascii?Q?rnoppA/xbmm0W+Zqi7MhrlRqakwM4OUAsYuYD+dw07wAeXT512trYFx6s8Sn?=
 =?us-ascii?Q?57nJIH5SFGNxiFmsrMTKyDvmqU92tJXNyR1Nc+AptVn6u0fvc5VLSYbkpK57?=
 =?us-ascii?Q?p6bSA1zlOa4DX7NiwuHJ4EitCg8iGUMxLXPL6NQ47+vFH+SAF10tra3rHGmX?=
 =?us-ascii?Q?m4ugRfg2XiORc2W3sTmd22X3vjHZZ+BA4QFFTzl9KqQEfYmZ7VpKmOFs6E1I?=
 =?us-ascii?Q?+nFwP6VYk9UsHI1Z2Vt2ny60TP6taQNQAosQvD1h1lHr8clRmtRWBhpHEGmS?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5998e4-2fed-4e91-da1a-08de2ffd75f7
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:44:38.6734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +TgGiMku51iuv3p/6W1ukmI8c8pnvXVm2xB0eP3d2dXowL2wi1HfXkBaIxNtgie0cA2jdmmDWa98uMGGFQ8YPJRPYnR7y7EAFzESZWe5fLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4235

Add mxpcie8250_rx_chars() to retrieve data from the Rx FIFO via
memory-mapped FIFO access, using the UART-specific FIFO byte counter
and FIFO memory region.

This avoids per-byte I/O reads through serial_in(), improving receive
throughput on Moxa PCIe UART devices. For break and error conditions,
the handler falls back to serial8250_rx_chars() to retain standard
error handling logic.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 37 +++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index fe2906d16d80..cf519960d5d1 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -8,6 +8,7 @@
 
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/tty_flip.h>
 #include <linux/8250_pci.h>
 
 #include "8250.h"
@@ -35,6 +36,7 @@
 /* UART */
 #define MOXA_PUART_BASE_BAUD	921600
 #define MOXA_PUART_OFFSET	0x200
+#define MOXA_PUART_FIFO_SIZE	128
 
 /* Special Function Register (SFR) */
 #define MOXA_PUART_SFR		0x07
@@ -70,6 +72,9 @@
 #define MOXA_PUART_RTL		0x11	/* Rx Interrupt Trigger Level */
 #define MOXA_PUART_FCL		0x12	/* Flow Control Low Trigger Level */
 #define MOXA_PUART_FCH		0x13	/* Flow Control High Trigger Level */
+#define MOXA_PUART_RX_FIFO_CNT	0x15	/* Rx FIFO Data Counter */
+
+#define MOXA_PUART_RX_FIFO_MEM	0x100	/* Memory Space to Rx FIFO Data Register */
 
 #define MOXA_GPIO_DIRECTION	0x09
 #define MOXA_GPIO_OUTPUT	0x0A
@@ -253,6 +258,30 @@ static void mxpcie8250_unthrottle(struct uart_port *port)
 	uart_port_unlock_irqrestore(port, flags);
 }
 
+static void mxpcie8250_rx_chars(struct uart_8250_port *up)
+{
+	struct uart_port *port = &up->port;
+	struct tty_port *tport = &port->state->port;
+	int recv_room, gdl, i;
+	u8 buf[MOXA_PUART_FIFO_SIZE];
+
+	recv_room = tty_buffer_request_room(tport, port->fifosize);
+
+	if (recv_room) {
+		gdl = serial_in(up, MOXA_PUART_RX_FIFO_CNT);
+
+		if (gdl > recv_room)
+			gdl = recv_room;
+
+		for (i = 0; i < gdl; ++i)
+			buf[i] = *(port->membase + MOXA_PUART_RX_FIFO_MEM + i);
+
+		port->icount.rx += gdl;
+		tty_insert_flip_string(tport, buf, gdl);
+		tty_flip_buffer_push(tport);
+	}
+}
+
 static int mxpcie8250_handle_irq(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -275,8 +304,12 @@ static int mxpcie8250_handle_irq(struct uart_port *port)
 	    !(port->read_status_mask & UART_LSR_DR))
 		skip_rx = true;
 
-	if (lsr & (UART_LSR_DR | UART_LSR_BI) && !skip_rx)
-		lsr = serial8250_rx_chars(up, lsr);
+	if (lsr & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
+		if (lsr & UART_LSR_BRK_ERROR_BITS)
+			lsr = serial8250_rx_chars(up, lsr);
+		else
+			mxpcie8250_rx_chars(up);
+	}
 
 	serial8250_modem_status(up);
 
-- 
2.45.2

