Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012057.outbound.protection.outlook.com [52.101.126.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960D5368D7E;
	Wed,  1 Jul 2026 03:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877461; cv=fail; b=RPy/eI6gxWO91rK5gMT7BY9U3Bur0Ukz5RKFIM36JhmpZj9SjygULX0tFh1aOOZN6+Tx4OD66pVEcYj7znxF9F75C2V2/l1eow43IsnGHTT8jP1vaCRmQQ7i4a/dbCC+naAHaRJ1Z01V9Hi9fXoqyZM1i6aq4fyrSwp6P1G8mBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877461; c=relaxed/simple;
	bh=lG1+VaiD1nvjg1zq4JZgDuur6Co4Bnyu7y/r2BHJ2pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q6v6MOdGtN1OtMaa8nhAyOkwd3+Pytuu7NNU5zMZ1mq0kCsLyLiYPdJ8v3IczwRwBNzy1kEOV/xOcTko0+r33DtjxGG2PsFTTz1ChA8QyFMZEJpviwUVm7UTCJHGVY1UzBTUxoy2jLfAVsS5YOcr/X1cJ7dliDzmZyRFUVeLxog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=FaLH/cpd; arc=fail smtp.client-ip=52.101.126.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="FaLH/cpd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1f/ItgKu4adGiwK0e/UdJ7xVsLm6ZnswgktmJb1aafFM+x/6gg7j9h/214MBv3jDrpSmAUvTr23JHMNjrNFXvowbEAi+a4alnXQAUaH8Lh/diC2MUlGpK6rGy4yZ07spVMU5C1PTqevjczF/RPPOdouLfbbifH7gBTqKPGL4ONoxvNiE+ceYLPoeolltRQXNiuYjT6JcuwnpUary2Eakf6Pi7ajMQ9E3KCXnuE1lsseH3mO3zLkSH1dIMj/xtp1+M9muYHCDUPzSl7m6xh6YxjKEEFDUYzJhrSD4+twhSTSq3HzGFNolcc9JldsPZbRSGQanMl+aiOUw/FpbSxvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccs3q9BWaXdnXWVk5ZeO4X0a5eXOqT1fg9vl1/2234c=;
 b=Waibw+ZG/zV7YDya7XLzcuWYsWBATiHCxykqMcQYme/MqzEmckMLY6hwvaMPQUJN3poiWP0pOJJUW9ZyS1QrEL40LrMElNVhxN287P0GfRocEWuC1jVzzOOcIxdWy+L1z5XgRHK+PLw/t9gKonw81QBmPZzWJZ65C+BsDBTJpGcHMiOLM+F+F6EKXgmpHxXJeESGQ0sVy47cmZ4bLgLwtCYwSggCM/DzUmkhUZvOWek6j0L37GIM40JIM6QeSDDfu+32ZF094c9YYzego1Z+a7hT+0JKeLgvk5PW4Gbq8DJrPL268kBylQRHP+zpjPvJ1U9QZnN39q4uGapNQz9Ztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccs3q9BWaXdnXWVk5ZeO4X0a5eXOqT1fg9vl1/2234c=;
 b=FaLH/cpdHNubLxG7kfkqXUZyuZ7JTfrhZlkna8dUuh2/SHuL5Al6kgPvtSby3doWInpQmHU2TDNxn+K5LSs4oh87vgXRL53j0/HGcdGlJcszGDK+HX40dj5k/ShAeJ+PrcJiSUZ00vxXpDi9F2+le5i5KQ3fWhxYW0gFAFZWFrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KUXPR01MB8048.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:7f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 03:44:18 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:44:18 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v2 09/15] serial: 8250_mxpcie: introduce per-port private data structure
