Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45718340401;
	Mon, 28 Sep 2026 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620387; cv=fail; b=Vea/n5TlltWS5/bM/Y2UCCL1g0ro1mAjqnwQ4DTBh+OEs/XrWIvBn8R5jS51q8XE1clf05YU486nlh4DnZ/Ot2HePsnVgJOFlGVtFsY+OJ/8wgRAD3BajtaQWsXcZggtOkyx/DOVcaYdCs7vZbxnKONugWzwS6k1rUKkcih6Hb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620387; c=relaxed/simple;
	bh=wCO4tg1njNEMYwq5q88IFc5PVtb6grE15lCa6Asn9OU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LvIHfxWr1g8AURUBCJ8TbGUbH0u3IF7da5vH52fD6NXNXUt51dAeafaAZ6lYNBxZ6f7ITyznHwnoS/PCBiKBwLUJxQULX+QSM/PU2gxul0t8l9paswRTwAwY3PPGJBaQ83zluNA4yQKQtFIW8vFHJGCsDtca953ybWN07Ht3W90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=s3IeEqUi; arc=fail smtp.client-ip=52.101.84.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="s3IeEqUi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M33ZweRNYTUVbzbGGeOyTuvMZXcUwwOAVN9xR4R3C44w1vM2zv6ResKr9bWWwVPToUTB8M2wWjR9uMaZ8ZJBtqoest1Lzwwsy14Cr6lO9243sPd6aezztl7toGpVtb1feh9NbhrLvwxOIRSCPpdUoV5pl40phl3PfIj0Xj47RK9nRZwX4A6P3VRinhfB+/d+Nb7xQlExZJA4mXngwwqDwJ6sEFbrlKi+HENN0Rso8f7pUyxpBePX3VH/b8rX3cyan8wPwJyGC9yvEEY5jUoXu0U/P2G6oQO+NpqHmyBC1awR6WlD42e2kviS+4OUF2dM67u761u0mouneYxPv0Slpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Usv14QyL/Dtec/T64ZW04K8J2cqw4VppuiTyKWpHrWM=;
 b=aZqOhVNWwekvmP7glaC5uuKW+DNANanmL0emxUSn5wLHea8W409xRMSSWY5vGxWVPtbtJetqvTHLxLE+Zcj0yO7Q71iPRc5xQ9exyjZPfEijID+iUk0dToLIxM9ub/Ey9HlIqWzWtPu+Tmun0YjietRtKGz8E9dLTF52gKt+taLhYUf9NRqLEKo/4KU5i2LZ+6n7BSMRjs6IA2+JLpCgEKLJmqqQZS8YZ3zWnS6mQ+ZdYiNvy4+m5iBdCPvH7ToO7iGv+YQv+1aBnKTZyQeshLVaJ+Ck4sBXaigK4vmjpJwjYrH8HUhUc5gOupLRO6i33vHi1g8i9lYHv6sxdzh09A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Usv14QyL/Dtec/T64ZW04K8J2cqw4VppuiTyKWpHrWM=;
 b=s3IeEqUiMgE8VaREit8s9squP4AVIIiycYouZRtDaQ0URi503rqiUBXCfsdcdE7vnDQr1sOxU5EYZv9VRq7c2W0ti0Wzz1pm4J8dKDTDmPGcxc8gSIwey/At8hLWTkYqCRK65RQyEgA2toZtd2jE9G3Qu8WRSz0iZPJ4d7N/o2BvHXFRgw+stTH/vPWmCooOgLi3tXxjzUsSpz9ddVvwsJwjwYSVoR7aHBaGWgk+Ux7RPviDBXhISGT/+Z43lDdBZ05komhJhiwyJLK+z7xpc/E9dR4al5xttfeMoGO9fPxRfg3fn/UUAv/KCc8veUSLuoVKe1zzPE3prAxf28uThg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU6PR04MB11208.eurprd04.prod.outlook.com (2603:10a6:10:5c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 18:33:01 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 18:33:01 +0000
From: Frank.Li@oss.nxp.com
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Raul E Rangel <rrangel@chromium.org>,
	Frank Li <Frank.Li@nxp.com>,
	Cunhao Lu <1579567540@qq.com>,
	Moteen Shah <m-shah@ti.com>,
	Kendall Willis <k-willis@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Matthias Feser <mfe@KBSgmbhfr.onmicrosoft.com>,
	Kartik Rajput <kkartik@nvidia.com>,
	Fan Wu <fanwu01@zju.edu.cn>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Stefan=20D=C3=B6singer?= <stefandoesinger@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	linux-serial@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-samsung-soc@vger.kernel.org (open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES)
Cc: vkoul@kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 1/2] serial: use dmaengine_get_dma_device() instead of chan->device->dev
Date: Mon, 28 Sep 2026 14:32:35 -0400
Message-ID: <20260928183252.1965169-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYXPR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:930:d1::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU6PR04MB11208:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab3de71-d7ef-45d9-540e-08df1d8eeced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|19092799006|23010399003|18002099003|921020|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ZwtISGOpYRAOPVKHcz5TkNJiXnx57279iZ/3dFqQr86oQoY91tIS5MwAI4izAM8TLzJSl1jnqh5YcjQ7eRQ5Jdngx6fojRS5GaNerMG/0iE/JbKNnhvhz2gpLUXQuRsS0l8qzxm4T171AoDK4/Ic/E8dM+jjV7y74s4KL47jFc+P9zVpKl/Tj1gld3qE69sY/K5Ul7ip2kAUur4REyWOA2irnmqROpga5D823qUBBKWsZMfEKTa1UtsummgQJOtDkdwlgL52OfVMynUCkC76gucs2Lu+uv0+W5TVz+oNT4nzy9Qw2/8kAt/TsWVMb4oSByls83v2IHMZHK43mSWKUOoeK7FEv0uA0dCvT0enz53W6VL5pe/x25CfLkz4wyWV5EkuK5ES/BOL0g0ZIkYNaLPm5cskdHY38YMQH5dLNJ2P5vUHxZEx2z5Tsaol5WUq4ysXyxlQ2hCPdIdLyp/yR9/Deb5h+RsrvlRYE8SNenncoZ1px88ZAJstzQ0L38+gheKS0KZSNKjjN42qWtPBkS5edCwpzMUTEyLjiRzraUImDyVXZ+9CbIAtPxSMKv4aIMNrJ5uasf6vwrUfC357C0+b7Fo6wZ4zQA3wx8uN//YQAmZ4KH/vf1zDwZwE38fgC+OTjVrbIRhP7NsmQblgaggQSjP4fd3tvABQRZ97+VM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(23010399003)(18002099003)(921020)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zJx9x1r3nFyxCOE6OkQP5hj77lPUAZZDTgubmkJQigQN5HxK9zV+7/J2oZdn?=
 =?us-ascii?Q?2XiDQVsLnk066Ti3wrO6Yi4tzLvjwJXLYXrk6BeueEIbXavfjmH9RnyYOIie?=
 =?us-ascii?Q?A9XwCdjViRf7OEznhPhUJhotjTyQa7+A8WXiA8+q3T6h4aZnse0mUs5069rW?=
 =?us-ascii?Q?x1fnSOFLcVFHY/7lgeLBB9rc8kwj2Fv3iQwTpxFJN/Xlzipc/osUI6vLd7o/?=
 =?us-ascii?Q?fgRuD3nbmkgDnUppp8bC7GuD1opaSrK4FxUKsFU2sCcCeMRPgfe6XttaeJ6U?=
 =?us-ascii?Q?9K5oB2axSE2YGPCBMtYt8y8zIB3OtYG9VIp1C8QIXBNzgmUNqFtGpG0xGCXG?=
 =?us-ascii?Q?KaxaJGNmSd1URl4RwcM1IsMnE5Yzv93ksSR5Uc04vZDWXJR1fiJg6hmbux57?=
 =?us-ascii?Q?xZkcO83N/Pb/c4oo0zIltNV0TLd1MqigTMg+QT6fPTd6U9WOewRu6odPiiyX?=
 =?us-ascii?Q?OZuW9EFOVPcuw1Cl0oXit/u4ZVGhvjxYkOT2V8eO/T4TEYY7rAVUEUgSaLEm?=
 =?us-ascii?Q?Ane84RxpiZPInG4Htzeu1RYDEK5iQioR/I2td+5GaKlPbxJlSOgniqr+UNbM?=
 =?us-ascii?Q?U78WfIHBfnLrk3woWWx8PqgE/iDSFdSK9/pvhcMw5PM3YK5xtfsX/RpNiXia?=
 =?us-ascii?Q?Xy7BdvWQvTbnqYdaj95J6cjolBxIiWfFEmxwAUpCVsXNy3Gd9jTux3LuOEMl?=
 =?us-ascii?Q?pDRJ/jHjYhQDrvKUmUSQYYaeRURxIqm2lBuAFyG5GQVnpUMrmE0xC1gr4xqN?=
 =?us-ascii?Q?CxryVxDKjYM8kZyACRbsBC1zh3s+i6EpUVAPG8CLw+a7E4+nQPJFl79uUfMt?=
 =?us-ascii?Q?5SLbf/n0+gLHOX7CoHZq4n6YEPnkDWRkglsmkCss5IQRSBXNrjKYigRNSQzT?=
 =?us-ascii?Q?gpq0CoAjUfFUr9VZbb0jaK4eF15/nDIg/Ei4itZ9X1QYpfYC0ZGX/NcwGDhf?=
 =?us-ascii?Q?e0WhhY/UoAzB72y6de02wv8kiNT6lyBnCGNYlXesLRS48MITOzrSXUlXbx8j?=
 =?us-ascii?Q?68C1dL5K0OvlrYBPh7NqGtoqBbM4JCnT92CTvn++CC60jkA49G1CJl9oPvPC?=
 =?us-ascii?Q?r4IYu0SVxClQ3wko3tjABAWOtusNGrvy0mbyOCByifc7hUmO1PTXTceqku3w?=
 =?us-ascii?Q?JdMv5NobCHHy2VeYIW1NVOiem2U/LB1E0Ifa3EAm7YgOBbf4VnTRzRiQlaZw?=
 =?us-ascii?Q?AoPMqu/0ZUBrxgGCABKvzPVJfOjrHZEqIVAqa2cfdHhAQKYfnRRTWgVt6o0Z?=
 =?us-ascii?Q?2csmH4eKVXPfxij4lGf3SBqeSjLB3UjdKcP/gpOHY22VgRRyKjkXDNTtiPt2?=
 =?us-ascii?Q?UD+/Upp8lImPSLHOv1f3krKmJ5uV6ME8DvQp+L5NTUBE4zZPiC5lGG4+NcqV?=
 =?us-ascii?Q?+oMvo7yDJyp/T9t33de35CYY7WvgSnx23epLGwHnA+v1E9TEwTzYIIrY0fcK?=
 =?us-ascii?Q?aevEywZ+fag/O8OIPsIRv8wpRfkaw6Oz62/+9YpRdzZG/O4U7JY80G6GfhHM?=
 =?us-ascii?Q?A/y3oY7HDyU/zAk7NWR7Oi1zsEQizrywmAJNGUGRz6K7lw1YlAfOymbsuDhb?=
 =?us-ascii?Q?8OXkl0T92PjRt9sJuMhtja0xq34gaWhfCanmKy6jRMeybQZuBRsT9u6ouGtd?=
 =?us-ascii?Q?q7fqQhNz/fsYUNSH/aVANR1wllGQaJqTtYv7kyc6m0EAnXXmxOuArTfSYVRD?=
 =?us-ascii?Q?83ggjC8TD876fvslRd8pQ57w/D2grN3Ac6fDGjpEHYehBmVCNh4JTBA2rNLz?=
 =?us-ascii?Q?3iwIWgSh5yn6qYsFRrPuEalxfp7FgNZzZtXaXdh+mgIB4dFLpum6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab3de71-d7ef-45d9-540e-08df1d8eeced
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 18:33:01.1058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jh6SsZoQ8xVbL1I6/FLnhHawZx074oPV3jEFDrtCZZdllyYT70P5NeZswCjhvvyNUZ0Sn/jl4FF2EKDBj6jx7a/KSsUkUejaKgCDXjCXCk4ufOXcerOzGtuErzmmzEBA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11208

