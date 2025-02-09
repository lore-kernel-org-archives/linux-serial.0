Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2125.outbound.protection.outlook.com [40.107.21.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC8223E22F;
	Sun,  9 Feb 2025 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739134975; cv=fail; b=j1HaSNzTvMDZK91+THxOcILsXRLJrY4f67oQNmR9bwDR+I9km7BVMLVjAVHfbKZmffb0Xc2tomtoPiudOTr+39gXvBogjFSXefIDHeo7GFd1SXz+0U2mskMdT1ezsH+fcj0qXZiYVXgrKL2lIJvohylU4Al8axbPrfJkOQDYmbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739134975; c=relaxed/simple;
	bh=/P9ZAN+UN3NLLewNEJRMSDrSUY2G+y4os0W8tbN9yl4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Z9Xcr06H/GOOOELmYvyGD/sfviGOLF8pm3Umk5kGWq7txJxiVm55fYvM7BGL+hB/UzjZjYm6y8/Fd9GxEM7ZwzJRN+HlDgtcgvVD/F2t33u4RrZW3F5kcvXWb3dpTvpIpWDZZiCSKLpEfpnMjx+9/XP66SHzASPz9x7Jw+221vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=mJc5IZZA; arc=fail smtp.client-ip=40.107.21.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="mJc5IZZA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7/Y6PKNvC8hpLqR4k7n7ZGC/hPBsYNUsqhpMjSmuwzSpK8PK4m+yRuOuoryalUcaqMjk5dRI4PX8AhVs68aQp2FShP7QXFBQCvk/1RjKzweoll+zJk+b8gAfh8HqE5yi7dXEZ7TPvwKv45/QMiSxY6ZDnT61b3G+YpV3dxVxsOunnhNS2MzuCJ8BflMiRQnpoocnfDycCRdTgY/nPDMj5/nW7/AyKpig93/3dHma6I7uAGBNWAzkC3qCJLGM+iGhwqW1tDOxKgpBVQNh/2ABlythLZuCVn5CqPxlTBcdbqWALbZ4WmMjPNhYIJtt48zzSMhkLroJu3wY48l7KShYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wI7BPFeX7ttgU89RVxsZ5kpQfUkmuRKsCX+YYbjvJaQ=;
 b=F8cwLLAvhDFZaCErZvSeXOOIWyF3JK3FEk/zl4P5vCFraq+wVzDQ7n6j5FwidpzgoHGUaxVVGTDo8gW6mZPHxDcEG66ODiu2+HRCtdcJd+6iGEhxGPkEZfY4fL9XfivVkRy6ROLPfK0m7Q4/PGdLUMp3K0yzneWgd+6WFAJmKXdstsL1YFV3iBaVx3VE/SkjOuBRNZH1qSYWTw5SiJfA+mgSG5xpWipQuAWFHDAgp2wjg7gZvpgm3fn602A+Rd7KKmRzm3Uzf/dE/NC0lXEJnEsXKX0teRs+Nc97Llcpm4E1LsTx4HYEsFU1jxaUwUJNqjbd+vGPyDJDixbvSnD+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI7BPFeX7ttgU89RVxsZ5kpQfUkmuRKsCX+YYbjvJaQ=;
 b=mJc5IZZAp/fJnCLMcZwBTEbDIUTjN18Be3sw5WegoIiHD0O/dPOWQKjWUippXGcvIfDrmySg49fWEX1YbJRRl3k4aFjCbEe3jtqcBIcaqC+oA9E5wT4OqRuV1ZZ7j8gq00YN+XFdougCpvGkcF58SCJRezDzMfmty4zG5pF8eJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 by DBBPR08MB5962.eurprd08.prod.outlook.com (2603:10a6:10:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Sun, 9 Feb
 2025 21:02:48 +0000
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42]) by AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42%4]) with mapi id 15.20.8422.015; Sun, 9 Feb 2025
 21:02:48 +0000
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
To: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ansuelsmth@gmail.com,
	lorenzo@kernel.org,
	gregkh@linuxfoundation.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>
