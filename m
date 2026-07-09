Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013064.outbound.protection.outlook.com [52.101.127.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7C03A960E;
	Thu,  9 Jul 2026 05:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575248; cv=fail; b=HVwr0gvPYq2PVYjIUXC+FLLwBgq0zRPQs+fB+T26Tsz/zo9+TT7VYkiuevcqTW2AqC7zeebpUB6O9QbpcQ7PbdQlHR2FisJuLbuA72XaO616bctIYSng9oPS+yJAnm5OqxGHjwG+l/SyldKQkTGLfvn36gDpwci5QxJVRzZ4Cqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575248; c=relaxed/simple;
	bh=wzeFOSkHQhiosE0oBC7uE1M9dMcFatQWyn0SknBfUV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wl0byZRUku+1G8AY71WKlX+vAFWNPf7TcAnYgLKt7NDGPxDYtcI7Bfw3NTF3sWLsI9snRy/csBB/yKkIqjC/3gTk0eoFlR0NqcZce7G3P29BxVMhzdMPGFtjN879Lq81h5X/TyAHb48uBQgi8CGkbGpn46JK8G3E8iqJI1iI0zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=fRz86g7f; arc=fail smtp.client-ip=52.101.127.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="fRz86g7f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdoRUxHETZa9QIYPmq5hVXq4uMKUWiZZx5C1qd4JHb0SsAmGJ9nq5Si/LSm1XFInzJrrt27lWbSIGfso3dHis7WNjIfuXY8PbZOydq0aNIaaE167aK7DpF9RNPHWxGGD+EPFey6cSqupn30lvYJ5RiQN4ZsASdh5yMFUaDRWiB+SDOjlHL3NLOCum9DuTIqFm0Iqx9KfXVKEyS6x8FVmrMobUT3xeJ2yDiZa5MwjL4kAAvIxfjAN07EWynYaBZfUqfTr5xNjrGt3TbUrPwm8d+K6t+uw9Ov3gIs6HrEXBc6vWH5Mo7hvSzRSy+RDlYVdarD/kyz6cxA/SNyQSi4MjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NV2thdKa6kG6x0SF+9UMRfodGAu4YGS0g86qrvTMs4U=;
 b=MDbYY8nOdX4HB4oaprRa9n9nrZu7qZkW3MphpgtpMcoqgf4CZKtPX0cKc4YFMYjtPvjT8pAtNJmxn4YgL8hNdDZBjfChKrcG9gLXfmdSMPBH0fkXEecwPXBlyRZQ1v9zjve0sm8H4VH8pNUxu5tpAaj5xISYdP9e+W2HGc9DFXSmVdeV3DtAtW+YMNoWSM3xbXq1YT17SxM0WJHghOF/lXzi1e5bKOZROvn6UnceIqcAP4M5Zjh107Z6+CwS74FHDQzazrxkD44HYgfExl8huC1SUuqfQ3QdGuV5oDOWrQXz1SCS89NfINN6bMRHFg0wrJzpXQEqdwBP5f/pfiqaEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NV2thdKa6kG6x0SF+9UMRfodGAu4YGS0g86qrvTMs4U=;
 b=fRz86g7fRhKe+ERViiK5Ebwa+WEx4wFd7sr7DUkfykgfcxUCdniIrJphsOHxm2UZKnZH4BlxM2EodXiydtnmpiRy/yDw8VhgmYzLEuNfAFNeNeFuRrzY1BAzgDINOXrov4yprC5dq+2Kmagl1qspzrQf59BzDAeEw1yLWe5BF5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6) by TYZPR01MB4610.apcprd01.prod.exchangelabs.com
 (2603:1096:400:260::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 05:33:57 +0000
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec]) by SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 05:33:57 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 10/15] serial: 8250_mxpcie: defer uart_write_wakeup() to workqueue
Date: Thu,  9 Jul 2026 13:33:09 +0800
Message-ID: <20260709053314.435629-11-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
References: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::7)
 To SEYPR01MB5387.apcprd01.prod.exchangelabs.com (2603:1096:101:d8::6)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB5387:EE_|TYZPR01MB4610:EE_
