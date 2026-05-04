Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013040.outbound.protection.outlook.com [40.107.44.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E1234A79E;
	Mon,  4 May 2026 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884643; cv=fail; b=ZbZW5vROoq8puCPLU0q+b/7vKn/vomwfx9UeEDsOMkaCUebEmiVk46qFALlpeMVKb1vJDNpwL1x5STJ6E/VqfMqXL79MLefAZeNsWXGL+ewuEoth4D3KRauGexSIqAPcgXQnfdq/sz2s/+Y6ilLpXqwjJFpeHWNRdcIgaGFt4LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884643; c=relaxed/simple;
	bh=Y0TWoR2cbFGUegMWlPk9w49DDp2AV6+ZZgPvqBa/fOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b+8EoZig8TRmfnUMs/eiYvPXoLT3vLwQmtgQlkNWnwKiU0o2ie/dJC86n/KdxjKY9T3JVEf6Xo1cW+0UWGviesAzzBZjBc6D1l5rmVJKq2XQczCLBwindLGoYS5m2kZazyZBumeI3HAcTbQOPQcFeEynV+KsIhDy/bwB9ULEoa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Rru4v1Lq; arc=fail smtp.client-ip=40.107.44.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Rru4v1Lq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOyz5c9WR1p11S1VtKahDTSBPsdblhtB/kpKsDBMra+CStp9vn17aiLlljtYevsYjXz0eC40Esej18mogekI/ZO5VdVhl9/89+tiM09XL05HLDgcHiksAevh0h6GN38itcOtLQkMHQB/bauSMJplew9G9i4tTV7WYl6T67QrHscchRBUtYpExm04yGsBX/mZXeq2SvXSHJSiMX59RgYu28zlOfug3sgNVoBMKzUBIj+YU/OhzEHntmsTLzG121d9lIpv/Xth8G18aPdnRsG7vMjdZEGIyJNxfFYMVi4re8CUxK39ppN1sHcGNh/4xfJdoofk9gP0JxOGaqvKnY2N9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDXj83kgcKHe5KhWDRchM0FXUd1m3zmqWurq1HvzH6U=;
 b=jFHP/tDVUqxijoOoMs4UczN+eozllfBYLKrKGszDGW57TBefWWd6y90fAhud0wcT9We3zPeGiFGg+vUr4ug8HM2Ed73nQOUH/BcnL9vEoIc2it5EB2XXFQNfYbj69XJAVOjVWRKSjvqXD9/1OnzSk6bhmQWgGf9EWDjf7PL7OplpZwvt56Py4nggXnyhtI4pUf2eNPIjsT4LVQ1JLFgVjr+NKP0eAjCSTTtdb0SwqsWRjuDbcb91/hRHlYQvBRfH2KoxibQXnbDw0ZR0T1XxYppM5czwkPP9/g1wN1tsN1h+GqEn5+xuUKHQXb45FnZoGVuFz85rmkF8UlNwZrgl7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDXj83kgcKHe5KhWDRchM0FXUd1m3zmqWurq1HvzH6U=;
 b=Rru4v1LqixZ3VbYVfS/FzpCEpCmWQ4J4irslpIhodblN2nXdIfU0+Nw0K88pGIKiTopXDECm5vZXWvKZnuAlVPkSlQbqZ7MjGapxFGBSQ2VCXfJgYTo81yh3LYXG8VUTqqzz86ZMLyoPboZIWE2XKI6NjrprZX/FNUDv1J9w9mM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by JH0PR01MB5516.apcprd01.prod.exchangelabs.com
 (2603:1096:990:13::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 08:50:39 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 08:50:38 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: crescentcy.hsieh@moxa.com,
	fangpingfp.cheng@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 10/15] serial: 8250_mxpcie: defer uart_write_wakeup() to workqueue
Date: Mon,  4 May 2026 16:48:55 +0800
Message-ID: <20260504084900.22380-11-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: d72b63e3-d2ed-4ddf-0dae-08dea9ba3712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	6Or70SkS4iDlCIfA/KRBtnLOYAkWEswNrxZphptMGE+iiH22vfeiZDcbjbA/0VT9Fj7Y6cpT5eUU62jozoVsd+SpzU0GOJUsa6eykib04uTUPoSmP95MyU0gA2PxRuePgTqeKs88EOR00wlU3PZMjMxsHMR5EWVyjT2e/ZeptHFBVV3eVgpWEghpAjxJexVjxSDpaHYEuzlFr+plH/gdqnvrAsbMcHmXIi1KL/E5bTQzH/RNHfr9nk0OqtecTaTi453dKakSCFao1ErezpsIazSrMnNyVaUb9urgxQNKNL+FiR2JYv8rASef6lTnNUNdTdgJLNeZWBDJE1LgmsRMVemyojIBOQX60JzoPGju64DVDorkNPum66UgqYe4GkZe4hzpL5SxXt9obcWY9Z7wIwT6SgTCkIM4hDbJzeljNZ5CQt9JLOIDQ8RY0K33qcRX7sVLUMaICJtDIUWDV8g6LQHAZ4AGMJJHAenFouzixKBsnxS6UMWOZi27szDYOhUGC0Joba/GQg+CkSuImy9zYxnB3hw+PapJeoWdZoptgQU61mhM53K9ZNeF6hcFnJbdoA1o/mzqcQx3gID9LFAXZ97WNaQuu8dgxlyzzW/gibK/RHLTe/lVXf2bUHG81HOctCxq69TN5siEfx9bgUKSoHjBJw25EbMSPGMk1f+1j4xsi7Ngw3jB3veluQpBIVajb2sitm9uiUMvRMgNzlY++GlZWzed30k1TuNmMnQcMBIwSkmjHQmwHmqfcxjaaIgM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1SQp2cWzOyV9lb7WsHvREC4nUHJChVGFTSY7/Y3FS3FOPpXFbgae0AOrTZdp?=
 =?us-ascii?Q?1MP4x5cviYHU3IwfoEham87hpVAApu48Y6UyqdnwTZvtiN0K0n/eeiNWRWtW?=
 =?us-ascii?Q?HIAUXFSV1sgVOqwIoNMdDyLIOrn2R/lB2VK2UnWcTLD71NhWRh+KCX/fKtG+?=
 =?us-ascii?Q?9G9tgtg5pSpT/UOqAcGRB+FrXVv87RP9nk/0CwhfS9md0dOMXdI7vwE5wX+Y?=
 =?us-ascii?Q?kw3ehS0csV8CsAwgpjv4KkB16ae+zvH4e7/H4mpZqHwyHwDV3elltP3l03uC?=
 =?us-ascii?Q?zh4ycm7qTuwS5pNQYoQbJTNPmu8q03X3NobEbDBQFFWmebVaci7RDlvA5BGv?=
 =?us-ascii?Q?CqL3w34I4S5mxst6TYmCNQuRJ6VEWC7p8NzhgQhudhDfsEbO6JZyUr33a0iq?=
 =?us-ascii?Q?d3c9O48xEt+goQhYkAoXZGKeF4jJ6i0qBZNs9M2HYTjAhEEFAZQcMiRuWkx3?=
 =?us-ascii?Q?vxxfHua9xOCJHJaWiKhQbwmIdToYf/f29/iRFzgtMPRY1eKgZToXKgMWvXgx?=
 =?us-ascii?Q?yaBi4ny0dFgbYwmg6Llvmw8FwloXTnZm8SBhpDCs7sR5fxeHlVzQKgwCzEtz?=
 =?us-ascii?Q?xbmyQRarFyo010u9RPUfzOC+v4t2xinTpFIorcLWHjbCwaHNLfiDcvBTAAzi?=
 =?us-ascii?Q?WimUDodHv6XHl8KQemcH1e956rxNO+95uA1GP7in0fPhXoRVbqhD8W1/MWlR?=
 =?us-ascii?Q?os93gWbq5qalfLStic/iwBgirHjop1QGX+MJjEoXChJL7L5PXoRzMbGq+aSN?=
 =?us-ascii?Q?UgbFXfT73tSb/ozqdxuL18mFO7MeXBag/BYfGoGqPmjj/jggqEMHp5PYIbBE?=
 =?us-ascii?Q?++8xPdPI5gzbqTKpdYxQrPYw7t7Hde4oWZlc20Dno3O+tSVSDfOjmXYUpNBJ?=
 =?us-ascii?Q?8+/1Wwr+IRbRHN/QoZiLiAkJ8ZTO/Ghia2drCGGmLtjjWiV8OBq6znPBqrAa?=
 =?us-ascii?Q?d/73h8dvM+cgXMCFrt5DAGLt2YupyLbjZXO1YxV9rviTfe34qHNj6mywBhkw?=
 =?us-ascii?Q?RGeQZeLeIi3BxFFv5FtcZRqLXTQtAPcpOtm9rbgqiuJvJ4JpASFw4f3oJdAC?=
 =?us-ascii?Q?Ex7VFElX0coI74WhdVfQJIYgOx1T+oSUJ7t8LyOWOQ0kHHXYPCPK9CvCZwwi?=
 =?us-ascii?Q?YkpuR1HEhDGpfwIj7potm1eVRaUY14RJTgcCd7enhdm/Ulq1Ft65Ycq83Dbe?=
 =?us-ascii?Q?q9uB5ODXeXslcRHQi1QlPzLVmwB2FjkWnKpOI2XF/PZfb72SrpetRbBplzwF?=
 =?us-ascii?Q?+BKJ4fKFckHGuSAmYBaznj8VZueuQUIj6+xvO31JZC8jkp5y/w7m2gWLGd8m?=
 =?us-ascii?Q?pc30/8zTzRiQE52oVh7/r6xLiqcNC6mm9yD/qrywlOKKYkEgbbBJbkZhJlB9?=
 =?us-ascii?Q?6w3EjeQbsoJzhHYEr9FiLKQfCCea+46jJDl5t/g3DEiZyC4NTJwNpRY1I1An?=
 =?us-ascii?Q?8w6swzi08I5iQybL/esaKkLakxggsWHuNAhOQ4tysKq3SwfEYsmZuNmG1wwY?=
 =?us-ascii?Q?XLyMh0GVu7X2bJPp7YfbKJMCARFwTcQXMqXmm6DcUO6WuIxp8kHk4KO69vml?=
 =?us-ascii?Q?AV9Y0ESajV06EewJeOuhI8wkTX8+iibAkPSdo66a20WxL22qB1e4neV1SjiU?=
 =?us-ascii?Q?zlomWiTR/h4kC4qYflwUsvtmlP9qC6A+d9aCDI0EuAAqEz9Rb6wvDY3Rbw+3?=
 =?us-ascii?Q?Vqi6c2wZTqiYIyG49iKCKQOP3WSgyutkvdZapQJaRwdFdpxMLjIbi3AWyVV7?=
 =?us-ascii?Q?ChgyJV4LhFpVmnueuBKuZi8BipJdyEY=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72b63e3-d2ed-4ddf-0dae-08dea9ba3712
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 08:50:38.8009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gr2PDPVybj3mzr/wvp3GYxN+GyPP5OJSClxMVXfcZk9HFFyRAdQ64qM5ZfiIbXtOQQ9fUyqXXmkcy1euUd/OcHzrUcHsmotW2Uiw7Khzfq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5516

Avoid calling uart_write_wakeup() directly from the interrupt-driven TX
path.

Defer the wakeup to a per-port work item and coalesce multiple TX events
using a pending flag, so only one wakeup is scheduled while a previous
one is still outstanding.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 34 +++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 19233c3c5f1f..8dc1b7b0af04 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -18,6 +18,7 @@
 #include <linux/serial_core.h>
 #include <linux/serial_reg.h>
 #include <linux/tty_flip.h>
+#include <linux/workqueue.h>
 #include <linux/8250_pci.h>
 
 #include "8250.h"
@@ -105,8 +106,13 @@
 #define MOXA_EVEN_RS_MASK	GENMASK(3, 0)
 #define MOXA_ODD_RS_MASK	GENMASK(7, 4)
 
+#define MOXA_EVENT_TXLOW	BIT(0)
+
 struct mxpcie8250_port {
 	int line;
+	unsigned long event_flags;
+	struct uart_port *port;
+	struct work_struct work;
 };
 
 struct mxpcie8250 {
@@ -327,6 +333,8 @@ static void mxpcie8250_tx_chars(struct uart_8250_port *up)
 {
 	struct uart_port *port = &up->port;
 	struct tty_port *tport = &port->state->port;
+	struct device *dev = port->dev;
+	struct mxpcie8250 *priv = dev_get_drvdata(dev);
 	unsigned int i, count, txsize;
 	unsigned char c;
 
@@ -347,9 +355,10 @@ static void mxpcie8250_tx_chars(struct uart_8250_port *up)
 
 		serial_out(up, MOXA_PUART_TX_FIFO_MEM + i, c);
 	}
-	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
+	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS) {
+		if (!test_and_set_bit(MOXA_EVENT_TXLOW, &priv->port[port->port_id].event_flags))
+			schedule_work(&priv->port[port->port_id].work);
+	}
 	if (kfifo_is_empty(&tport->xmit_fifo) && !(up->capabilities & UART_CAP_RPM))
 		port->ops->stop_tx(port);
 }
