Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012034.outbound.protection.outlook.com [40.107.75.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8A63B6BF2;
	Wed, 29 Jul 2026 06:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305209; cv=fail; b=qp4h/Xj23QXkVrcCwvj9AaDl1Qc+I31ncKzVV8HFzFBY09v0h/5IVpyjgGLmow2VaTi1nmGeDpogv4Jj9QsqJ+TfvCzV1qwI2xWE5nvhSKmc/STZHRO74lVhK3BlvqwRM0dLVR+nfLZDTzYRcSmWc9g3Oa8f2+AH3hWMtqzPuAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305209; c=relaxed/simple;
	bh=Fit+cuuLgbtvWZ8VRS89nb1YYfRF/PuONPz2Ol766NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sUUooVCXVUxktvpZf6ljRkTt46y58H3B2MiUh4atYyKIJjWs3oH012hvgfN+mAgZRKe3VKYoQnpZRfBp0/sDElzgXTL0Ny7+t8d0rGICzvYru+O8ApQPpuQLBVBrdybqwwfEEruCdmJaPl9Hz5RiEMqTYwoP6WkhxfdtAhSGrRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=gY1AaMBb; arc=fail smtp.client-ip=40.107.75.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="gY1AaMBb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPpOrRF3a+BufkGxqFq4sl18PYeDpsmeJ/fOVDs/3aEczpOqVDJXjgIc3MeNSwb7mlHANsxKsMI4xl4c6KVkh07SXnAW9G+yA3zQwniW+8X6nePAPhJy+DH12mxlom0eMoPjH3GPk7hcEmC03VDdUTVKLwgS6rgATDaHfVWzhuS0U6bD9jWGe9JiLTw0TOFN6Fdo4zshNYIyI/K74IJhP5PJFmGAV2iL94cND2qFBZCTRkUWgrCZYYVqUihbMAGPIB50T2uNLG9rsLdgXcnBJC5pBnJVwT15OKL6LQ/fRN59WyxSBa6fwVRa7P0nyxriu/n0qhfBqgBa19trXMIOrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=205E/0xEkeDG8XfuEnfSeVblD1vFh4pLUHRj/mroNG8=;
 b=sLM9+WtjaC+/I6FEVhySGtyuv8DZOm8JQAhs+1RY98OLD8glcLetTjJSrX0H5VhvJif7Xk2IglVsiRSItnLnRfK2o2BxpNEpAaon/HYzxntcJ3eF5v6+P/TINz15nluvi6kSwb27+B9YVqIVTYA6yVu1AdOxareD+9d18cI7t2AookYJALA6sGHKp+ICunYYmzEWyuinga+PyjkxLR7Omzp1/VXPScdhuWFhqOqLOKJS3yVFa9oDAlEDU8KgIhPhnjCTRjX8/VV8xtDIi3zYoeqXUPG68XmTMM37Te9uQT+HuqgauDE1b7+AwSOXcG7slpBibxMRPrvM/4xYZGCrbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=205E/0xEkeDG8XfuEnfSeVblD1vFh4pLUHRj/mroNG8=;
 b=gY1AaMBbjOW7dHrQA8jU/bkZN4tiwNTXPP7XH6UoWyUrh7jSP1VDM/b6HB0vYzRqGrDJc+JTAWjVd59SK4w44jUgTfoeAuiHevC1y4uTV11Xt4U9oOFYzm4RO2GyL6v+KSflxiS5zYUdlGrFAsfxfcGC9vL0/XjV9zIlnwstDWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEL0PF4D55A38B9.apcprd01.prod.exchangelabs.com
 (2603:1096:108:1::59b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:06:34 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 06:06:34 +0000
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
Subject: [PATCH v4 13/14] serial: 8250_mxpcie: introduce per-port private data structure
Date: Wed, 29 Jul 2026 14:06:01 +0800
Message-ID: <20260729060602.492430-14-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260729060602.492430-1-crescentcy.hsieh@moxa.com>
References: <20260729060602.492430-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::10) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEL0PF4D55A38B9:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c958e2c-c84b-423d-3458-08deed378ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|23010399003|38350700014|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	gyh3615LDpqebg5/Bc7AflRYvcLQsh/qEF4460EE2kEGOAmZdJDAzNmee7U7gHbRO7alS/UJo84vay8Ajpte9qNVdF3SIp/gCXtRVCpKq2zz02Ph76FVyusgmceGCzzIqX61svPsWXG55zPhDL/axNy1eYOQzw8V3PU9mZ5Lb8E063etgtAa5aYXjdh2914v93PRXkZXZZgeVbhg82NYBwFwnaIk2j/iGbVaX9ejbkTP2g53OaAmWl6EFjI6hjp5k5BcHNSZeDoep9qeGTls/9Muv9RCPY0anQUPHYnb46iLOTjwx4AXocOtkd0Q5HZeHeFVoFH7BzJFbkAgySzO9ATYM5EN8NtihPwk7CBSkgsAi41FeQoG5butuluTQ8bmx/EQQ1CVSICEVq9cJQ5LbN3icoQ/sl/dcwyT61VEjXHpBUgHvit+uDZgXlTdoNFofvzpMSEI91RIDhyQRv/8G72LdJl1GgJVgZN9sMvvBIkdlxK9ZfdzMmb2y7BKjRLJ0mT+6ywZtEke3C0bF3w2TVG6bs7LCHcw4Q8CBx062PjTBEmDyiZFsjRS6pTGbe5ICqrfZFTm7fN1v2psM6pTAJoko+8gdK3342D/MDbK4F1otuv1PZsYMzn4CsodKUXOllnJlrQL0laMwIyXLWNpU5n4UdxG1q6vsh/23/2HlV46QbFhECQYy24K8BkjM3Ae7yZ6xE4QzO6WvTHVRll2YNdztL9+LLPRNvKQeFsaoYU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(23010399003)(38350700014)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6B1co5yZNVEDXkwkrMVoyYDtbDAmBb4q6ZsuNF1vdZ4hwRGyvdVyYuCXsKMA?=
 =?us-ascii?Q?DfIybMp4+9i/OC6gzDCYUqakPt0h7Ku//pjeBdIQJlV5DAkvVMI+7abD5vEj?=
 =?us-ascii?Q?muKR7YFkUgCguwq+fw89+Alpv5VbWT3iJQFvPsO2vqay5hbUnRMGajEwIJJa?=
 =?us-ascii?Q?LxOXgP6uJDMcu9YKzktmEVP9tCZCc34IEA3FwDfv6qUic0YbFrCeYEyXrzg2?=
 =?us-ascii?Q?kKgN1InSx8TqNmkVbFlHwv1BzNf5qWDk0BILlRo6jMtpvn2oIo76vHOAJsef?=
 =?us-ascii?Q?fbA+2tUKtnyDpQAGtDZSRCwQje6vYnldq8vB/Yoe2v+oriW+Hl2g2kN2VanX?=
 =?us-ascii?Q?em8ofex8t+aFPrIKQqVXiBsVnnoXSST84sdTGpCypso45d+IqYlrKvhaG1kn?=
 =?us-ascii?Q?52nf1paZtuxj2xra9LrYjpnErRMJlvgURyhA09n3pgSLA/w0CEN0WjLpR/Dp?=
 =?us-ascii?Q?2BblTK2Ti/CxwmRpe6QzXjIBtHj3XbWojpdyaZe3y6JUQHqmNJqH4adquAau?=
 =?us-ascii?Q?PFXW9ufauNgS3HRfU/+9Umcmcl2qnXwDAxQJjeWIKvsL9120pEyDYh+bsGNc?=
 =?us-ascii?Q?Klm0Ox/J02h+kzsP2Hg/+XZM78pQMXaAmvjRYDgGXCgn9MzthSF5Hq0LMnpb?=
 =?us-ascii?Q?aI9TQhnm8VFuOf9cGRClJPSXCHsMEjCHA2/zx6c+xraMI76llG1XSlJ3NK4+?=
 =?us-ascii?Q?MSPaAV0lVJ+NIItJIuoffj631hvdAX8sBWBraYs73KkQFLixvuZven2EYTNK?=
 =?us-ascii?Q?FU/YmtdnhwkDkKWP0aGGJ6Ub6bJC+TstsR7Y5LdyxTbJtLblg5WAPqEAkdi+?=
 =?us-ascii?Q?5J62ARrTWu2lCKToMhlTPewnqBXY6SG7XyGT8q7cfwrcD6kIU8lY9pGyobxp?=
 =?us-ascii?Q?wVIFmtsUQ1cxcu6FEGCe6M5PYjOFWTo/l7j5ASdb3fUdm8FOZ4s/7zt4Jf0T?=
 =?us-ascii?Q?rIEIzi5tealtAkLIYZOa+sRybQfCJhiy9ppRb59dci1C347tURuwEvNwAAGz?=
 =?us-ascii?Q?44Ao5TLlJMHkb0gpp9NGBXCaucR79EHyfUC5EKZ751LmGj+4r1qzuIpCaynm?=
 =?us-ascii?Q?w5/mPSxeMjAWPXCQ1xoul8q+jxtkzcX9Wzv/5l/a0Lf7VYVeYfTELNbjicQ8?=
 =?us-ascii?Q?PmJXCIxh7QZEyx3jylbIQW1OLoWIMctwzzao+mScUffuOzEcDXN5YMEkF0GE?=
 =?us-ascii?Q?HU5xDD4sgOZAHQL925tPjv89tJweKEoMbcvd4LPfjKxjNMQekkpsp4vlAVtC?=
 =?us-ascii?Q?LG0/HvuSxopTpZAFSdzw+ZU41wcMBsfY9xEc0sC4F2UQy8VsgJ+NvDJ9pDG/?=
 =?us-ascii?Q?gBty/EnNMMWLZHMPQ0aEG3tkLOuuYJbggNXH0qf8amEQzd3vm9g47ZSBzlmZ?=
 =?us-ascii?Q?tmCqptk4eRDI2pBeJ337p6y62JbTWPokVyP0HgQo2Mcql+mxpo1XPUkHIphZ?=
 =?us-ascii?Q?1hhXgweUGlY7pkGUUi6+YdQdQcg0+C7emwmoZFCFr9mNoH9D70ejHdTd1bbo?=
 =?us-ascii?Q?bFIvUXeX+zqqg0TdX5J/mzRfzVCyDJBRJTVeP6lMCLJ3Kka1pG+HgWc5JKS1?=
 =?us-ascii?Q?WbLPwdwJhOKCSunXNXqFAsL9F4wT/4d8ioKhjsU3w1YOL27wO785Q+Sb1Du+?=
 =?us-ascii?Q?wcbXK4/k++fAiPSlW0TmCgvKWEqSWeF8qmpD5dXN2at2lW69chlReILcf5JD?=
 =?us-ascii?Q?FB0gN0R1iWa0suD45Pjd//6GKwJvUiKwvQBQ3ElbcNhMezqHsKhRL9m5HE1r?=
 =?us-ascii?Q?BJvs4wrbeRZa9PDmhYjXh7+8NM7o4g0=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c958e2c-c84b-423d-3458-08deed378ac7
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:06:34.2391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZZvAXY9I4occW/HHCpvAUZOsovUwKvo+6EX4CkIhiKhlYFTMH0ZZxsGnJ4Q1BeLo9NCd1bzSx83aweABZzZeVjjdW/DMl5T1FMHyRfKXss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEL0PF4D55A38B9

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
index 878fc64c4451..ce0ab5c1df52 100644
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
@@ -504,7 +508,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 
 	num_ports = mxpcie8250_get_nports(device);
 
-	priv = devm_kzalloc(dev, struct_size(priv, line, num_ports), GFP_KERNEL);
+	priv = devm_kzalloc(dev, struct_size(priv, port, num_ports), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -545,12 +549,12 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
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
@@ -564,7 +568,7 @@ static void mxpcie8250_remove(struct pci_dev *pdev)
 	struct mxpcie8250 *priv = pci_get_drvdata(pdev);
 
 	for (unsigned int i = 0; i < priv->num_ports; i++)
-		serial8250_unregister_port(priv->line[i]);
+		serial8250_unregister_port(priv->port[i].line);
 }
 
 static const struct pci_device_id mxpcie8250_pci_ids[] = {
-- 
2.45.2