From: Frank Li <Frank.Li@nxp.com>

Replace direct dma_chan::device::dev access with the proper
dmaengine_get_dma_device() for consumer API

chan->device->dev is not always the device used for DMA mapping.
Some DMA engines support per-channel IOMMU mappings, so different
channels may use different DMA devices.  dmaengine_get_dma_device()
returns the correct device for each channel.

This also prepares for making the DMA engine provider data structures
private. DMA consumers should not access DMA engine internals directly.

Assisted-by: LLM
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v2
- remove drivers/tty/serial/pch_uart.c param_dma->dev == chan->dev->dev
  change, which need specific get dmaengine devices, not channel device to
  filter channel. A new API needed, will update later.
- fix args warp according andy's feeback.

Check all unders driver/tty/ by rename device to _device in dma_chan struct
with all yes config.

Still few left, one for copy_align access, which need new API. some filter
DMA channel, need new API to get provider devices.

In https://lore.kernel.org/imx/67966b47-22cb-4b07-80c7-2044f557dbcb@app.fastmail.com/
There are better idea to move map singe/sg into dma prep functions.

But it takes more times, not straightforward works. Let replace this firstly,
---
 drivers/tty/serial/8250/8250_dma.c  | 29 ++++++++++++++++-------------
 drivers/tty/serial/8250/8250_omap.c |  4 ++--
 drivers/tty/serial/amba-pl011.c     | 12 ++++++------
 drivers/tty/serial/samsung_tty.c    | 27 +++++++++++++++------------
 drivers/tty/serial/sh-sci.c         | 14 ++++++++------
 5 files changed, 47 insertions(+), 39 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 5a83e5269b415..1da605cc86011 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -19,7 +19,7 @@ static void __dma_tx_complete(void *param)
 	unsigned long	flags;
 	int		ret;
 