X-MS-Office365-Filtering-Correlation-Id: 1deec3b9-5940-425c-8b23-08dedd7bac58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|52116014|56012099006|22082099003|18002099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	h96pZNYiA4Ub54atsdUNemNwhpUBo4T/eXAk6X/yajKqNdwnDsFPXQxKLj1dW0zbC919knSILv56QSgOPQ9dNH5FJzJ0BLUpptZo/IAORw7zt6wMS1hEeHl5VurkDFTx8WijIdAd1wGRqka3FoZWvBQxXR2HGaA30Gq17jDIG8T4F67ZrFjueV+rOD8uczr0jO8gVLYCVbfgHDXyDs1mYC/rRklt4Bccs024frEpCmQn+4Y6YyrPPGhApSeZ5vMNWRxPGTQ0sZ7hg6Wd/p1aqK5VHIqILhxhpwrimHCnLUFoZvpPbwW57Kfv3S3+eYDe7HPD8RYgSxc8kEirfRA6MAyj9ooEcH8+89C4d+cu7Q9O6/moJfCqp/q4VLP6HX1/ZJ+I2cI4XQKjPpW+VWk5ngFbq+gNNivJMOp1Y9qwF9uJ+qB1ifPLl9YAuDaaZkjzYfHe+6pLqTf4gZey5YQdbhM3m4s4WdTxr4T1VSTEwPEsClTaVJT9dkESSd/Gz8jpsMji/cHryu/X9jwsa3aTNL3gt4UM0BNlrw1e5j97t5upUpfWhSG1UD5gv0b5k2/rrW57ROLk7617Q/qnVa7pFETHcSXM+xFDROPt9hCtg7SYccA7YHGmxC+NKzDmYCWmKSfdaLuqsrvyuhmgZilPEuZVZiW2951zTc0mXG0GsTT4bwlaQmbfyWc2b40hjR6aEKqSkWAWOjpHj5MVNOipqy/TdJZcpBEAGym8rDNMJhQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB5387.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(52116014)(56012099006)(22082099003)(18002099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JmjsBbhTS5XwlXLzJ6FOg65/C/slQHxJQLDAEll6aq9zZi3Z2Lm8Zqamwdj4?=
 =?us-ascii?Q?YW5DaL9nz+7JaxqHvZjjgd05/s/gmUFR2YHgSZ7U0AY6luJc9Gk5TiXLnOy5?=
 =?us-ascii?Q?0t/Kj9uecZNm0q1OF4zCtv56GNXT8/YSt+rBQgk4t5gTmKUtLAmWTzIBN3kQ?=
 =?us-ascii?Q?nXEhhasooHjP2yyuXUAwVTmG+gc3jJmjTdVPgInaT1wJdFkTZA9V9secOqWx?=
 =?us-ascii?Q?k3bosqyrT/JkaTae1R6tbr+3D4Sp2NHC53J5VLRWkAOPER8FDhcEbQIEvRZz?=
 =?us-ascii?Q?9q+aqvh4t1pJWgI1jBfeMXS7gS5vQX5JS+vMlPt/vfz1jE3A+jkhrMRZtKeL?=
 =?us-ascii?Q?FEoKefHWbPZZX2T6Vtjy+X8pmnkkud3O8bnOBLjwo1Hc9X6D+SzJhr2b83oi?=
 =?us-ascii?Q?nWI+kOo69oNuufDqji8yVHonl0esL+zh3CT5FysfKdeSgWZpyElF0TmnYHLi?=
 =?us-ascii?Q?lbsuOOIL9JIPrDSaj+YfBi/4bvhMGO0G5B6PpfjVQv5qvGljfaZsYTTNJTwP?=
 =?us-ascii?Q?4OYj+nswgKhQYuHvNVvWTsy/bmM6me8/Ci8eg4ylPGmgkS1DG0t6BTIaTtUu?=
 =?us-ascii?Q?We7UoXoQZqeQ82DBfX8BWvo1jsqZEmNERcljup6UC34rWjMcpO/NtMDTvTiK?=
 =?us-ascii?Q?rc4j5mDl1Xfb/NPcx8uzSWd0crOwiiZVB0qozg/AVCzs3FJ4M8jxvu/la63x?=
 =?us-ascii?Q?bIPshJ2/XZgXnYUHpJCKnY9/EDZEg8dcGkqlH3zVZPa9slt0TzNCcfczTDrI?=
 =?us-ascii?Q?yk6QnjGwMWPT8UX/4GRlTK0aWjXfzCjA3nAXq3CaMX2UMdWwSh7qcd/IoZUL?=
 =?us-ascii?Q?fTeNYNdJJJx65FDwvc/5GyylYzY2vjO33rLnVtIHnSYqtGclfbwSNwEyI3CM?=
 =?us-ascii?Q?sh/yZxymHbujuvFPdGIVL0ab57t0X4IwnsB2euUEcdohZLxqq8ozyKrpcEnV?=
 =?us-ascii?Q?YqJcHtd0lm+B/Cs6lH4BPYyeNeYXBRi4amYRzyTUgkjlquQoAxtBozqliVEL?=
 =?us-ascii?Q?El+cOOgqxcFAP73K3bKN1RppTI4dcgCrG3QGaeVy/VDHuwukt0nW6YZgEHBH?=
 =?us-ascii?Q?sKDQTKrwatgFP42msK8WSK6vakjKF2OhDCRcys+qEWEDr10nBOa23k9THOen?=
 =?us-ascii?Q?nAyhhmTl1pxkHHGq/0MQfcDjv+lkrYDxWybtTKXDv4Ro9DJWN2iMxhf0Dm8M?=
 =?us-ascii?Q?Rra4y0YNj9tNdd6Lolcbd3je8SH3KumwBLsNxdTxzyXO7h3L215Q3QO5Ow77?=
 =?us-ascii?Q?9zq41GVt9jgBtpY14MS3t6YfM1ZUT3/jicqNB6FZkxGzELJ2kCgNLwwJFAhr?=
 =?us-ascii?Q?TuQpm22co8qZJpWtbvkdLt2WMP++EDN8BFVZboV0XUcIa6KhKJLdRDHqL/rz?=
 =?us-ascii?Q?QVqePHBiPR4PlJJU7cn9ljoxVZuyoAXTNej2wptA1mep2H0GN63W2WTPkncN?=
 =?us-ascii?Q?e0XdCLGyz2JCSBJHpILEp4s0M9WDd9phfcAb04VMVslGoe1HyK0yeA+3O/cK?=
 =?us-ascii?Q?X+fukz4TeKgJFJ17xj+7eqf8OtMQ46BP8nCRbmTSARlj8ZHhOQ4mfJT6H6wJ?=
 =?us-ascii?Q?kf6MD7h3U6evJkufWcACgWewdhH/OECbz7W50y4gi9BBv2kSH9CaTarAVdUe?=
 =?us-ascii?Q?cHlZg0Bxcj07kEUAMpDiF5nd0WpSvz8m9sRz6zUv6ikQrVPLXzFvgDrlebTD?=
 =?us-ascii?Q?Dyo5yd40qY45TX7pJynEt469R3fKuyYEi8s/4xq8sU2LvQBVNhxdJ4tNt70r?=
 =?us-ascii?Q?YXTYKokjH5YBPvMx5chU2dIN4UD2OsQ=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1deec3b9-5940-425c-8b23-08dedd7bac58
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5387.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:33:57.6941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSkunD6SKWF3S12Rj2rMt/GuYGYwTFVJdqMCyEgB1ZtB0ZiXv+KXKcgUZPS7Fu+gpn89A8O4Wwj9pR3NYxXO57hl530ulAsM3VVQ0cnTe8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4610

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
index c7467fb94021..7b39ad19b331 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -15,6 +15,7 @@
 #include <linux/pci.h>
 #include <linux/tty_flip.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
 #include <linux/8250_pci.h>
 #include <linux/serial_8250.h>
@@ -104,7 +105,12 @@
 #define MOXA_EVEN_RS_MASK	GENMASK(3, 0)
 #define MOXA_ODD_RS_MASK	GENMASK(7, 4)
 
+#define MOXA_EVENT_TXLOW	BIT(0)
+
 struct mxpcie8250_port {
+	struct uart_port *port;
+	struct work_struct work;
+	unsigned long event_flags;
 	int line;
 };
 
@@ -328,6 +334,8 @@ static void mxpcie8250_tx_chars(struct uart_8250_port *up)
 {
 	struct uart_port *port = &up->port;
 	struct tty_port *tport = &port->state->port;
+	struct device *dev = port->dev;
+	struct mxpcie8250 *priv = dev_get_drvdata(dev);
 	unsigned int count, txsize;
 	unsigned char c;
 
@@ -348,9 +356,10 @@ static void mxpcie8250_tx_chars(struct uart_8250_port *up)
 
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
@@ -377,6 +386,14 @@ static int mxpcie8250_handle_irq(struct uart_port *port)
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
@@ -432,7 +449,7 @@ static void mxpcie8250_setup_port(struct pci_dev *pdev,
 static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
-	struct uart_8250_port up = {};
+	struct uart_8250_port up = {}, *new_port;
 	struct mxpcie8250 *priv;
 	unsigned short device = pdev->device;
 	unsigned int num_ports;
@@ -492,6 +509,11 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 				up.port.iotype, priv->port[i].line);
 			break;
 		}
+		new_port = serial8250_get_port(priv->port[i].line);
+
+		priv->port[i].port = &new_port->port;
+
+		INIT_WORK(&priv->port[i].work, mxpcie8250_work_handler);
 	}
 	pci_set_drvdata(pdev, priv);
 
@@ -502,8 +524,10 @@ static void mxpcie8250_remove(struct pci_dev *pdev)
 {
 	struct mxpcie8250 *priv = pci_get_drvdata(pdev);
 
-	for (unsigned int i = 0; i < priv->num_ports; i++)
+	for (unsigned int i = 0; i < priv->num_ports; i++) {
+		cancel_work_sync(&priv->port[i].work);
 		serial8250_unregister_port(priv->port[i].line);
+	}
 }
 
 static const struct pci_device_id mxpcie8250_pci_ids[] = {
-- 
2.45.2