@@ -381,6 +390,14 @@ static int mxpcie8250_handle_irq(struct uart_port *port)
 	return 1;
 }
 
+static void mxpcie8250_work_handler(struct work_struct *work)
+{
+	struct mxpcie8250_port *priv_port = container_of(work, struct mxpcie8250_port, work);
+
+	if (test_and_clear_bit(MOXA_EVENT_TXLOW, &priv_port->event_flags))
+		uart_write_wakeup(priv_port->port);
+}
+
 static void mxpcie8250_init_board(struct pci_dev *pdev, struct mxpcie8250 *priv)
 {
 	void __iomem *bar2_base = priv->bar2_base;
@@ -436,7 +453,7 @@ static void mxpcie8250_setup_port(struct pci_dev *pdev,
 static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
-	struct uart_8250_port up = {};
+	struct uart_8250_port up = {}, *new_port;
 	struct mxpcie8250 *priv;
 	unsigned short device = pdev->device;
 	unsigned int i, num_ports;
@@ -496,6 +513,11 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 				up.port.iotype, priv->port[i].line);
 			break;
 		}
+		new_port = serial8250_get_port(priv->port[i].line);
+
+		priv->port[i].port = &new_port->port;
+
+		INIT_WORK(&priv->port[i].work, mxpcie8250_work_handler);
 	}
 	dev_set_drvdata(dev, priv);
 
@@ -507,8 +529,10 @@ static void mxpcie8250_remove(struct pci_dev *pdev)
 	struct mxpcie8250 *priv = dev_get_drvdata(&pdev->dev);
 	unsigned int i;
 
-	for (i = 0; i < priv->num_ports; i++)
+	for (i = 0; i < priv->num_ports; i++) {
+		cancel_work_sync(&priv->port[i].work);
 		serial8250_unregister_port(priv->port[i].line);
+	}
 }
 
 static const struct pci_device_id mxpcie8250_pci_ids[] = {
-- 
2.43.0

