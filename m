Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012023.outbound.protection.outlook.com [52.101.126.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778AE368D7E;
	Wed,  1 Jul 2026 03:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877467; cv=fail; b=pgK2JTlABPsvpxtw2jy93dMc8uy5eFMzEBXutMIEg/F6utmisYNUS18HJgEc3uxNzCFRRKaVHDQrNjhkt226HaYKksK624QeyUF7wC1TVGT2lWXfjko0tfjKPG9cigD1OvvU34D+5fcOT7axxplf8eB9a1wZmXM2OcbcEbPOrF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877467; c=relaxed/simple;
	bh=OfepXsSlxPnkA0dhj1UdnSItI182K0M1RYVBi+Gb3lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RQ/pH54MA8yQn3d+MDaJ7B2srAgftJLUvIb+anQ18n9RHY4gPL/++HYuIt6N2WByVStO+Th5asjwXvjC17qWp5GL0S1dcfBsue9VcWsGOnK7FXPoVZngcGrbLhkUcWp19UDs/fNGR2YYRYTD48HWAW1/Jw7qH6Vfbc8Kd94LJKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=f6TQexpK; arc=fail smtp.client-ip=52.101.126.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="f6TQexpK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2LOKn0a6AhC8tru7db6PZm3cCpm7eIZ5jm8gqQLP394d3UwgqU3fZgOjqmTUbPdQKO+T3Fn0xx8R7DVYZXBPvAFdUFwiuHkTHkcmKmOdPHeIOaAAbFjHhLrkMqcXGV58sGbv4RMVrFdmPc4Qvirp3O7KJoA0lhMoLDqC3ocfAndWmFWHhvw/920Ajk8M4VBuCRediVAuaNBv4hgYUBHERIlRhRyIaynQMWAM2UQ+0VxispwGunE+AxmsX3yNkbCimm2z0Ij7fh18e3hftRJnPrTTz5g5RcAR0HrScQmquEGruxBFHRjT+WRnIP2yEHPPoHEQAXc984k/P8Sbaut/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tW9ywrPuhKmkOEQBNNqxK9FO/8fkCvFeT7gvIZQ481s=;
 b=nKj586zw47+kSAfnyGaOG++NcloUGoS/ugk3cnvet2fKdSopydpRdYE2UPCzO+F5MKQp5jnUUn1EbnQCazt/uVRfHakt20CjVTSC8f6muB1/uLCQPyfrJR+XT4D3vhkzc9MU6Sot32eiF6ob1wLNbF3SrU/OWBfUvV0YgpDKfnmgquoLiB5HftsjJLWGBrqtlCFOa//TwEmRJ376NXBZPJlCC7Cy6RA4x6Ev3S1oxhPJUzSqz7T7iN5+JiwFKruSTMEpBRktY4gQJRRxEXZutWwTQE3vQbCu01LRtjiR6XlF3GsYkWM90J10g0Lc4I8LsWV3Bb3elmCiC8SdCUg2NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW9ywrPuhKmkOEQBNNqxK9FO/8fkCvFeT7gvIZQ481s=;
 b=f6TQexpKTpKwogBJ2QxPyeaLZqu6L8QI3hEr/BxLzmDrk2oc3yhzto1547XTGjwpCR+wfES4vRWJ8h6Qi4uecANws44wHmVwwkWMBEZZD5BEa0GlOOQw2aHYFDdqJWtHt1CuiUoNjM4BKXwc3OfCHE5vx5rP8PtDcSl7jM4PUwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KUXPR01MB8048.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:7f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 03:44:24 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:44:24 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v2 10/15] serial: 8250_mxpcie: defer uart_write_wakeup() to workqueue
