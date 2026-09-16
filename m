Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1CD3B47CA;
	Wed, 16 Sep 2026 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572201; cv=fail; b=kKXz+PtXKpoKQXv90+Qp/crqBO86+Vu0eNRwweg+DnmMstprkOFxsceGdfNYfyi21h/KOAGbKdreQtv0rL4LdhNSrxcyfR03RhT+vNVLyWr5SyQUfJKZarleOwh4XiFj2cGT68UJ+g1G/wuPoJ4rDlz7v6arua2tMt+4vb7ZfFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572201; c=relaxed/simple;
	bh=Imqza8tpeLn6Q0gWw0mafqcwqzhoUk7bT3Gg+77r8/o=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=uMu6Q1OaPbcR33qSwUKymo3aTBXKaPgGRCOH/Hf5ySRE2PC8GabhepqU2KO5OFdVBQ3WGImAaSCA5QesE7/CKRj5HBpmnuS6QmMJEKjOCmizX/dXjFZ7PbOt2e5Dij8MOL0u6bRdzpgi3xlOjpGnKYoFAj+yjdWI98SqS1ZHV4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fMVkcGY9; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fMVkcGY9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cie4gDmXxKDL4cjPaQaRUgmZJ+7aIoZ+z/qeqhkIGwM4pTQ2lQqP68ErV7ESsPynjNbEgUL5qZ6/k6Qv0xwxSS4tdfA60aL7sOoqMtuMCrwZp5C3RfD+VcvtRmVr3CRy03nO+E4Bik6dhLdlUmWRBqbYg+TyvbHlz5R3txkJGJ88L40XIyqtWVPZY63thHX5SbDA8aOZlDFp2tmdiWYWlcFe7t9WK64DPHxGj88faJI5xz3qaXWB05YApeyWHC/kmXrFr135TaxaPJVoHrMW1zursu7UthlgWh6D2gjX1Gz+NOIvtWlAw1Iu0uTT8E2OMR3BADxMANxU0Ba7GTig8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8z6ZZC/E4sC/KXgamyt4bEQdGc4VZbLvSAiumL+RLLQ=;
 b=TT7ShIUU2jgcCRjCNp0PZPcn13w7gsKzI7guWVIyRphzEYATWqwZYqDrgZ2HRSzOqjzzU8iWWpm8vRncikFDF9+9aFYWYlPjv0Zchz1wYicr85WALQ6DP5q4fTmZlaR9E724hXD/JR1roBL926NJsVXXlNtNHFxT0nesewyg9wUa0LiVWL+YYMQ4eF1f7ATgN/rZmykqaWRPHlk5icTpK+7gZivB+la72BuAlAKBu4jfje1kmoCCTYm3mkvpFXqDEXkfWpSgsTWzgbXeYH+sOp9VIjZO/ue/ZBK3I3XC/nU4ncqzxQWN7z2tG1kmV6cNhvXmR47G0sLgvFlANMEjNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8z6ZZC/E4sC/KXgamyt4bEQdGc4VZbLvSAiumL+RLLQ=;
 b=fMVkcGY9Joo7DH4W4s+6hGnJFHcg41K9wehcM0CIeRaTUTZceenv7kQm0KFxwjumKE2Gm8cIyy8fHCFGT2AdkFxVMp9V0gADC+xT+DkRsR33XbK95S9+2WvLa0GlKLbN3lihGByEvsjkt9m7LmN3LBI/WM4b5SUrjvq2CoApn6DWWsPPJoe668RRGBV9OXI8f73Oo3/VQEhW04tUEUud+uc2shu+0NhlS11tmVgtVd1iQKAiay42nIToWG++jc/+qvGDlu5jNB26CHHe1VkIBSqnJxX4TQoQt6ZohKbeB+J+kM6L2qKAJIGDz5FdCeEeszuFi1Neyk+LuZwuwGKkOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA6PR04MB11912.eurprd04.prod.outlook.com (2603:10a6:102:51a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 15:23:13 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 15:23:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 16 Sep 2026 23:27:30 +0800
Subject: [PATCH] tty: serial: fsl_lpuart: use dmaengine_get_dma_device()
 for DMA mapping
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-lpuart-dma-v1-1-021be5b03e53@nxp.com>
X-B4-Tracking: v=1; b=H4sIAGG1qmoC/yXMTQqAIBBA4avErBPUwLCrRAvNqSb6QzOC6O5ZL
 b/FexcE9IQBquwCjwcFWpcEkWfQDmbpkZFLBsml4looNm3R+J252TCtZWFLK1E4AynYPHZ0frO
 6+R2iHbHd3wPc9wNi4bjsbgAAAA==
X-Change-ID: 20260916-lpuart-dma-9923b7b2e1da
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: Sherry Sun <sherry.sun@nxp.com>, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA6PR04MB11912:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6a64a5-75a8-4eb1-ea49-08df14066c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|376014|366016|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	nmPYvNkm0gqCqP1LWIy7MuA7BcBJlhHdg43BKcCPqBx3n41GsSaNDzwLWaVe98w4hWhEjRtFIZx8fy6K24tzUJAun0NKFBeuroa3eBlTaPqS5zu40zIcrq2WWrg2NvTkZzCP31PjiI2/Mf+g8H/Nd3HKn0hE2jTfDQvU7EiFBqKqvBVzefU1oiP3KVXBXwix3ByFGiavY6FMhLkQQvjY7+VRZ9fe8q47qziHTWOVn15B0+CTn9yCM/LX1m2aIcQ0wm3fBJEHX7biYUE4KXJtXdRloluQgXSBEr2GwDCfMRGq89KA8ZnFkNDro22S8iA4cmdsPgaLbho9qVkyp6U4geKLbF35bPgJjHlMtlNdaY4lATe+Zyku8x07plmR/n4t6iyXVNKr3B7GAEjqRitLFuyTjIbUFHsbimP/EtMuV0nD6ugsmPHwU/qaccXx2FUAZPoWRkUdo1neJQAf/GXjBHHQZd/kZamU2lp9Fn3V6hrSUigzXwy+VoBXAq4EpPnjl2cMKLrnH21AXDFigzWn/nQZDNi1BZ/+aAAEGBrYa+3dc2ZecJhtlWUk+YiDADYGvEcRN7KvWnKaTokiYs1/cOSzEHVB/hvf0/0LlQhm4sAuCq64Ne6wFrPDluhcuHAXM87Y5C/7e3VjDZgxC1Eh87ZWTWRq8Jls7FEu18T2DcE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3ZOVTk2VHY0WndaR3JwbUFkazBlWkZkTEtFT0VpeUxKQ0grbHRrdFB3ME9m?=
 =?utf-8?B?b0dGR1E5UDErZDN2MWYrTnJQaG1lUUxYR1BpaVZ5eWtQZW41MlVyNmVZQ3JG?=
 =?utf-8?B?YVNIYzQxdE1TNkc0cVFkaFR2NkJobjAzTTVkVGhKQWNqSllranY3NkEzdlhu?=
 =?utf-8?B?RTA3YnZKaElvS2tyd2MzUFhiQXZLRWJWS0ZRSzhtTDViZGI1RmdTaTNLZkU5?=
 =?utf-8?B?RHlaWW0yc05DNVduR0g2WXM4dUdrT2hzQUtFWDFqdzRQSy9sQU4xeitRVFRR?=
 =?utf-8?B?SHpZck5TcWRmdDlnYTU4OTZwVEJobVNWWlBpaDBlQXI1QU5uZnJ3ZFN3Tlhl?=
 =?utf-8?B?VG9wTUNHaWZkMC93MUlJSU1pSnY0L05DODBIbnFTMjl4eDJ5UWpYUmRoM2t1?=
 =?utf-8?B?dmREbE5UeFdnZWFwNGtIdW5DdFdmZTZsRzZCbk1NRTJSU1R6Y1czeFE4QW5a?=
 =?utf-8?B?TWJnbHB1UTg5VU04c05rYU84dzNGeUhZb3YyT0prUHZjbGJENU5SZW05MVBY?=
 =?utf-8?B?OUdxQmxaZXRPeWgzWnUxWG9tRGRoT3E2UVAzS1RKZ0tvTU16ZXFBTzI1K2R4?=
 =?utf-8?B?eFhkNThHeDZ5dyszcVdDTDErM2liYWtKVm91K2p3YnNxVnFnM24rRElVVU9j?=
 =?utf-8?B?UjN6WDNpYjFxOHVSNlZhTHV4T1RoMVVZU2w4d0NPd0FYSlZOVjRjbCt2aEpp?=
 =?utf-8?B?ZWpkTVVuT3J2NTVkOTdESi9LeVAyUmJaU2F2TkNEc1crNTNXMGpHVDNPREZm?=
 =?utf-8?B?dTNKbW5MOFdXRFlHdHhBZnV6VzJiN2RzNXJuV2lBZGhzamV0ZjNqVkxwTTZJ?=
 =?utf-8?B?dzFVeGJvN3h3S0dQOFh6ck1hOGIyUWVOam5mQVg4bXJ3QVIyWGo0VDJuYjh0?=
 =?utf-8?B?UWhkLzdGRGlhOXBQOGdzVmVZYSt1M1lOcFRkMEwxVzkwR2piMVN3QUZ6bE9w?=
 =?utf-8?B?bHNjb1lKSzk3a3g5d0VTTnIvM2RWdklSUjE5UldPYVcwdjRibWxsZEVKY3FO?=
 =?utf-8?B?WVcxU3RwQ0t4eEtNZVZpNWtlRTVCbUwzdFNBVXZoL0UzcGNWU2FZdHFla2Js?=
 =?utf-8?B?QWtGU3lNMGxocUVMMmRhQWFKZnEyUEt5WjZYUEJPdGtKZE9Ld1FqcGxDbmVp?=
 =?utf-8?B?U3ZDS2tGdndyMGNUMGVLTjJveEZlOUdHQkpsNUZPcXZXTGxPTHNrdUd6YjVG?=
 =?utf-8?B?c0dydEluN2xuLzFrbXdxbGEwTW8xVnp2MlpIQUJkWUhxcGtyRS85WSs1UDJ4?=
 =?utf-8?B?b0toSGNHL0xEeTRJeGlsbG4zRDQ5QlR1bFVpYlRKNWVSUnkzOXJwME41OTF1?=
 =?utf-8?B?ZXNDRHh6Y1BwQ083QnF1T1lIYUJyeFhIbUhsUUF4bTZMUUtCQm5XTFNDd0Ir?=
 =?utf-8?B?VjVFOUh6TkhwelF5cTVnNUJHemhTc0cwTVhNZ1hpMkhwaFkyLzNaVkhjZWkx?=
 =?utf-8?B?RHIzcnBZTys1M3FEUzRhZmlUSThvcEZkdTJySnJxdFBxR0tVQ2trcXkwZisz?=
 =?utf-8?B?bUJqcnFCVEdmSTBmaTNEL3B0cExid2VQWS9SR1BjODF6UjQzRVVGRU1LVks4?=
 =?utf-8?B?VFdmOHE0emV2YktpU0FnbXRlSDM2N1F5TE43M1F0WWw1NG1DQitTcWdPSVl1?=
 =?utf-8?B?dU5Pb3h4cGRuVmNvcDVVS2xwWDFxYTZzcjgrS0FZaVNaVm81b2Mzd3E0RDIz?=
 =?utf-8?B?ZExzZ05obWhBOVlVVittVmRjd3h6eXh4aUo4M2VHZ1dlOS9SeFJXVXNhWXFr?=
 =?utf-8?B?Zi9pOTViWS9jMWlwK1Nxck1yYXp6SHpZMGxDUWxHMndjQjJjeHhXL1lGMmEr?=
 =?utf-8?B?b3dwSHRocEtTaXVUekpWT0RJYmJFVkVMNkluRkVURkg3YlppQWhDUTRUa0F6?=
 =?utf-8?B?OFB2QUc0cldDYVIrUnNvY1ZScGUyZVJoNHIyRFlTdjdsOUVZTHN3RFQyRUkv?=
 =?utf-8?B?aG9iWWJRVTAwK3d3bjRRSG9EWmJrVEQvamVHRHpYamk2MWhFK05PYkpKdTdz?=
 =?utf-8?B?eEZXMnB3S0hURnQ1MUk5VURSSENTRmUvSHVBT2ZkbWFpeTM5L0NaM3NhMWlB?=
 =?utf-8?B?YVJFQ3RpTzBkWEZydUhEWERJZ1FxcHl2MG5VR2JKMUVWZ0J0aUNIaDRNWTlY?=
 =?utf-8?B?V3F6MGVDWUJtNTF1NGJjZU5mQXBZbjJwVHV1M3dkV1FOd2xjQWN3K2hqeEhU?=
 =?utf-8?B?SzAwZStJREM3Ymp2bXh5aEtKcno0N3N5K3RaM01yVkQ2SUxDdXg4ZCtpL1FG?=
 =?utf-8?B?cjY0NC9iZEhXUjFpR0RDbzFXdFBWZXF6VmxMRlV2WmtNcUJlbytoalE5c3lM?=
 =?utf-8?B?c3JwbFFwTVI4ZzF5RHFSNXh1U2hwdG9lK2M4TDhtSDd5OXpYaWVQOUhtQ0d3?=
 =?utf-8?Q?J86XV+6f8Ec4a13llHIdgK3UmVznor/FtW9xF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6a64a5-75a8-4eb1-ea49-08df14066c6a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:23:13.2383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVrWpsvjoG5NpEUrEEXRS5UV2G2sad+X2eNRs13XQUhZ3N9Tc66LF1DFHhT4M8fKNwbwBnDa/M+/rNh++VbOEIZC975eSYH931qpzXcRR5H2z5SYqN5+Uy3zuU/1Zpsz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11912

From: Peng Fan <peng.fan@nxp.com>

Replace all chan->device->dev references with
dmaengine_get_dma_device(chan) so that DMA mapping goes through the
correct device when the DMA controller has per-channel IOMMU domains
(chan_dma_dev=true). Without this, DMA map/unmap/sync bypasses the
IOMMU context configured by the eDMA driver.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index b7919c05f0fb8..c8575c9652035 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -491,7 +491,7 @@ static void lpuart_dma_tx(struct lpuart_port *sport)
 	sport->dma_tx_nents = kfifo_dma_out_prepare(&tport->xmit_fifo, sgl,
 			ARRAY_SIZE(sport->tx_sgl), sport->dma_tx_bytes);
 
-	ret = dma_map_sg(chan->device->dev, sgl, sport->dma_tx_nents,
+	ret = dma_map_sg(dmaengine_get_dma_device(chan), sgl, sport->dma_tx_nents,
 			 DMA_TO_DEVICE);
 	if (!ret) {
 		dev_err(dev, "DMA mapping error for TX.\n");
@@ -502,7 +502,7 @@ static void lpuart_dma_tx(struct lpuart_port *sport)
 					ret, DMA_MEM_TO_DEV,
 					DMA_PREP_INTERRUPT);
 	if (!sport->dma_tx_desc) {
-		dma_unmap_sg(chan->device->dev, sgl, sport->dma_tx_nents,
+		dma_unmap_sg(dmaengine_get_dma_device(chan), sgl, sport->dma_tx_nents,
 			      DMA_TO_DEVICE);
 		dev_err(dev, "Cannot prepare TX slave DMA!\n");
 		return;
@@ -535,7 +535,7 @@ static void lpuart_dma_tx_complete(void *arg)
 		return;
 	}
 
-	dma_unmap_sg(chan->device->dev, sgl, sport->dma_tx_nents,
+	dma_unmap_sg(dmaengine_get_dma_device(chan), sgl, sport->dma_tx_nents,
 		     DMA_TO_DEVICE);
 
 	uart_xmit_advance(&sport->port, sport->dma_tx_bytes);
@@ -606,7 +606,7 @@ static void lpuart_flush_buffer(struct uart_port *port)
 
 	if (sport->lpuart_dma_tx_use) {
 		if (sport->dma_tx_in_progress) {
-			dma_unmap_sg(chan->device->dev, &sport->tx_sgl[0],
+			dma_unmap_sg(dmaengine_get_dma_device(chan), &sport->tx_sgl[0],
 				sport->dma_tx_nents, DMA_TO_DEVICE);
 			sport->dma_tx_in_progress = false;
 		}
@@ -1176,7 +1176,7 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 	}
 
 	/* CPU claims ownership of RX DMA buffer */
-	dma_sync_sg_for_cpu(chan->device->dev, &sport->rx_sgl, 1,
+	dma_sync_sg_for_cpu(dmaengine_get_dma_device(chan), &sport->rx_sgl, 1,
 			    DMA_FROM_DEVICE);
 
 	/*
@@ -1237,7 +1237,7 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 	sport->last_residue = state.residue;
 
 exit:
-	dma_sync_sg_for_device(chan->device->dev, &sport->rx_sgl, 1,
+	dma_sync_sg_for_device(dmaengine_get_dma_device(chan), &sport->rx_sgl, 1,
 			       DMA_FROM_DEVICE);
 
 	uart_port_unlock_irqrestore(&sport->port, flags);
@@ -1374,7 +1374,7 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 		return -ENOMEM;
 
 	sg_init_one(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
-	nent = dma_map_sg(chan->device->dev, &sport->rx_sgl, 1,
+	nent = dma_map_sg(dmaengine_get_dma_device(chan), &sport->rx_sgl, 1,
 			  DMA_FROM_DEVICE);
 
 	if (!nent) {
@@ -1430,7 +1430,7 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	return 0;
 
 err_unmap_sg:
-	dma_unmap_sg(chan->device->dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
+	dma_unmap_sg(dmaengine_get_dma_device(chan), &sport->rx_sgl, 1, DMA_FROM_DEVICE);
 err_free_buf:
 	kfree(ring->buf);
 	ring->buf = NULL;
@@ -1447,7 +1447,7 @@ static void lpuart_dma_rx_free(struct uart_port *port)
 	if (!sport->dma_idle_int)
 		timer_delete_sync(&sport->lpuart_timer);
 
-	dma_unmap_sg(chan->device->dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
+	dma_unmap_sg(dmaengine_get_dma_device(chan), &sport->rx_sgl, 1, DMA_FROM_DEVICE);
 	kfree(sport->rx_ring.buf);
 	sport->rx_ring.tail = 0;
 	sport->rx_ring.head = 0;

---
base-commit: e6e35979777d646fe3c7c94dca7dd32fb25d45f4
change-id: 20260916-lpuart-dma-9923b7b2e1da

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

