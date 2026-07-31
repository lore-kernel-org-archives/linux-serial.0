Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013042.outbound.protection.outlook.com [52.101.127.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB193C108C;
	Fri, 31 Jul 2026 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484164; cv=fail; b=o+f2hBEJBEaykImmJd5DMjbmoOd02NINJUzmYmav3XtEVXnFs1lF5bxeOw4jQX17qfCW3zt9laQG8VTODnlNHm1Momr1nmDGhNxRgI3KlB5KlYjJCOGkWSI/PMiv24ithAc2xeUOKxmL532ck3yrlwYACxXZ7ZxNgMvhdBNMae0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484164; c=relaxed/simple;
	bh=rCA/RmIjfitMtrw+OxO51WSCTOc9N7GYNKCR6BuWpiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aJF30vmDXrLWHJ1Tn6pk87ri3qKqlf88a7VdcWotMKfegSoMyVn9Su+kKt/UK3JuvZ2ekL5dvw1z7fvUAo3miTJ2uaQoVhcF2KNUf1vIughEDLomiYIsZEWLIkXKgWe8rgCWnR/y1mlpHzYRxZY+kyNZJ6M1qg6162eB7NBDrn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=dqZsQLwf; arc=fail smtp.client-ip=52.101.127.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="dqZsQLwf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6MEzKynR7CGmz6/JELrX73t74XvwEcKf8CDEh0NciqXHpPnYX5EphNjEVf0NNQYGQmvzZRwG95kIlHOJBPneaqRT4mZjPqsykYa2rxa81mJdJZ7K0XSQyjcOgWADCHyY6uLnwjCS4Cq6jejQYkbQGBVKU4Nkyewi37S47if6Xf2bDsP3ivaqhcmnNIkxa6Prk7e+bI8WmVpw7vJpYrFXBdT5F/ia1GGH6kqizKfHAj7YlJ3v6hygkkjCJ0L3oDqBiAG1UeXTXrD0y5xs4Xe7uTBbArmkBPo8HgpSoQau/GuolDsHtbzrdfs2edzEiUobEZDGy0HSrxOCD+oblV90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyFUfB2xPJ+pCwbhzLzseBjz959ABgCHSYbUeI+fVqQ=;
 b=RX1IYQbDWIbV9oSMtS3Ar1zfCCxiw0TUrZEuG8vkLP8rDdViZoSf/4ttGgBuhudASjzohwk/UL3P0izXjxMu+hWFBY+1fFMt+vdVjjdnvcuVa8nI1+twKwJoT8lKXAP/e3xCUEvt6DQTa5HKjjkUmApbKgZ84yaFAZiCB4BO+Mp5fYfI5XvRdvc/YIsUmPDA86j6AaLDwaGTrnVek0WicI4KOGQxmGXmYQZiNah9R2kpyp76+pVnydUfHW83M1pi/Q4ibxgJS0NkujmWgxnK1aYxJJItsljZsepPc4ub7p6V+J74qtBp9AcTAcpNIkLQnkycPG/1hMMj2WksJSaLLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyFUfB2xPJ+pCwbhzLzseBjz959ABgCHSYbUeI+fVqQ=;
 b=dqZsQLwf4ASPPct5ZjBSWHmK0rOf0c3wLpDec7DVudVuZ5X5IECNKzp8/vhsBfPEZv4ofrDDXHdH/uGDyHJCf/grnhZoc+AmwOggydgPhJ3XZN0odUP7dAKKgCVtfbTbAkRrV6nX5BBze5fi91Slm/kbB/+4AoZkLKBLmptiP+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SG2PPF8F9622068.apcprd01.prod.exchangelabs.com
 (2603:1096:f:fff6::439) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:49:12 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 07:49:12 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	EddieSY.Lin@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v5 13/14] serial: 8250_mxpcie: introduce per-port private data structure