Subject: [PATCH v4 0/2] Airoha UART support
Date: Sun,  9 Feb 2025 22:02:39 +0100
Message-Id: <20250209210241.2622309-1-benjamin.larsson@genexis.eu>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002BB9.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:13) To AM6PR08MB4215.eurprd08.prod.outlook.com
 (2603:10a6:20b:90::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:EE_|DBBPR08MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb59a77-3336-4039-ee07-08dd494d1b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BTjjq25oGkqMcs1Oog27GGTkF8+wFPT7jF0I24Q7KneRDXgv4i37aCjL1mae?=
 =?us-ascii?Q?0XdTIp+Hm8zlPzP1DPBbT5pnFm0FSUdRaUmnkua9EMT/0pBvT/99mppd+ZEc?=
 =?us-ascii?Q?l/q8kNoo4WIVmj8iYrDSRpKuH8r4x5W8xt1YCY7gVUDQUuscNPCwZG0ZHA6c?=
 =?us-ascii?Q?D3cNqjLjWNkNSgrbbaJ56Nju8xeoq8xveQUbBiurjMX7b7YT5BZ+JEMBB/k5?=
 =?us-ascii?Q?BcFFJ0sHHMBxTw+8RgPzTFZeHEsI+jksjVYXrjF0t7DwtfMqqAYGAZUVXBzD?=
 =?us-ascii?Q?zdCC7gvgT23tgQVRieXH4iVixbfqdzgg/627r6M8iQTAWqBmvMYfjHGaZC8E?=
 =?us-ascii?Q?q0XFka9M7RFT/2xkP7TI10DyM2z4Fak+Fo6SaB0qTgSv4P0mAg8QKFW8R47w?=
 =?us-ascii?Q?tyOnaWO/OlHQB+HPlTKlTqPyxgYJcrvNWiyJN5C6W5+8NxUWChRth8Ey0NW8?=
 =?us-ascii?Q?DwlhpO0HhX8++EZ0SkHrH4W+GFuP1pBepvw7a6A4OfAtccV3vOSVxMLMxy2d?=
 =?us-ascii?Q?2YcDZcLbW+SvEX1c6iiVi3vT45qUvSoxcQ+YCVSqMKzSzMitdfQynAEwnFin?=
 =?us-ascii?Q?fDL8IayMu7eUTyyuPbUgzjqMNnh9QQVOfLaVtqnQ/cmsG4oQYYBXAX1YE8f5?=
 =?us-ascii?Q?egKikEQlj6S8Wal3EUEe8/2F6larPcLcc/w25BSibOSZW6sxybnkIImw9HaQ?=
 =?us-ascii?Q?uI6s5OroFhhOrCULwZPRplueI2plNIPIT0MiQKBzqO6L9UVugvr8dvta0yeC?=
 =?us-ascii?Q?fxnt+nM1o1VP2iFIQwx6GOWdg/sZm7lcYIYrUKcJjNPzq4TvZHdc932V05Wf?=
 =?us-ascii?Q?QqEVp7pTmhzwxKZeLNTsVWrXjdTnVKwVC8HKfvw+EtUG5knh6jLk3PZphUX7?=
 =?us-ascii?Q?TVFci1vbg37Ci2DOokkTw9KM6zW8oy1NoszkuQJ53I85DfJKPNKSbpjLnCJL?=
 =?us-ascii?Q?aj8BtxX+wYpUjpvsnLA2DZITvoZxZqEF+ZQPzPVlAbd9/qTxbdUxD81Q7DIX?=
 =?us-ascii?Q?oeKL2jFpQweXGJ75LKF96qs6n6SSakILW+y51PIqKHByUkjvYPfHfB3ObBoB?=
 =?us-ascii?Q?ORJgXdwFl01dJ7zKPPfy5St/pyLC9gd4YnctXevZ19ZqfA5DfFSJHei5Kufo?=
 =?us-ascii?Q?eyj3M/ACa1Mh6zowfLPWxJfiOIDDARNPyKLoyKEswydwbRGhpovhOhYXi6fk?=
 =?us-ascii?Q?3F/BjSVLUzghULPqOFxmu0s+3g9+9u6dbiqLExwPYYA7pPnRXatt3X/4FHLV?=
 =?us-ascii?Q?zgf+M1Smsy1s1D6hAgcuv5UJ2SxEnkreiVFPXwqvIje9xuecl/EggRSfbyS0?=
 =?us-ascii?Q?owhXuSmyZfVE0wIw1IuOZt/aSasz1PCy0pssae1kiOJXixOcHfj4QHLcTgyC?=
 =?us-ascii?Q?Ma2Zl0ehslKjPsSSmpiQZqfnvSXs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4215.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6byF8U6mSP9JSP6B5IJnpk/tcC/AmYr9JflvZMUywayqRTeT1kgvGn1cNuSK?=
 =?us-ascii?Q?crBAwLWtYD/oCiZVKA2R/QpI3JQ5Cta0mwqwzRvOE+BRTg/vHyI03soBjYyd?=
 =?us-ascii?Q?+Zi6ZwAY3oTHb8nOda/7wj1iXmTtQ1+vg0UX1iDA+oWiYALZw4qKBouO/QUW?=
 =?us-ascii?Q?9EVKUUhu/AncWuG8xroHEqkg1spJ3haJRequ8E0MWWOiSOVCLBYrs39gyqpx?=
 =?us-ascii?Q?bdw59HpLivUFuN9Vg+F7eaiwMhSmPcpmVyhRzPAPvs2UBmNL5OWbWWNYphZR?=
 =?us-ascii?Q?RF3dfrKYBnMfLv6r+OkddvPj3XUQr99XqV96ZmKbo/ykB30qNBhYsxPdu/GE?=
 =?us-ascii?Q?2nsXhzCK624uhjVaCk9KHR8a3bj/cRXkPsqW2iYJnq2qST2roEVEQmEcPe0N?=
 =?us-ascii?Q?CaijQYAebjJPRSxTfrHKS4yAQ2TOQioIxwYJhnztsL/SOp6rQr/93eNtoO/8?=
 =?us-ascii?Q?jV8yaUJwYlCwlAM3s9urYKf3LoNDTMS4ngy5OPQDLOalgSye59aOcGe2dW4o?=
 =?us-ascii?Q?XqmgNgYA8+10We4lRIAKpMb7NCckTdLmBAUP3ckzeb6/9yeoeTm2tby5TkOI?=
 =?us-ascii?Q?PXYpTX7L5Vp2aLRmgY7Nuuh02yeyoZHj3+A8rXRktiFOd+R1EQvqLDLVbhaY?=
 =?us-ascii?Q?a8hgVpY9vGIK9tCrpFTkNnlU6OT1RtV5yQipRdo1ED/hOUrJKR0JoGx/HP4U?=
 =?us-ascii?Q?g+lbC4puLrJBS3K91Kb3jWH/RbKPH9W/Cv89AVFOT/B8tyHn7ZxklqULPhJM?=
 =?us-ascii?Q?MZGW/Exd0M7m8iN10y1QiYa/1N93vpznCAb3XYe8pgno1VTDE8nwvBPGDeW6?=
 =?us-ascii?Q?8o3F0/CVx3CS9ecDG6UFWenOdSb7J8hEEdygbzfYzYDyiaWiIoMVUqZddms+?=
 =?us-ascii?Q?yjt6/oAriPAQq0zoeUrCHglXrDs7vcNqN6rX4jS5Bkn/zbeTY5a8uFFuT6Y6?=
 =?us-ascii?Q?lp/Q9hzYsUULTveBGZUJrxg+2fbx2lQL9etCbRcFjhieKNOhNll4hXdWfPbP?=
 =?us-ascii?Q?zm6tNcemslxDboWbFqBl+QnPeUtVbVq5ecuRi0GW1yTPNVjx8Wm032e57j/G?=
 =?us-ascii?Q?fGEbwQ2QGjSAlHNNHj8jM0CkxHPgnwXjpNtfmItYbJ/y3yJXZm9jeWMcM+J4?=
 =?us-ascii?Q?juhbPoWoqP0s28dlICuNiDRsIpr1330hRiVdki/QTxO1YNAq30Y95kzjf5Nb?=
 =?us-ascii?Q?NuM4Nb7lrcEdBFFhsZ4nCNjcRaAjXJJvOwhBbKOqw5JngHHQ3gELN8YkepIs?=
 =?us-ascii?Q?weHZm7i7lkBjcUd8Y1yJ9TpCl23ICuEt9PJkwnpVfl5qOYg8ku0Jc0yguVry?=
 =?us-ascii?Q?9s4GIEaaWbYzKk+krkv/BLBvym0H+VWATxl4mrBtVH8E8z3bkNo8dOw+uD6P?=
 =?us-ascii?Q?Dxg1T0KblpEo6Rk3bD/bkrgOtep+ZGqCmHeacy2QDMD4mGWAiYlPMrGk+1f9?=
 =?us-ascii?Q?sDmztmqaMRTqDfnGsKpIiLehFkrMWl99TuiFFiRLXJ8V0/svQfo9K3CRc8mN?=
 =?us-ascii?Q?5bsGTtW+bgn0KU1MViFBj4XixVz/t8HhtrM8glx8GvHs89KS+MtFuplVyNM+?=
 =?us-ascii?Q?9GE0c+/8y1GyFe17KS13l0+9xzjRnwByQsrhwQkxK1igE2V/2fYgsycKv7TQ?=
 =?us-ascii?Q?Hvbs0p4Ns2HD0AM+yldSUg0EwvKiQen0LgrBcz0MBkeWU2LGEo1WIEKZ6prW?=
 =?us-ascii?Q?ubSSWQ=3D=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb59a77-3336-4039-ee07-08dd494d1b0a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4215.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 21:02:48.3728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QN2lEaFO7nqJOpEPPDgQL/vp4Pa+8G0CgjHBNkW18+OZ1EoeLa7yf1SH8zXHOwsDrboqyBptQHX24SCrx+y+qnGj3B3znnTIALJKE0t9Lbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5962

The Airoha familty of SoCs have a UART hardware that is 16550-compatible
with the exception of the baud rate settings.

This patch implements code for calculating the baud rate for the Airoha
UART and HSUART.

Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
---
Changes in v4:
- Removed COMPILE_TEST from Kconfig
- Removed Kconfig option to build as module

Changes in v3:
- Reworded commit message
- Restructured comment text
- Fixed kernel-doc warning
- Fixed kernel test robot build error and build warning

Changes in v2:
- Removed ifdef use in .c files
- Removed uart port defines from user-space headers
- Reworded commit message
- Added code documentation

Benjamin Larsson (2):
  dt-bindings: serial: 8250: Add Airoha compatibles
  serial: Airoha SoC UART and HSUART support

 .../devicetree/bindings/serial/8250.yaml      |  2 +
 drivers/tty/serial/8250/8250.h                | 15 ++++
 drivers/tty/serial/8250/8250_airoha.c         | 83 +++++++++++++++++++
 drivers/tty/serial/8250/8250_of.c             |  2 +
 drivers/tty/serial/8250/8250_port.c           | 27 ++++++
 drivers/tty/serial/8250/Kconfig               | 10 +++
 drivers/tty/serial/8250/Makefile              |  1 +
 7 files changed, 140 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_airoha.c

-- 
2.34.1