Date: Wed,  1 Jul 2026 11:41:23 +0800
Message-ID: <20260701034128.218569-11-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
References: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::14) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KUXPR01MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c77f08b-5db4-42ea-cbf3-08ded7230ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|6133799003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	pgxyHudoGra/uNv052Y0m92kARloHITb3o522UABI1gKjllbJclSFflyYCvWL/TZWlegAkIil6xqDsSSkK6gIjMToUsnM4ULK18jN5iM+Jabzm3WAeexUwDqaz9hCFBzQ+NH5ypIgj0P+SCvJvQTzWQJjR2AZo6rwWVWbErvlEyD7pgelp83+CtY69IoLcxk+A8YIUW2q43v3XeYgYCxogEXfORVIAKAOQprWokkT2lyPRomAW1vhZEWSgSFy8uZXpzNO2smh5CUstnxJFeMaxFGUniLZs6lRTs6qONZziRDZBwW5R2DuxoWGodUtdRAr3gL3tCR95GOHNs/5CIpsWVE89q6bCNKGtWmp4InlqoPPIi1pLZACfLhbX9gRz+4YBDsTdPbQi65k4ZxTrrTmNccH+SLGDbUQCCkI8ypGKsGZ/8qbXcmHxHByxoXHFxs0+aKQ3KDGGGy0r+l61Ufs6KY2ihBSM7YxsJeZ+OTJYSZt9uShWIMGyUQ92GQNy3DcaLvBCnjYyy1L1+2EGRDUHJJmos8AA/xkf5f6UrS5D/WTowyhqP41jbZGhzVM/DTvsYTpkMrjZAH2mXK0Ddmf1Z1rUNC4TC+6Bx9ekBPTEoY+kjk4LV8FeNDLiln2h2YMPcK8hFglwD0kY/ADAmLPn+/uTFEg8YHp5KwZvzy2uhnPAELUv37z7FXJ3U7/31RKKSJyQUBYHwX+mRDM06cHfY9HULJA5KlOSVX3soCrw4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(6133799003)(56012099006)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y17P1aLRDFwBVtER1TzXuda3PfL3wnV11s9wYn4poi2PJttUaAxzSANSBq68?=
 =?us-ascii?Q?l8MmI9cOgB5QOuU7enTKjVs5PXTveq2i2k8hlVlZBO1TSPSOlVDul9BIaFFp?=
 =?us-ascii?Q?t1Q43wa3vcpnYQeYWiy8tPLJZB59WkhsObdp1VRacGjEfigebvGyNcPYN3iV?=
 =?us-ascii?Q?ATYBbPTzIgApATpphGMy5VxX7yZdVW7tYJFnXb3Bra6DVfgsTtrcFLfih3pw?=
 =?us-ascii?Q?tCdi9f2baUJIPR+U8SLejGw9Uh+KxYVgx5kDBTIhYXTMvvHvGVBWcUv7m3bL?=
 =?us-ascii?Q?l3v02j26i2RLOYDW11tF6xMsSnzgYLjdeGd/2vAWbzM6tH8nFZJFG0gyvcb0?=
 =?us-ascii?Q?PzkVdVSr85c1YxytzeFgMbBkHT6GC+lyS+xkOygDRXcF9X+eL3y4+/VEem5R?=
 =?us-ascii?Q?EcD4gSkgp+tPKge7r9GnjRfvdIjUU2j1fFcVhCY+mFDjH3T1+UgYJpjE3qUm?=
 =?us-ascii?Q?6I1hupjSCosk2JL1Bd5bn7hNeXZAuio9g2iR2HsX+Q5cmHgEeFJg8xOjrCtt?=
 =?us-ascii?Q?u+S3FV1QM0B4D9KVToiMviRWpNfYWZHgmMlmry+7OJqhIzqYjeD7loxr3iqj?=
 =?us-ascii?Q?x4k9LhZFIjj04jD1H6Xvm7/1ufq5PBPygPuC24G9HI3RJBgEe6+fNdktCZ2o?=
 =?us-ascii?Q?vHUEzt64C72bFDy/tS6SovzmCyHryS+ezAQJImrhQ/E0ihSQ0pxFBYoWa6I6?=
 =?us-ascii?Q?hRk48+zVdXBGdWzE3gckx6CDOEp9xz6jtixPHCH12blwL2+z5a0b8iTd7Noo?=
 =?us-ascii?Q?nk5MCIpfwdV43nkJ67JStVNjixmGgEtUHe16P8zNppiGiBsb5TG4zzFC4gVa?=
 =?us-ascii?Q?AFLg3m0RwV7hTpumSNUPhTJaJnwFqfywV+hVozK8Th7LOnEGYyJFP3NiGsJR?=
 =?us-ascii?Q?gZ9x1tCwur9eE36qMpxCW5SDAwI2yovOqv0AAJ6MJXx2Tm2KEdY+N8DT/QE6?=
 =?us-ascii?Q?WQIjk6iwmjaghzv89pNIE7licTKdL4JOPiEenMlJPbHXJnFLL1eGDu8sxICt?=
 =?us-ascii?Q?NszzvfoeBSC3890Ck+hf2h6zClXJVrpG1Rlb0BUkmfWKhGX09AU3fCbUVHBz?=
 =?us-ascii?Q?soMMqQg1GZWH7R92cpqM62DQbquoX4yT8Gw8aUtBgWGGrWG04R5CrQdh3ruo?=
 =?us-ascii?Q?zPNWmu60XwHQkZF1e7A0lnBEGQri6HvkofEqRSzfqkZ89OqdYVGAHlwritf9?=
 =?us-ascii?Q?TQWGlxR2EnNmE8N/JiqJ2GRmK+7tOvfr3uNuuPGRxkm3lxM5YEu4rsZmiQW8?=
 =?us-ascii?Q?X4AkBGDs+cHhC9NXM/qESCRke3oFsqmmCKmB5kvMsZyBEOBWGb9nFuNj5qLm?=
 =?us-ascii?Q?PEj9fr48I4DE/hBjo4QLZtPMmTP0cA/k5XziCXzX+BjYrWVfOyBkv9f426n3?=
 =?us-ascii?Q?MTLNwX/U0bnGjtOMY4Pix8hgm/gu4QX1RYjU1Qf6kyUUyQwof71binubX0dm?=
 =?us-ascii?Q?XUjGWaxXZST/D5botqFhvja3CIrVjHNFhwk4j81LTwPL2S2kHpraVBBZ/Ip0?=
 =?us-ascii?Q?/HPR3z2yC2cmA0RFVtyCRonQ1NPRg/n0q/iB/c/HM8mibX3RqCmLZXOKJNro?=
 =?us-ascii?Q?37B7PSev2I935obbmEZSCOu2TjypNIIjFYV6aXCWFwXrHK7jJcZdsXuZTDsw?=
 =?us-ascii?Q?NjJpE9XfJdB8u5DbvXle7RJKK7bmZkR2SY9t85gZUvVTy5f4rRCovSukGqE0?=
 =?us-ascii?Q?Ir1VDGXeufCje5Mt9taTRmNM3NxsUL0fEz1Rg/W31pHhNEfFx9i0HyZrNIZ6?=
 =?us-ascii?Q?xHT2mv6lkVsivWfu+Ri8/l4VGLySioU=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c77f08b-5db4-42ea-cbf3-08ded7230ac6
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:44:23.9633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHKJe7e21f9a1Q5OVJzUcYIxfzERYnbB9agM+2KzLiLKxcTCOnBb2k52eAhoj+IHwV/0ivjG+IP9/BWPQ4tooRGIdMR+59cytoh5Ke1Cir8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR01MB8048

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
index 63885348c14c..f8b7abd7871b 100644
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
 	unsigned int i, count, txsize;
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
@@ -382,6 +391,14 @@ static int mxpcie8250_handle_irq(struct uart_port *port)
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
@@ -437,7 +454,7 @@ static void mxpcie8250_setup_port(struct pci_dev *pdev,
 static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
-	struct uart_8250_port up = {};
+	struct uart_8250_port up = {}, *new_port;
 	struct mxpcie8250 *priv;
 	unsigned short device = pdev->device;
 	unsigned int num_ports;
@@ -497,6 +514,11 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
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
 
@@ -507,8 +529,10 @@ static void mxpcie8250_remove(struct pci_dev *pdev)
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

