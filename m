Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793803951;
	b=IRwvgp4OZLpgshReid5XindeNFqFgK5+fyZrhW9wp6vkrTOaY0Trfr7C0X8i2WHRvAHI
	 +Iwjjom2tA5b6vOFvwER9yzven+UytrQt9/k7Wz4XDGhQotYaIUyPwXWZ+v6jDd+y1Juz
	 V62qb0WtHJFDql8sKVqTbPFos+taCiAM4oq2VVZUGzXOn73LfFSqbcQKe/ObSdm3bCoe7
	 XoQ9sqqXaPyvNxI1fZuOQi8xN9JUFkxlPXAI0ioJxH6vyL0KR09Ve0caRAAeVRM5U3A52
	 xLRLTQ3dYRii6egI/lnnjSZiR93QocqLzbV6zxeHhhQhAygS/XpGgH93q7ubjB7cDlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803951;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=4AcwAMXC4JkZnjOTA0ZC2IzWjus3qwwfEWc7XxM3Qic=;
	b=zGtNqHPAkgtSfN/IYTGvw9hRTmER+r3RdtX0HgV4WN2emRcg6QDTzIJ2M+y/RV+zfgNY
	 EIYYoLz2WIl8R2N+530I01Z1Zea5Y59IykZEqtBxr8BHvrFhdB6F+Vz7gagqOrLYEYcxG
	 HreAU1X7njyMtUlRx94BqcMS4WgbVOSazZsIAmrkELfG60myz22mXh6IJNWSb5bzodk/w
	 EOj1Xv7NzuiTmQZdn1fxAcLcGcilKQl0gKBb8vTDYaPoTEPC4mRPhBf6XJ/8dlnjkO+s9
	 FnIul5r87f7pveL/9zAiSrLNbujQC0i60s/g6uwYVH3wF3uvV6XaAFEZ7U3BWipdXKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=acPmmUAQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.56
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010056.outbound.protection.outlook.com [52.101.69.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75DC606A326;
	Wed,  4 Nov 2026 14:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A75DC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=acPmmUAQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z77XwkkDM9dHgD9ALhatPwqC3A+dwb6hh6XZHuiFNhQraXsACWsfPD7c7jrfQgha1QNTw7uPYUuS2CoDBLZ2ldNKYxhQ3fnKPmpZKlWMetTTdAMZmCH7MzUucIBPSF5hIKTBBaTBiOPEgGSFXEGZzk87LXRPBNHLxA51DMs0RAo7ddrgRsyKuU40iowg6CEn5mBpGQrzb/HN8z+woibKxkyMNvk2Y3+pPraLC9LqeRji9h2NtGPKbuajy6AU2IUJM6M62UdsbAQGfEEwYz9OOCFiyo+s2BYgIhzpyEOugqEfoEcxmzZkzaK1nwlvwTeM0DMfGXuhiNwlh1uqXF0Hzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AcwAMXC4JkZnjOTA0ZC2IzWjus3qwwfEWc7XxM3Qic=;
 b=UlWhc7T6Bq0Vjh9NS8F2G6Qw17yQ6pHLL/75Py3DmDgTt0hebujR8TvtU71djxEYfYmNB4Br+P7tgWkDg1KTguB6V7xOe6afra8vh2sqLYa/44QkyoVEHFSxaxbXUnxF42ZZE0NefrbjwTmCsexlOkcg1bkU6/DdCB/o4t8yAXAVEhpnPqq61P2SpRiJB/FUvmykVlteEpKCNXZWYUsiG0w7IQaIktdlSWJG414IkW4zYN66pmG1Y7pOGmpGEOwd7U9I3CP0ntnNU2e3WLdOEdOVPwtgtQr6cogAlmxcPJgYnWjGTw9raHRZPHB24sI1Qe9oBGYf614SYdzztpLmuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AcwAMXC4JkZnjOTA0ZC2IzWjus3qwwfEWc7XxM3Qic=;
 b=acPmmUAQNpKycinNbT+BVFDtJqoaZbIwMwnWRpruqj7eCvkGzNuz0yKatK8d5ARCTeYtRedyBh4vDiro3ThpV6gv1hqpLuvv3tPRMP3DRIj37BtoX/7XD3bX9skGiU96xa3t1yB92qJXqkmn4s0bafccMNv9MBvr1pvQEEY3OrrwkhtA8y6510XjX2bR+4sghsG4h4iFEubX7oXHUPiSpF5ikyT16vSM01XVoQvkACmhqeYt6oA1J/CDRYxB7HKuAz7AZdZtqhR5KbyxHsY4dT0kBI0hiHSSVOY+Nriaucj8zi1zQcuMYQSpYTS41j9R3NkXrk1tBtLZDWqzohAeQw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 14:52:27 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 14:52:27 +0000
From: Frank.Li@oss.nxp.com
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	linux-serial@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Cc: imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 2/2] tty: serial: 8250: replace chan->device->dev with dmaengine_get_provider_device()
Date: Wed,  4 Nov 2026 09:52:07 -0500
Message-ID: <20261104145211.3209669-2-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104145211.3209669-1-Frank.Li@oss.nxp.com>
References: <20261104145211.3209669-1-Frank.Li@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::24) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PR04MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 19dce114-aeef-480f-9084-08df3a833ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|376014|1800799024|18002099003|22082099003|10067099003|56012099006|11063799006|261102123227099003|261028144727099003|261022105027099003|261026140227099003|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	rPI4fDhUoSEKpOp+SDkvAJ6EV8nrp56Yp76WsVbg8WBP5iVm4iSf4Lp0R72lXdWAhcHlLJFtYPGwssfX4+OPCBS16ch0eh/eyv+OV6VvFP7Z52L3AKUpnWurAIEXlYLIJv+wrvv1SyQ6owEABNg/qLcSSwAWwZD00hblnBz8XOIRT/rrKlXGi2xlaZSXbHmH47jHDSqKIDpHBEw7MQV/2Dhym5g7dlV7hNUfl0awkVDRuuJUFam7JVEudQT6cVUuOBIhypDWHM0X7Z62ekTgbw6vjV2y09/gSd5MoGVvlagHqPGmHEERVDLSRl5CI9HRItnRC3xl5J6KFopHfhmAOP0G+CnYeqtOwyYpL539Yxnje2EFIL2Iv6dzVDiDTIL2ZOl9ooQXC7j6eSGe13z4JtCGnJkMqCqswaArHD9s9Glf+ADNm/RSKCWgXPTrQTI81oF0W7wIW9b5G9GS/PeXNWhuijPWAyRtoGY5SPPGZ0TcdhNGmlnLsb+YKBoPtalvisRRLa/AAX+NSCUE8gGuHROue6gEV8hIHTx3UKHsrkgKqHzJQTIQNyR7Y9G1YdaPAgSX9AjVjRLDJDCr+whDAC99IJWlBRqeICoKByIL5PNmqVqdMQNfgX6EB3BIOTfnmvCrbOZTM/M0ZVFszTrrMp14VVMjbH32Rug8ClgxU8o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261022105027099003)(261026140227099003)(261021121427099003)(261021123027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6E2QUCKCNFXEr0nxPIqjS2jiG+zPazviKm7y5lALU+92x3eaAu6J5pGLrb3J?=
 =?us-ascii?Q?F93QH11pqy4j67BAQzdVJSeUPSWwQ/HEZMifSv1bigKTWKBkZwPCwCKkXDRY?=
 =?us-ascii?Q?zE/5R+Gam1vflBTwappcGPAs8C6xBYwGcypjN9otcYdnNBCDbgx4p8k1+CQE?=
 =?us-ascii?Q?LIuAmrIwumJgqJ0LMek8YQxMrDLwVBv8CpO9zZC6QPZs9JJZpW8QtOj6BsN5?=
 =?us-ascii?Q?mHMFRKgzn2UZbj7h0Pfo9lqMTYnKIrBtu83vpFhNuBgMpKWn/fTtnkBQVzOI?=
 =?us-ascii?Q?QOUxEUtsTUVfglpvu8lHnKHaYvuu/TiO+RyKs/Qu+DKrmG8ZvI2nknSxlSQH?=
 =?us-ascii?Q?g5/0ZzCIgbMtZetCQIw9x1EmSjxaEKQ2PFQ3WGME5zITCIyMZFKIHbAGWUvh?=
 =?us-ascii?Q?cplZrcbmKTPjyIxb+L4jV3BLHXSTA0qsNsWLTISjO3aTBdTJ6lDcHCTMUYoa?=
 =?us-ascii?Q?aHWpWnSCQw78xBk9KmmmQYgmJjJtDA4G19eIUsGwvohy4N8Hx4mvGsDXHG5N?=
 =?us-ascii?Q?g4uW7H2F/CZYxm4tmCPq2gWOmrU0YwwQxXmxJ8XHMXWb7LuEanPBadW1sIxc?=
 =?us-ascii?Q?CbdeIaogzJf3OV8pB9h8ER4wcp5SfvKCBNmP+/mE342LFQGINq8td4RHhqpu?=
 =?us-ascii?Q?CKmavqp3KrsiR3OvZfMaGs9yOytZy1ntYFv8yKalynLsdVVVrme+Gr9HT9nl?=
 =?us-ascii?Q?aJrhxKfYu9dNpftR69wRuO+IiPxFYPKuG9IhZHdRIfTSLpWa3OjyhdeUIODJ?=
 =?us-ascii?Q?bvLLPatNmUcLY6SdViJAfPRNNQAW1EpG4U44ZnR3ZXDwBVHgemnmNeGIjCX7?=
 =?us-ascii?Q?pzLEfTooh7mlC+K5CHzJWXunFBl+gnlt0uODv6fzU411pjg9HiSQ53L9j1cy?=
 =?us-ascii?Q?3l3lkWj60G7KQijgOSUVg/8FYOgmbNgZ0+GPeYQK9eiC1X28BeIvN/pt6KQJ?=
 =?us-ascii?Q?BqhAxBYci5QSARl2fcRLQm7b2gcJNYjQ5UAbj4pTjHBTDVYNe1Q1gIaEGtI8?=
 =?us-ascii?Q?J/zbCXpE7rJc1E6yrChhoCGGJkmPVMIh3IDP1Zek/HiF0ChT8fMJeAb3SeD1?=
 =?us-ascii?Q?X6AJ5n5lRRZtKQrnx9C3vajvPCL74G5uZpRPVMxVgaKfWpeh3L4A8rNpHSi1?=
 =?us-ascii?Q?f2ig8/ZLIHQmULFQlgxDr5n2qMH3gl6aZbOy7RaaahrTJnYGMN0wvfWL8MFM?=
 =?us-ascii?Q?Mw6y/qTGMlrGcS0Iyz66te+9Ivb73XcmwD2yB7RnJ2fJsyFG/R3q7SaPu6l7?=
 =?us-ascii?Q?hycAyFdPTeCgTYIYccWWVWzTh01a3rC+TbrXcIfdXt4EZiPBOtGlAl7aWnUA?=
 =?us-ascii?Q?88o5cUfcFoVzoZWCZ3RF1Ai/gpwkPeRgKHVXSFMxLM9ObMahFwNhp0sr9cL6?=
 =?us-ascii?Q?w1utcdKd7tvc3jM8pRGoBoeC+kJSUSN+iAk4VmkBIw+YB1v6H+qOSRSkbQJ9?=
 =?us-ascii?Q?7tfHjFAav48Dli28A/diFB4NK5VFqo6wQ5RC/+kXnM1LO/tY6VHpyZSmUF2v?=
 =?us-ascii?Q?3FDrgXjiHL9LBb6+Jue8n1lzKMS7agWvjWQjjQhNIAS3bePSsQdtgXmPeNww?=
 =?us-ascii?Q?yDqWHKq72jVxAcUzIucQQZo3/0Q1UCfRzM1Dehckb3E5vJAFdWkCE0FYyQKX?=
 =?us-ascii?Q?E5AVievyZmgpXDRfe0jYdyKonwwI8L9TFIOdp3y6TalAW0LXvZykuu5RDkET?=
 =?us-ascii?Q?3Oi+c5qsKE2HzRSUqJqjkQlwpjjBpbSfopsL7kznCME3UaGnbY/8t3fAKbeN?=
 =?us-ascii?Q?f3OvzzLD7L+bjbQUUNri3SjzNkxaHSG0sUd2BVX75pMTs/looJKP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19dce114-aeef-480f-9084-08df3a833ec1
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 14:52:27.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DNJV6TTp3Sq/eI1MG4VlJKKnIhUSyEzMnwh45q18NT5eWQbEt2XGmns/YUnmryHKtN07TM/OXVVNkr04hC/uKm0lIchxYH+xX8oz7i/oHflxdrUt8cpwvf3xblwPPLe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8505

From: Frank Li <Frank.Li@nxp.com>

Use the dmaengine_get_provider_device() API instead of directly
accessing chan->device->dev to get the DMA provider device.

No functional change. Prepare make to struct dma_device private to the DMA
engine.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- split pch_uart.c to new patch and keep only 8250*
- andy's add new API suggest, defer to next release.
---
 drivers/tty/serial/8250/8250_dw.c   | 2 +-
 drivers/tty/serial/8250/8250_lpss.c | 2 +-
 drivers/tty/serial/8250/8250_mid.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index eca02e8bd6d13..9adaf5b5fbd56 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -530,7 +530,7 @@ static bool dw8250_fallback_dma_filter(struct dma_chan *chan, void *param)
 
 static bool dw8250_idma_filter(struct dma_chan *chan, void *param)
 {
-	return param == chan->device->dev;
+	return param == dmaengine_get_provider_device(chan);
 }
 
 static void dw8250_setup_dma_filter(struct uart_port *p, struct dw8250_data *data)
diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 7e88f2b793b5a..eed37e8b3e831 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -269,7 +269,7 @@ static bool lpss8250_dma_filter(struct dma_chan *chan, void *param)
 {
 	struct dw_dma_slave *dws = param;
 
-	if (dws->dma_dev != chan->device->dev)
+	if (dws->dma_dev != dmaengine_get_provider_device(chan))
 		return false;
 
 	chan->private = dws;
diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 44b43163df511..dfd2460983fab 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -252,7 +252,7 @@ static bool mid8250_dma_filter(struct dma_chan *chan, void *param)
 {
 	struct hsu_dma_slave *s = param;
 
-	if (s->dma_dev != chan->device->dev || s->chan_id != chan->chan_id)
+	if (s->dma_dev != dmaengine_get_provider_device(chan) || s->chan_id != chan->chan_id)
 		return false;
 
 	chan->private = s;
-- 
2.43.0