-	dma_sync_single_for_cpu(dma->txchan->device->dev, dma->tx_addr,
+	dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 
 	uart_port_lock_irqsave(&p->port, &flags);
@@ -136,7 +136,7 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 
 	dma->tx_cookie = dmaengine_submit(desc);
 
-	dma_sync_single_for_device(dma->txchan->device->dev, dma->tx_addr,
+	dma_sync_single_for_device(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 				   UART_XMIT_SIZE, DMA_TO_DEVICE);
 
 	dma_async_issue_pending(dma->txchan);
@@ -223,6 +223,8 @@ EXPORT_SYMBOL_GPL(serial8250_rx_dma_flush);
 int serial8250_request_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma	*dma = p->dma;
+	struct device *rx_dev;
+	struct device *tx_dev;
 	phys_addr_t rx_dma_addr = dma->rx_dma_addr ?
 				  dma->rx_dma_addr : p->port.mapbase;
 	phys_addr_t tx_dma_addr = dma->tx_dma_addr ?
@@ -282,24 +284,25 @@ int serial8250_request_dma(struct uart_8250_port *p)
 
 	dmaengine_slave_config(dma->txchan, &dma->txconf);
 
+	rx_dev = dmaengine_get_dma_device(dma->rxchan);
+	tx_dev = dmaengine_get_dma_device(dma->txchan);
+
 	/* RX buffer */
 	if (!dma->rx_size)
 		dma->rx_size = PAGE_SIZE;
 
-	dma->rx_buf = dma_alloc_coherent(dma->rxchan->device->dev, dma->rx_size,
-					&dma->rx_addr, GFP_KERNEL);
+	dma->rx_buf = dma_alloc_coherent(rx_dev, dma->rx_size, &dma->rx_addr,
+					 GFP_KERNEL);
 	if (!dma->rx_buf) {
 		ret = -ENOMEM;
 		goto err;
 	}
 
 	/* TX buffer */
-	dma->tx_addr = dma_map_single(dma->txchan->device->dev,
-					p->port.state->port.xmit_buf,
-					UART_XMIT_SIZE,
-					DMA_TO_DEVICE);
-	if (dma_mapping_error(dma->txchan->device->dev, dma->tx_addr)) {
-		dma_free_coherent(dma->rxchan->device->dev, dma->rx_size,
+	dma->tx_addr = dma_map_single(tx_dev, p->port.state->port.xmit_buf,
+				      UART_XMIT_SIZE, DMA_TO_DEVICE);
+	if (dma_mapping_error(tx_dev, dma->tx_addr)) {
+		dma_free_coherent(rx_dev, dma->rx_size,
 				  dma->rx_buf, dma->rx_addr);
 		ret = -ENOMEM;
 		goto err;
@@ -326,14 +329,14 @@ void serial8250_release_dma(struct uart_8250_port *p)
 	/* Release RX resources */
 	dmaengine_terminate_sync(dma->rxchan);
 	dma->rx_running = 0;
-	dma_free_coherent(dma->rxchan->device->dev, dma->rx_size, dma->rx_buf,
-			  dma->rx_addr);
+	dma_free_coherent(dmaengine_get_dma_device(dma->rxchan), dma->rx_size,
+			  dma->rx_buf, dma->rx_addr);
 	dma_release_channel(dma->rxchan);
 	dma->rxchan = NULL;
 
 	/* Release TX resources */
 	dmaengine_terminate_sync(dma->txchan);
-	dma_unmap_single(dma->txchan->device->dev, dma->tx_addr,
+	dma_unmap_single(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 			 UART_XMIT_SIZE, DMA_TO_DEVICE);
 	dma_release_channel(dma->txchan);
 	dma->txchan = NULL;
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index ceecb39fb82da..3a1473bf54d0f 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1076,7 +1076,7 @@ static void omap_8250_dma_tx_complete(void *param)
 	bool			en_thri = false;
 	struct omap8250_priv	*priv = p->port.private_data;
 
-	dma_sync_single_for_cpu(dma->txchan->device->dev, dma->tx_addr,
+	dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 
 	guard(uart_port_lock_irqsave)(&p->port);
@@ -1193,7 +1193,7 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 
 	dma->tx_cookie = dmaengine_submit(desc);
 
-	dma_sync_single_for_device(dma->txchan->device->dev, dma->tx_addr,
+	dma_sync_single_for_device(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 				   UART_XMIT_SIZE, DMA_TO_DEVICE);
 
 	dma_async_issue_pending(dma->txchan);
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c4824c201e1c3..eb4ba78815028 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -435,8 +435,8 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 static int pl011_dmabuf_init(struct dma_chan *chan, struct pl011_dmabuf *db,
 			     enum dma_data_direction dir)
 {
-	db->buf = dma_alloc_coherent(chan->device->dev, PL011_DMA_BUFFER_SIZE,
-				     &db->dma, GFP_KERNEL);
+	db->buf = dma_alloc_coherent(dmaengine_get_dma_device(chan),
+				     PL011_DMA_BUFFER_SIZE, &db->dma, GFP_KERNEL);
 	if (!db->buf)
 		return -ENOMEM;
 	db->len = PL011_DMA_BUFFER_SIZE;
@@ -448,7 +448,7 @@ static void pl011_dmabuf_free(struct dma_chan *chan, struct pl011_dmabuf *db,
 			      enum dma_data_direction dir)
 {
 	if (db->buf) {
-		dma_free_coherent(chan->device->dev,
+		dma_free_coherent(dmaengine_get_dma_device(chan),
 				  PL011_DMA_BUFFER_SIZE, db->buf, db->dma);
 	}
 }
@@ -609,7 +609,7 @@ static void pl011_dma_tx_callback(void *data)
 
 	uart_port_lock_irqsave(&uap->port, &flags);
 	if (uap->dmatx.queued)
-		dma_unmap_single(dmatx->chan->device->dev, dmatx->dma,
+		dma_unmap_single(dmaengine_get_dma_device(dmatx->chan), dmatx->dma,
 				 dmatx->len, DMA_TO_DEVICE);
 
 	dmacr = uap->dmacr;
@@ -867,7 +867,7 @@ __acquires(&uap->port.lock)
 	dmaengine_terminate_async(uap->dmatx.chan);
 
 	if (uap->dmatx.queued) {
-		dma_unmap_single(uap->dmatx.chan->device->dev, uap->dmatx.dma,
+		dma_unmap_single(dmaengine_get_dma_device(uap->dmatx.chan), uap->dmatx.dma,
 				 uap->dmatx.len, DMA_TO_DEVICE);
 		uap->dmatx.queued = false;
 		uap->dmacr &= ~UART011_TXDMAE;
@@ -1249,7 +1249,7 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 		/* In theory, this should already be done by pl011_dma_flush_buffer */
 		dmaengine_terminate_sync(uap->dmatx.chan);
 		if (uap->dmatx.queued) {
-			dma_unmap_single(uap->dmatx.chan->device->dev,
+			dma_unmap_single(dmaengine_get_dma_device(uap->dmatx.chan),
 					 uap->dmatx.dma, uap->dmatx.len,
 					 DMA_TO_DEVICE);
 			uap->dmatx.queued = false;
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 63d0232dffc20..640f85e2d636b 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -300,7 +300,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 		dmaengine_pause(dma->tx_chan);
 		dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
 		dmaengine_terminate_all(dma->tx_chan);
-		dma_sync_single_for_cpu(dma->tx_chan->device->dev,
+		dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->tx_chan),
 					dma->tx_transfer_addr, dma->tx_size,
 					DMA_TO_DEVICE);
 		async_tx_ack(dma->tx_desc);
@@ -333,7 +333,7 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
 	count = dma->tx_bytes_requested - state.residue;
 	async_tx_ack(dma->tx_desc);
 
-	dma_sync_single_for_cpu(dma->tx_chan->device->dev,
+	dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->tx_chan),
 				dma->tx_transfer_addr, dma->tx_size,
 				DMA_TO_DEVICE);
 
@@ -435,7 +435,7 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
 	dma->tx_size = count & ~(dma_get_cache_alignment() - 1);
 	dma->tx_transfer_addr = dma->tx_addr + tail;
 
-	dma_sync_single_for_device(dma->tx_chan->device->dev,
+	dma_sync_single_for_device(dmaengine_get_dma_device(dma->tx_chan),
 				   dma->tx_transfer_addr, dma->tx_size,
 				   DMA_TO_DEVICE);
 
@@ -509,7 +509,7 @@ static void s3c24xx_uart_copy_rx_to_tty(struct s3c24xx_uart_port *ourport,
 	if (!count)
 		return;
 
-	dma_sync_single_for_cpu(dma->rx_chan->device->dev, dma->rx_addr,
+	dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->rx_chan), dma->rx_addr,
 				dma->rx_size, DMA_FROM_DEVICE);
 
 	ourport->port.icount.rx += count;
@@ -631,7 +631,7 @@ static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port *ourport)
 {
 	struct s3c24xx_uart_dma *dma = ourport->dma;
 
-	dma_sync_single_for_device(dma->rx_chan->device->dev, dma->rx_addr,
+	dma_sync_single_for_device(dmaengine_get_dma_device(dma->rx_chan), dma->rx_addr,
 				   dma->rx_size, DMA_FROM_DEVICE);
 
 	dma->rx_desc = dmaengine_prep_slave_single(dma->rx_chan,
@@ -1101,20 +1101,23 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 		goto err_release_tx;
 	}
 
-	dma->rx_addr = dma_map_single(dma->rx_chan->device->dev, dma->rx_buf,
+	struct device *rx_dev = dmaengine_get_dma_device(dma->rx_chan);
+	struct device *tx_dev = dmaengine_get_dma_device(dma->tx_chan);
+
+	dma->rx_addr = dma_map_single(rx_dev, dma->rx_buf,
 				      dma->rx_size, DMA_FROM_DEVICE);
-	if (dma_mapping_error(dma->rx_chan->device->dev, dma->rx_addr)) {
+	if (dma_mapping_error(rx_dev, dma->rx_addr)) {
 		reason = "DMA mapping error for RX buffer";
 		ret = -EIO;
 		goto err_free_rx;
 	}
 
 	/* TX buffer */
-	dma->tx_addr = dma_map_single(dma->tx_chan->device->dev,
+	dma->tx_addr = dma_map_single(tx_dev,
 				      p->port.state->port.xmit_buf,
 				      UART_XMIT_SIZE,
 				      DMA_TO_DEVICE);
-	if (dma_mapping_error(dma->tx_chan->device->dev, dma->tx_addr)) {
+	if (dma_mapping_error(tx_dev, dma->tx_addr)) {
 		reason = "DMA mapping error for TX buffer";
 		ret = -EIO;
 		goto err_unmap_rx;
@@ -1123,7 +1126,7 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 	return 0;
 
 err_unmap_rx:
-	dma_unmap_single(dma->rx_chan->device->dev, dma->rx_addr,
+	dma_unmap_single(dmaengine_get_dma_device(dma->rx_chan), dma->rx_addr,
 			 dma->rx_size, DMA_FROM_DEVICE);
 err_free_rx:
 	kfree(dma->rx_buf);
@@ -1143,7 +1146,7 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
 
 	if (dma->rx_chan) {
 		dmaengine_terminate_all(dma->rx_chan);
-		dma_unmap_single(dma->rx_chan->device->dev, dma->rx_addr,
+		dma_unmap_single(dmaengine_get_dma_device(dma->rx_chan), dma->rx_addr,
 				 dma->rx_size, DMA_FROM_DEVICE);
 		kfree(dma->rx_buf);
 		dma_release_channel(dma->rx_chan);
@@ -1152,7 +1155,7 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
 
 	if (dma->tx_chan) {
 		dmaengine_terminate_all(dma->tx_chan);
-		dma_unmap_single(dma->tx_chan->device->dev, dma->tx_addr,
+		dma_unmap_single(dmaengine_get_dma_device(dma->tx_chan), dma->tx_addr,
 				 UART_XMIT_SIZE, DMA_TO_DEVICE);
 		dma_release_channel(dma->tx_chan);
 		dma->tx_chan = NULL;
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 50ae9aae6b614..bd58bbfa65aa7 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1495,7 +1495,7 @@ static void sci_dma_rx_release(struct sci_port *s)
 	uart_port_unlock_irqrestore(port, flags);
 
 	dmaengine_terminate_sync(chan);
-	dma_free_coherent(chan->device->dev, s->buf_len_rx * 2, s->rx_buf[0],
+	dma_free_coherent(dmaengine_get_dma_device(chan), s->buf_len_rx * 2, s->rx_buf[0],
 			  sg_dma_address(&s->sg_rx[0]));
 	dma_release_channel(chan);
 }
@@ -1591,7 +1591,7 @@ static void sci_dma_tx_release(struct sci_port *s)
 	s->chan_tx_saved = s->chan_tx = NULL;
 	s->cookie_tx = -EINVAL;
 	dmaengine_terminate_sync(chan);
-	dma_unmap_single(chan->device->dev, s->tx_dma_addr, UART_XMIT_SIZE,
+	dma_unmap_single(dmaengine_get_dma_device(chan), s->tx_dma_addr, UART_XMIT_SIZE,
 			 DMA_TO_DEVICE);
 	dma_release_channel(chan);
 }
@@ -1676,7 +1676,7 @@ static void sci_dma_tx_work_fn(struct work_struct *work)
 		goto switch_to_pio;
 	}
 
-	dma_sync_single_for_device(chan->device->dev, buf, s->tx_dma_len,
+	dma_sync_single_for_device(dmaengine_get_dma_device(chan), buf, s->tx_dma_len,
 				   DMA_TO_DEVICE);
 
 	desc->callback = sci_dma_tx_complete;
@@ -1832,12 +1832,13 @@ static void sci_request_dma(struct uart_port *port)
 	chan = sci_request_dma_chan(port, DMA_MEM_TO_DEV);
 	dev_dbg(port->dev, "%s: TX: got channel %p\n", __func__, chan);
 	if (chan) {
+		struct device *dma_dev = dmaengine_get_dma_device(chan);
 		/* UART circular tx buffer is an aligned page. */
-		s->tx_dma_addr = dma_map_single(chan->device->dev,
+		s->tx_dma_addr = dma_map_single(dma_dev,
 						tport->xmit_buf,
 						UART_XMIT_SIZE,
 						DMA_TO_DEVICE);
-		if (dma_mapping_error(chan->device->dev, s->tx_dma_addr)) {
+		if (dma_mapping_error(dma_dev, s->tx_dma_addr)) {
 			dev_warn(port->dev, "Failed mapping Tx DMA descriptor\n");
 			dma_release_channel(chan);
 		} else {
@@ -1853,12 +1854,13 @@ static void sci_request_dma(struct uart_port *port)
 	chan = sci_request_dma_chan(port, DMA_DEV_TO_MEM);
 	dev_dbg(port->dev, "%s: RX: got channel %p\n", __func__, chan);
 	if (chan) {
+		struct device *dma_dev = dmaengine_get_dma_device(chan);
 		unsigned int i;
 		dma_addr_t dma;
 		void *buf;
 
 		s->buf_len_rx = 2 * max_t(size_t, 16, port->fifosize);
-		buf = dma_alloc_coherent(chan->device->dev, s->buf_len_rx * 2,
+		buf = dma_alloc_coherent(dma_dev, s->buf_len_rx * 2,
 					 &dma, GFP_KERNEL);
 		if (!buf) {
 			dev_warn(port->dev,
-- 
2.43.0