Date: Wed,  1 Jul 2026 11:41:22 +0800
Message-ID: <20260701034128.218569-10-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 986e7fb9-d7ea-408b-0ad9-08ded7230785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	VpW5fN4y+TV9j/yCBYDNCRwflS2b/5JRbuEF+fB5PGNwLf6fBAwV4xLgOFrrZ06WSyUcg5ip1H07XFGQA3bT3sZUhlfR/ijs7W8iGWnEb4NaLPD3GyULdyJoj+IHpWGV6VWBgOi4dofrpx/IqajEPp6OpuEwabbjIpVYREhG0cOGnfEyIGxHcNbb8EuGu0/0E6BRfGZ7+d6g89cECOFy6V5Q3o077RdUgYj3QEk7jfu95FxK2Tsp7q2bQdJglKrXowpfSgTQvaMzbIDyTqLmnJHk2+Huqlg0wBEboeHh/f3+9p+yHqXw+PhJFjqsMsDQ4zru8t8PjbsqtvJC/CJtilh3YD0gM7SkavfYAD4eJO4RZegYDny76xMtks5s4URAEf/LtjwyC4Ow897dOXJcFxGv2ITd/vxcWZ7u9aJhkKbl9rFhfJiUvEIx7bQuCGqFfdW71JDoJ51MTjHm9XyXFxvx8VGoASXov3SF5ZHvNRKeOB1qnYLQXFnyjbfNIyRzgwKwGCluqmB3RZFTf0RlTTMXINVK2Ier1yHz2AbojkT5vZi6ITWahotpuaCtCaNBddBWS66rdEN1O/AQ7bHBG2kvkczTGrzmvJLtiF9LtGdSB5E/Nx44WW4UTnP2g/QUvNFG3Pd0PpzJ4kHQYaerlZCBWiBbfOPibCdxjU0xuZOtgzpjnio6aGAhINwBQ/DGglJI5ST2nAlqp4YHfJNxwew0DfrwRgz5pr37AnNnP6c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(56012099006)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jsR28UYEDEiLNiKwWv+R3h0VakLKrraje4DPywR+kKf8lkTGpUkuG5qIpVJY?=
 =?us-ascii?Q?odgk5btuXba44kozpy3KNOZWBUfx1CsbChjMsiEhTQQVLb9nvcV/XaJ7SWuu?=
 =?us-ascii?Q?ENQ8/Fl5dU9P+Y/Vp6ecZ5Gq5bzZkIG2HGwWaIdkRt3zMkVLCpmdGm5E7IqG?=
 =?us-ascii?Q?poUMpNvnqJRqdVS532RgDBCQ8STOXanvYbS0UfS9jxGhB1GXZ8W2Tkch0hvT?=
 =?us-ascii?Q?AVppr/ydbnF3VHdQtNuBw9YU/YxHMgM6PSYMykxJVQ+yXoQI2Uugp+m0y9C4?=
 =?us-ascii?Q?70/Lge2tA42Iup9pJEcZTgFEXZkCmZMubZv9sW0ZlXnPH639/NBcLyRvP8Kc?=
 =?us-ascii?Q?jYbcCPtGf9eKlKGJX58wuxjxKXXRQ/8gZqfW9EfnHe4LQMh3JnQAOaEJjjoz?=
 =?us-ascii?Q?naMCukgU+VZDExeWwWlwSN4Dn+oza0in/6o3UZdaZROENSkmkmzxYOjaRxE5?=
 =?us-ascii?Q?zXLwkHERgDVq1y76cmZmbWde8TNPhRmJu6VQHl+7AL0hGbJmdcw6Acr8V4NK?=
 =?us-ascii?Q?JItFwObLOvjX5eiTfQwEg14MYT4vNNVnEcU/A/GKCmSZraZhhxoU2qvc8XNC?=
 =?us-ascii?Q?wOxZPYekoJQFFYyRAaQocXD5QMWIjzNr3p19EYG4+PxFfoTk7ENcWwi24wF5?=
 =?us-ascii?Q?1KEQNSmtSoTHAJrLxL9O3K+utMBkj0+KQiGA/gnVam5SiL1eieRTvcgjLbGN?=
 =?us-ascii?Q?oguCj3Iru+EUOnXFTGB08Cr5ZCWcA+bKy016h0oc8Gk+YBmNssJLcFRU+kY2?=
 =?us-ascii?Q?h8OExtMblYqvbKMOg0ZCUyAIXE+ipCFnGpEhijMwT1S2I35p//ocMi6CCQA4?=
 =?us-ascii?Q?6myCT9dJuX323yITqSxoCWq3NJ+/KBYpNfIjD/EeP2mwbH7LAzPNkxgTldpc?=
 =?us-ascii?Q?7YvWgzs/0vOI4uoXWyJYlo3j8lPCutTho8dnKqDHooqAdbjP48+YpkOstl20?=
 =?us-ascii?Q?3SkQ4oyuGKAAvxRZxoHOGn5lDfq31+2kzSUGvceG7MlSePdO6PdfFUFRIMoA?=
 =?us-ascii?Q?30LrETLxL9zEiCK8jAmazfd3Ppfo/KHew0gNebh+Mq3ECtCkijyrajATCCK1?=
 =?us-ascii?Q?qityGlpF3ypimy1xAFF6/YWT3ugdq2DSKdFrFWRrMG9eCpRMNQ9XknUMNNxn?=
 =?us-ascii?Q?UU4C63X4owTz3JNc2Zw1uhUqd1DhnwZ/HmG2jQMCULL0NbuEQHwD9q4xT+oa?=
 =?us-ascii?Q?lUZInkO36Ckm3XtfnoK8OaQTnl1qKTbH1b6bOgdPw7vHUuFwkBqp9k7ulBc6?=
 =?us-ascii?Q?E6i3ensoKvv0PjpxCH9vsG3+Ar5NoY1OeGVNwO7cMJHCFa/3jYvA0T6sXg9N?=
 =?us-ascii?Q?gX3L0wj5byC94HknpB1lxTjGjy0E4ydwfGfywEtsIxil4OeL8aB23pkUl8mw?=
 =?us-ascii?Q?Pf9gFKmg29cxycWLcxYeBXZxpT+VayxLt7+moY+OfjpUTTvlDVtnSPHr6/N4?=
 =?us-ascii?Q?c95Osq7xjJ7fTnlKiL24Cbx9AlPueZNyCBGJN22SrKUXNIEeZjIvGmh6RkDr?=
 =?us-ascii?Q?4GfughYV7EhM4JLr/L4c7HD1wpOOkgJUGpIOUajWR4QrzyAQY6IIgJwYsVIW?=
 =?us-ascii?Q?p1iqZ4o5QBhiVUWTY/Q2SlMpmQAu5UHezZ6ddAyLVqxepFMwfIHwOdSnkKMz?=
 =?us-ascii?Q?JrMtj6ZnRBQru7dHXQ95I2CVWeX8HqRLy2tebpVnuhD6sSNWXl4Lp1AMKTKF?=
 =?us-ascii?Q?BZ1ib+VvR+qvq0qTfzxJAw/ufxbfqiNZ6epODT1q6d9XReSBSGqJjsdSMnfH?=
 =?us-ascii?Q?JAnF9p2gCP2S+Nl3RAcm+6tMT07o8H4=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986e7fb9-d7ea-408b-0ad9-08ded7230785
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:44:18.5968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwFUT0CVGWnFB8KKcpUuT87RRVJNIwjSTsURycLyABq0c7tDE1FsENs3ogCzhstq2okLSWuMvTJ8UhgM/GGI3foTGGOZcy4+JJNH6+GDvqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR01MB8048