Date: Fri, 31 Jul 2026 15:48:19 +0800
Message-ID: <20260731074820.735619-14-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>
References: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::10) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SG2PPF8F9622068:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ce5072-cb63-4f11-ddd9-08deeed835e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|23010399003|1800799024|38350700014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uqcCW693TcPUTWVwnoFJO936E7/J5y6V/xSvI8ZdtsjyiflSHOI7oW8hlpdgNzBHgIe+2aQTDX0Opao8syEoTBeXpYYzMERC4V9UTgf4rruQvs9hlgzPC7miSpHr+iOVt2PaRSY47iceBSW3iXY+sB5FAHqlVsLRTk9jytRGWoJBslff+qHCcy7y1ZjwZ5o/tAVypaZxZzGIRiG4DXJzKllCRfk38Jt871V4JG1CBXLrx0lUO+aykyeDcBF/AHD9o51kSepC5h2OQJGLLc41a2fvhBcazI1QtnErtLN88B7p/LtUp+47g3x4ypfDBtLA6dq0qcPkA0qpoOCfmY4I4KTAPKmDz7NZgTXit1VA3VKDzq3UPvrUqVztASAhjOP2JeMSBxk8RDFVVgcrKXVE6ILoze1CUz9TGrpiaHjg4VysVeECZQ4U6jzQlO+mE7LcymPTgofgn+EenABfp1anhgnnI4hYcVYSNdifBEsxZdmX4JVqiS1WmgX4LfJ8MEGLlR2Y38Ikzsso9WC6yCGFCW+8hSCFW3BMp0MulgDmIgk589BRCren12bCBC5uiPizZDfP7AOSIicTtCAcP7EE8hiuRthDVbCb/qDPll94bHkueTdi6T3EDtkgtO7pVpBcf+zhtas4Q7Kxz5gAH1n60yEi7aoYCLLQnDRi8E9tbkS8Lhc5yWa6NAChmqQq+4Ac4GeWL6fJk6lHa0xzesmqCGzCh6ByXVTB9uTu2McEBmc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(23010399003)(1800799024)(38350700014)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zSMgGsWoAHRi5gI88eDlVpGkWvDCI8I45KJUaG1SNbUsJfP85QuclnDhinZL?=
 =?us-ascii?Q?2bwKVmSB78qUw+fGIPnW60nZNbzuVBmI5VY6rpcnctQePwnEUXAq1RJzjhmD?=
 =?us-ascii?Q?OXdv6LuhiRE+ayU/xDyxi/5ihaX6Ujj9W6ohJdQme0IS22JQsrre7Dh9Zmo5?=
 =?us-ascii?Q?nax1ccK4nk5nR6QjQl0ebNlUm/LuTypUdc+O/UDrCc+BCK42A9AqQ3yf6OeY?=
 =?us-ascii?Q?4km+uo7OKpiMyRSyOQzyTfZo820qFH2asjktPcF6qP0AN3GAXPNzOYQ5m49P?=
 =?us-ascii?Q?Xqb+FGkq5LYqZSCMFsAvB1Do1BD2GVZVC58nTBpBR3ewUY6u6m7VKgN2jO7G?=
 =?us-ascii?Q?qHulzeWSZxT/gXAhag1kTGrJ/73rfGPDqkU2rfIgXjbHFUeF6fKROS6i56Nx?=
 =?us-ascii?Q?OXhMol07EJXeNnhg+Y9+1O1PrwibTfudBhYg1arI6VHAHzZlWSCxlrTEsvIR?=
 =?us-ascii?Q?DMQUmCQHn3WqJhxHZKBrRB3/GIlO/9dpXrvqqrnEqHaIVpD8p1YVxptWqe+i?=
 =?us-ascii?Q?mpYu2ans8fnIB0ZofIiZ8H9p9YxIvSMUJuS5YPE29GLUdPcaeCaEDaM9ebF7?=
 =?us-ascii?Q?tUuZV4CCcT9+wUAc+LmszUGZkN6PiNzF3Ws7GhLegqoKaawko7/4fAtQHV5f?=
 =?us-ascii?Q?4T46QgpFieV+eT/IZa96ANzo9Vs6wLbVv8XJKxPANngqo7a0dc/g3knWfrHz?=
 =?us-ascii?Q?FIC+CJq7/kwPJfMD07euTZPT5CTrp7WYpxjCdC3q6PxtySYWUyWeq4gYAIQy?=
 =?us-ascii?Q?fvT1MfwFKsq399PMDVLNeSsRqBOpkdP+z0e9jmOUkgfOwzvbX8jb5hq2ronq?=
 =?us-ascii?Q?xKuIiP7oLfHzpgOUIMsUNkYHgGFBEXPRjz2Ikki59zyYLxXExmKnjbJqTQIq?=
 =?us-ascii?Q?2LFGpeozJ97T+myhO2UtNiZg+mhH4QO7FeA+6ue74Eqqndwpz2no1jdJvlRE?=
 =?us-ascii?Q?bOq6OY1F6DyIc9sMBYm9Wt+KSu3SKEEbIWGeGREGByIjRc++IWY6wADkXfqm?=
 =?us-ascii?Q?7ohXeeXXU2We4J5vokbCCzWSHf7e31TdODCj701NCKxvp70X6+Slx0aTtnVn?=
 =?us-ascii?Q?NANvSztwMiXwdroUPAoYeUHVQI7ooPPxdRdnCnR3R7AZtUrQNWpPl3HM7hoc?=
 =?us-ascii?Q?6Nr7Vhy0CLbKHvgoqRxot0QVW3ghp8s0Nn2PhpFfStR67ZR+gGOVnKJ6OQQX?=
 =?us-ascii?Q?dINRkEKJm8VKuI/JccODHIjRFh7Cx+hrn0pt74v9QeKdVAvztpDRNrrs+joc?=
 =?us-ascii?Q?QfNl9ypMktdqYhouPhEBChgDcTzdeVOB+y2DNP/k+aAkdPWrWjVmCdrsXcQJ?=
 =?us-ascii?Q?JMqO7c7vKIpD6pu5Tqec8Uv9kZH9PO5EHxx2V9eEAojhKUqAWM04oXqelwQF?=
 =?us-ascii?Q?qgkJxGa2A0YwwZ5ccI+3LHYBNGShkN8+0e4zns7Aql5xyPtvrXiMd/zqzNnV?=
 =?us-ascii?Q?ZbpsYIIEHdWOeC3bzTeZrLq+pJTn5/C8CkTZM+CzTUnJ55v5SjlIYuOGx1Ct?=
 =?us-ascii?Q?gcOScVJ9wGqDSfEWD7fAx0D4zPAiNZyRphtJBEUEsBnPFm2IC2DjnQsyEj8W?=
 =?us-ascii?Q?csOhrAMO8hxTaZe0lKCwbWlCCI7s4wbH3UbHje02Q8+BDqsQtF8AottOcIfg?=
 =?us-ascii?Q?XwDddnEWjBodQpKz0l7w4eX8ED8n2pzwa1xaoT8uPHZHS+k3zGgXaYmxQVhS?=
 =?us-ascii?Q?Un4mlXra3DPMfl61A5492UNw55vWXC4cjyhtXk1ISwr5uCFn2YjA7N9mxUgV?=
 =?us-ascii?Q?w0r7DMAsEu/xp6kfvNNtfJ2rhPGfwCE=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ce5072-cb63-4f11-ddd9-08deeed835e3
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:49:12.0313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3L6gagp8Rqudz0woO5QIfD+tCHUs/mVGG3T0AjEAsRtROJC6qm97sY+FWwK/0KqO7TT/Bi0t9OBZlPYjH8eoz+HdGye8tlBhByQ5lWCBN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PPF8F9622068

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
index 6f44a557a6d6..b37e014af553 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -101,12 +101,16 @@
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
@@ -501,7 +505,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 
 	num_ports = mxpcie8250_get_nports(device);
 
-	priv = devm_kzalloc(dev, struct_size(priv, line, num_ports), GFP_KERNEL);
+	priv = devm_kzalloc(dev, struct_size(priv, port, num_ports), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -542,12 +546,12 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
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
@@ -561,7 +565,7 @@ static void mxpcie8250_remove(struct pci_dev *pdev)
 	struct mxpcie8250 *priv = pci_get_drvdata(pdev);
 
 	for (unsigned int i = 0; i < priv->num_ports; i++)
-		serial8250_unregister_port(priv->line[i]);
+		serial8250_unregister_port(priv->port[i].line);
 }
 
 static const struct pci_device_id mxpcie8250_pci_ids[] = {
-- 
2.45.2

