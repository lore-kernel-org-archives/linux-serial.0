Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012045.outbound.protection.outlook.com [52.101.66.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B408F49;
	Tue, 23 Sep 2025 03:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758597456; cv=fail; b=Hea5hSwNBHg4uXVp/u9tPJq+6cxBj0YIA8Sj2gbhEPL2v21QQjT4IMiXRX7LW9HHGxfIXixFPWVttJcW0oCJRc68n9o2sVJ7ZLnPiIiZCq2z2wPUgtOdX3ctPnWMC1j7o3eHTcnpNtbRoCv1mARWp0wmWDLGH31fUXJisjS9W/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758597456; c=relaxed/simple;
	bh=zr5q1RSfeGwUOoeOJZwEP5Yycr/etkYmkVz5lCba534=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RUUuXVzThCNodXQ6kTjuFVl+45RGE+4dAzfJ29OYwrhKUw12TcRbRe3z/ovtUjafmNoUg/aEwrMUcIrKWTjlvMdDpI4KUwustKkUXB1yCa0iSTa1UNO/la5Y1awHCNifauUnbNr/hO+rCVlISkG6Cr5VTqwmTV8adubfSD5hbQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d1dFp3iL; arc=fail smtp.client-ip=52.101.66.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d1dFp3iL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwtNypUSgekEdG/X2vusDifxenigXvQkG1mAFyGB34mbtclDtI+S3GpIq1x5WJg/SBUIT+EAhoAdVA/+4XFRoIbftsKedyH7ALewBas5ftzdRbQYVb9ksYZ7hsTLaF9sjmxmoV4Hyp44nRSIP7CU3DFl8JypPiw7nK1emcoKXm0hsUJsse9uUFlx9eVZMnymi+wJa6PUjSzg+Z4RzWkhaZ0K/xU2df5OzHOUtkIiBw7FDNQJCcsCEQlPTvmMBfJSpthlCWGp6thH15ugMgYsoCigEcdx212DIwMld045hXJma+dSpiLYWUMgGwjGnGRi/wgXC31va7MOGrpoQmhyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neUYcerCtenUMo0NXdd1Qh9ZBU/xQlXN+rToFyCSsOw=;
 b=bDzVPA+imDKggoHQIFtNaKernE+GVSd3WXVqYLKhi3mPryRMI6wrJfPsDRvfPEJL5NojPOULjTpCBs+vnN5FqMIW7YaJkWDRUes0qV0R7UTTLEFpJIW0ERX8+LDOvuc7EVBVIL0fndXeIMyhVZyfhXQyiDpQiorSg/b6KQ/a72suCLgczisCqEbjrEb8z+aGdJvy37UVBkd3YtDJ3ICRCZbcIeCnUOVT6P6zVtnRwzIZXFC1LCfLIptYBYMuTeDZKP8KKexdAtgnBu03c885gjEjuymY29yPoiK7l9HqinUN9FCeXkGXNlYsptUoWRGGdR/uCxpJPM8ytEoEBnirTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neUYcerCtenUMo0NXdd1Qh9ZBU/xQlXN+rToFyCSsOw=;
 b=d1dFp3iLAnpQ2O86yxIImBi9rWx/3lGqwp9AVv5qJOdy6lExfb77ToOP9a/+EFASoUKZidJvTe8F9FqzJ/B1VLgmyknYHJ8OgMdxwYDSPRIquFPo0iwQPo6I2kQ6SruikKMh1uPn9XOpmQWJq3daPV2L5CdI9x0+FjkojVb1UWG1W7AZg2xwUQfcnZviWus84TvmliMlvPot6xpzrAhoNI1g8rJf1AQkZyhR+my4n57oOgKuHllKMb8OH4h5CCIR39WYl2UgSEgYB1J2nIojOFg2tdaKu61mQweewfuspY4SF1Z4Cf3k6NNL9HfYzDbOwPgHQ6O0zerI89AUBdfmpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by DU7PR04MB11137.eurprd04.prod.outlook.com (2603:10a6:10:5b1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 03:17:29 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 03:17:28 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	shenwei.wang@nxp.com
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 0/2] tty: serial: imx: improve the imx uart wakeup function
Date: Tue, 23 Sep 2025 11:16:11 +0800
Message-Id: <20250923031613.2448073-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::7) To DB9PR04MB8429.eurprd04.prod.outlook.com
 (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|DU7PR04MB11137:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d81a6f-b4cc-4631-1435-08ddfa4fb9ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ol0Lb9RLxFIOc74X6l3KhzggSVgw8gDti6MYW/5wc7oqTTK39GPkYvHTVeZT?=
 =?us-ascii?Q?p5j61rCklX14tt0cRZ20mA1L6nziZXlDo38PXiP9ZyGtESFHx/sLw/q8pwM7?=
 =?us-ascii?Q?8jia2Hf6TB67imBvgJwsGrs7wDcDL/0af483Y7QoH657Kp7pRZH362LhRLlc?=
 =?us-ascii?Q?1b0L2Y0e3vMMlBwhLNfp9FojG3VH8bAjpIbi4auNdNA/LEtqVcWf1wzVLW9p?=
 =?us-ascii?Q?VV2Z1pOUZiw6IjDb7rqAg0TpGDGEMffeDLd4A6O0g2s0M1f4hGBLE/+1MRZG?=
 =?us-ascii?Q?YlloIGpUrywhkMkLdvWqvU68qSfJFIuXNbMB3YYhRHvLUZaTaBtcBBz2N3iX?=
 =?us-ascii?Q?qj8ILmAqm4ZeIrXWaXCuEZJukOuj/pDpTXXpIgsLbVZ4ktj2wNzs8JLFuNzT?=
 =?us-ascii?Q?U+FQnSFHNtEMHh/2kGVTKUBnPNkrVrOPDlB8hg3UBK1/xKmt0dZFw3XXoqtc?=
 =?us-ascii?Q?VOfI50TyPUSfoY5K3QqIdtcUG6hE8S+R83YdAIqNtq6i4E24DGhA8yehc3en?=
 =?us-ascii?Q?d+X2ZDG6u735v1khG36Ocov4znIaYrCFtnVgKI67TswEQp4ZvRu4WKerLFjH?=
 =?us-ascii?Q?q61Peg53QZJSKV3Ra913vsIkYqPZTe/FsDwCp0rO6RIK9Maidbruj8CF929p?=
 =?us-ascii?Q?Q3WZP9gq6MBsnLGMKlGZMzbNEErJaachrSDHNgUEaH05XiN8esTfSunSyDVP?=
 =?us-ascii?Q?sJD6whmB8g4UoUYLKcl7sOUbhQQ5nH+inQ8+4JpDqowdwc4Bmk2S3+ULuHQT?=
 =?us-ascii?Q?ZOVeFVRKsxLBiBMmSQ80BiBOlPSH8Alw3qqdMxdE5x9xuOdEpGHG7h32L7A6?=
 =?us-ascii?Q?cPuBgJHMxyCUCEQ0CqigtyuipqSbbyRE5sZ5v3X/MxHSC+25lPm06BHrNHF5?=
 =?us-ascii?Q?HrEhGdf/QJGVAnHey0azLu7WAjme2aBZedBW1qVzxt80KzhyUFR373m+hbqs?=
 =?us-ascii?Q?NOsaFm8mFd2ySrnr1UlWxbsGCN7tL01uNKnKp17y5/6JVeJCMwOYEZSbot2D?=
 =?us-ascii?Q?O5qvylngooS1K9c478P/AWzS6+Q3h64LOkmViCChCMlQDN+2wttKQqRQk1sl?=
 =?us-ascii?Q?SSv8JyTgxQ56hMmKLA1cNpsS/nX/h2l+ftmNkZA2i3ps7QNHuospTqtGvJvr?=
 =?us-ascii?Q?hXaVkEY/dZbNlGnv9c51fVbCMJ9YGi80TlaS3rKJXxYUmv7m14OJeloakyhy?=
 =?us-ascii?Q?gLYiZkRxmE/SpR1LeW7uTe5VvbREFKIvd8kiNepuER+WnAuuHfndJs1TNB+p?=
 =?us-ascii?Q?dNR1NROYWgf9LyAXUUBApaFL1tkz9Vm/yu+0U2CJIaI6sfVZj08Tu3Muoe3l?=
 =?us-ascii?Q?0NrA0dM0/j97C8+dUaqevoBhI+TI4eNKR7n2W5r8LnYzllEaqf4dhHno0rJy?=
 =?us-ascii?Q?c2xjPsGkwFyNc0vNXB7p9iJy92iXf/Qq83STS9eVYi56Vxo16K4aq+PR5z8v?=
 =?us-ascii?Q?pKXkGpnhwKQ6ymxH8ff5aDSnFK03AH2sSULQIy4L2ELJziXSuujrhA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?od5jkDtSxYE9bDkGSdD1ydxN+zpkpdkygq9LJnpXOoRw0FmVea1PfVOjnHtc?=
 =?us-ascii?Q?isob/urVvdeuwgoTZjrww/worNI3ajMbc3Y8m01rsalwKZGUgvINIlnDi1eU?=
 =?us-ascii?Q?K8fHc3y2vCI0hnrgnNgjeOXqA/xo4lARkxoIUPznxjjEiJTInUEsZa08KeVg?=
 =?us-ascii?Q?2ZhurCeEDB5vI39QxqfAQKTTYpaG08tE/9f1i/R+lA0xoIEsFifCE/3aTqxL?=
 =?us-ascii?Q?uZw4cY75nQAk6+/idHU8V41xzZWgQtt7qfCvT0J7kcFhRGomMZF1gYOoGSmm?=
 =?us-ascii?Q?GSbdWkDtre10/ThKJ588hBa9L8+mgcq8scAduc5GqgENuTkZJcfMIFNvSaXg?=
 =?us-ascii?Q?Bp4Mk/YOpbXHG2vga7fIHtAHc/uvu4JputfxUWfqBcFFuxnl6NI45mhHDXbm?=
 =?us-ascii?Q?wbDcQmeuBrGh4Yt0LDeadQq3rylN18JqJv8yJQeOcO4rbVv3k1vy8CRyfm0c?=
 =?us-ascii?Q?WL9Qu8/hYExiH7AHoPp+ypFUULAOIuX1uJEGTDQHObMHiguxnXHhthIc1cMO?=
 =?us-ascii?Q?8MjQjRYsqTGyYprC7QH03n63tCfkp7XImPK0FbQt0H6XjXMuL+tfrs3rQDxG?=
 =?us-ascii?Q?Y8rSae2OwvCGXqALgY2iFlTKyMlbBjIIJNC1RSAlog81TeMJZ68cp9rpZuXF?=
 =?us-ascii?Q?tmFeFAh+nJi/pfxEULK1dlHq9aGEn9xDryZtDnnuLSbbYzcpaOWyzwXwuojA?=
 =?us-ascii?Q?ufKzh8fgQ4SMuM5YDyRzKQE13mF6EH2YIQwDBTXVIkiHRfRtBuz1CPX9Jfi3?=
 =?us-ascii?Q?rL6Nwab4PU4AMRbXbCz6MPF4XpC4IXT0VUD91I4xD/ojV90cjMwYjw+9e4KP?=
 =?us-ascii?Q?RcXnRYBIbbdsSANlCKTv7aQHP/nYEz/imjsOtxuPd2YAfbLCVDnSAixIwOo/?=
 =?us-ascii?Q?iXUd84E1AiwtGn66bZN3A+1+jmLY4cbbh/ANVEAtXRWOBCx1NISSsgReUsOI?=
 =?us-ascii?Q?OAEHMM1l95hEKnrRSnap//8BZEUz+CT/xGI4sdhv2EqMAanUQUOcYAqcYj21?=
 =?us-ascii?Q?WKGyf9aSjDvwjegt1QPxp9L8ez9lrZA3YchN6smblrvSPcCFtWj6njUz8ndi?=
 =?us-ascii?Q?vCdIYZarbdLMAgZVYlvlpt360dCkjN9rU9UM2zBSWaAGBDObL4SGQpvzhoEm?=
 =?us-ascii?Q?8F+bBWZvOFK97UynDcfr69G01YZPOncY10CftvF2swoOv54GZVNvvdf5zDM/?=
 =?us-ascii?Q?okFfU/Hma8M3NApCPZ5rL7T8P3aIcS2WM6xaxjo5LAzM9TfO6r8PQQjD1uUT?=
 =?us-ascii?Q?u1UYLI1NPpz0XrD7jSW5qVSvAMe82T1AAl/cZGmBCGBaP/sW8CxqbOaLN1Fv?=
 =?us-ascii?Q?s/dIDFse49RlH36TU+JGquzu3+8he6KlNRa5HS7cP8b5M8Vku4PpHXZScFbJ?=
 =?us-ascii?Q?7I4xzzsB2wKJSTESOS855bCOIMwOXJPuB5frffwApbtRR/jDy6x7SV0rR8gW?=
 =?us-ascii?Q?5h1FiACpBAWAk1iURxVS5MdVIEkOz7D2XF3TRA/UhfrGMy3FrWWQs6jHojeD?=
 =?us-ascii?Q?Vj9/rg0ZCxsVC38Jyy1bmds7TT/Zt/6KljQpPb+gy3ezleRZ0ek+lKQPJPIa?=
 =?us-ascii?Q?wO1Uo/IvzXx1Yr87PlVbCjv6lmTqYiIunOw1bBUb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d81a6f-b4cc-4631-1435-08ddfa4fb9ec
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 03:17:28.8995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqhPi6MGWdWNbyoz05qyG+Puwp8DMdUkeksoYQmX49xVJ25C79QbjmpUDMrT3FMtVjDmcZXN9MKgk3LFao/JYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11137

Make some improvements for imx uart wakeup function. The first patch adds
device_may_wakeup() check before configuring the wake related registers.
The second patch adds the wakeup event reporting support for imx uart.

Sherry Sun (2):
  tty: serial: imx: Only configure the wake register when device is set
    as wakeup source
  tty: serial: imx: Add missing wakeup event reporting

 drivers/tty/serial/imx.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

-- 
2.34.1