Introduce a private per-port data structure for the mxpcie driver and
replace the shared flexible array of registered lines with an array of
per-port objects.

This prepares the driver for storing per-port state needed by subsequent
features.

No functional change intended.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 8d38f7d80282..63885348c14c 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -104,12 +104,16 @@
 #define MOXA_EVEN_RS_MASK	GENMASK(3, 0)
 #define MOXA_ODD_RS_MASK	GENMASK(7, 4)
 
+struct mxpcie8250_port {
+	int line;
+};
+
 struct mxpcie8250 {
 	unsigned int supp_rs;
 	unsigned int num_ports;
 	void __iomem *bar1_base; /* UART registers (MMIO) */
 	void __iomem *bar2_base; /* UIR / GPIO / CPLD (IO) */
-	int line[] __counted_by(num_ports);
+	struct mxpcie8250_port port[] __counted_by(num_ports);
 };
 
 enum {
@@ -445,7 +449,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 
 	num_ports = mxpcie8250_get_nports(device);
 
-	priv = devm_kzalloc(dev, struct_size(priv, line, num_ports), GFP_KERNEL);
+	priv = devm_kzalloc(dev, struct_size(priv, port, num_ports), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -485,12 +489,12 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		dev_dbg(dev, "Setup PCI port: port %lx, irq %d, type %d\n",
 			up.port.iobase, up.port.irq, up.port.iotype);
 
-		priv->line[i] = serial8250_register_8250_port(&up);
-		if (priv->line[i] < 0) {
+		priv->port[i].line = serial8250_register_8250_port(&up);
+		if (priv->port[i].line < 0) {
 			dev_err(dev,
 				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
 				up.port.iobase, up.port.irq,
-				up.port.iotype, priv->line[i]);
+				up.port.iotype, priv->port[i].line);
 			break;
 		}
 	}
@@ -504,7 +508,7 @@ static void mxpcie8250_remove(struct pci_dev *pdev)
 	struct mxpcie8250 *priv = pci_get_drvdata(pdev);
 
 	for (unsigned int i = 0; i < priv->num_ports; i++)
-		serial8250_unregister_port(priv->line[i]);
+		serial8250_unregister_port(priv->port[i].line);
 }
 
 static const struct pci_device_id mxpcie8250_pci_ids[] = {
-- 
2.45.2

