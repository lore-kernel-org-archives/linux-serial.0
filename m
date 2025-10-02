Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1476C262815;
	Thu,  2 Oct 2025 04:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759380891; cv=fail; b=bwLZeeGdvpdbtAe2SHafPsT/MHXjMMg1PSGQK77T3gBoWgiZ45SH2b6hJaAWbhDWfdwLRnbc/K06jkml/dwPC4L10ZzQxlhwXsl8BIMv78OSVZwGPnLeGWHvSf/7BVlQrdkdQOE7ConncIkuQl3hekfMu7ncBII7vWw3uV9MyDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759380891; c=relaxed/simple;
	bh=Sun1dDOoGwlgMOOwBQmHzsOOMVAV6GKvG4xoDIM+vNg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UdlEPgBL4U0RJFb+s77mmz7E/D2ddOdIKnKlaZFZtRO7Sp98IzrHhqv8lq4gN43FQouXAS/Rwu2S2tohORpGTcOi4FDy9PQ8xM/2AKUKRN+az+tEyqAXUOKkeKc9r1Zh7CbEFJC1lXe5Xhw/6kxb/4BleGuDnk6heB6xUcE7Jts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cVXvsUIT; arc=fail smtp.client-ip=52.101.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cVXvsUIT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYONoswYGBA/osOsdvAeJz8RVfdvs9Ze+Ue3DDHSLMKGgzzF/dPhpHVQiNR6HB5tG4FkhTXMleT6NxoioAT5HLL9h+i/IpF9yWZXKLZZxgpLyBzcZ0esMQptAVFrlgTnsp1eJhibacK1nGjNd/z7gKgjhgJ1wxDLYNCS0DlO0TzjT9V/Mtu/ZH0LBXWobDKTRvyBZGu8odX/wB3oQ7NjrwziQI0yK7emcQ0wnW2S02sKrKisnGqrygbe3B3K/slMBfPerjciF0lm1hRrgHfk6bGr4EgAl8wl9MLQv/eleMgc4e0vQ1S6etXrJajk+YxHy5k2ceWhf9CCUrg8BFQXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdiqFgmMP3h+c48nOgEKXm0YVuRIbkrTQQxCeHBOtJg=;
 b=Ce1IBbmemNxlZfaOvmsZ0EJ7fFRiQlNjQJKxVZ+TNqdoKTFbIb2f/MN1eD3Fe5hdDOBwZ31qP4gr6CgbiMWNjU2K3O1gjFrNg6/naa6QeUlyJCfOk1tvfAX4VXDQ3bdLpFBfAwFOmm4Y3TIV7NTQHX1gRR1sCz5vloWW0NnL+OuXsOzsqnL7sPyJjNvUGObLEoDy6bwZvrAPWkACfp41mIA4MCO8lP2+iB69KuE3QSEUtHgQWlXmxL66mPVtwPq5YU72ruNDQqVCdqQF4h2qFecHlRsmXEjnAdZj6NkIiqTg/P1s7O2szqkh2IqLXYD/mQG+9UDxiW6Svwxln27RjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdiqFgmMP3h+c48nOgEKXm0YVuRIbkrTQQxCeHBOtJg=;
 b=cVXvsUITLhPM+e0Op2RN/ZaJMtUDBFN7hgdt52hU+qelEa5gqWbK9hz2AE/BN0rvLExI6CkUyqqwGUPqdZ7IyfAkPGWiL3zXRaxEWOkVoYBgdpCn22Q6GNZCuybMNrLrYDNcz0VNeYdQMJMqZrkPbcwJICGQXx8jjVJgjoyhWJUAbCgL+avmCYZ9Uzg9RFIyJr6ueo9kcAHwA76IHnvf2T8jRiFmE0heHhTNk/gcLRTI2yJLB2dKBcSPmfd7ixJE3Jyj1Fz9bdSn/DyDW1+ITKMsgzrjosotFmNIs1Y+knRi68zWGU//Arbl2aB/2iBvqjA2COWfpAxTQ/26/gsieQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AS8PR04MB8818.eurprd04.prod.outlook.com (2603:10a6:20b:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Thu, 2 Oct
 2025 04:54:41 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.9182.015; Thu, 2 Oct 2025
 04:54:41 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	shenwei.wang@nxp.com,
	peng.fan@nxp.com,
	frank.li@nxp.com
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH V4 0/2] tty: serial: imx: improve the imx uart wakeup function
Date: Thu,  2 Oct 2025 12:52:57 +0800
Message-Id: <20251002045259.2725461-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To DB9PR04MB8429.eurprd04.prod.outlook.com
 (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|AS8PR04MB8818:EE_
X-MS-Office365-Filtering-Correlation-Id: f75de7ed-1bdf-43e2-95f0-08de016fcc13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BCiZtAARtXcKQtxPzJIFh/XcSYeNGpdN6iyf5uBG1aBfx712zw4oFWjr49bB?=
 =?us-ascii?Q?3Q3ihGR4mNtyWhPFkG5lyxfYfmzEFd2vp1DAPsshtd2HwYuqh4cryXCQ4Zua?=
 =?us-ascii?Q?xtNgFePCPVCWwV13R82Wo1vwGcixIk9c5sf6og2pQY2Cvw+JLI3Lg4Yc8MXd?=
 =?us-ascii?Q?uthlZ1VfFJXCC82hm5dlob8cqk6uwwBZviHruLVJfrOZCcV795YL5rWkccil?=
 =?us-ascii?Q?T+QCIVBzUY5BHxGwjmLj8G1ibkBUsWx1LMddZcZIqIm4bsZ2m6taT301pHwS?=
 =?us-ascii?Q?bscGiko+JcwdVgxX/SecZNrT0D8hEb2H7N5fI5Xa6Svbz3aaEYv68Btpz6fi?=
 =?us-ascii?Q?c+xLz2XSnphpkwqY/iQ7fhLtzaAZqj+eviqS6VLlgZzBejUs9tVJO5nYH9gx?=
 =?us-ascii?Q?HF0/b9rrBWfz+zt1wVgmo7nW7cvOab3j4Y2E33YKIlrBS2Hp8jixaN6k6u7c?=
 =?us-ascii?Q?dxMht3uB2rb1b7VmbFwyf69+78eYj99l1vDKieutr1gX6iwSL56JziFTcrnA?=
 =?us-ascii?Q?IFfeXEO0J/PlnjbjRDOuoVPaPPAcA3tKQojUpqKaGVUYyIGaIEiD/C9nSAas?=
 =?us-ascii?Q?4BxrLnV2gOuokqYjb1MtFIvIthygZ9e+yvE8Gqo+QelU5RdbOXGSV7gpTRGh?=
 =?us-ascii?Q?o0Nsa7OxPJEf2FPrlzv/+PfHwGUbrqN9jujpmBEGXttJ5OQ29wNlO5EVd9UD?=
 =?us-ascii?Q?P33NqQb4fnYFmGh+cxd2F95XcN1MM6ORW4lCSg7BXbtuW4zYm9getoW2kkAK?=
 =?us-ascii?Q?8QZ245aKEEg+09VOpClE6r/6W+TabrDBVswO4BP0ewKoLbwMt9TRzRlt1i02?=
 =?us-ascii?Q?ThN7A5OSpPTDPJIh/d6Q947wWfG867P8Hj5C5PdHIUJUtLVHUZ8pATF+OgBI?=
 =?us-ascii?Q?Af27ld8d8uQbQ4u0PT8Ga8pmmimlvxfbzenstd5Glol7oikmB0Y1bgNnZGmg?=
 =?us-ascii?Q?VqnA+dfpcCHlT1JFl7CCZ1pb4r2UQUDIaMXm6c7ttOwXfL9qJQK/utq0nHq2?=
 =?us-ascii?Q?AZg+taBtwaEkGeggg+D+lJ8ejxrxuXmaPHWm62qjCVDi2qYpWAgUaK8vV/ZB?=
 =?us-ascii?Q?62aVSBaeZOMfXuTcdssVWwTL3dZ+61z6V5uk6pYKxyRq8xeja8uFI3Nz0T1t?=
 =?us-ascii?Q?glY1OGoJpiCGqNHhAesPVamEmSQElAA9VbPOgP6L4fcbLS8dwRrT+t+O4lPQ?=
 =?us-ascii?Q?guYoGPZkUMDG0COpo052NSYVuNw2YnId5syp7gGBQNl4vX6tAeAIFHNea0T2?=
 =?us-ascii?Q?SA97cMZijK5SncI3smaJznJzD4AxNyfIatuTzFeppMUtmqH39MaR68oU2NmN?=
 =?us-ascii?Q?/v4J6r7YHwu51hRJeS2QAtvpA4syPGLZ0IT2vPe+21zl2zHBbOiRPUD/cNgp?=
 =?us-ascii?Q?xfDqqiVN2dajneF4N8S56TSTDRarZA3aYSohielwnGZwB+9y7vOkQBJwnYqW?=
 =?us-ascii?Q?wk7NT3Vk4zYqRtXk5WaRVpd5g0m+aCcVkqobcL7Kden/MNX3XqTGhqn+RcAZ?=
 =?us-ascii?Q?cmFau6gWk5tTYojzN/UYpELVBsxbc521zCOJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c7WGgKwpf34p7cE85o8omE6cXs0ZKbygoam/O8AiR+lNX1vbYZBJKxNAN7nk?=
 =?us-ascii?Q?eYjelaqS0VnAZoc3UIHToCkGfzt9++7YB3xIDNgsDGJZgNrWepj6QV4aykWO?=
 =?us-ascii?Q?t+NjCuvbz8otn5cz9xIu9cmmmXIWiCvYzsy8XUMqAGDyeDUSgTHO+Wg7L4Ju?=
 =?us-ascii?Q?dMZOR3He4K5G5dTaScfBrqhTT+qy/7rQ0CDzgNLemUIB5HpoIC47nCHfGtiC?=
 =?us-ascii?Q?AOyWk9CZH4QNex1YInVjinhW5C1HmaAXhTS6G6DMhqs4Nis+icIVOcaRsLDH?=
 =?us-ascii?Q?275sY7kI5wKH4j1vsnKj+3I6M+nqTcv2tMMGprEfDTRCaB6aTytR4p1tL3d7?=
 =?us-ascii?Q?z/5qkaFIbsQ5g9f0UMpejDBQDhccieJ+B2cFTmeQaomiD8kjl5kFDyHJ/dOh?=
 =?us-ascii?Q?4csqobcP3gTyTscdUbei06IZOLGYkmncSM41U87vJwi0JaRVmOHfQ0hSQZi4?=
 =?us-ascii?Q?A/IQqmjmUHuoWd80sYgqK5zT/flT6A7QX06lz/KPc++CSdUCj0bCST0erk31?=
 =?us-ascii?Q?FIlja0QmUth5yWzZfuO+1co020iATcWeGau4rJJ3XXDPiIGltKTlVGx+U4ZS?=
 =?us-ascii?Q?rkPn1YagfakwIX/nrGWiAnTYcduWC++xqs2NbRXIp0/QZFQ7NLcA1PlIN9dz?=
 =?us-ascii?Q?C6Jdb5JdOOZpcwuUMzPFrTt58UENhTvoG9h0gDWtvqFowt+Mqyblvp/wfVoZ?=
 =?us-ascii?Q?L6Ml7sUvfHPEjlrDo2QVfPv2mJkGCIAdcNTUUKw6ppgAfQVI1ByU3iAlVIeh?=
 =?us-ascii?Q?Mm/694wWk6gfUQB0Uak7C7cL8r6kYglAmzGFRcou4SvRHlC2Ozp2diLYWxA8?=
 =?us-ascii?Q?UbChpeITAbLCxvhdrQC+P9Echi63OqH228Dd2k6w5q/sTZB9By72QWNYlTMq?=
 =?us-ascii?Q?Qw3UBXB9Vmfvi7IlV2shOzfpusjykwn4GGtaIdbLAttwbu76oJc9F5npuAWc?=
 =?us-ascii?Q?gG4dUSWPGQoH7h7wzs9HnVOOS+Ml9RVsNPyUvrxkgLzHl/HQgHW6ouGALCwY?=
 =?us-ascii?Q?Qx7P2a8cqwtbXQftKq4QPiyQas2nGcVi59SSTIIWiip9KIv4WXc3OJFeP1oW?=
 =?us-ascii?Q?WXyByxBAKpwQ5SiwE++RZwULzdkillfXxgvA2e7aeDFNlat7u8lDM8gI9z1v?=
 =?us-ascii?Q?ZIWgYzyCkjZwoRdIuB/Bm7NC8jLT1G6nn6XDr1XmKOCtfvVNqnrU2kBfOOlq?=
 =?us-ascii?Q?UpIUj8V+1/jKX80UMBas6EBpn2ug6ZEP69WRhKS3xV8GYtmMb3zEh0Jo+Kdb?=
 =?us-ascii?Q?CJwzvQSf0uXrSK7Q1NTsehNYH7WLnPpePzxJwg2ZrtQuN8L3yhwUSN3AwbGG?=
 =?us-ascii?Q?d689NE3LWFNUeRjpTubXxxSm/hDKCCOXuLUOMLHGVX/aBv/rN8GTsbMddA2r?=
 =?us-ascii?Q?mCR1hnGs3ASSgoxPsik+tCidRGQ42/Qe50PUwarGgwg87NCAsKdKu6dQozHT?=
 =?us-ascii?Q?PhRN9AM4/kYEemImAhEr4AkeU2rlYOMC1q0yrwyAn3C5/QtOvp+VPKJNoLaJ?=
 =?us-ascii?Q?iJzxTxzJoe+yztYi/WGftpZadbPFpvUDxRjXDVOy0jC7oBoYeJzYd2EA76yM?=
 =?us-ascii?Q?/hV8yIF6q4hikk4AQlDEz/urP72iyYFBJMrB5JxC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f75de7ed-1bdf-43e2-95f0-08de016fcc13
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 04:54:41.3833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeoqtYTYss1rowC2/uoGrEgwgi87hQDE7yIISyL+/xO27of+uagS2Sky1u0ZY3JgkNWU6XaGJTuy+0py0qD03Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8818

Make some improvements for imx uart wakeup function. The first patch adds
device_may_wakeup() check before configuring the wake related registers.
The second patch adds the wakeup event reporting support for imx uart.

Changes in V4:
1. Use scoped_guard(tty_port_tty, port) in patch #1 as Jiri suggested.
2. Use wake_active = wake_active || (usr1 & USR1_RTSD) in patch #2 for easier
   understand as Frank suggested.

Changes in V3:
1. Add !!() to make bool type wake_active clearer.
2. Add Reviewed-by tag for patch #1.

Changes in V2:
1. Improve the commit message as Peng suggested.
2. Initialize the may_wake and wake_active variables to avoid build
   warnings. 
3. Move may_wake and wake_active above u32 ucr3.
4. Use linux/irq.h instead of asm/irq.h to avoid build errors.

Sherry Sun (2):
  tty: serial: imx: Only configure the wake register when device is set
    as wakeup source
  tty: serial: imx: Add missing wakeup event reporting

 drivers/tty/serial/imx.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

-- 
2.34.1

